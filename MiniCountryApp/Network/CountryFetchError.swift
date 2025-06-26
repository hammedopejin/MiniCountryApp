//
//  CountryFetchError.swift
//  MiniCountryApp
//
//  Created by Hammed opejin on 6/25/25.
//



enum CountryFetchError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case nodataError
}
