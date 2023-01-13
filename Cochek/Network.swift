//
//  Network.swift
//  Cochek
//
//  Created by hwikun on 2023/01/08.
//

import Coinpaprika
import SwiftUI

// class Network: ObservableObject {
//    @Published var coins: [Coin] = []
//
//    func getCoins() {
//        guard let url = URL(string: "https://api.huobi.pro/market/tickers") else { fatalError("Missing URL") }
//
//        let urlRequest = URLRequest(url: url)
//
//        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    do {
//                        let decodedCoins = try JSONDecoder().decode(Results.self, from: data)
//                        self.coins = decodedCoins.data
//                    } catch {
//                        print("Error decoding: ", error)
//                    }
//                }
//            }
//        }
//
//        dataTask.resume()
//    }
// }

class CoinList: ObservableObject {
    init() {
        if let coinList = UserDefaults.standard.data(forKey: "coinPaprikaList") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Coin].self, from: coinList) {
                self.coinList = decoded
                return
            }
        }
        self.coinList = []
    }

    @Published var coinList = [Coin]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(coinList) {
                UserDefaults.standard.set(encoded, forKey: "coinPaprikaList")
            }
        }
    }

    func getCoinList() {
        Coinpaprika.API.coins().perform { response in
            switch response {
            case .success(let coins):
                // Successfully downloaded [Coin]
                // coins[0].id - Coin identifier, to use in ticker(id:) method
                // coins[0].name - Coin name, for example Bitcoin
                // coins[0].symbol - Coin symbol, for example BTC
                if self.coinList == coins {
                    self.coinList = coins
                    print(coins)
                }
            case .failure(let error):
                // Failure reason as error
                print("Fail to get Coin List: ", error)
            }
        }
    }
}

class OHLCV: ObservableObject {
    @Published var ohlcvList: [Ohlcv] = []
    func getOhlcvList(coinId: String) {
        Coinpaprika.API.coinHistoricalOhlcv(id: coinId, start: Calendar.current.date(byAdding: .hour, value: -23, to: Date())!, limit: 365).perform { response in
            switch response {
            case .success(let result):

                self.ohlcvList = result
                print(self.ohlcvList)

            case .failure(let error):
                print("Fail to get OHLCV List: ", error)
            }
        }
    }
}
