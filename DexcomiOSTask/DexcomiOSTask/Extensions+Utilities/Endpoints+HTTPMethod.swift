//
//  Endpoints+HTTPMethod.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation

enum Endpoints {
    static let currencyBaseURL = "https://api.coindesk.com/v1/bpi"
    static let coinBaseURL = "https://api.coinpaprika.com/v1/"
    case currencies
    case coinsList

   
    
    /// We are using switch for stringValue computed property by going through all the cases
    /// so we can add specific parameters like category to the url so we can fetch we need.
    var stringValue: String {
        switch self {
        case .currencies:
            return Endpoints.currencyBaseURL + "/currentprice.json"
        case .coinsList:
            return Endpoints.coinBaseURL + "coins"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
