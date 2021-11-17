//
//  RepoDetailsViewController.swift
//  GithubClient
//
//  Created by Farghaly on 17/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class RepoDetailsViewController: UIViewController {
    @IBOutlet weak var repoAvatar: UIImageView!
    @IBOutlet weak var repoName: UILabel!

    // MARK: Properties
    let viewModel: RepoViewModel!
    private let disposeBag = DisposeBag()

    required init?(coder: NSCoder, viewModel: RepoViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       setupBindings()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.didClose.onNext(())
    }

}

private extension RepoDetailsViewController {
    func setupBindings() {
        self.navigationItem.title = viewModel.name
        self.repoName?.text = viewModel.name
        self.repoAvatar.setImage(imageURL: viewModel.avatar)
    }
}
