//
//  CityInfoModel.swift
//  myWeather
//
//  Created by Миша on 14.08.2022.
//

import Foundation

struct CityInfoModelContainer: Decodable {
    var coordinates = String()
    var address = String()
    var weather: WeatherModel?
    
    var keyedValues: [String: Any] {
        return [
            "coordinates": self.coordinates,
            "address": self.address,
            "weather": self.weather ?? nil
        ]
    }


    enum CodingKeys: String, CodingKey {
        case response
    }
    
    private enum ResponseKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
    
    private enum GeoObjectCollectionKeys: String, CodingKey {
        case featureMember = "featureMember"
    }
    
    private  enum FeatureMemberKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
    
    private enum GeoObjectKeys: String, CodingKey {
        case point = "Point"
        case metaDataProperty
    }
    
    private enum PointKey: String, CodingKey {
        case pos
    }
    
    private enum MetaDataPropertyKeys: String, CodingKey {
        case geocoderMetaData = "GeocoderMetaData"
        
        enum GeocoderMetaDataKeys: String, CodingKey {
            case address = "Address"
            
            enum AddressKeys: String, CodingKey {
                case formatted
            }
        }
    }

    init(from decoder: Decoder) throws {

        let mainContainer = try? decoder.container(keyedBy: CodingKeys.self)
        
        let responseContainer = try? mainContainer?.nestedContainer(keyedBy: ResponseKeys.self, forKey: .response)
        let geoObjectCollectionContainer = try? responseContainer?.nestedContainer(keyedBy: GeoObjectCollectionKeys.self, forKey: .geoObjectCollection)
        
        var featureMemberContainer = try? geoObjectCollectionContainer?.nestedUnkeyedContainer(forKey: .featureMember)
        let firstContainer = try? featureMemberContainer?.nestedContainer(keyedBy: FeatureMemberKeys.self)
        
        let geoObjectContainer = try? firstContainer?.nestedContainer(keyedBy: GeoObjectKeys.self, forKey: .geoObject)
        
        let pointContainer = try? geoObjectContainer?.nestedContainer(keyedBy: PointKey.self, forKey: .point)
        
        let metaDataPropertyContainer = try? geoObjectContainer?.nestedContainer(keyedBy: MetaDataPropertyKeys.self, forKey: .metaDataProperty)
        let geocoderMetaDataContainer = try? metaDataPropertyContainer?.nestedContainer(keyedBy: MetaDataPropertyKeys.GeocoderMetaDataKeys.self, forKey: .geocoderMetaData)
        let addressContainer = try? geocoderMetaDataContainer?.nestedContainer(keyedBy: MetaDataPropertyKeys.GeocoderMetaDataKeys.AddressKeys.self, forKey: .address)
        
        let pos = try? pointContainer?.decode(String.self, forKey: .pos)
        let formatted = try? addressContainer?.decode(String.self, forKey: .formatted)

        if let pos = pos,
           let formatted = formatted {
            self.coordinates = pos
            self.address = formatted
        }
    }
}





// MARK: - Old Spare Objects

//"response": {
//    "GeoObjectCollection": {
//
//        "featureMember": [
//            {
//                "GeoObject": {
//
//                    "Point": {
//                        "pos": "37.617698 55.755864"
//                    },
//                    "metaDataProperty": {
//                        "GeocoderMetaData": {
//                            "Address": {
//                                "formatted": "Russia, Moscow"
//                            }
//                        }
//                    }
//                }
//            }
//        ]
//    }
//}


//
//// MARK: - CoordinatesCoderModel
//struct CityInfoModel: Codable {
//    let response: Response
//}
//
//// MARK: - Response
//struct Response: Codable {
//    let geoObjectCollection: GeoObjectCollection
//
//    enum CodingKeys: String, CodingKey {
//        case geoObjectCollection = "GeoObjectCollection"
//    }
//}
//
//// MARK: - GeoObjectCollection
//struct GeoObjectCollection: Codable {
//    let featureMember: [FeatureMember]
//}
//
//// MARK: - FeatureMember
//struct FeatureMember: Codable {
//    let geoObject: GeoObjectCoder
//
//    enum CodingKeys: String, CodingKey {
//        case geoObject = "GeoObject"
//    }
//}
//
//// MARK: - GeoObject
//struct GeoObjectCoder: Codable {
//    let point: Point
//    let metaDataProperty: GeoObjectMetaDataProperty
//
//    enum CodingKeys: String, CodingKey {
//        case point = "Point"
//        case metaDataProperty
//    }
//}
//
//// MARK: - GeoObjectMetaDataProperty
//struct GeoObjectMetaDataProperty: Codable {
//    let geocoderMetaData: GeocoderMetaData
//
//    enum CodingKeys: String, CodingKey {
//        case geocoderMetaData = "GeocoderMetaData"
//    }
//}
//
//// MARK: - GeocoderMetaData
//struct GeocoderMetaData: Codable {
//    let address: Address
//
//    enum CodingKeys: String, CodingKey {
//        case address = "Address"
//    }
//}
//
//// MARK: - Address
//struct Address: Codable {
//    let formatted: String
//
//    enum CodingKeys: String, CodingKey {
//        case formatted
//    }
//}
//
//// MARK: - Point
//struct Point: Codable {
//    let pos: String
//}
//
//
//
//

