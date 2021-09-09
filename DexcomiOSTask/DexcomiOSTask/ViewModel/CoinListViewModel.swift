//
//  CoinListViewModel.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation
import Combine

class CoinListViewModel: ObservableObject {
    static var shared = CoinListViewModel()
    @Published var coins = [Coin]()
    var cancellable: AnyCancellable?
    private let fetchListServices = FetchListServices()
    
    init() {
        callAPI()
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
            self.coins = container.map { Coin(name: $0.name, symbol: $0.symbol, rank: $0.rank) }
           
        }
        )
    }
}
