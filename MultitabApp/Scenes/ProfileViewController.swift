//
//  ProfileViewController.swift
//  MultitabApp
//
//  Created by nika razmadze on 02.07.25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: – UI Elements
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit profile", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: – Lifecycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProfileViewController — viewDidLoad")
        
        view.backgroundColor = .systemBackground
        title = "Profile"
        setupNavigationItems()
        layoutUI()
        
        editProfileButton.addTarget(self,
                                    action: #selector(didTapEditProfile),
                                    for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ProfileViewController — viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ProfileViewController — viewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("ProfileViewController — viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ProfileViewController — viewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ProfileViewController — viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ProfileViewController — viewDidDisappear")
    }
    
    // MARK: – Setup Helpers
    
    private func setupNavigationItems() {
        let renameItem = UIBarButtonItem(
            image: UIImage(systemName: "pencil.slash"),
            style: .plain,
            target: self,
            action: #selector(didTapRename)
        )
        let anonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapAnonymous)
        )
        navigationItem.rightBarButtonItems = [anonItem, renameItem]
    }
    
    private func layoutUI() {
        view.addSubview(nameLabel)
        view.addSubview(editProfileButton)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            editProfileButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editProfileButton.widthAnchor.constraint(equalToConstant: 160),
            editProfileButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: – Actions
    
    @objc private func didTapRename() {
        let alert = UIAlertController(title: "Enter new name",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addTextField { tf in tf.placeholder = "Name" }
        alert.addAction(.init(title: "Cancel", style: .cancel))
        alert.addAction(.init(title: "OK", style: .default) { [weak self] _ in
            let text = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespaces)
            self?.nameLabel.text = (text?.isEmpty ?? true) ? "Default" : text
        })
        present(alert, animated: true)
    }
    
    @objc private func didTapAnonymous() {
        nameLabel.text = "Anonymous"
    }
    
    @objc private func didTapEditProfile() {
        let editVC = EditProfileViewController()
        navigationController?.pushViewController(editVC, animated: true)
    }
}


