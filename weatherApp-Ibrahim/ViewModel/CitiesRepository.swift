//
//  CitiesRepository.swift
//  weatherApp-Ibrahim
//
//  Created by Ibrahim Zakarya on 09/09/2022.
//

import Foundation
import Combine

class CitiesRepository: CitiesLocalRepository {
    
    func fetchCities() -> [CitiesResponse]? {
        if let path = Bundle.main.path(forResource: "weather_14", ofType: "json") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let citiesJSON = data.components(separatedBy: .newlines)
                var arr: [CitiesResponse] = []
                for json in citiesJSON {
                    if json == "" {
                        continue
                    }
                    guard let data = json.data(using: .utf8) else { return nil }
                    do {
                        let city = try JSONDecoder().decode(CitiesResponse.self, from: data)
                        arr.append(city)
                    } catch let DecodingError.typeMismatch(type, context) {
                        print(type, context)
                    }
                }
                return arr
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    
}

protocol CitiesRemoteRepository {
    func fetchCities() -> AnyPublisher<[CitiesResponse], Error>
}


protocol CitiesLocalRepository {
    func fetchCities() -> [CitiesResponse]?
}
