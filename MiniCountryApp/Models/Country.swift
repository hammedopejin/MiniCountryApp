//
//  Country.swift
//  MiniCountryApp
//
//  Created by Hammed opejin on 6/25/25.
//

import Foundation

struct Country: Decodable {
    let name: String
    let region: String
    let code: String
    let capital: String
}
