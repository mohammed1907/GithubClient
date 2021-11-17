//
//  Repositories.swift
//  GithubClient
//
//  Created by Farghaly on 17/11/2021.
//

import Foundation

// MARK: - Repositories
struct Repositories: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
