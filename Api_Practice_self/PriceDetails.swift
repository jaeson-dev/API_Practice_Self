//
//  PriceDetails.swift
//  Api_Practice_self
//
//  Created by Jaeson.dev on 2022/03/10.
//

import Foundation

enum Currency: CaseIterable {
    case usd
    case gbp
    case eur
    
    var icon: String {
        switch self {
        case .usd:
            return "💵"
        case .gbp:
            return "💷"
        case .eur:
            return "💶"
        }
    }
    
    var code: String {
        switch self {
        case .usd:
            return "USD"
        case .gbp:
            return "GBP"
        case .eur:
            return "EUR"
        }
    }
}

struct PriceDetails {
    let currency : Currency
    let rate: String
    
    public init(currency: Currency, rate: String = "--") {
        self.currency = currency
        self.rate = rate
    }
}
