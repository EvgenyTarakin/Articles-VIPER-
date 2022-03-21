//
//  ApiEndPoint.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 10.12.2021.
//

import Foundation
import Alamofire

public enum ApiEndPoint {
    case news(name: String, from: String, sortBy: String, api: String)
}

extension ApiEndPoint {
    private var scheme: String {
        return "https"
    }
    
    private var host: String {
        return "newsapi.org"
    }
    
    private var path: String {
        switch self {
        case .news:
            return "/v2/everything"
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = []
        
        switch self {
        case .news(let name, let from, let sortBy, let api):
            items.append(URLQueryItem(name: "q", value: name))
            items.append(URLQueryItem(name: "from", value: from))
            items.append(URLQueryItem(name: "sortBy", value: sortBy))
            items.append(URLQueryItem(name: "apiKey", value: api))
        }
        
        return items
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .news:
            return .get
        }
    }
    
    private func configurateURL() -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    var url: URL? {
        return configurateURL()
    }
}
