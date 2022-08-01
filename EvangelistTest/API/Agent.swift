//
//  Agent.swift
//  EvangelistTest
//
//  Created by James on 24/07/2022.
//

import Foundation
import Combine

struct Agent {
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        print("Request: \(request.url?.absoluteString ?? "")")
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .handleEvents(receiveOutput: { data in
                let responseString: String = String(data: data, encoding: .utf8) ?? ""
                print("Response: \(responseString)")
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
