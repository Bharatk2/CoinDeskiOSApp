//
//  GBPViewModel.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation
/// Our class ``GBPViewModel``is an observable object where we can set the values before the publisher changes the values. It overtakes the upcoming values from publisher
// In order to conform to observable object we need hashable.
class GBPViewModel: ObservableObject, Hashable {
    @Published var rate: String
    @Published var description: String
    @Published var currency: String
    
    init(gbp: GBP) {
        self.currency = gbp.code
        self.rate = gbp.rate
        self.description = gbp.description
    }

    static func == (lhs: GBPViewModel, rhs: GBPViewModel) -> Bool {
        lhs.currency == rhs.currency && lhs.rate == rhs.rate && lhs.description == rhs.description
    }
// Hashable has to conform to equatable so we need to ad equatable method
    func hash(into hasher: inout Hasher) {
        hasher.combine(rate)
        hasher.combine(description)
        hasher.combine(currency)
    }
}
