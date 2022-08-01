//
//  WeatherRequest.swift
//  EvangelistTest
//
//  Created by James on 24/07/2022.
//

import Foundation
import CoreLocation

struct WeatherRequest {

    let location: CLLocationCoordinate2D
    init(location: CLLocationCoordinate2D) {
        self.location = location
    }

    var units: String = "metric"

    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: "lat", value: String(describing: location.latitude)))
        items.append(URLQueryItem(name: "lon", value: String(describing: location.longitude)))
        items.append(URLQueryItem(name: "units", value: units))
        return items
    }
}
