//
//  EditProfileViewController.swift
//  MultitabApp
//
//  Created by nika razmadze on 02.07.25.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    // MARK: – UI Elements
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit your profile here"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleLabel: UILabel = {
        let label = UILabel()
        label.text = "Navigation is easy!"
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = true
        toggleSwitch.isEnabled = false
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        return toggleSwitch
    }()
    
    // MARK: – Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EditProfileViewController — viewDidLoad")
        
        title = "Edit profile"
        view.backgroundColor = .systemBackground
        
        view.addSubview(infoLabel)
        view.addSubview(toggleLabel)
        view.addSubview(toggleSwitch)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            toggleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            toggleLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 60),
            
            toggleSwitch.centerYAnchor.constraint(equalTo: toggleLabel.centerYAnchor),
            toggleSwitch.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        toggleSwitch.addTarget(self,
                               action: #selector(didChangeSwitch(_:)),
                               for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("EditProfileViewController — viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("EditProfileViewController — viewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("EditProfileViewController — viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("EditProfileViewController — viewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("EditProfileViewController — viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("EditProfileViewController — viewDidDisappear")
    }
    
    // MARK: – Actions
    
    @objc private func didChangeSwitch(_ sender: UISwitch) {
        print("Navigation is easy? →", sender.isOn)
    }
}


