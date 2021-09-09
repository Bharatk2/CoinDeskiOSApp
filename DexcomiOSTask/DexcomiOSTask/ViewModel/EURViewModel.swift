//
//  EURViewModel.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation
/// Our class ``EURViewModel``is an observable object where we can set the values before the publisher changes the values. It overtakes the upcoming values from publisher
// In order to conform to observable object we need hashable.
class EURViewModel: ObservableObject, Hashable {
    @Published var rate: String
    @Published var description: String
    @Published var currency: String
    
    init(eur: EUR) {
        self.currency = eur.code
        self.rate = eur.rate
        self.description = eur.description
    }
    // Hashable has to conform to equatable so we need to ad equatable method
    static func == (lhs: EURViewModel, rhs: EURViewModel) -> Bool {
        lhs.currency == rhs.currency && lhs.rate == rhs.rate && lhs.description == rhs.description
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(rate)
        hasher.combine(description)
        hasher.combine(currency)
    }
}
