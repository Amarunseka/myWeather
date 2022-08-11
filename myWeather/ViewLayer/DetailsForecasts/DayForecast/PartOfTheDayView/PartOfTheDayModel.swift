//
//  PartOfTheDayModel.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import Foundation

struct PartOfTheDayModel {
    
    var name: String
    var temp: String
    var prescription: String
    var prescriptionIcon: String
    
    var feelsLike: String
    var wind: String
    var uvIndex: String
    var rain: String
    var cloudiness: String
        
    static var day = PartOfTheDayModel(name: "Day",
                                       temp: "13˚",
                                       prescription: "Rain",
                                       prescriptionIcon: "rainIcon",
                                       feelsLike: "11˚",
                                       wind: "5 m/s WSW",
                                       uvIndex: "4(medium)",
                                       rain: "55%",
                                       cloudiness: "72%")
    
    static var night = PartOfTheDayModel(name: "Night",
                                       temp: "0˚",
                                       prescription: "Rain",
                                       prescriptionIcon: "rainIcon",
                                       feelsLike: "0˚",
                                       wind: "5 m/s WSW",
                                       uvIndex: "4(medium)",
                                       rain: "55%",
                                       cloudiness: "72%")
}
