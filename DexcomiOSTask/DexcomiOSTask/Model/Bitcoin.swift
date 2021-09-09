//
//  Bitcoin.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation

struct CurrencyData: Decodable {
    var bpi: bpi
}
struct bpi: Decodable {
    var usd: USD
    var gbp: GBP
    var eur: EUR
}
struct USD: Decodable {
    var rate: String
    var description: String
    var currency: String
}
struct GBP: Decodable {
    var rate: String
    var description: String
    var currency: String
}

struct EUR: Decodable {
    var rate: String
    var description: String
    var currency: String
}
