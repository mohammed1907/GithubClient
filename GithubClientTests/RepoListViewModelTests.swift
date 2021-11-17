//
//  RepoListViewModelTests.swift
//  GithubClientTests
//
//  Created by Farghaly on 16/11/2021.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import GithubClient

class RepoListViewModelTests: XCTestCase {

    var sut: RepositoryListViewModel!
    var repositoryViewModel: RepoViewModel!
    var service: RepoServiceMock!
    var testSchedular: TestScheduler!
    var disposeBag: DisposeBag!

    var repositories: Repositories!
    let repository = Repository(id: 1,
                                name: "name",
                                fullName: "fullName",
                                owner: Owner(login: "name",
                                             id: 123,
                                             avatarURL: "http"),
                                htmlURL: "http",
                                url: "http",
                                createdAt: "2013-11-04T01:59:19Z")

    override func setUpWithError() throws {
        super.setUp()
        repositories = Repositories(totalCount: 3, incompleteResults: false, items: [repository])
        service = RepoServiceMock()
        sut = RepositoryListViewModel(service: service)
        repositoryViewModel = RepoViewModel(repository: repository)
        testSchedular = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        service = nil
        sut = nil
        repositoryViewModel = nil
        testSchedular = nil
        disposeBag = nil
    }

    func test_title_emits_correctTitle() throws {
        XCTAssertEqual(try sut.title.toBlocking().first(), "Repositories")
    }

    func test_load_emitsAlertMessage() {
        let result = testSchedular.start { self.sut.noDataText }
        XCTAssertEqual(result.events, [.next(200, "Enter your search text")])
    }

    func test_load_emitZeroSearchResult() {
        service.searchReturnValue = .just(repositories)

            sut.repositories
            .subscribe()
            .disposed(by: disposeBag)

        let result = testSchedular.start { self.sut.repositories.map({ _ in true }) }
        XCTAssertEqual(result.events, [])
    }

    func test_repositories_returnsValidRequest() {
        service.searchReturnValue = .just(repositories)

        testSchedular.createHotObservable([.next(300, "Swift")])
            .bind(to: sut.searchText)
            .disposed(by: disposeBag)

        let result = testSchedular.start { self.sut.repositories }
        XCTAssertEqual(result.events.count, 1)
    }

    func test_repositories_returnsValidViewModels() {
        service.searchReturnValue = .just(repositories)

        testSchedular.createHotObservable([.next(300, "Swift")])
            .bind(to: sut.searchText)
            .disposed(by: disposeBag)

        XCTAssertEqual(repositoryViewModel.name, "name")
    }

}
