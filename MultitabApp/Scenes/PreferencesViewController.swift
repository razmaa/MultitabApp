//
//  PreferencesViewController.swift
//  MultitabApp
//
//  Created by nika razmadze on 03.07.25.
//

import UIKit

import UIKit

class PreferencesViewController: UIViewController {
    
    private var onboardingData: OnboardingData
    
    init(onboardingData: OnboardingData) {
        self.onboardingData = onboardingData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - UI Elements
    
    private let selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Notification Preference", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let choiceLabel: UILabel = {
        let label = UILabel()
        label.text = "No preference selected"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - State
    
    private var selectedPreference: String? {
        didSet {
            choiceLabel.text = selectedPreference ?? "No preference selected"
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Preferences"
        
        view.addSubview(selectButton)
        view.addSubview(choiceLabel)
        setupConstraints()
        
        selectButton.addTarget(self,
                               action: #selector(didTapSelect),
                               for: .touchUpInside)
    }
    
    // MARK: - Layout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            selectButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            selectButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            selectButton.heightAnchor.constraint(equalToConstant: 50),
            
            choiceLabel.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: 16),
            choiceLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            choiceLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapSelect() {
        let sheet = UIAlertController(
            title: "Select Notification Preference",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        func makeAction(title: String) -> UIAlertAction {
            return UIAlertAction(title: title, style: .default) { [weak self] _ in
                guard let self = self else { return }
                
                self.onboardingData.preference = title
                self.choiceLabel.text = title
                
                let confirmVC = ConfirmDetailsViewController(
                    name: self.onboardingData.name,
                    phone: self.onboardingData.phone,
                    preference: title
                )
                self.navigationController?.pushViewController(confirmVC, animated: true)
            }
        }
        
        sheet.addAction(makeAction(title: "Email Notifications"))
        sheet.addAction(makeAction(title: "SMS Notifications"))
        sheet.addAction(makeAction(title: "Push Notifications"))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = sheet.popoverPresentationController {
            popover.sourceView = selectButton
            popover.sourceRect = selectButton.bounds
        }
        
        present(sheet, animated: true)
    }

    
}

