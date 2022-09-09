//
//  CitiesViewModel.swift
//  weatherApp-Ibrahim
//
//  Created by Ibrahim Zakarya on 07/09/2022.
//

import Foundation
import Combine

class CitiesViewModel {
    
    let repo: CitiesRepository
    var updateViewsSubject: PassthroughSubject<String?, Never> = .init()
    var error: String?
    private var cities: [CitiesResponse] = []
    
    
    init(repo: CitiesRepository) {
        self.repo = repo
        readFile()
    }
    
    private func readFile() {
        if let cities = repo.fetchCities() {
            self.cities = cities
        } else {
            self.error = "Couldn't read data from local storage"
        }
//        if let path = Bundle.main.path(forResource: "weather_14", ofType: "json") {
//            do {
//                let data = try String(contentsOfFile: path, encoding: .utf8)
//                let citiesJSON = data.components(separatedBy: .newlines)
//                var arr: [CitiesResponse] = []
//                for json in citiesJSON {
//                    if json == "" {
//                        continue
//                    }
//                    guard let data = json.data(using: .utf8) else { return }
//                    do {
//                        let city = try JSONDecoder().decode(CitiesResponse.self, from: data)
//                        arr.append(city)
//                    } catch let DecodingError.typeMismatch(type, context) {
//                        print(type, context)
//                        self.error = "Some cities could not be paresed"
//                    }
//                }
//                self.cities = arr
//            } catch {
//                print(error)
//            }
//        }
    }
    
    func getCitiesViewModels() -> [CityViewModel] {
        return self.cities.map({ CityViewModel(city: $0.city, temp: $0.main?.temp) })
    }
}
