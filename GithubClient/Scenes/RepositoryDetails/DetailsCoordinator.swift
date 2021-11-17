//
//  DetailsCoordinator.swift
//  GithubClient
//
//  Created by Farghaly on 17/11/2021.
//

import UIKit
import RxSwift

class DetailsCoordinator: BaseCoordinator<Void> {
    private let rootViewController: UIViewController
    private let viewModel: RepoViewModel

    init(rootViewController: UIViewController, viewModel: RepoViewModel) {
        self.rootViewController = rootViewController
        self.viewModel = viewModel
    }

    override func start() -> Observable<Void> {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "RepoDetailsViewController") { coder in
            return RepoDetailsViewController(coder: coder, viewModel: self.viewModel)
        }
        let didClose = viewModel.didClose

        rootViewController.show(viewController, sender: nil)

        return didClose
            .take(1)
    }
}
