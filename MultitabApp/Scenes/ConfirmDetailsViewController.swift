//
//  ConfirmDetailsViewController.swift
//  MultitabApp
//
//  Created by nika razmadze on 03.07.25.
//

import UIKit

class ConfirmDetailsViewController: UIViewController {
    
    // MARK: - Stored Data
    
    private let name: String
    private let phone: String
    private let preference: String
    
    // MARK: - UI Elements
    
    private let summaryStack = UIStackView()
    private let startOverButton = UIButton(type: .system)
    private let editPrefButton  = UIButton(type: .system)
    private let editInfoButton  = UIButton(type: .system)
    private let confirmButton   = UIButton(type: .system)
    
    // MARK: - Init
    
    init(name: String, phone: String, preference: String) {
        self.name       = name
        self.phone      = phone
        self.preference = preference
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) not supported") }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Confirm Details"
        navigationItem.hidesBackButton = true
        
        configureSummary()
        configureButtons()
        layoutViews()
    }
    
    // MARK: - Configuration
    
    private func configureSummary() {
        summaryStack.axis      = .vertical
        summaryStack.spacing   = 12
        summaryStack.alignment = .leading
        summaryStack.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.text = "Name: \(name)"
        
        let phoneLabel = UILabel()
        phoneLabel.text = "Phone Number: \(phone)"
        
        let prefLabel = UILabel()
        prefLabel.text = "Notification Preference: \(preference)"
        
        [nameLabel, phoneLabel, prefLabel].forEach {
            summaryStack.addArrangedSubview($0)
        }
    }
    
    private func configureButtons() {
        func style(_ button: UIButton, title: String, color: UIColor) {
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = color
            button.layer.cornerRadius = 6
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        
        style(startOverButton,   title: "Start over",         color: .systemRed)
        style(editPrefButton,    title: "Edit preferences",   color: .systemOrange)
        style(editInfoButton,    title: "Edit personal info", color: .systemTeal)
        style(confirmButton,     title: "Confirm",            color: .systemGreen)
        
        startOverButton.addTarget(self, action: #selector(didTapStartOver),     for: .touchUpInside)
        editPrefButton.addTarget(self,  action: #selector(didTapEditPref),     for: .touchUpInside)
        editInfoButton.addTarget(self,  action: #selector(didTapEditInfo),     for: .touchUpInside)
        confirmButton.addTarget(self,   action: #selector(didTapConfirmDone),  for: .touchUpInside)
    }
    
    private func layoutViews() {
        view.addSubview(summaryStack)
        [startOverButton, editPrefButton, editInfoButton, confirmButton]
            .forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            summaryStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            summaryStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            summaryStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            startOverButton.topAnchor.constraint(equalTo: summaryStack.bottomAnchor, constant: 40),
            startOverButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            startOverButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            startOverButton.heightAnchor.constraint(equalToConstant: 50),
            
            editPrefButton.topAnchor.constraint(equalTo: startOverButton.bottomAnchor, constant: 16),
            editPrefButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            editPrefButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            editPrefButton.heightAnchor.constraint(equalToConstant: 50),
            
            editInfoButton.topAnchor.constraint(equalTo: editPrefButton.bottomAnchor, constant: 16),
            editInfoButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            editInfoButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            editInfoButton.heightAnchor.constraint(equalToConstant: 50),
            
            confirmButton.topAnchor.constraint(equalTo: editInfoButton.bottomAnchor, constant: 16),
            confirmButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapStartOver() {
        if let onboardingNav = tabBarController?.viewControllers?.first as? UINavigationController,
           let onboardingVC  = onboardingNav.viewControllers.first as? OnboardingViewController {
            onboardingVC.configureForRestart()
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func didTapEditPref() {
        if let controllers = navigationController?.viewControllers {
            if let prefsVC = controllers.first(where: { $0 is PreferencesViewController }) {
                navigationController?.popToViewController(prefsVC, animated: true)
            }
        }
    }
    
    @objc private func didTapEditInfo() {
        if let controllers = navigationController?.viewControllers {
            if let infoVC = controllers.first(where: { $0 is PersonalInfoViewController }) {
                navigationController?.popToViewController(infoVC, animated: true)
            }
        }
    }
    
    @objc private func didTapConfirmDone() {
        let alert = UIAlertController(
            title: "Success",
            message: "You have successfully passed the onboarding.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.didTapStartOver()
        })
        present(alert, animated: true)
    }
}


