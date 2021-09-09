//
//  Coin.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation

/// The Struct ``Coin`` will access the coin list array to decode
struct Coin: Decodable {
    let name: String
    let symbol: String
    let rank: Int
    // we don't need enum codingkeys because our properties have the same name as the api keys
    init(name: String, symbol: String, rank: Int) {
        self.name = name
        self.symbol = symbol
        self.rank = rank
    }
    
    
}
