//
//  RepoViewModel.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import Foundation

struct RepoViewModel {
    let id: Int
    let name: String

    init(repository: Repository) {
        self.id = repository.id ?? 0
        self.name = repository.name ?? ""
    }
}
