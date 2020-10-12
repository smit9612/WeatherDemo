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
            List(viewModel.dataSource) { rowviewModel in
                NavigationLink(destination: viewModel.weeklyWeatherView(for: rowviewModel.name)) {
                    CityWeatherRowView(viewModel: rowviewModel)
                }
            }.listStyle(GroupedListStyle())
                .navigationBarTitle("Weather ⛅️")
        }
    }
}
