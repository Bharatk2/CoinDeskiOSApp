//
//  EURViewModel.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation

class EURViewModel: ObservableObject, Hashable {
    @Published var rate: String
    @Published var description: String
    @Published var currency: String
    
    init(usd: EUR) {
        self.currency = usd.currency
        self.rate = usd.rate
        self.description = usd.description
    }

    static func == (lhs: EURViewModel, rhs: EURViewModel) -> Bool {
        lhs.currency == rhs.currency && lhs.rate == rhs.rate && lhs.description == rhs.description
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(rate)
        hasher.combine(description)
        hasher.combine(currency)
    }
}
