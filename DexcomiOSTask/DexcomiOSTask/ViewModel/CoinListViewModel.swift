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
    @Published var usdCurrency: USD?
    @Published var eurCurrency: EUR?
    @Published var gbpCurrency: GBP?
    var cancellable: AnyCancellable?
    var currencyCancellable: AnyCancellable?
    
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
           currencyCancellable = fetchListServices.fetchCurrencies().sink(receiveCompletion: { _ in
               
           }, receiveValue: { data in
               self.usdCurrency = data.bpi.usd
               self.eurCurrency = data.bpi.eur
               self.gbpCurrency = data.bpi.gbp
           })
       }
}
