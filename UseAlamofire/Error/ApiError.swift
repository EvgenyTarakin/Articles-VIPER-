//
//  ApiError.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 14.12.2021.
//

import Foundation

struct ApiError: Error {
    var message: String
    init(_ message: String) {
        self.message = message
    }
}
