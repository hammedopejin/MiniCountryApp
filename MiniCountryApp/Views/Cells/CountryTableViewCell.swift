//
//  CountryTableViewCell.swift
//  MiniCountryApp
//
//  Created by Hammed opejin on 6/25/25.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameRegionLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground

        nameRegionLabel.textColor = .label
        codeLabel.textColor = .label
        capitalLabel.textColor = .secondaryLabel

        configureFonts()
    }

    private func configureFonts() {
        nameRegionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameRegionLabel.adjustsFontForContentSizeCategory = true
        nameRegionLabel.textAlignment = .left

        codeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        codeLabel.adjustsFontForContentSizeCategory = true
        codeLabel.textAlignment = .right

        capitalLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        capitalLabel.adjustsFontForContentSizeCategory = true
        capitalLabel.textColor = .secondaryLabel
        capitalLabel.textAlignment = .left
    }


    func configure(with country: Country) {
        nameRegionLabel.text = "\(country.name), \(country.region)"
        codeLabel.text = country.code
        capitalLabel.text = country.capital
    }
}

