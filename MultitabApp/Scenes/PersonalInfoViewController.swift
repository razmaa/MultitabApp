//
//  PersonalInfoViewController.swift
//  MultitabApp
//
//  Created by nika razmadze on 03.07.25.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your phone"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Personal Info"
        
        setupLayout()
        setupTargets()
    }
    
    // MARK: - Setup
    
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [
            nameTextField,
            phoneTextField,
            confirmButton
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupTargets() {
        nameTextField.addTarget(self,
                                action: #selector(textFieldDidChange),
                                for: .editingChanged)
        phoneTextField.addTarget(self,
                                 action: #selector(textFieldDidChange),
                                 for: .editingChanged)
        confirmButton.addTarget(self,
                                action: #selector(confirmButtonTapped),
                                for: .touchUpInside)
    }
    
    // MARK: - Validation
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let nameOK  = !(nameTextField.text ?? "").isEmpty
        let phoneOK = (phoneTextField.text ?? "").count >= 9
        
        let enable = nameOK && phoneOK
        confirmButton.isEnabled = enable
        confirmButton.alpha     = enable ? 1.0 : 0.5
    }
    
    // MARK: - Actions
    
    @objc private func confirmButtonTapped() {
        let name  = nameTextField.text!
        let phone = phoneTextField.text!
        
        let data = OnboardingData(name: name, phone: phone, preference: nil)
        
        let prefsVC = PreferencesViewController(onboardingData: data)
        navigationController?.pushViewController(prefsVC, animated: true)
    }
    
    
    private func presentConfirmationAlert() {
        let name  = nameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        
        let message = """
        Please confirm your name and \
        phone number.
        Name: \(name)
        Phone: \(phone)
        """
        
        let alert = UIAlertController(
            title: "Confirm Information",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "Confirm",
            style: .default,
            handler: { [weak self] _ in
                let nextVC = PreferencesViewController(onboardingData: OnboardingData(name: name, phone: phone))
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
        ))
        
        alert.addAction(UIAlertAction(
            title: "Edit",
            style: .cancel,
            handler: nil
        ))
        
        present(alert, animated: true)
    }
}

