//
//  RepositoryListViewModel.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import Foundation
import RxSwift
import RxCocoa

class RepositoryListViewModel {

    let service: RepositoriesService!
    private let disposeBag = DisposeBag()

    init(service: RepositoriesService) {
        self.service = service
    }

    func start() {
        service.getRepositories()
            .subscribe { repos in
                print(repos.map { $0.name })
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)
    }
}
