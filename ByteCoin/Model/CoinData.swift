//
//  CoinData.swift
//  ByteCoin
//
//  Created by formathead on 2020/03/13.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable{
//    {
//    "time": "2020-03-13T03:17:16.9971562Z",
//    "asset_id_base": "BTC",
//    "asset_id_quote": "USD",
//    "rate": 5354.429434036508
//    }
    
    let asset_id_quote: String
    let rate: Double
    
}
