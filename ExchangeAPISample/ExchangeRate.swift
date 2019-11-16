//
//  ExchangeRate.swift
//  ExchangeAPISample
//
//  Created by Masuhara on 2019/11/16.
//  Copyright © 2019 Ylab Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftDate

struct ExchangeRate {
    
    enum Country: String {
        case HKD = "HKD"
        case JPY = "JPY"
        case SEK = "SEK"
        case KRW = "KRW"
        case BGN = "BGN"
        case SGD = "SGD"
        case HRK = "HRK"
        case DKK = "DKK"
        case ILS = "ILS"
        case NZD = "NZD"
        case GBP = "GBP"
        case INR = "INR"
        case PLN = "PLN"
        case NOK = "NOK"
        case MYR = "MYR"
        case CZK = "CZK"
        case USD = "USD"
        case EUR = "EUR"
    }
    
    var baseCountry: String?
    var date: Date?
    var name: String?
    var rate: Float?
    
    static func getCurrentRates(baseCountry: Country, completion: @escaping([ExchangeRate]?, Error?) -> ()) {
        let baseURL = "https://api.exchangeratesapi.io/latest?base=\(baseCountry)"
        Alamofire.request(baseURL).responseJSON {
            response in
            if response.result.isSuccess {
                if let returnValue = response.result.value {
                    let ratesJSON = JSON(returnValue)
                    if let rateDictionary = ratesJSON["rates"].dictionary {
                        var rates = [ExchangeRate]()
                        for (key, value) in rateDictionary {
                            var rate = ExchangeRate()
                            rate.name = key
                            rate.rate = value.number?.floatValue
                            rates.append(rate)
                        }
                        completion(rates, nil)
                    } else {
                        completion(nil, nil)
                    }
                } else {
                    completion(nil, nil)
                }
            } else {
                completion(nil, response.result.error)
            }
        }
    }
}
