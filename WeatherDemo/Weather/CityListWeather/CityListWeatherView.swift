//
//  CityListWeather.swift
//  WeatherDemo
//
//  Created by Smitesh Patel on 2020-10-11.
//

import Combine
import SwiftUI

struct CityListWeatherView: View {
    @ObservedObject var viewModel: CityListWeatherViewModel

    init(viewModel: CityListWeatherViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                forecastSection
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Weather ⛅️")
        }
    }
}

extension CityListWeatherView {
    var forecastSection: some View {
        Section {
            ForEach(viewModel.dataSource, content: CityWeatherRowView.init(viewModel:))
        }
    }
}
