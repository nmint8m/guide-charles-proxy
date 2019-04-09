//
//  API.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/7/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct API {
    struct Path {
        static let baseURL = "https://pokeapi.co/api/v2"

        struct Pokemon {
            static var pokemon: String { return API.Path.baseURL / "pokemon" }
        }
    }

    enum Errors: Error {
        case badRequest
        case notFound
        case authentication
        case noResponse
        case jsonFormat
        case networkNotConnect

        // TODO: - Define more errors https://en.wikipedia.org/wiki/List_of_HTTP_status_codes

        var code: Int {
            switch self {
            case .badRequest: return 400
            case .notFound: return 404
            case .authentication: return 500
            case .noResponse: return 1000
            case .jsonFormat: return 1001
            case .networkNotConnect: return 1002
            }
        }

        var description: String {
            switch self {
            case .badRequest: return "Bad request"
            case .notFound: return "Not found"
            case .authentication: return "This authentication is not valid"
            case .noResponse: return "No response"
            case .jsonFormat: return "JSON format is wrong"
            case .networkNotConnect: return "Cannot connect network"
            }
        }
    }
}

infix operator /: AdditionPrecedence

extension String {
    static func / (left: String, right: String) -> String {
        return left + "/" + right
    }
}
