import Foundation

class HDCard {
    let calculator: CalculatorHD = Calculator(payment: 10000)
    
    func calculatorPoint() {
        print(calculator.calculatorPointHD())
    }
}

class WRCard {
    let calculator: CalculatorWR = Calculator(payment: 20000)
    
    func calculatorPoint() {
        print(calculator.calculatorPointWR())
    }
}

protocol CalculatorHD {
    func calculatorPointHD() -> Double
}

protocol CalculatorWR {
    func calculatorPointWR() -> Double
}

class Calculator: CalculatorHD, CalculatorWR {
    
    var payment: Double
    
    init(payment: Double) {
        self.payment = payment
    }
    
    func calculatorPointHD() -> Double {
        return payment * 0.005
    }
    
    func calculatorPointWR() -> Double {
        return payment * 0.01
    }
}

func main() {
    let hdCard = HDCard()
    let wrCard = WRCard()
    
    hdCard.calculatorPoint()
    wrCard.calculatorPoint()
}

main()
