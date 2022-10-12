//
//  WeatherCDM+CoreDataProperties.swift
//  practiceCoreDataWithWeather
//
//  Created by Миша on 05.10.2022.
//
//

import Foundation
import CoreData


extension WeatherCDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherCDM> {
        return NSFetchRequest<WeatherCDM>(entityName: "WeatherCDM")
    }

    @NSManaged public var city: String?
    @NSManaged public var now: Int64
    @NSManaged public var fact: FactCDM?
    @NSManaged public var forecasts: NSOrderedSet?

}

// MARK: Generated accessors for forecasts
extension WeatherCDM {

    @objc(insertObject:inForecastsAtIndex:)
    @NSManaged public func insertIntoForecasts(_ value: ForecastCDM, at idx: Int)

    @objc(removeObjectFromForecastsAtIndex:)
    @NSManaged public func removeFromForecasts(at idx: Int)

    @objc(insertForecasts:atIndexes:)
    @NSManaged public func insertIntoForecasts(_ values: [ForecastCDM], at indexes: NSIndexSet)

    @objc(removeForecastsAtIndexes:)
    @NSManaged public func removeFromForecasts(at indexes: NSIndexSet)

    @objc(replaceObjectInForecastsAtIndex:withObject:)
    @NSManaged public func replaceForecasts(at idx: Int, with value: ForecastCDM)

    @objc(replaceForecastsAtIndexes:withForecasts:)
    @NSManaged public func replaceForecasts(at indexes: NSIndexSet, with values: [ForecastCDM])

    @objc(addForecastsObject:)
    @NSManaged public func addToForecasts(_ value: ForecastCDM)

    @objc(removeForecastsObject:)
    @NSManaged public func removeFromForecasts(_ value: ForecastCDM)

    @objc(addForecasts:)
    @NSManaged public func addToForecasts(_ values: NSOrderedSet)

    @objc(removeForecasts:)
    @NSManaged public func removeFromForecasts(_ values: NSOrderedSet)

}

extension WeatherCDM : Identifiable {

}
