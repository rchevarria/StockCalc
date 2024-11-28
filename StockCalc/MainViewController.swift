//
//  MainViewController.swift
//  StockCalc
//
//  Created by Ryan Chevarria on 11/27/24.
//

import UIKit

class MainViewController: UIViewController {
    
    // Buttons for each option
    var profitButton: UIButton!
    var averageDownButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color for the main view
        view.backgroundColor = .white
        
        // Set up the UI components
        setupUI()
    }
    
    func setupUI() {
        // 1. Set up Profit Button
        profitButton = UIButton(type: .system)
        profitButton.setTitle("Calculate Profit", for: .normal)
        profitButton.translatesAutoresizingMaskIntoConstraints = false
        profitButton.addTarget(self, action: #selector(calculateProfitTapped), for: .touchUpInside)
        
        // Style the button
        profitButton.backgroundColor = .systemBlue  // Background color
        profitButton.setTitleColor(.white, for: .normal)  // Text color
        profitButton.layer.cornerRadius = 10  // Rounded corners
        profitButton.layer.masksToBounds = true  // Ensure the corner radius is applied
        
        view.addSubview(profitButton)
        
        // 2. Set up Average Down Button
        averageDownButton = UIButton(type: .system)
        averageDownButton.setTitle("Average Down Share Price", for: .normal)
        averageDownButton.translatesAutoresizingMaskIntoConstraints = false
        averageDownButton.addTarget(self, action: #selector(averageDownTapped), for: .touchUpInside)
        
        // Style the button
        averageDownButton.backgroundColor = .systemGreen  // Background color
        averageDownButton.setTitleColor(.white, for: .normal)  // Text color
        averageDownButton.layer.cornerRadius = 10  // Rounded corners
        averageDownButton.layer.masksToBounds = true  // Ensure the corner radius is applied
        
        view.addSubview(averageDownButton)
        
        // 3. Set up Auto Layout Constraints
        setupConstraints()
    }
    
    func setupConstraints() {
        // Set up constraints using NSLayoutConstraint
        NSLayoutConstraint.activate([
            // Profit Button
            profitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            profitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profitButton.widthAnchor.constraint(equalToConstant: 200),
            profitButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Average Down Button
            averageDownButton.topAnchor.constraint(equalTo: profitButton.bottomAnchor, constant: 20),
            averageDownButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            averageDownButton.widthAnchor.constraint(equalToConstant: 200),
            averageDownButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Button Action for Profit Calculation
    @objc func calculateProfitTapped() {
        // Navigate to the Calculate Profit Screen
        let profitVC = ProfitViewController()
        navigationController?.pushViewController(profitVC, animated: true)
    }
    
    // Button Action for Average Down Calculation
    @objc func averageDownTapped() {
        // Navigate to the Average Down Price Screen
        let averageDownVC = AverageDownViewController()
        navigationController?.pushViewController(averageDownVC, animated: true)
    }
}
