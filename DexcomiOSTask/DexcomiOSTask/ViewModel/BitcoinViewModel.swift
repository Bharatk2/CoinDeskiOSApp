//
//  BitcoinViewModel.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation
import Combine

/// The class ``BitcoinViewModel``takes care of calling our fetching services call so we don't have to implement these in our view controllers.
class BitcoinViewModel: ObservableObject {
    
    // MARK: - Properties
    // We are assigning published typealias to our view models as we are going to subscribe to the data received from our combine method.
    @Published var coins = [CoinViewModel]()
    @Published var usdCurrency: USDViewModel?
    @Published var eurCurrency: EURViewModel?
    @Published var gbpCurrency: GBPViewModel?
    var cancellable: AnyCancellable?
    var currencyCancellableUSD: AnyCancellable?
    var currencyCancellableGBP: AnyCancellable?
    var currencyCancellableEUR: AnyCancellable?
    private let fetchListServices = FetchListServices()
    
    // MARK: - Initializer
    init() {
        callCoinListAPI()
        callCurrencies()
    }
    
    // MARK: - Helper Methods
    
    func callCoinListAPI() {
        // cancellable wil deinitialize the call once we are done with it.
        cancellable = fetchListServices.fetchCoinsList().sink(receiveCompletion: { completion in
            // we are handling completion status
            switch completion {
            case .failure(let error):
                NSLog("Couldn't fetch coins: \(error)")
                
            case .finished:
                break
            }
            // if everything went well we will assign the data to our published model
        }, receiveValue: { container in
            
            self.coins = container.map { CoinViewModel(coin: $0)}
        }
        )
    }
    
    func callCurrencies() {
        // USD fetching call
        // cancellable wil deinitialize the call once we are done with it.
        currencyCancellableUSD = fetchListServices.fetchCurrenciesUSD().sink(receiveCompletion: { completion in
            switch completion {
            // we are handling completion status
            case .failure(let error):
                NSLog("Couldn't fetch coins: \(error)")
                
            case .finished:
                break
            }
            // if everything went well we will assign the data to our published model
        }, receiveValue: { data in
            self.usdCurrency =  USDViewModel(usd: data)
            print(self.usdCurrency)
        })
        
        // GBP fetching call
        // cancellable wil deinitialize the call once we are done with it.
        currencyCancellableGBP = fetchListServices.fetchCurrenciesGBP().sink(receiveCompletion: { completion in
            // we are handling completion status
            switch completion {
            case .failure(let error):
                NSLog("Couldn't fetch coins: \(error)")
                
            case .finished:
                break
            }
            // if everything went well we will assign the data to our published model
        }, receiveValue: { data in
            self.gbpCurrency =  GBPViewModel(gbp: data)
            print(self.gbpCurrency)
        })
        
        // EUR fetching call
        // cancellable wil deinitialize the call once we are done with it.
        currencyCancellableEUR = fetchListServices.fetchCurrenciesEUR().sink(receiveCompletion: { completion in
            // we are handling completion status
            switch completion {
            case .failure(let error):
                NSLog("Couldn't fetch coins: \(error)")
                
            case .finished:
                break
            }
            // if everything went well we will assign the data to our published model
        }, receiveValue: { data in
            self.eurCurrency =  EURViewModel(eur: data)
            print(self.eurCurrency)
        })
    }
}
