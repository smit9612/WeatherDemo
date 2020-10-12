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
        if viewModel.loading {
            ProgressView("Loading...")
                .scaleEffect(1.5, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .foregroundColor(.blue)
        } else {
            NavigationView {
                List {
                    lastUpdateSection
                    cityListSection

                }.listStyle(GroupedListStyle())
                    .navigationBarTitle("Weather ⛅️")
            }
        }
    }
}

private extension CityListWeatherView {
    var cityListSection: some View {
        Section {
            ForEach(viewModel.dataSource) { rowViewModel in
                NavigationLink(destination: viewModel.weeklyWeatherView(for: rowViewModel.name)) {
                    CityWeatherRowView(viewModel: rowViewModel)
                }
            }
        }
    }

    var lastUpdateSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Last Update Weather at \(viewModel.lastUpdate)")
            }
        }
    }
}
