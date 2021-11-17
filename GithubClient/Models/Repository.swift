//
//  Repository.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import Foundation

// MARK: - Repository
struct Repository: Codable {
    let id: Int?
    let name, fullName: String?
    let owner: Owner?
    let htmlURL: String?
    let url: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case htmlURL = "html_url"
        case createdAt = "created_at"
        case url
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let id: Int?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
