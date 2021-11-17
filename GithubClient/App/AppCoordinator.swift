//
//  AppCoordinator.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    private let service = RepositoriesServiceImpl()

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        let viewModel = RepositoryListViewModel(service: service)
        let viewController = storyBoard.instantiateViewController(identifier: "RepositoriesViewController") { coder in
            return RepositoriesViewController(coder: coder, viewModel: viewModel)
        }

        let navigationController = UINavigationController(rootViewController: viewController)
        let repositoriesCoordinator = RepositoriesCoordinator(viewController: navigationController.viewControllers[0], viewModel: viewModel)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return coordinate(to: repositoriesCoordinator)
    }

}
