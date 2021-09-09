//
//  FetchListServices.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import Foundation
import Combine

enum NetworkError: Error {
    case noData(String), badData(String)
    case failedFetch(String), badURL(String)
    case badError(String)
}

/// The final class ``FetchListServices`` is where we are implementing networking calls to fetch data. We are making it final so it can't be subclassed from other class which is essential for networking layer.
final class FetchListServices {
    
    // MARK: - Computed Properties
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    /// Networking method for CoinList
    /// - Returns: Return any publisher to wrap our model ``Coin`` with combine.
    func fetchCoinsList() -> AnyPublisher<[Coin], Error> {
        let coinListURL = Endpoints.coinsList.url
        /* here we are using urlsession datataskpublisher since we are using combine and we will use it's mapping method to wrap Coin with
         eraseToAnyPublisher to any publisher.
         */
        return URLSession.shared.dataTaskPublisher(for: coinListURL).map {
            // here we want to make sure before we wrap this model to any publisher we want the task to be received on mainthread
            $0.data }.decode(type: [Coin].self, decoder:
                                decoder).receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    /// Networking Method for USD
    /// - Returns: Return any publisher to wrap our model ``USD`` with combine.
    func fetchCurrenciesUSD() -> AnyPublisher<USD, Error> {
        let currencyURL = Endpoints.currencies.url
        
        return URLSession.shared.dataTaskPublisher(for: currencyURL).map
        {
            print("response")
            print($0)
            return $0.data }.decode(type: USD.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    
    /// Networking Method for GBP
    /// - Returns: - Returns: Return any publisher to wrap our model ``GBP`` with combine.
    func fetchCurrenciesGBP() -> AnyPublisher<GBP, Error> {
        let currencyURL = Endpoints.currencies.url
        
        return URLSession.shared.dataTaskPublisher(for: currencyURL).map
        {
            print("response")
            print($0)
            return $0.data }.decode(type: GBP.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    /// Networking Method for GBP
    /// - Returns:  Returns: Return any publisher to wrap our model ``GBP`` with combine.
    func fetchCurrenciesEUR() -> AnyPublisher<EUR, Error> {
        let currencyURL = Endpoints.currencies.url
        
        return URLSession.shared.dataTaskPublisher(for: currencyURL).map
        {
            print("response")
            print($0)
            return $0.data }.decode(type: EUR.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    /* I tried using native approach for urlsession to get jsonserialization and access the jsondata
     by the currency and use that dictionary to access the properties and assign to the assigned model.
     But, I had to rethink this because it will be out of the combine structure and I didn't felt right
     by mixing networking methods.
 
 */
    
    //    func fetchPriceByCurrency(currency: String, completion: @escaping (Bitcoin?, Error?) ->Void)  {
    //        let priceURL = Endpoints.price(currency).url
    //        var request = URLRequest(url: priceURL)
    //        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    //        request.httpMethod = HTTPMethod.get.rawValue
    //
    //        URLSession.shared.dataTask(with: request) { data, response, error in
    //            if let response = response as? HTTPURLResponse {
    //                NSLog("Server responded with: \(response.statusCode)")
    //            }
    //
    //            if let error = error {
    //                completion(nil, error)
    //            }
    //
    //            guard let data = data else {
    //                completion(nil, NetworkError.badData("No data was returned for prices"))
    //                return
    //            }
    //
    //            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
    //               let bpi = json["bpi"] as? [[String: Any]],
    //               let currency = bpi[0][currency] as? [String: Any] {
    //                let rate = currency["rate"] as? String ?? ""
    //                let description = currency["description"] as? String ?? ""
    //
    //                let bitcoin = Bitcoin(rate: rate, description: description)
    //
    //                DispatchQueue.main.async {
    //                    completion(bitcoin, nil)
    //                }
    //            }
    //        }
    //    }
    
}

struct CoinDataContainer: Decodable {
    var coins: [Coin]
}
