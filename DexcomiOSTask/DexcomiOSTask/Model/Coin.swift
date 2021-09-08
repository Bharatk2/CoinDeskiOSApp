//
//  Coin.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation

struct Coin: Decodable {
    let name: String
    let symbol: String
    let rank: Int
    
    init(name: String, symbol: String, rank: Int) {
        self.name = name
        self.symbol = symbol
        let rank = rank
    }
}
