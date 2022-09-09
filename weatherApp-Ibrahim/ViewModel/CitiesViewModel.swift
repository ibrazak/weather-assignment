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
    
    private var cities: [CitiesResponse] {
        get {
            if isFiltering {
                return filteredCities
            } else {
                return allCities
            }
        }
    }
    private var filteredCities: [CitiesResponse] = []
    private var allCities: [CitiesResponse] = []
    private var isFiltering: Bool = false
    
    init(repo: CitiesRepository) {
        self.repo = repo
        readFile()
    }
    
    private func readFile() {
        if let cities = repo.fetchCities() {
            self.allCities = cities
        } else {
            self.error = "Couldn't read data from local storage"
        }
    }
    
    func search(_ searchTerm: String) {
        isFiltering = searchTerm == "" ? false : true
        filteredCities = allCities.filter({ $0.city?.name.contains(searchTerm) == true })
        updateViewsSubject.send(nil)
    }
    
    func getCitiesViewModels() -> [CityViewModel] {
        return self.cities.map({ CityViewModel(city: $0.city, temp: $0.main?.temp) })
    }
}
