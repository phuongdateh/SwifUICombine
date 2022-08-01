//
//  CurrentWeatherView.swift
//  EvangelistTest
//
//  Created by James on 31/07/2022.
//

import Foundation
import SwiftUI
import MapKit

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: CurrentWeatherViewModel

    var body: some View {
        NavigationView {
            content
        }
        .onAppear {
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
            return MapView().eraseToAnyView()
        }
    }
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 40.83834587046632,
                        longitude: 14.254053016537693),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.03,
                        longitudeDelta: 0.03)
                    )

    var body: some View {
        return Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
    }
}
