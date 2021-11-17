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

    var searchReturnValue: Observable<Repositories> = .empty()
    var searchKeyArgument: String!

    func searchRepositories(key: String) -> Observable<Repositories> {
        searchKeyArgument = key
        didEnterSearchRepo = true
        return searchReturnValue
    }
}
