//
//  RepositoryListViewModel.swift
//  GithubClient
/// Users/farghaly
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
    let noDataText = BehaviorRelay<String>(value: "Enter your search text")
    let title = BehaviorRelay<String>(value: "Repositories")
    var loadingIndicator = BehaviorRelay<Bool>(value: false)
    let selectedRepo = PublishSubject<RepoViewModel>()

    var repositories: Observable<[RepoViewModel]>

    init(service: RepositoriesService) {
        self.service = service
        self.repositories = _reposSubject.asObserver()
        self.repositories = searchText.map { $0 }
            .filter({ $0.count > 1 })
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] query -> Observable<[RepoViewModel]> in
                guard let self =  self else { return .just([]) }
                if query.isEmpty {
                    return .just([])
                }
                self.loadingIndicator.accept(true)
                return self.service.searchRepositories(key: query)
                    .catch { _ in
                        self.loadingIndicator.accept(false)
                        return Observable.empty()
                    }.map {
                        self.loadingIndicator.accept(false)
                        let repoItems = $0.items.compactMap { RepoViewModel(repository: $0) }
                        repoItems.count > 0 ? self.noDataText.accept("") : self.noDataText.accept("No result found")
                        return repoItems
                    }
            }
    }
}
