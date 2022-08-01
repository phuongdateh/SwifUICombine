//
//  EvangelistTestApp.swift
//  EvangelistTest
//
//  Created by James on 21/07/2022.
//

import SwiftUI

@main
struct EvangelistTestApp: App {
    var body: some Scene {
        WindowGroup {
            CurrentWeatherView(viewModel: CurrentWeatherViewModel())
        }
    }
}
