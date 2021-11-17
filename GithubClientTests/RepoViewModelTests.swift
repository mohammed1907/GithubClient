//
//  RepoViewModelTests.swift
//  GithubClientTests
//
//  Created by Farghaly on 17/11/2021.
//

import XCTest
@testable import GithubClient

class RepoViewModelTests: XCTestCase {

    var sut: RepoViewModel!
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
        sut = RepoViewModel(repository: repository)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        sut = nil
    }

    func test_repositoryId_equal_repositoryId() throws {
        XCTAssertEqual(sut.id, 1)
    }

    func test_repositoryName_equal_repositoryName() throws {
        XCTAssertEqual(sut.name, "name")
    }

    func test_repositoryAvatar_equal_repositoryAvatar() throws {
        XCTAssertEqual(sut.avatar, "http")
    }

    func test_repositoryOwnerName_equal_repositoryOwnerName() throws {
        XCTAssertEqual(sut.ownerName, "name")
    }

    func test_repositoryCreationDate_equal_repositoryCreationDate() throws {
        XCTAssertEqual(sut.date, "2013-11-04T01:59:19Z")
    }

}
