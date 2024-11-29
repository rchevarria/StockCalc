//
//  ProfitViewController.swift
//  StockCalc
//
//  Created by Ryan Chevarria on 11/27/24.
//

import UIKit

class ProfitViewController: UIViewController {
    
    var numSharesField: UITextField!
    var buyingPriceField: UITextField!
    var sellingPriceField: UITextField!
    var buyingCommissionField: UITextField!
    var sellingCommissionField: UITextField!
    var commissionTypeSwitch: UISegmentedControl!
    var resultLabel: UILabel!
    var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        // 1. Number of Shares
        numSharesField = createTextField(placeholder: "Number of Shares", keyboardType: .numberPad)
        view.addSubview(numSharesField)
        
        // 2. Buying Price
        buyingPriceField = createTextField(placeholder: "Buying Price", keyboardType: .decimalPad)
        view.addSubview(buyingPriceField)
        
        // 3. Selling Price
        sellingPriceField = createTextField(placeholder: "Selling Price", keyboardType: .decimalPad)
        view.addSubview(sellingPriceField)
        
        // 4. Buying Commission
        buyingCommissionField = createTextField(placeholder: "Buying Commission (default 0)", keyboardType: .decimalPad)
        view.addSubview(buyingCommissionField)
        
        // 5. Selling Commission
        sellingCommissionField = createTextField(placeholder: "Selling Commission (default 0)", keyboardType: .decimalPad)
        view.addSubview(sellingCommissionField)
        
        // Commission Type Switch
        commissionTypeSwitch = UISegmentedControl(items: ["Percentage", "Amount"])
        commissionTypeSwitch.selectedSegmentIndex = 0 // Default to Percentage
        commissionTypeSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commissionTypeSwitch)
        
        // Result Label
        resultLabel = UILabel()
        resultLabel.text = "Result will appear here"
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        resultLabel.textColor = .systemGray
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabel)
        
        // Calculate Button
        calculateButton = UIButton(type: .system)
        calculateButton.setTitle("Calculate Profit", for: .normal)
        calculateButton.backgroundColor = .systemBlue
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.layer.cornerRadius = 8
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.addTarget(self, action: #selector(calculateProfitTapped), for: .touchUpInside)
        view.addSubview(calculateButton)
        
        setupConstraints()
    }
    
    func createTextField(placeholder: String, keyboardType: UIKeyboardType) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = keyboardType
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            numSharesField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            numSharesField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numSharesField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numSharesField.heightAnchor.constraint(equalToConstant: 50),
            
            buyingPriceField.topAnchor.constraint(equalTo: numSharesField.bottomAnchor, constant: 20),
            buyingPriceField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buyingPriceField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buyingPriceField.heightAnchor.constraint(equalToConstant: 50),
            
            sellingPriceField.topAnchor.constraint(equalTo: buyingPriceField.bottomAnchor, constant: 20),
            sellingPriceField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sellingPriceField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sellingPriceField.heightAnchor.constraint(equalToConstant: 50),
            
            buyingCommissionField.topAnchor.constraint(equalTo: sellingPriceField.bottomAnchor, constant: 20),
            buyingCommissionField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buyingCommissionField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buyingCommissionField.heightAnchor.constraint(equalToConstant: 50),
            
            sellingCommissionField.topAnchor.constraint(equalTo: buyingCommissionField.bottomAnchor, constant: 20),
            sellingCommissionField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sellingCommissionField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sellingCommissionField.heightAnchor.constraint(equalToConstant: 50),
            
            commissionTypeSwitch.topAnchor.constraint(equalTo: sellingCommissionField.bottomAnchor, constant: 20),
            commissionTypeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            calculateButton.topAnchor.constraint(equalTo: commissionTypeSwitch.bottomAnchor, constant: 30),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.heightAnchor.constraint(equalToConstant: 50),
            calculateButton.widthAnchor.constraint(equalTo: numSharesField.widthAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 30),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func calculateProfitTapped() {
        guard let numSharesText = numSharesField.text,
              let buyingPriceText = buyingPriceField.text,
              let sellingPriceText = sellingPriceField.text,
              let numShares = Int(numSharesText),
              let buyingPrice = Double(buyingPriceText),
              let sellingPrice = Double(sellingPriceText) else {
            resultLabel.text = "Please enter valid inputs!"
            resultLabel.textColor = .red
            return
        }
        
        let buyingCommission = Double(buyingCommissionField.text ?? "0") ?? 0
        let sellingCommission = Double(sellingCommissionField.text ?? "0") ?? 0
        let isPercentage = commissionTypeSwitch.selectedSegmentIndex == 0
        
        let totalBuyingCommission = isPercentage ? buyingCommission / 100 * buyingPrice * Double(numShares) : buyingCommission
        let totalSellingCommission = isPercentage ? sellingCommission / 100 * sellingPrice * Double(numShares) : sellingCommission
        
        let profit = (sellingPrice * Double(numShares) - totalSellingCommission) -
                     (buyingPrice * Double(numShares) + totalBuyingCommission)
        
        resultLabel.textColor = profit >= 0 ? .green : .red
        resultLabel.text = String(format: "Your profit will be: $%.2f", profit)
    }
}


