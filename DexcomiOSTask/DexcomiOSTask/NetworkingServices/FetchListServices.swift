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
final class FetchListServices {
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetchCoinsList() -> AnyPublisher<[Coin], Error> {
        let coinListURL = Endpoints.coinsList.url
        
        return URLSession.shared.dataTaskPublisher(for: coinListURL).map {
            $0.data }.decode(type: [Coin].self, decoder:
                                decoder).receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    func fetchCurrencies() -> AnyPublisher<CurrencyData, Error> {
         let currencyURL = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!

         return URLSession.shared.dataTaskPublisher(for: currencyURL).map
         {
             $0.data }.decode(type: CurrencyData.self, decoder: decoder)
         .receive(on: DispatchQueue.main).eraseToAnyPublisher()
     }

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
