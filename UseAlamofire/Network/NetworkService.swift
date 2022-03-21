//
//  NetworkService.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 01.12.2021.
//

import Foundation
import Alamofire

class NetworkService {

    func performGetRequest<T: Decodable>(endPoint: ApiEndPoint, type: T.Type, completion: @escaping ((Result<T, ApiError>) -> ())) {
        guard let url = endPoint.url else {
            completion(.failure(.init("Ошибка URL")))
            return
        }
        AF.request(url,
                   method: endPoint.httpMethod,
                   encoding: JSONEncoding.default
        ).response { (responseData) in
            guard responseData.error == nil,
                  let data = responseData.data
            else {
                completion(.failure(.init("Ошибка данных 1")))
                return
            }
            
            do {
                let decodedValue = try JSONDecoder().decode(type.self, from: data)
                completion(.success(decodedValue))
            }
            catch (let error) {
                print("Response parsing error: \(error)")
                completion(.failure(.init("Ошибка данных 2")))
            }
        }
    }
    
}
