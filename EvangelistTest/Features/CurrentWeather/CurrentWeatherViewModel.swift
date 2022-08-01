//
//  CurrentWeatherViewModel.swift
//  EvangelistTest
//
//  Created by James on 25/07/2022.
//

import Foundation
import Combine
import CoreLocation

final class CurrentWeatherViewModel: ObservableObject {

    @Published private(set) var state = State.idle

    private var bag = Set<AnyCancellable>()
    private let input = PassthroughSubject<Event, Never>()

    init() {
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenLoading(request: WeatherRequest(location: CLLocationCoordinate2D.init(latitude: CLLocationDegrees(10.770297329035756),
                                                                                               longitude: CLLocationDegrees(106.68227855611462)))),
                Self.userInput(input: input.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &bag)
    }

    func send(event: Event) {
        input.send(event)
    }
}

// MARK: - Inner Types
extension CurrentWeatherViewModel {
    enum State {
        case idle
        case loading
        case loaded(PlacesWeatherData)
        case error(Error)
    }

    enum Event {
        case onAppear
        case onWeatherLoad(PlacesWeatherData)
        case onFailedToWeather(Error)
    }

    struct PlacesWeatherData {
    }
    
}

// MARK: - State machine
extension CurrentWeatherViewModel {
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onAppear:
                return .loading
            default:
                return state
            }
        case .loading:
            switch event {
            case .onWeatherLoad(let currentWeatherData):
                return .loaded(currentWeatherData)
            case .onFailedToWeather(let error):
                return .error(error)
            default:
                return state
            }
        case .loaded:
            return state
        case .error:
            return state
        }
    }

    static func whenLoading(request: WeatherRequest) -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else {
                return Empty().eraseToAnyPublisher()
            }

            return WeathersAPI.currentWeather(request: request)
                .map { $0.toCurrentWeatherData() }
                .map(Event.onWeatherLoad)
                .catch {
                    Just(Event.onFailedToWeather($0))
                }
                .eraseToAnyPublisher()
        }
    }

    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }
}
