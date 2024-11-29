//
//  ProfitViewController.swift
//  StockCalc
//
//  Created by Ryan Chevarria on 11/27/24.
//

import UIKit

class ProfitViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var numSharesField: UITextField!
    var buyingPriceField: UITextField!
    var sellingPriceField: UITextField!
    var buyingCommissionField: UITextField!
    var buyingCommissionControl: UISegmentedControl!
    var sellingCommissionField: UITextField!
    var sellingCommissionControl: UISegmentedControl!
    var resultLabel: UILabel!
    var calculateButton: UIButton!
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        // Background color
        view.backgroundColor = .systemBackground
        
        // Set Title
        navigationItem.title = "Profit Calculator"
        
        // Add Clear Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Clear",
            style: .plain,
            target: self,
            action: #selector(clearFields)
        )
        
        // Create UI components
        numSharesField = createTextField(keyboardType: .numberPad) // Numeric keyboard
        buyingPriceField = createTextField(keyboardType: .decimalPad) // Decimal keyboard
        sellingPriceField = createTextField(keyboardType: .decimalPad) // Decimal keyboard
        buyingCommissionField = createTextField(keyboardType: .decimalPad) // Decimal keyboard
        sellingCommissionField = createTextField(keyboardType: .decimalPad) // Decimal keyboard
        
        // Create UISegmentedControls
        buyingCommissionControl = createSegmentedControl()
        sellingCommissionControl = createSegmentedControl()
        
        // Result label
        resultLabel = UILabel()
        resultLabel.text = "Result will appear here"
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        resultLabel.textColor = .systemGray
        resultLabel.numberOfLines = 0
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Calculate button
        calculateButton = UIButton(type: .system)
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.backgroundColor = .systemBlue
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.layer.cornerRadius = 10
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.addTarget(self, action: #selector(calculateProfitTapped), for: .touchUpInside)
        
        // Set up table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomFieldCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add components to the view
        view.addSubview(tableView)
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)
        
        setupConstraints()
    }
    
    func createTextField(keyboardType: UIKeyboardType) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.keyboardType = keyboardType // Set the keyboard type
        
        // Set a minimum height for the text field
        textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        
        return textField
    }


    func createSegmentedControl() -> UISegmentedControl {
        let control = UISegmentedControl(items: ["%", "$"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }
    
    func setupConstraints() {
        let spacing: CGFloat = 20
        
        NSLayoutConstraint.activate([
            // TableView Constraints
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 350),
            
            // Calculate Button
            calculateButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: spacing),
            calculateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calculateButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Result Label
            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: spacing),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - UITableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // 3 text fields + 2 with segment controls
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomFieldCell
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cell.configure(with: "Number of Shares/Coins", textField: numSharesField)
        case 1:
            cell.configure(with: "Buying Price", textField: buyingPriceField)
        case 2:
            cell.configure(with: "Selling Price", textField: sellingPriceField)
        case 3:
            cell.configure(with: "Buying Commission", textField: buyingCommissionField, control: buyingCommissionControl)
        case 4:
            cell.configure(with: "Selling Commission", textField: sellingCommissionField, control: sellingCommissionControl)
        default:
            break
        }
        
        return cell
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
        
        // Getting commission values
        let buyingCommission = Double(buyingCommissionField.text ?? "0") ?? 0
        let sellingCommission = Double(sellingCommissionField.text ?? "0") ?? 0
        
        // Check commission type (Amount or Percentage)
        let isPercentageBuying = buyingCommissionControl.selectedSegmentIndex == 0
        let isPercentageSelling = sellingCommissionControl.selectedSegmentIndex == 0
        
        // Calculate total commission
        let totalBuyingCommission = isPercentageBuying ? (buyingCommission / 100) * buyingPrice * Double(numShares) : buyingCommission
        let totalSellingCommission = isPercentageSelling ? (sellingCommission / 100) * sellingPrice * Double(numShares) : sellingCommission
        
        // Calculate profit
        let profit = (sellingPrice * Double(numShares) - totalSellingCommission) -
                     (buyingPrice * Double(numShares) + totalBuyingCommission)
        
        // Display result
        resultLabel.textColor = profit >= 0 ? .green : .red
        resultLabel.text = String(format: "Your profit will be: $%.2f", profit)
    }
    
    @objc func clearFields() {
        // Clear all input fields
        numSharesField.text = ""
        buyingPriceField.text = ""
        sellingPriceField.text = ""
        buyingCommissionField.text = ""
        sellingCommissionField.text = ""
        
        // Reset segmented controls
        buyingCommissionControl.selectedSegmentIndex = 0
        sellingCommissionControl.selectedSegmentIndex = 0
        
        // Clear result label
        resultLabel.text = "Result will appear here"
        resultLabel.textColor = .systemGray
    }
}

class CustomFieldCell: UITableViewCell {
    private let label = UILabel()
    private let stackView = UIStackView()
    private let horizontalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Configure label
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        
        // Configure stack view
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure horizontal stack view
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add components
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(horizontalStackView)
        
        // Layout
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with title: String, textField: UITextField, control: UISegmentedControl? = nil) {
        label.text = title
        
        // Clear any existing arranged subviews in horizontalStackView
        horizontalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add text field
        horizontalStackView.addArrangedSubview(textField)
        
        // Add segmented control if available
        if let control = control {
            horizontalStackView.addArrangedSubview(control)
            control.widthAnchor.constraint(equalToConstant: 80).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
