//
//  HomeViewController.swift
//  Calculatorr
//
//  Created by hasanberk yigit on 16.08.2019.
//  Copyright © 2019 hasanberk yigit. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var resultLabel: UILabel!
    //MARK: - Numbers
    
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    //MARK: - Operators
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorPlusMinus: UIButton!
    @IBOutlet weak var operatorPercent: UIButton!
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var operatorAddition: UIButton!
    @IBOutlet weak var operatorSubstriction: UIButton!
    @IBOutlet weak var operatorMultiplication: UIButton!
    @IBOutlet weak var operatorDivition: UIButton!
    
    //MARK: - Variables
    
    private var total: Double = 0
    private var temp: Double = 0
    private var operating = false
    private var decimal = false
    private var operation: OperationType = .none
    
    //MARK: - Constants
    
    private let kDecimalSeperator =  Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kMaxValue:Double = 999999999
    private let kMinValue:Double = 0.00000001
    private let kTotal = "total"
    
    
    private enum OperationType {
        case none, addiction , substriction , percent , divition , multiplication
    }
   
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
  
    
    
    
    private let auxTotalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    
    
    
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    
    private let printScientificFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
    
    
    
    
    //MARK: - Initialization
    
    init (){
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberDecimal.setTitle(kDecimalSeperator, for: .normal)
        
        total = UserDefaults.standard.double(forKey: kTotal)
        
        result()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    
    //UI - UI - UI
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        
        operatorAC.round()
        operatorPlusMinus.round()
        operatorPercent.round()
        operatorResult.round()
        operatorAddition.round()
        operatorSubstriction.round()
        operatorMultiplication.round()
        operatorDivition.round()
        

    }
    
    //MARK: - Button Actions
    @IBAction func operatorACAction(_ sender: UIButton) {
        
        clear()
        
        sender.shine()
    }
    
    @IBAction func operatorPlusMinusAction(_ sender: UIButton) {
        
        temp = temp * (-1)
        
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        sender.shine()
    }
    
    @IBAction func operatorPercentAction(_ sender: UIButton) {
        
        if operation != .percent {
            result()
        }
        operating = true
        operation = .percent
        result()
        
        sender.shine()
    }
    
    @IBAction func operatorResultAction(_ sender: UIButton) {
        
        result()
        
        sender.shine()
    }
    
    @IBAction func operatorAdditionAction(_ sender: UIButton) {
        
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .addiction
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func operatorSubstrictionAction(_ sender: UIButton) {
        
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .substriction
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func operatorMultiplicationAction(_ sender: UIButton) {
        
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .multiplication
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func operatorDivitionAction(_ sender: UIButton) {
        
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .divition
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        
        let currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        if resultLabel.text?.contains(kDecimalSeperator) ?? false || (!operating && currentTemp.count >= kMaxLength) {
            return
        }
        
        resultLabel.text = resultLabel.text! + kDecimalSeperator
        decimal = true
        
        selectVisualOperation()
        
        sender.shine()
    }
    
    @IBAction func numberAction(_ sender: UIButton) {
        
        operatorAC.setTitle("C", for: .normal)
        
        var currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        
        if operating {
            total = total == 0 ? temp : total
            resultLabel.text = ""
            currentTemp = ""
            operating = false
        }
        
       
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeperator)"
            decimal = false
        }
        
        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        selectVisualOperation()
        
        sender.shine()
    }
    
    
    private func clear() {
        if operation == .none {
            total = 0
        }
        operation = .none
        operatorAC.setTitle("AC", for: .normal)
        if temp != 0 {
            temp = 0
            resultLabel.text = "0"
        } else {
            total = 0
            result()
        }
    }
    
    // Obtiene el resultado final
    private func result() {
        
        switch operation {
            
        case .none:
            // No hacemos nada
            break
        case .addiction:
            total = total + temp
            break
        case .substriction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .divition:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        }
        
        
        if let currentTotal = auxTotalFormatter.string(from: NSNumber(value: total)), currentTotal.count > kMaxLength {
            resultLabel.text = printScientificFormatter.string(from: NSNumber(value: total))
        } else {
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        operation = .none
        
        selectVisualOperation()
        
        UserDefaults.standard.set(total, forKey: kTotal)
        
        print("TOTAL: \(total)")
    }
    
    
    private func selectVisualOperation() {
        
        if !operating {
            // No estamos operando
            operatorAddition.selectOperation(false)
            operatorSubstriction.selectOperation(false)
            operatorMultiplication.selectOperation(false)
            operatorDivition.selectOperation(false)
        } else {
            switch operation {
            case .none, .percent:
                operatorAddition.selectOperation(false)
                operatorSubstriction.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivition.selectOperation(false)
                break
            case .addiction:
                operatorAddition.selectOperation(true)
                operatorSubstriction.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivition.selectOperation(false)
                break
            case .substriction:
                operatorAddition.selectOperation(false)
                operatorSubstriction.selectOperation(true)
                operatorMultiplication.selectOperation(false)
                operatorDivition.selectOperation(false)
                break
            case .multiplication:
                operatorAddition.selectOperation(false)
                operatorSubstriction.selectOperation(false)
                operatorMultiplication.selectOperation(true)
                operatorDivition.selectOperation(false)
                break
            case .divition:
                operatorAddition.selectOperation(false)
                operatorSubstriction.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivition.selectOperation(true)
                break
            }
        }
    }
    
    
}
