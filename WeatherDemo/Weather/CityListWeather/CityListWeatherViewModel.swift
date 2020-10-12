//
//  CityListWeather.swift
//  WeatherDemo
//
//  Created by Smitesh Patel on 2020-10-11.
//

import Combine
import SwiftUI

// fetch current location of device

final class CityListWeatherViewModel: ObservableObject {
    @Published var dataSource: [CityWeatherRowViewModel] = []
    @Published var loading = false
    @Published var lastUpdate: String = "Test LastUpdate"
    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()
    let start = Date()
    init(
        weatherFetcher: WeatherFetchable,
        scheduler _: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
    ) {
        self.weatherFetcher = weatherFetcher
        refresh()
        startTimer()
    }

    // func get current location lat and long using combine
    func startTimer() {
        Timer.publish(every: 60.0, on: .main, in: .common)
            .autoconnect()
            .map { output in
                output.timeIntervalSince(self.start)
            }
            .map { timeInterval in
                Int(timeInterval)
            }
            .sink { [weak self] _ in
                self?.refresh()
            }
            .store(in: &disposables)
    }

    func refresh() {
        lastUpdate = timeFormatter.string(from: Date())
        fetchNearBy()
    }

    func fetchNearBy() {
        loading = true
        weatherFetcher.nearbyCurrentWeatherForecast(for: 43.65, lon: -79.34, count: 10)
            .map { response in
                response.list.map(CityWeatherRowViewModel.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    self.loading = false
                    switch value {
                    case .failure:
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] forecast in
                    guard let self = self else { return }
                    self.loading = false
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
