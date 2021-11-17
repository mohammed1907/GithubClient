//
//  RepositoriesService.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import Foundation
import RxSwift

protocol RepositoriesService {
    func searchRepositories(key: String) -> Observable<Repositories>
    func getRepositories() -> Observable<[Repository]>
}

class RepositoriesServiceImpl: RepositoriesService {
    private let service = NetworkService()

    func searchRepositories(key: String) -> Observable<Repositories> {
        return service.fetchRequest(forRoute: .search(key: key))
    }

    func getRepositories() -> Observable<[Repository]> {
        return service.fetchRequest(forRoute: .getRepos)
    }
}
