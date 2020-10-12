//
//  CityListWeather.swift
//  WeatherDemo
//
//  Created by Smitesh Patel on 2020-10-11.
//

import SwiftUI

extension WeeklyWeatherBuilder {
    static func makeWeeklyWeatherView(
        weatherFetcher: WeatherFetchable
    ) -> some View {
        let viewModel = WeeklyWeatherViewModel(weatherFetcher: weatherFetcher)
        return WeeklyWeatherView(viewModel: viewModel)
    }
}
