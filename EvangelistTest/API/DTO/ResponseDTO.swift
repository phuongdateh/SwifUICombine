//
//  ResponseDTO.swift
//  EvangelistTest
//
//  Created by James on 24/07/2022.
//

import Foundation

struct ResponseDTO: Decodable {
    let message: String?
    let cod: String?
    let count: Int?
    let list: [WeatherWrapperDTO]?
}

struct WeatherDTO: Decodable {
    let id: Int
    let main: String?
    let description: String?
    let icon: String?
}

struct MainDTO: Decodable {
    let tempMin: Double
    let tempMax: Double
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp
    }
}

struct WeatherWrapperDTO: Decodable {
    let id: Int
    let name: String?
    let coord: CoordDTO?
    let main: MainDTO?
    let weather: [WeatherDTO]?
}

struct CoordDTO: Decodable {
    let lat: Double
    let lon: Double
}

extension ResponseDTO {
    func toCurrentWeatherData() -> CurrentWeatherViewModel.PlacesWeatherData {
        print("DTO Data: \(self)")
        return .init()
    }
}
