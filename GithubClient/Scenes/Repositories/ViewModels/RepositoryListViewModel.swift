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
        self.repositories = searchText.map { $0 }
            .filter({ $0.count > 1 })
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] query -> Observable<[RepoViewModel]> in
                guard let self =  self else { return .just([]) }
                if query.isEmpty {
                    return .just([])
                }
                return self.service.searchRepositories(key: query)
                    .catch { error in
                        return Observable.empty()
                    }.map {
                        let repoItems = $0.items.compactMap { RepoViewModel(repository: $0) }
                        return repoItems
                    }
            }
    }
}
