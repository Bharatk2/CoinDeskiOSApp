//
//  Bitcoin.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation

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
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let bpiDictionary = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .bpi)
        let usdDictionary = try bpiDictionary.nestedContainer(keyedBy: CodingKeys.self, forKey: .USD)
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
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let bpiDictionary = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .bpi)
        let gbpDictionary = try bpiDictionary.nestedContainer(keyedBy: CodingKeys.self, forKey: .GBP)
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
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let bpiDictionary = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .bpi)
        let eurDictionary = try bpiDictionary.nestedContainer(keyedBy: CodingKeys.self, forKey: .EUR)
        rate = try eurDictionary.decode(String.self, forKey: .rate)
        description = try eurDictionary.decode(String.self, forKey: .description)
        code = try eurDictionary.decode(String.self, forKey: .code)
    }
}

