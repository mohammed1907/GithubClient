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

    // MARK: - Properties
    var method: HTTPMethod {
        switch self {
        case .getRepos:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getRepos:
            return Config.EndpointPath.getRepositories

        }
    }

    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }

    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        guard let baseURL = URL(string: Config.baseURL) else { throw NetworkError.notFound }
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        return urlRequest
    }
}
