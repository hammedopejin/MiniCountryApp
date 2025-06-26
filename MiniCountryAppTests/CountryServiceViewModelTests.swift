//
//  CountryServiceViewModelTests.swift
//  MiniCountryAppTests
//
//  Created by Hammed opejin on 6/25/25.
//

import XCTest
@testable import MiniCountryApp

final class CountryServiceViewModelTests: XCTestCase {

    var viewModel:CountryServiceViewModel!
    var manager: DummyCountryService!
    
    override func setUpWithError() throws {
        manager = DummyCountryService()
        viewModel = CountryServiceViewModel(countryService: manager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testGetCountriesListFromAPI_WhenWeExpectCorrectData()  {
        
        //given
        let expectation = XCTestExpectation(description: "Wait for countries to load")
        
        //when
        manager.path = "CountriesTest"
        viewModel.refreshCountryListViewController = {
            expectation.fulfill()
        }
        
        viewModel.getCountriesList()
        // Then
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(self.viewModel)
        XCTAssertEqual(self.viewModel.filteredCountries.count,4)
        
        
        let firstCountry = self.viewModel.filteredCountries.first
        XCTAssertEqual(firstCountry?.name,"Afghanistan")
        XCTAssertEqual(firstCountry?.capital,"Kabul")
        XCTAssertEqual(firstCountry?.code,"AF")
        XCTAssertEqual(firstCountry?.region,"AS")
        
        
        
    }

    func testGetCountriesListFromAPI_WhenWeDontExpectDataAsURLIsWrong()  {
        
        //given
        let expectation = XCTestExpectation(description: "Wait for countries to load")
        
        //when
        manager.path = "invalid"
        viewModel.refreshCountryListViewController = {
            expectation.fulfill()
        }
        viewModel.showError = { errorMsg in
            XCTAssertNotNil(errorMsg)
            expectation.fulfill()
        }

        
        viewModel.getCountriesList()
        // Then
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(self.viewModel)
        XCTAssertEqual(self.viewModel.filteredCountries.count,0)
    }
    
    func testGetCountriesListFromAPI_WhenWeExpect_CorrectSearchFunctionality()  {
        
        //given
        let expectation = XCTestExpectation(description: "Checking search feature")
         
        //when
        manager.path = "CountriesTest"
        viewModel.refreshCountryListViewController = {
            expectation.fulfill()
        }
        
        
        viewModel.getCountriesList()
        XCTAssertNotNil(self.viewModel)
        viewModel.filterCountriesList(for: "Kabul")

        //Then - Before Search
        wait(for: [expectation], timeout: 5)
        

        
        viewModel.refreshCountryListViewController = {
            XCTAssertEqual(self.viewModel.filteredCountries.count,1)
            expectation.fulfill()
        }
        
    }
    func testGetCountriesListFromAPI_WhenWeDontExpectDataAs_ItThrowsParssongError()  {
        
        //given
        let expectation = XCTestExpectation(description: "expecting parsing error")
        
        //when
        manager.path = "CountriesTestWithParssingError"
        viewModel.refreshCountryListViewController = {
            expectation.fulfill()
        }
        viewModel.showError = { errorMsg in
            XCTAssertNotNil(errorMsg)
            expectation.fulfill()
        }

        
        viewModel.getCountriesList()
        // Then
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(self.viewModel)
        XCTAssertEqual(self.viewModel.filteredCountries.count,0)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
