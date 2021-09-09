//
//  GBPViewModel.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation

class GBPViewModel: ObservableObject, Hashable {
    @Published var rate: String
    @Published var description: String
    @Published var currency: String
    
    init(usd: GBP) {
        self.currency = usd.currency
        self.rate = usd.rate
        self.description = usd.description
    }

    static func == (lhs: GBPViewModel, rhs: GBPViewModel) -> Bool {
        lhs.currency == rhs.currency && lhs.rate == rhs.rate && lhs.description == rhs.description
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(rate)
        hasher.combine(description)
        hasher.combine(currency)
    }
}
