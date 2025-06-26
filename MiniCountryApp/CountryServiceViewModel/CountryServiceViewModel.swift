//
//  CountryServiceViewModel.swift
//  MiniCountryApp
//
//  Created by Hammed opejin on 6/25/25.
//

import Foundation

class CountryServiceViewModel {
    let countryService: CountryServiceActions
     var countries: [Country] = []
     var filteredCountries: [Country] = []
    var refreshCountryListViewController: (()-> Void)?
    var showError: ((String)-> Void)?

    init(countryService: CountryServiceActions) {
        self.countryService = countryService
    }
    
    func getCountriesList()  {
        self.countryService.fetchCountries(endpoint: Endpoints.CountryServiceEndpoint, modelType: [Country].self) { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countries = countries
                self?.filteredCountries = countries
                self?.refreshCountryListViewController?()
            case .failure(let error):
                self?.showError?("Error loading countries: \(error.localizedDescription)")
            }
        }
    }
    
    func filterCountriesList(for searchText: String) {
        guard !searchText.isEmpty else {
            self.filteredCountries = self.countries
            refreshCountryListViewController?()
            return
        }

        self.filteredCountries = self.countries.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.capital.localizedCaseInsensitiveContains(searchText)
        }
        refreshCountryListViewController?()
    }
}
