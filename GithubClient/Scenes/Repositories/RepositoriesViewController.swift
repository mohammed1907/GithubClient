//
//  RepositoriesViewController.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoriesViewController: UIViewController {

    let service =  RepositoriesServiceImpl()
    let dispoisebag = DisposeBag()

    private let viewModel: RepositoryListViewModel!

    required init?(coder: NSCoder, viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
    }

}
