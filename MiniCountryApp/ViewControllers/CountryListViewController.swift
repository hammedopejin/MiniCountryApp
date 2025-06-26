//
//  CountryListViewController.swift
//  MiniCountryApp
//
//  Created by Hammed opejin on 6/25/25.
//

import UIKit

class CountryListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let searchController = UISearchController(searchResultsController: nil)
    private let countryService = CountryService()
    private var viewModel = CountryServiceViewModel(countryService: CountryService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Countries"

        setupTableView()
        setupSearchController()
        fetchCountries()
        viewModel.showError = { [weak self] message in
            DispatchQueue.main.async {
                self?.presentErrorAlert(message: message)
            }
        }
        viewModel.refreshCountryListViewController = {
            [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by name or capital"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.tintColor = .label
        searchController.searchBar.barTintColor = .systemBackground
        searchController.searchBar.backgroundColor = .systemBackground

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    private func fetchCountries() {
        viewModel.getCountriesList()
    }

    private func presentErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in
            self.fetchCountries()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource & Delegate

extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCountries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryTableViewCell
        else {
            return UITableViewCell()
        }

        let country = viewModel.filteredCountries[indexPath.row]
        cell.configure(with: country)
        return cell
    }
}

// MARK: - UISearchResultsUpdating

extension CountryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterCountriesList(for: searchController.searchBar.text ?? "")
    }
}
