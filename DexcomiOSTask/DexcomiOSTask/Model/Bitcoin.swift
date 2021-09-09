//
//  Bitcoin.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation

/// I tried implementing bpi model in order to access these three dictionaries USD, GBP, EUR, but it didn't decode properly. So, I made individual models for them.
struct USD: Decodable {
    var rate: String
    var description: String
    var code: String
    
    enum CodingKeys: String, CodingKey {
        case bpi
        case USD
        case rate
        case description
        case code
    }
    /// Initializer wil access access the dicitionaries by decoder and set the keys to the properties```
    /// - Parameter decoder: Decoder to access CodingKeys.
    init(from decoder: Decoder) throws {
        // here we are getting the container to access coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // we are accessing bpi dictionary since the USD dictionary is inside the bpi dictionary
        let bpiDictionary = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .bpi)
        // once, we have the bpi dictionary we will use that to acess usd dictionary
        let usdDictionary = try bpiDictionary.nestedContainer(keyedBy: CodingKeys.self, forKey: .USD)
        // set the properties to the keys.
        rate = try usdDictionary.decode(String.self, forKey: .rate)
        description = try usdDictionary.decode(String.self, forKey: .description)
        code = try usdDictionary.decode(String.self, forKey: .code)
    }
}

struct GBP: Decodable {
    var rate: String
    var description: String
    var code: String
    enum CodingKeys: String, CodingKey {
        case bpi
        case GBP
        case rate
        case description
        case code
    }
    /// Initializer wil access access the dicitionaries by decoder and set the keys to the properties```
    /// - Parameter decoder: Decoder to access CodingKeys.
    init(from decoder: Decoder) throws {
        // here we are getting the container to access codingkeys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // we are accessing bpi dictionary since the GBP dictionary is inside the bpi dictionary
        let bpiDictionary = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .bpi)
        // once, we have the bpi dictionary we will use that to acess GBP dictionary
        let gbpDictionary = try bpiDictionary.nestedContainer(keyedBy: CodingKeys.self, forKey: .GBP)
        // set the properties to the keys.
        rate = try gbpDictionary.decode(String.self, forKey: .rate)
        description = try gbpDictionary.decode(String.self, forKey: .description)
        code = try gbpDictionary.decode(String.self, forKey: .code)
    }
}

struct EUR: Decodable {
    var rate: String
    var description: String
    var code: String
    
    enum CodingKeys: String, CodingKey {
        case bpi
        case EUR
        case rate
        case description
        case code
    }
    /// Initializer wil access access the dicitionaries by decoder and set the keys to the properties```
    /// - Parameter decoder: Decoder to access CodingKeys.
    init(from decoder: Decoder) throws {
        // here we are getting the container to access codingkeys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // we are accessing bpi dictionary since the EUR dictionary is inside the bpi dictionary
        let bpiDictionary = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .bpi)
        // once, we have the bpi dictionary we will use that to acess EUR dictionary
        let eurDictionary = try bpiDictionary.nestedContainer(keyedBy: CodingKeys.self, forKey: .EUR)
        // set the properties to the keys.
        rate = try eurDictionary.decode(String.self, forKey: .rate)
        description = try eurDictionary.decode(String.self, forKey: .description)
        code = try eurDictionary.decode(String.self, forKey: .code)
    }
}

