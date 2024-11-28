//
//  ProfitViewController.swift
//  StockCalc
//
//  Created by Ryan Chevarria on 11/27/24.
//

import UIKit

import UIKit

class ProfitViewController: UIViewController {

    var sharePriceField: UITextField!
    var numSharesField: UITextField!
    var expectedPriceField: UITextField!
    var resultLabel: UILabel!
    var calculateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the UI components
        setupUI()
    }

    func setupUI() {
        // Background Color
        view.backgroundColor = UIColor.systemBackground
        
        // 1. Set up Share Price Field
        sharePriceField = UITextField()
        sharePriceField.placeholder = "Enter current share price"
        sharePriceField.borderStyle = .roundedRect
        sharePriceField.keyboardType = .decimalPad
        sharePriceField.layer.borderColor = UIColor.systemGray5.cgColor
        sharePriceField.layer.borderWidth = 1.0
        sharePriceField.layer.cornerRadius = 8
        sharePriceField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sharePriceField)
        
        // 2. Set up Number of Shares Field
        numSharesField = UITextField()
        numSharesField.placeholder = "Enter number of shares"
        numSharesField.borderStyle = .roundedRect
        numSharesField.keyboardType = .numberPad
        numSharesField.layer.borderColor = UIColor.systemGray5.cgColor
        numSharesField.layer.borderWidth = 1.0
        numSharesField.layer.cornerRadius = 8
        numSharesField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numSharesField)
        
        // 3. Set up Expected Price Field
        expectedPriceField = UITextField()
        expectedPriceField.placeholder = "Enter expected share price"
        expectedPriceField.borderStyle = .roundedRect
        expectedPriceField.keyboardType = .decimalPad
        expectedPriceField.layer.borderColor = UIColor.systemGray5.cgColor
        expectedPriceField.layer.borderWidth = 1.0
        expectedPriceField.layer.cornerRadius = 8
        expectedPriceField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(expectedPriceField)
        
        // 4. Set up Result Label
        resultLabel = UILabel()
        resultLabel.text = "Result will appear here"
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        resultLabel.textColor = UIColor.systemGray
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabel)
        
        // 5. Set up Calculate Button
        calculateButton = UIButton(type: .system)
        calculateButton.setTitle("Calculate Profit", for: .normal)
        calculateButton.backgroundColor = UIColor.systemBlue
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.layer.cornerRadius = 8
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.addTarget(self, action: #selector(calculateProfitTapped), for: .touchUpInside)
        view.addSubview(calculateButton)
        
        // 6. Set up Auto Layout Constraints
        setupConstraints()
    }

    func setupConstraints() {
        // Set up constraints using NSLayoutConstraint
        NSLayoutConstraint.activate([
            // Share Price Field
            sharePriceField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            sharePriceField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sharePriceField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sharePriceField.heightAnchor.constraint(equalToConstant: 50),
            
            // Number of Shares Field
            numSharesField.topAnchor.constraint(equalTo: sharePriceField.bottomAnchor, constant: 20),
            numSharesField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numSharesField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numSharesField.heightAnchor.constraint(equalToConstant: 50),
            
            // Expected Price Field
            expectedPriceField.topAnchor.constraint(equalTo: numSharesField.bottomAnchor, constant: 20),
            expectedPriceField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            expectedPriceField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            expectedPriceField.heightAnchor.constraint(equalToConstant: 50),
            
            // Calculate Button
            calculateButton.topAnchor.constraint(equalTo: expectedPriceField.bottomAnchor, constant: 30),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.heightAnchor.constraint(equalToConstant: 50),
            calculateButton.widthAnchor.constraint(equalTo: sharePriceField.widthAnchor),
            
            // Result Label
            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 30),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // Profit Estimation Function
    func estimateProfit(sharePrice: Double, numShares: Int, expectedPrice: Double) -> Double {
        return (expectedPrice - sharePrice) * Double(numShares)
    }

    // Button Action Method
    @objc func calculateProfitTapped() {
        // Ensure that textfields have valid values
        guard let sharePriceText = sharePriceField.text,
              let numSharesText = numSharesField.text,
              let expectedPriceText = expectedPriceField.text,
              let sharePrice = Double(sharePriceText),
              let numShares = Int(numSharesText),
              let expectedPrice = Double(expectedPriceText) else {
            resultLabel.text = "Please enter valid inputs!"
            resultLabel.textColor = .red
            return
        }
        
        // Calculate profit
        let profit = estimateProfit(sharePrice: sharePrice, numShares: numShares, expectedPrice: expectedPrice)
        
        // Display result
        resultLabel.textColor = profit >= 0 ? .green : .red
        resultLabel.text = String(format: "Your profit will be: $%.2f", profit)
    }
}
