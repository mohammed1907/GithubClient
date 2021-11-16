//
//  RepositoriesService.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import Foundation
import RxSwift

protocol RepositoriesService {
    func getRepositories() -> Observable<Repositories>
}

class RepositoriesServiceImpl: RepositoriesService {
    private let service = NetworkService()
    func getRepositories() -> Observable<Repositories> {
        return service.fetchRequest(forRoute: .getRepos)
    }
}
