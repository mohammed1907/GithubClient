//
//  Config.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import Foundation

struct Config {
    static let baseURL: String = "https://api.github.com/"

    struct EndpointPath {
        static let getRepositories = "repositories"
    }
}
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
}
