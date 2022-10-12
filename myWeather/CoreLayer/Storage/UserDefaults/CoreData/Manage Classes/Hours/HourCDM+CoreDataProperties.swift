//
//  HourCDM+CoreDataProperties.swift
//  practiceCoreDataWithWeather
//
//  Created by Миша on 05.10.2022.
//
//

import Foundation
import CoreData


extension HourCDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HourCDM> {
        return NSFetchRequest<HourCDM>(entityName: "HourCDM")
    }

    @NSManaged public var cloudness: Double
    @NSManaged public var condition: String?
    @NSManaged public var feelsLike: Int64
    @NSManaged public var hourTs: Int64
    @NSManaged public var temp: Int64
    @NSManaged public var windDir: String?
    @NSManaged public var windSpeed: Double
    @NSManaged public var forecast: ForecastCDM?

}

extension HourCDM : Identifiable {

}
