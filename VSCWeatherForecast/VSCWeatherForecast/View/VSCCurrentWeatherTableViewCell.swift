//
//  VSCCurrentWeatherView.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

class VSCCurrentWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var citryName: UILabel!
    @IBOutlet weak var weatherTemperatureMax: UILabel!
    @IBOutlet weak var weatherTemperatureMin: UILabel!
    @IBOutlet weak var weatherTemperature: UILabel!
    @IBOutlet weak var weatherhumidity: UILabel!
    @IBOutlet weak var weatherPressur: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    
    var weatherItem : VSCCurrentWeather? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateView() {
        if let weatherItem = weatherItem {
            
            if let humidity  = weatherItem.humidity{
                self.weatherhumidity.text = String(describing: humidity) + "%"

            }
            
            if let tempMax  = weatherItem.tempMax{
                self.weatherTemperatureMax.text = String(describing: Int(tempMax)) + "°"

            }
            
            if let tempMin  = weatherItem.tempMin{
                self.weatherTemperatureMin.text = String(describing: Int(tempMin)) + "°"

            }
            
            if let temp  = weatherItem.temp{
                self.weatherTemperature.text = String(describing: Int(temp)) + "°"

            }
            
            if let pressure  = weatherItem.pressure{
                self.weatherPressur.text = String(describing: pressure) + "hPa"

            }
            
            if let weather = weatherItem.weather, let weatherDescription = weather.weatherDescription {
                self.weatherDescription.text = String(describing: weatherDescription)
            }
        }
    
    }
}
