//
//  GithubRouter.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import Foundation

enum GithubRouter {

    // MARK: - Endpoints
    case getRepos
    case search(key: String)

    // MARK: - Properties
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getRepos:
            return Config.EndpointPath.getRepositories
        case .search:
            return Config.EndpointPath.searchRepo
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .search(let searchKey):
            let parameters: [String: Any] = ["q": "\(searchKey)",
                              "sort": "stars",
                              "order": "desc",
                              "per_page": 10]

            return parameters
        default:
            return nil
        }
    }

    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        let endpointPath: String = "\(Config.baseURL)\(path)"
        var components = URLComponents(string: endpointPath)
        var urlRequest = URLRequest(url: (components?.url)!)
        components?.queryItems = []
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        if parameters != nil {
            components?.queryItems?.append(contentsOf: parameters!.map { (key, value) in
                URLQueryItem(name: key, value: value as? String)
            })
        }
        urlRequest.url = components?.url

        return urlRequest
    }
}
