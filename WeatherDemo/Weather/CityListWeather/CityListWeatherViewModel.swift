//
//  CityListWeather.swift
//  WeatherDemo
//
//  Created by Smitesh Patel on 2020-10-11.
//

import Combine
import SwiftUI

// fetch current location of device

class CityListWeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var dataSource: [CityWeatherRowViewModel] = []

    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()

    init(
        weatherFetcher: WeatherFetchable,
        scheduler _: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
    ) {
        self.weatherFetcher = weatherFetcher
        fetchNearBy()
//        $city
//            .dropFirst(1)
//            .debounce(for: .seconds(0.5), scheduler: scheduler)
//            .sink(receiveValue: fetchNearBy(forCity:))
//            .store(in: &disposables)
    }

    // func get current location lat and long using combine

    func fetchNearBy() {
        weatherFetcher.nearbyCurrentWeatherForecast(for: 43.65, lon: -79.34, count: 10)
            .map { response in
                response.list.map(CityWeatherRowViewModel.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] forecast in
                    guard let self = self else { return }
                    self.dataSource = forecast
                }
            )
            .store(in: &disposables)
    }
}

extension CityListWeatherViewModel {
    func weeklyWeatherView(for city: String) -> some View {
        WeeklyWeatherBuilder.makeWeeklyWeatherView(withCity: city, weatherFetcher: weatherFetcher)
    }
}
