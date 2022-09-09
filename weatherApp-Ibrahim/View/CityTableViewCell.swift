//
//  CityTableViewCell.swift
//  weatherApp-Ibrahim
//
//  Created by Ibrahim Zakarya on 09/09/2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(cityViewModel: CityViewModel) {
        cityNameLabel.text = cityViewModel.getCityName()
        temperatureLabel.text = cityViewModel.getCityTemp()
        countryNameLabel.text = cityViewModel.getCountryName()
        coordinatesLabel.text = cityViewModel.getCoordinatesLabel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
