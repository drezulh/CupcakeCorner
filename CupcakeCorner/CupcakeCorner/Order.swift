//
//  Order.swift
//  CupcakeCorner
//
//  Created by Gorkem Turan on 01/01/2023.
//

import SwiftUI



class Order: ObservableObject {
//    enum CodingKeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
    
    enum CodingKeys: CodingKey {
        case item
    }

    @Published var item = Item()
    
    init() { }

// Below code is used, if Order class is Codable. We do not need if only Item struct is enough to be codable
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(item, forKey: .item)
//
// below code is used if variables inside the struct move inside class
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
// -------
    }
// Below code is used, if Order class is Codable. We do not need if only Item struct is enough to be codable
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        item = try container.decode(Item.self, forKey: .item)
//----------------------
//
//
// below code is used if variables inside the struct move inside class
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//--------------------
//    }
//}
