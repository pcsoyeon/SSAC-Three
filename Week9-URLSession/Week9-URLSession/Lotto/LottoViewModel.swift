//
//  LottoViewModel.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/09/01.
//

import Foundation

class LottoViewModel {
    
    // MARK: - Property
    
    var number1: Observable<Int> = Observable(1)
    var number2: Observable<Int> = Observable(1)
    var number3: Observable<Int> = Observable(1)
    var number4: Observable<Int> = Observable(1)
    var number5: Observable<Int> = Observable(1)
    var number6: Observable<Int> = Observable(1)
    var number7: Observable<Int> = Observable(1)
    
    var lottoMoney = Observable("당첨금")
    
    // MARK: - Method
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    func fetchLottoAPI(drwNo: Int) {
        LottoAPIManager.requestLotto(drwNo: drwNo) { lotto, error in
            guard let lotto = lotto else {
                return
            }
            
            self.number1.value = lotto.drwtNo1
            self.number2.value = lotto.drwtNo2
            self.number3.value = lotto.drwtNo3
            self.number4.value = lotto.drwtNo4
            self.number5.value = lotto.drwtNo5
            self.number6.value = lotto.drwtNo6
            self.number7.value = lotto.bnusNo
            
            self.lottoMoney.value = self.format(for: lotto.totSellamnt)
        }
    }
}
