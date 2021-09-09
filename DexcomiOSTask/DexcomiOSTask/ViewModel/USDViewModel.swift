//
//  CurrencyViewModel.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation

/// Our class ``USDViewMode``is an observable object where we can set the values before the publisher changes the values. It overtakes the upcoming values from publisher
// In order to conform to observable object we need hashable.
class USDViewModel: ObservableObject, Hashable {
    @Published var rate: String
    @Published var description: String
    @Published var currency: String
    
    init(usd: USD) {
        self.currency = usd.code
        self.rate = usd.rate
        self.description = usd.description
    }
    // Hashable has to conform to equatable so we need to ad equatable method
    static func == (lhs: USDViewModel, rhs: USDViewModel) -> Bool {
        lhs.currency == rhs.currency && lhs.rate == rhs.rate && lhs.description == rhs.description
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(rate)
        hasher.combine(description)
        hasher.combine(currency)
    }
}
