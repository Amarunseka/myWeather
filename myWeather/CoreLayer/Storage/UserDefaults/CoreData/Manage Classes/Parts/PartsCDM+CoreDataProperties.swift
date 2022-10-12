//
//  PartsCDM+CoreDataProperties.swift
//  practiceCoreDataWithWeather
//
//  Created by Миша on 05.10.2022.
//
//

import Foundation
import CoreData


extension PartsCDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PartsCDM> {
        return NSFetchRequest<PartsCDM>(entityName: "PartsCDM")
    }

    @NSManaged public var cloudness: Double
    @NSManaged public var condition: String?
    @NSManaged public var feelsLike: Int64
    @NSManaged public var humidity: Int64
    @NSManaged public var tempAvg: Int64
    @NSManaged public var tempMax: Int64
    @NSManaged public var tempMin: Int64
    @NSManaged public var uvIndex: Int64
    @NSManaged public var windDir: String?
    @NSManaged public var windSpeed: Double
    @NSManaged public var forecast: ForecastCDM?

}

extension PartsCDM : Identifiable {

}
