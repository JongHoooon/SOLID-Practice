import Foundation

class Banker {
    
    enum Departmnet {
        case card           // 카드
        case insurance      // 보험
        case development    // 적금
    }
    
    let department: Departmnet
    let data: CalData
    let bankerFacade: BankerFacade
    
    init(
        deparment: Departmnet,
        data: CalData
    ) {
        self.department = deparment
        self.data = data
        self.bankerFacade = BankerFacade(
            cardProfitCalculator: CardProfitCalculator(data: data),
            insuranceProfitCalculator: InsuranceProfitCalculator(data: data),
            profitSaver: ProfitSaver(data: data)
        )
    }
}

class BankerFacade {
    
    private let cardProfitCalculator: CardProfitCalculator
    private let insuranceProfitCalculator: InsuranceProfitCalculator
    private let profitSaver: ProfitSaver
    
    init(
        cardProfitCalculator: CardProfitCalculator,
        insuranceProfitCalculator: InsuranceProfitCalculator,
        profitSaver: ProfitSaver
    ) {
        self.cardProfitCalculator = cardProfitCalculator
        self.insuranceProfitCalculator = insuranceProfitCalculator
        self.profitSaver = profitSaver
    }
    
    func calculateCardProfit() {
        cardProfitCalculator.calculateCardProfit()
    }
    
    func calculateInsuranceProfit() {
        insuranceProfitCalculator.calculateInsuranceCardProfit()
    }
    
    func save() {
        profitSaver.save()
    }
}

class CardProfitCalculator {
    
    var data: CalData
    
    init(data: CalData) {
        self.data = data
    }
    
    /// 카드 수익을 계산해서 은행장에게 보고
    func calculateCardProfit() {
        let investment = Int.random(in: (1...100)) * 100
        let profit = Double(investment) * 0.2
        data.calculatedProfitByCard = Int(profit)
        
        print("report \(profit) to bank president")
    }
}

class InsuranceProfitCalculator {
    
    var data: CalData
    
    init(data: CalData) {
        self.data = data
    }
    
    /// 보험 수익을 계산해서 은행장에게 보고
    func calculateInsuranceCardProfit() {
        let investment = Int.random(in: (1...100)) * 100
        let profit = Double(investment) * 0.4
        data.calculatedProfitByInsurance = Int(profit)
        
        print("report \(profit) to bank president")
    }
}

class ProfitSaver {
    
    var data: CalData
    
    init(data: CalData) {
        self.data = data
    }
    
    /// 수익을 DB에 저장
    func save() {
        print("save card profit: \(data.calculatedProfitByCard ?? 0), insurance profit: \(data.calculatedProfitByInsurance ?? 0)")
    }
}

class CalData {
    var calculatedProfitByCard: Int?
    var calculatedProfitByInsurance: Int?
}


func main() {
    let data = CalData()
    
    let cardBanker = Banker(deparment: .card, data: data)
    
    let insuranceBanker = Banker(deparment: .insurance, data: data)
    
    let developer = Banker(deparment: .development, data: data)
    
    
    cardBanker.bankerFacade.calculateCardProfit()
    insuranceBanker.bankerFacade.calculateInsuranceProfit()
    developer.bankerFacade.save()
}


main()
