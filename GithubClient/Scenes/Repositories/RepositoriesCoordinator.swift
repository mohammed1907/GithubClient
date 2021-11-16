//
//  RepositoriesCoordinator.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import UIKit
import RxSwift

class RepositoriesCoordinator: BaseCoordinator<Void> {
    
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    override func start() -> Observable<Void> {
        return Observable.empty()
    }
}
