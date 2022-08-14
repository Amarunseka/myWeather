//
//  CityInfoModel.swift
//  myWeather
//
//  Created by Миша on 14.08.2022.
//

import Foundation

// MARK: - CoordinatesCoderModel
struct CityInfoModel: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let geoObjectCollection: GeoObjectCollection

    enum CodingKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
}

// MARK: - GeoObjectCollection
struct GeoObjectCollection: Codable {
    let featureMember: [FeatureMember]
//    let metaDataProperty: GeoObjectCollectionMetaDataProperty
}

// MARK: - FeatureMember
struct FeatureMember: Codable {
    let geoObject: GeoObjectCoder

    enum CodingKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
}

// MARK: - GeoObject
struct GeoObjectCoder: Codable {
    let point: Point // оставить
//    let boundedBy: BoundedBy
//    let geoObjectDescription: String
    let metaDataProperty: GeoObjectMetaDataProperty
//    let name: String

    enum CodingKeys: String, CodingKey {
        case point = "Point"
//        case boundedBy
//        case geoObjectDescription = "description"
        case metaDataProperty
//        case name
    }
}

//// MARK: - BoundedBy
//struct BoundedBy: Codable {
//    let envelope: Envelope
//
//    enum CodingKeys: String, CodingKey {
//        case envelope = "Envelope"
//    }
//}

//// MARK: - Envelope
//struct Envelope: Codable {
//    let lowerCorner, upperCorner: String
//}

// MARK: - GeoObjectMetaDataProperty
struct GeoObjectMetaDataProperty: Codable {
    let geocoderMetaData: GeocoderMetaData

    enum CodingKeys: String, CodingKey {
        case geocoderMetaData = "GeocoderMetaData"
    }
}

// MARK: - GeocoderMetaData
struct GeocoderMetaData: Codable {
    let address: Address // оставить
//    let addressDetails: AddressDetails
//    let kind, precision, text: String

    enum CodingKeys: String, CodingKey {
        case address = "Address"
//        case addressDetails = "AddressDetails"
//        case kind, precision, text
    }
}

// MARK: - Address
struct Address: Codable {
//    let components: [Component]
//    let countryCode
    let formatted: String

    enum CodingKeys: String, CodingKey {
//        case components = "Components"
//        case countryCode = "country_code"
        case formatted
    }
}

// MARK: - Component
//struct Component: Codable {
//    let kind, name: String
//}

//// MARK: - AddressDetails
//struct AddressDetails: Codable {
//    let country: CountryCoder
//
//    enum CodingKeys: String, CodingKey {
//        case country = "Country"
//    }
//}

//// MARK: - Country
//struct CountryCoder: Codable {
//    let addressLine: String
//    let administrativeArea: AdministrativeArea
//    let countryName: String
//    let countryNameCode: String
//
//    enum CodingKeys: String, CodingKey {
//        case addressLine = "AddressLine"
//        case administrativeArea = "AdministrativeArea"
//        case countryName = "CountryName"
//        case countryNameCode = "CountryNameCode"
//    }
//}

//// MARK: - AdministrativeArea
//struct AdministrativeArea: Codable {
//    let administrativeAreaName: String
//
//    enum CodingKeys: String, CodingKey {
//        case administrativeAreaName = "AdministrativeAreaName"
//    }
//}

// MARK: - Point
struct Point: Codable {
    let pos: String
}

//// MARK: - GeoObjectCollectionMetaDataProperty
//struct GeoObjectCollectionMetaDataProperty: Codable {
//    let geocoderResponseMetaData: GeocoderResponseMetaData
//
//    enum CodingKeys: String, CodingKey {
//        case geocoderResponseMetaData = "GeocoderResponseMetaData"
//    }
//}
//
//// MARK: - GeocoderResponseMetaData
//struct GeocoderResponseMetaData: Codable {
//    let boundedBy: BoundedBy
//    let found, request, results: String
//}
