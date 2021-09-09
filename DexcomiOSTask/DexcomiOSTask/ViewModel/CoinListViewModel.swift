//
//  CoinListViewModel.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation
import Combine

class CoinListViewModel: ObservableObject {
   
    @Published var coins = [CoinViewModel]()
    @Published var usdCurrency: USDViewModel?
    @Published var eurCurrency: EURViewModel?
    @Published var gbpCurrency: GBPViewModel?
    var cancellable: AnyCancellable?
    var currencyCancellableUSD: AnyCancellable?
    var currencyCancellableGBP: AnyCancellable?
    var currencyCancellableEUR: AnyCancellable?


    private let fetchListServices = FetchListServices()
    
    init() {
        callAPI()
     callCurrencies()
    }
    
    func callAPI() {
        cancellable = fetchListServices.fetchCoinsList().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                NSLog("Couldn't fetch coins: \(error)")
                
            case .finished:
                break
            }
        }, receiveValue: { container in
            
            self.coins = container.map { CoinViewModel(coin: $0)}
        }
        )
    }
    
    func callCurrencies() {
           currencyCancellableUSD = fetchListServices.fetchCurrenciesUSD().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                NSLog("Couldn't fetch coins: \(error)")
                
            case .finished:
                break
            }
           }, receiveValue: { data in
            self.usdCurrency =  USDViewModel(usd: data)
            print(self.usdCurrency)
           })

    
        currencyCancellableGBP = fetchListServices.fetchCurrenciesGBP().sink(receiveCompletion: { completion in
         switch completion {
         case .failure(let error):
             NSLog("Couldn't fetch coins: \(error)")
             
         case .finished:
             break
         }
        }, receiveValue: { data in
            self.gbpCurrency =  GBPViewModel(gbp: data)
         print(self.gbpCurrency)
        })

    
        currencyCancellableEUR = fetchListServices.fetchCurrenciesEUR().sink(receiveCompletion: { completion in
         switch completion {
         case .failure(let error):
             NSLog("Couldn't fetch coins: \(error)")
             
         case .finished:
             break
         }
        }, receiveValue: { data in
            self.eurCurrency =  EURViewModel(eur: data)
         print(self.eurCurrency)
        })
}
}
