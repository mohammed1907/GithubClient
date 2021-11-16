//
//  NetworkService.swift
//  GithubClient
//
//  Created by Farghaly on 16/11/2021.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    func fetchRequest<T: Decodable>(forRoute route: GithubRouter) -> Observable<T>
}

class NetworkService: NetworkServiceProtocol {

    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func fetchRequest<T: Decodable>(forRoute route: GithubRouter) -> Observable<T> {

        let urlRequest = try? route.asURLRequest()
        return session.rx.data(request: urlRequest!)
            .flatMap { data throws -> Observable<T> in
                let decoder = JSONDecoder()
                do {
                    return try Observable.of(decoder.decode(T.self, from: data))
                }
            }
    }

}
