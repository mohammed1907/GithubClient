//
//  RepositoriesViewController.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

final class RepositoriesViewController: UIViewController {

    @IBOutlet weak var noDataLbl: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private let cellIdentifier = "RepoTableViewCell"
    private let viewModel: RepositoryListViewModel!
    private let disposebag = DisposeBag()

    required init?(coder: NSCoder, viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        subscribeToLoading()
    }

}

private extension RepositoriesViewController {
    func setupUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        configureTableView()
    }

    func configureTableView() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    func configureSearchBarUI() {
        self.searchBar.backgroundColor = UIColor.clear
        self.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.semanticContentAttribute = .forceRightToLeft

        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            let key = NSAttributedString.Key.foregroundColor
            let color = UIColor.lightGray
            let text = textfield.placeholder ?? ""
            textfield.attributedPlaceholder = NSAttributedString(string: text, attributes: [key: color])
            textfield.font = UIFont.systemFont(ofSize: 15.0)

            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.lightGray
            }
        }

    }
}

private extension RepositoriesViewController {
    func setupBindings() {
        // bind title
        viewModel.title
            .bind(to: self.rx.title)
            .disposed(by: disposebag)
        // bind searchBar
        _ = searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposebag)

        // bind noDataLbl to handel empty result
        viewModel.noDataText
            .bind(to: noDataLbl.rx.text)
            .disposed(by: disposebag)

        // bind tableView to retreive data
        viewModel.repositories
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: RepoTableViewCell.self)) { _, viewModel, cell in
                cell.viewModel = viewModel
            }.disposed(by: disposebag)

        // bind tableView selection
        tableView.rx.modelSelected(RepoViewModel.self)
            .bind(to: viewModel.selectedRepo)
            .disposed(by: disposebag)
    }
    func subscribeToLoading() {
        viewModel.loadingIndicator.subscribe(onNext: { (isLoading) in
            DispatchQueue.main.async {
                if isLoading {
                    self.showBlockingLoading()
                } else {
                    self.hideBlockingLoading()
                }
            }

        }).disposed(by: disposebag)
    }

}
