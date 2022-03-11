//
//  CoindeskAPIService.swift
//  Api_Practice_self
//
//  Created by Jaeson.dev on 2022/03/11.
//

import Combine
import Foundation

// https://api.coindesk.com/v1/bpi/currentprice.json

struct APIPriceData: Decodable {
    let rate: String
}

struct APIBitcoinPriceIndex: Decodable {
    let USD: APIPriceData
    let GBP: APIPriceData
    let EUR: APIPriceData
}

struct APITime: Decodable {
    let updated: String
}

struct APIResponse: Decodable {
    let time: APITime
    let bpi: APIBitcoinPriceIndex
}

struct CoindeskAPIService {
    public static let shared = CoindeskAPIService()
    
    public func fetchBitcoinPrice() -> AnyPublisher<APIResponse, Error> {
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else {
            let error = URLError(.badURL)
            
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ (data, response) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.unknown)
                }
                guard httpResponse.statusCode == 200 else {
                    let code = URLError.Code(rawValue: httpResponse.statusCode)
                    throw URLError(code)
                }
                return data
            })
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
