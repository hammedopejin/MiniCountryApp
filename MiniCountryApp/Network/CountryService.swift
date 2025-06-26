//
//  CountryService.swift
//  MiniCountryApp
//
//  Created by Hammed opejin on 6/25/25.
//

import Foundation

protocol CountryServiceActions {
    func fetchCountries<T: Decodable>(endpoint:String, modelType:T.Type, completion: @escaping (Result<T, CountryFetchError>) -> Void)
}

class CountryService: CountryServiceActions{
    let urlSession: URLSession
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchCountries<T: Decodable>(endpoint:String,modelType:T.Type,  completion: @escaping (Result<T, CountryFetchError>) -> Void)
 {
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }

        self.urlSession.dataTask(with: url) { data, _, error  in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.networkError(CountryFetchError.nodataError)))
                return
            }

            do {
                let countries = try JSONDecoder().decode(modelType.self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}

