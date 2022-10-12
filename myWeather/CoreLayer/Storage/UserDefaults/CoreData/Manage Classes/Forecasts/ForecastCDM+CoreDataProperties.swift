//
//  ForecastCDM+CoreDataProperties.swift
//  practiceCoreDataWithWeather
//
//  Created by Миша on 05.10.2022.
//
//

import Foundation
import CoreData


extension ForecastCDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastCDM> {
        return NSFetchRequest<ForecastCDM>(entityName: "ForecastCDM")
    }

    @NSManaged public var date: String?
    @NSManaged public var dateTs: Int64
    @NSManaged public var sunrise: String?
    @NSManaged public var sunset: String?
    @NSManaged public var hours: NSOrderedSet?
    @NSManaged public var parts: NSOrderedSet?
    @NSManaged public var weather: WeatherCDM?

}

// MARK: Generated accessors for hours
extension ForecastCDM {

    @objc(insertObject:inHoursAtIndex:)
    @NSManaged public func insertIntoHours(_ value: HourCDM, at idx: Int)

    @objc(removeObjectFromHoursAtIndex:)
    @NSManaged public func removeFromHours(at idx: Int)

    @objc(insertHours:atIndexes:)
    @NSManaged public func insertIntoHours(_ values: [HourCDM], at indexes: NSIndexSet)

    @objc(removeHoursAtIndexes:)
    @NSManaged public func removeFromHours(at indexes: NSIndexSet)

    @objc(replaceObjectInHoursAtIndex:withObject:)
    @NSManaged public func replaceHours(at idx: Int, with value: HourCDM)

    @objc(replaceHoursAtIndexes:withHours:)
    @NSManaged public func replaceHours(at indexes: NSIndexSet, with values: [HourCDM])

    @objc(addHoursObject:)
    @NSManaged public func addToHours(_ value: HourCDM)

    @objc(removeHoursObject:)
    @NSManaged public func removeFromHours(_ value: HourCDM)

    @objc(addHours:)
    @NSManaged public func addToHours(_ values: NSOrderedSet)

    @objc(removeHours:)
    @NSManaged public func removeFromHours(_ values: NSOrderedSet)

}

// MARK: Generated accessors for parts
extension ForecastCDM {

    @objc(insertObject:inPartsAtIndex:)
    @NSManaged public func insertIntoParts(_ value: PartsCDM, at idx: Int)

    @objc(removeObjectFromPartsAtIndex:)
    @NSManaged public func removeFromParts(at idx: Int)

    @objc(insertParts:atIndexes:)
    @NSManaged public func insertIntoParts(_ values: [PartsCDM], at indexes: NSIndexSet)

    @objc(removePartsAtIndexes:)
    @NSManaged public func removeFromParts(at indexes: NSIndexSet)

    @objc(replaceObjectInPartsAtIndex:withObject:)
    @NSManaged public func replaceParts(at idx: Int, with value: PartsCDM)

    @objc(replacePartsAtIndexes:withParts:)
    @NSManaged public func replaceParts(at indexes: NSIndexSet, with values: [PartsCDM])

    @objc(addPartsObject:)
    @NSManaged public func addToParts(_ value: PartsCDM)

    @objc(removePartsObject:)
    @NSManaged public func removeFromParts(_ value: PartsCDM)

    @objc(addParts:)
    @NSManaged public func addToParts(_ values: NSOrderedSet)

    @objc(removeParts:)
    @NSManaged public func removeFromParts(_ values: NSOrderedSet)

}

extension ForecastCDM : Identifiable {

}
