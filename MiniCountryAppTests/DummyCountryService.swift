//
//  DummyCountryService.swift
//  MiniCountryAppTests
//
//  Created by Hammed opejin on 6/25/25.
//

import Foundation
@testable import MiniCountryApp


class DummyCountryService:CountryServiceActions{
    var path: String = ""
    
    func fetchCountries<T>(endpoint: String, modelType: T.Type, completion: @escaping (Result<T, MiniCountryApp.CountryFetchError>) -> Void) where T : Decodable {
        let bundle = Bundle(for: DummyCountryService.self)
        guard let url = bundle.url(forResource: path, withExtension: "json") else{
            completion(.failure(.invalidURL))
            return
        }
        do{
            let data = try Data(contentsOf: url)
            let countries = try JSONDecoder().decode(modelType.self, from: data)

            completion(.success(countries))

        }catch{
            completion(.failure(.decodingError(error)))

        }
    }
    
}


