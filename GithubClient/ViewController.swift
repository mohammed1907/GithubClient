//
//  ViewController.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let service =  RepositoriesServiceImpl()
    let dispoisebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        service.getRepositories().subscribe { repo in
            print(repo.map { $0.name })
        } onError: { error in
            print(error)
        }.disposed(by: dispoisebag)

    }

}
