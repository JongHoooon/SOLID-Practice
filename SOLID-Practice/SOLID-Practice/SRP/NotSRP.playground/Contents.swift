import Foundation


class Banker {
    
    enum Departmnet {
        case card           // 카드
        case insurance      // 보험
        case development    // 개발
    }
    
    let department: Departmnet
    
    init(deparment: Departmnet) {
        self.department = deparment
    }
}

class Calculator {
    
    static var profit: Int?
    
    /// 카드 수익을 계산해서 은행장에게 보고
    static func calculateCardProfit() {
        let investment = investMoney()
        let cardProfit = Int(Double(investment) * 0.2)
        profit = cardProfit
        
        print("report \(cardProfit) to bank president")
    }
    
    /// 보험 수익을 계산해서 은행장에게 보고
    static func calculateInsuranceProfit() {
        let investment = investMoney()
        let InsuranceProfit = Int(Double(investment) * 0.4)
        profit = InsuranceProfit
        
        print("report \(InsuranceProfit) to bank president")
    }
    
    /// 수익을 DB에 저장
    static func save() {
        guard let profit = profit else { return }

        print("save \(profit) to DB")
    }
    
    /// 고객이 투자한 금액을 반환하는 메소드
    static private func investMoney() -> Int {
        return Int.random(in: (1...100)) * 100
    }
}
