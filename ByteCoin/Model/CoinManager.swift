//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdate(price: String, country: String)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "96C20BE2-2935-4777-A86F-E9A6C6AF8852"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(_ country: String) {
        
        let urlString = "\(baseURL)/\(country)?apikey=\(apiKey)"
        print(urlString)
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        
        if let url = url {
            let sessionTask = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error as Any)
                }
                
                if let returnData = data {
                    if let parsedData = self.parseJSON(returnData) {
                        let price = parsedData.bytePrice
                        let country = parsedData.country
                        let rawPrice = String(format: "%.2f", price)
                        
                        print(rawPrice, country)
                        self.delegate?.didUpdate(price: rawPrice, country: country)
                    }
                }
            }
            sessionTask.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do {
            
            let parseData = try decoder.decode(CoinData.self, from: data)
            let bytePrice = parseData.rate
            let country = parseData.asset_id_quote
            
            let rawCoinModel = CoinModel(bytePrice: bytePrice, country: country)
            
            return rawCoinModel
        } catch {
            print(error)
            return nil
        }
    }
}
