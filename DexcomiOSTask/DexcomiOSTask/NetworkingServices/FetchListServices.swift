//
//  FetchListServices.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation
import Combine
final class FetchListServices {
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetchCrypto() -> AnyPublisher<[Coin], Error> {
        let url = Endpoints.coinsList.url
        
        return URLSession.shared.dataTaskPublisher(for: url).map {
            $0.data }.decode(type: [Coin].self, decoder:
                    decoder).receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    func fetchCurrencies() -> AnyPublisher<[Currency], Error> {
        let url = Endpoints.currencies.url
        
        return URLSession.shared.dataTaskPublisher(for: url).map
        {
            $0.data }.decode(type: [Currency].self, decoder: decoder)
        .receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    
}
