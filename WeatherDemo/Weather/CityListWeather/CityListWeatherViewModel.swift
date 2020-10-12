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
    @Published var lastUpdate: String = ""

    @ObservedObject var locationManager = LocationManager()

    var userLatitude: Double = 43.65
//    {
//        (locationManager.lastLocation?.coordinate.latitude ?? 43.65).round(to: 2)
//    }

    var userLongitude: Double = -79.34
//    {
//        (locationManager.lastLocation?.coordinate.longitude ?? -79.34).round(to: 2)
//    }

    var statusString: String {
        locationManager.statusString
    }

    var count = 0
    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()
    let start = Date()
    init(
        weatherFetcher: WeatherFetchable,
        scheduler _: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
    ) {
        self.weatherFetcher = weatherFetcher
        locationManager.$lastLocation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                guard let self = self else { return }
                self.userLatitude = (location?.coordinate.latitude ?? 0.0).round(to: 2)
                self.userLongitude = (location?.coordinate.longitude ?? 0.0).round(to: 2)
                self.refresh()
                self.startTimer()
            }
            .store(in: &disposables)
    }

    // func get current location lat and long using combine
    func startTimer() {
        Timer.publish(every: 10.0, on: .main, in: .common)
            .autoconnect()
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
        weatherFetcher.nearbyCurrentWeatherForecast(for: userLatitude, lon: userLongitude, count: 10)
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
