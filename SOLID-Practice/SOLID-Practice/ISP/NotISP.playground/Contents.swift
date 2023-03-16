import Foundation

class HDCard {
    let calculator = Calculator(payment: 10000)
    
    func calculatorPoint() {
        print(calculator.calculatorPoint(type: .HD))
    }
}

class WRCard {
    let calculator = Calculator(payment: 20000)
    
    func calculatorPoint() {
        print(calculator.calculatorPoint(type: .WR))
    }
}

class Calculator {
    var payment: Double
    
    init(payment: Double) {
        self.payment = payment
    }
    
    enum CardType {
        case HD
        case WR
    }
    
    func calculatorPoint(type: CardType) -> Double {
        switch type {
        case .HD:
            return payment * 0.005
        case .WR:
            return payment * 0.01
        }
    }
}

func main() {
    
    let hdCard = HDCard()
    let wrCard = WRCard()
    
    hdCard.calculatorPoint()
    wrCard.calculatorPoint()
}

main()
