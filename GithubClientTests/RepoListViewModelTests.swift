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
    var service: RepositoriesService!
    var testSchedular: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        super.setUp()
        service = RepoServiceMock()
        sut = RepositoryListViewModel(service: service)
        testSchedular = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        service = nil
        sut = nil
        testSchedular = nil
        disposeBag = nil
    }

    func test_title_emits_correctTitle() throws {
        XCTAssertEqual(try sut.title.toBlocking().first(), "Repositories")
    }

}
