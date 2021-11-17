//
//  RepoViewModel.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import Foundation
import RxSwift

struct RepoViewModel {

    let didClose = PublishSubject<Void>()

    let id: Int
    let name: String
    let avatar: String
    let date: String
    let ownerName: String
    init(repository: Repository) {
        self.id = repository.id ?? 0
        self.name = repository.name ?? ""
        self.avatar = repository.owner?.avatarURL ?? ""
        self.date = repository.createdAt?.formatedShortDate ?? ""
        self.ownerName = repository.owner?.login ?? ""
    }
}
