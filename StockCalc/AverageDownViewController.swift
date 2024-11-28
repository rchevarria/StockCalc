//
//  AverageDownViewController.swift
//  StockCalc
//
//  Created by Ryan Chevarria on 11/27/24.
//

import UIKit

class AverageDownViewController: UIViewController {

    var numSharesField: UITextField!
    var currentPriceField: UITextField!
    var sharePriceField: UITextField!
    var numBuyField: UITextField!
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
        
        // 1. Set up Number of Shares Field
        numSharesField = UITextField()
        numSharesField.placeholder = "Enter number of shares you currently own"
        numSharesField.borderStyle = .roundedRect
        numSharesField.keyboardType = .numberPad
        numSharesField.layer.borderColor = UIColor.systemGray5.cgColor
        numSharesField.layer.borderWidth = 1.0
        numSharesField.layer.cornerRadius = 8
        numSharesField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numSharesField)
        
        // 2. Set up Current Share Price Field
        currentPriceField = UITextField()
        currentPriceField.placeholder = "Enter current share price"
        currentPriceField.borderStyle = .roundedRect
        currentPriceField.keyboardType = .decimalPad
        currentPriceField.layer.borderColor = UIColor.systemGray5.cgColor
        currentPriceField.layer.borderWidth = 1.0
        currentPriceField.layer.cornerRadius = 8
        currentPriceField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentPriceField)
        
        // 3. Set up Share Price Field
        sharePriceField = UITextField()
        sharePriceField.placeholder = "Enter current average share price"
        sharePriceField.borderStyle = .roundedRect
        sharePriceField.keyboardType = .decimalPad
        sharePriceField.layer.borderColor = UIColor.systemGray5.cgColor
        sharePriceField.layer.borderWidth = 1.0
        sharePriceField.layer.cornerRadius = 8
        sharePriceField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sharePriceField)
        
        // 4. Set up Number to Buy Field
        numBuyField = UITextField()
        numBuyField.placeholder = "Enter number of shares to buy"
        numBuyField.borderStyle = .roundedRect
        numBuyField.keyboardType = .numberPad
        numBuyField.layer.borderColor = UIColor.systemGray5.cgColor
        numBuyField.layer.borderWidth = 1.0
        numBuyField.layer.cornerRadius = 8
        numBuyField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numBuyField)
        
        // 5. Set up Result Label
        resultLabel = UILabel()
        resultLabel.text = "Result will appear here"
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        resultLabel.textColor = UIColor.systemGray
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabel)
        
        // 6. Set up Calculate Button
        calculateButton = UIButton(type: .system)
        calculateButton.setTitle("Calculate Average Down", for: .normal)
        calculateButton.backgroundColor = UIColor.systemBlue
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.layer.cornerRadius = 8
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.addTarget(self, action: #selector(calculateAverageDownTapped), for: .touchUpInside)
        view.addSubview(calculateButton)
        
        // 7. Set up Auto Layout Constraints
        setupConstraints()
    }

    func setupConstraints() {
        // Set up constraints using NSLayoutConstraint
        NSLayoutConstraint.activate([
            // Number of Shares Field
            numSharesField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            numSharesField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numSharesField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numSharesField.heightAnchor.constraint(equalToConstant: 50),
            
            // Current Share Price Field
            currentPriceField.topAnchor.constraint(equalTo: numSharesField.bottomAnchor, constant: 20),
            currentPriceField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            currentPriceField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            currentPriceField.heightAnchor.constraint(equalToConstant: 50),
            
            // Share Price Field
            sharePriceField.topAnchor.constraint(equalTo: currentPriceField.bottomAnchor, constant: 20),
            sharePriceField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sharePriceField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sharePriceField.heightAnchor.constraint(equalToConstant: 50),
            
            // Number to Buy Field
            numBuyField.topAnchor.constraint(equalTo: sharePriceField.bottomAnchor, constant: 20),
            numBuyField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numBuyField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numBuyField.heightAnchor.constraint(equalToConstant: 50),
            
            // Calculate Button
            calculateButton.topAnchor.constraint(equalTo: numBuyField.bottomAnchor, constant: 30),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.heightAnchor.constraint(equalToConstant: 50),
            calculateButton.widthAnchor.constraint(equalTo: numSharesField.widthAnchor),
            
            // Result Label
            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 30),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // Averaging Down Function (as per your example)
    func averaging(userShares: Int, userAvgSharePrice: Double, currentPrice: Double, numBuy: Int) -> Double {
        
        let amountOwned = userAvgSharePrice * Double(userShares)
        let amountNew = currentPrice * Double(numBuy)
        
        let amountTotal = amountOwned + amountNew
        let shareTotal = userShares + numBuy
        
        let newAveragePrice = amountTotal / Double(shareTotal)
        
        return newAveragePrice

    }



    @objc func calculateAverageDownTapped() {
        guard let numSharesText = numSharesField.text,
              let currentPriceText = currentPriceField.text,
              let sharePriceText = sharePriceField.text,
              let numBuyText = numBuyField.text,
              
              let numCurrentSharesOwned = Int(numSharesText), //Amount of shares the user owns
              let averageCurrentPrice = Double(currentPriceText), //Based on what they own, their current share average
              
              let currentSharePrice = Double(sharePriceText),   //The share's current price
              let numToBuy = Int(numBuyText) else {             //How much more does the user want to buy?
                resultLabel.text = "Please enter valid inputs!"
                resultLabel.textColor = .red
                return
        }
        
        if currentSharePrice >= averageCurrentPrice {
            resultLabel.text = "Average price must be lower than Current Price to average down."
            resultLabel.textColor = .red
            return
        }

        // Debugging Logs for Inputs
        print("DEBUGGING INPUTS:")
        print("Number of Currently Owned Shares: \(numCurrentSharesOwned)")
        print("Your current Share Price (Average): \(averageCurrentPrice)")
        print("The Current Share Price: \(currentSharePrice)")
        print("Number of Shares to Buy: \(numToBuy)")

        // Calculate new average price
        let newAverage = averaging(userShares: numCurrentSharesOwned, userAvgSharePrice: averageCurrentPrice, currentPrice: currentSharePrice, numBuy: numToBuy)

        // Debugging Log for Result
        print("Calculated Average: \(newAverage)")

        // Display result
        resultLabel.textColor = .green
        resultLabel.text = String(format: "Your new average: $%.2f", newAverage)
    }


}

