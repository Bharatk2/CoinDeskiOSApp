//
//  CoinViewModel.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation

class CoinViewModel: ObservableObject, Hashable {
    @Published var name: String
    @Published var symbol: String
    @Published var rank: Int
    
    init(coin: Coin) {
        self.name = coin.name
        self.symbol = coin.symbol
        self.rank = coin.rank
    }

    static func == (lhs: CoinViewModel, rhs: CoinViewModel) -> Bool {
        lhs.name == rhs.name && lhs.symbol == rhs.symbol && lhs.rank == rhs.rank
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(symbol)
        hasher.combine(rank)
    }
}
