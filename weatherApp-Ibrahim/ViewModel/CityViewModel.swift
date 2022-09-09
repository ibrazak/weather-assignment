//
//  CityViewModel.swift
//  weatherApp-Ibrahim
//
//  Created by Ibrahim Zakarya on 09/09/2022.
//

import Foundation

class CityViewModel {
    
    private let city: City?
    private let temp: Double?
    
    init(city: City?, temp: Double?) {
        self.city = city
        self.temp = temp
    }
    
    func getCityName() -> String? {
        return city?.name
    }
    
    func getCountryName() -> String? {
        return city?.country
    }
    
    func getCityTemp() -> String? {
        if let temp = temp {
            let tempString = String(temp)
            return "\(tempString)°F"
        }
        return "-"
    }
    
    func getCoordinatesLabel() -> String? {
        if let city = city {
            return "Lat: \(city.coord.lat), Long: \(city.coord.lon)"
        }
        return "-"
    }
}
