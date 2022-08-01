//
//  CurrentWeatherView.swift
//  EvangelistTest
//
//  Created by James on 31/07/2022.
//

import Foundation
import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: CurrentWeatherViewModel

    var body: some View {
        return content.onAppear {
            self.viewModel.send(event: .onAppear)
        }
    }

    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.clear.eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loading:
            return Spinner(isAnimating: true, style: .large).eraseToAnyView()
        case .loaded(let currentData):
            return Text("heheh ok la").eraseToAnyView()
        }
    }

    
}
