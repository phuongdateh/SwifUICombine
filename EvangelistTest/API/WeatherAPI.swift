//
//  WeatherAPI.swift
//  EvangelistTest
//
//  Created by James on 24/07/2022.
//

import Foundation
import Combine

typealias WeatherResult<T: Decodable> = AnyPublisher<T, Error>

enum WeathersAPI {

    static let base: URL = URL(string: "https://api.openweathermap.org/data/2.5")!
    static let apiKey: String = "03ddb09da2f553ed9ca0601f15b7bff4"
    static let agent = Agent()

    static func currentWeather(request: WeatherRequest) -> WeatherResult<ResponseDTO> {
        let request = URLComponents(url: base.appendingPathComponent("find"), resolvingAgainstBaseURL: true)?
            .addingApiKey(apiKey)
            .addQueryItem(items: request.queryItems)
            .request
        guard let request = request else {
            fatalError("URL invalid")
        }
        return agent.run(request)
    }
}

private extension URLComponents {
    func addingApiKey(_ apiKey: String) -> URLComponents {
        var copy = self
        copy.queryItems = [URLQueryItem(name: "appid", value: apiKey)]
        return copy
    }

    func addQueryItem(items: [URLQueryItem]) -> Self {
        var copy = self
        if copy.queryItems == nil {
            copy.queryItems = items
        }
        items.forEach({ copy.queryItems?.append($0) })
        return copy
    }

    var request: URLRequest? {
        url.map { URLRequest.init(url: $0) }
    }
}
