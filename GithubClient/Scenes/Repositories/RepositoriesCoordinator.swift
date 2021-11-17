//
//  RepositoriesCoordinator.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import UIKit
import RxSwift

class RepositoriesCoordinator: BaseCoordinator<Void> {

    private let rootViewController: UIViewController
    private let viewModel: RepositoryListViewModel

    init(viewController: UIViewController, viewModel: RepositoryListViewModel) {
        self.rootViewController = viewController
        self.viewModel = viewModel
    }

    override func start() -> Observable<Void> {
        viewModel.selectedRepo
            .flatMap({ [unowned self] (repoViewModel) in
                self.coordinateToRepoDetail(with: repoViewModel)
            })
            .subscribe()
            .disposed(by: disposeBag)

        return Observable.empty()
    }

    private func coordinateToRepoDetail(with repoViewModel: RepoViewModel) -> Observable<Void> {
        let repoDetailsCoordinator = DetailsCoordinator(rootViewController: rootViewController, viewModel: repoViewModel)
        return coordinate(to: repoDetailsCoordinator)
            .map { _ in () }
    }
}
