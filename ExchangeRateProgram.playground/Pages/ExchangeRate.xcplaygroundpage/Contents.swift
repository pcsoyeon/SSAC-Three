import UIKit

struct ExchageRate {
    var currencyRate: Double {
        willSet {
            print("currencyRate willSet - 환율 변동 예정 \(currencyRate) -> \(newValue)")
        }
        
        didSet {
            print("currencyRate didSet - 환율 변동 완료 \(oldValue) -> \(currencyRate)")
        }
    }
    
    var USD: Double {
        willSet {
            print("USD willSet - 환전 금액: \(newValue)로 환전될 예정")
        }
        
        didSet {
            print("USD didSet - KRW: \(KRW)원 -> \(USD)로 환전되었음")
        }
    }
    
    var KRW: Double = 1000 {
        didSet {
            USD = KRW / currencyRate
        }
    }
}

var rate = ExchageRate(currencyRate: 1100, USD: 1)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000
