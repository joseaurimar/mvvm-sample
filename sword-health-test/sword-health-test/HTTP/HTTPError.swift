//
//  HTTPError.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import Foundation

public enum HttpError: Error {
    case noConnection
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
