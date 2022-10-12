//
//  FactCDM+CoreDataProperties.swift
//  practiceCoreDataWithWeather
//
//  Created by Миша on 05.10.2022.
//
//

import Foundation
import CoreData


extension FactCDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FactCDM> {
        return NSFetchRequest<FactCDM>(entityName: "FactCDM")
    }

    @NSManaged public var cloudness: Double
    @NSManaged public var condition: String?
    @NSManaged public var feelsLike: Int64
    @NSManaged public var humidity: Int64
    @NSManaged public var temp: Int64
    @NSManaged public var windSpeed: Double
    @NSManaged public var weather: WeatherCDM?

}

extension FactCDM : Identifiable {

}
