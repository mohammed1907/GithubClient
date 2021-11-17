//
//  RepoServiceMock.swift
//  GithubClientTests
//
//  Created by Farghaly on 17/11/2021.
//

import Foundation
import RxSwift

@testable import GithubClient

class RepoServiceMock: RepositoriesService {
    var didEnterSearchRepo = false
    var didEnterGetRepo = false
    func searchRepositories(key: String) -> Observable<Repositories> {
        didEnterSearchRepo = true
        return Observable.empty()
    }

    func getRepositories() -> Observable<[Repository]> {
        didEnterGetRepo = true
        return Observable.empty()
    }
}
