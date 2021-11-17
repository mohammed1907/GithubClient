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

    private let service: RepositoriesService!
    private let disposeBag = DisposeBag()
    private let _reposSubject = PublishSubject<[RepoViewModel]>()
    let searchText = BehaviorRelay<String>(value: "")
    
    let title = BehaviorRelay<String>(value: "Repositories")

    let selectedRepo = PublishSubject<RepoViewModel>()

    var repositories: Observable<[RepoViewModel]>

    init(service: RepositoriesService) {
        self.service = service
        self.repositories = _reposSubject.asObserver()

        searchText.map { $0 }
        .filter({ $0.count > 1 })
        .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .subscribe { query in
            service.searchRepositories(key: query)
                .subscribe { [weak self] repos in
                    guard let self = self else { return }
                    let repoViewModel = repos.items.compactMap { RepoViewModel(repository: $0) }
                    self._reposSubject.onNext(repoViewModel)
                } onError: { error in
                    print(error)
                }.disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }

    func start() {
        service.getRepositories()
            .subscribe { [weak self] repos in
                guard let self = self else { return }
                let repoViewModel = repos.compactMap { RepoViewModel(repository: $0) }
                self._reposSubject.onNext(repoViewModel)
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)
    }
}
