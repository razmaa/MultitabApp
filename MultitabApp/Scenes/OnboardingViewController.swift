//
//  OnboardingViewController.swift
//  MultitabApp
//
//  Created by nika razmadze on 02.07.25.
//

import UIKit

class OnboardingViewController: UIViewController {
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Welcome"

        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 140),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        startButton.addTarget(self,
                              action: #selector(didTapStart),
                              for: .touchUpInside)
    }

    @objc private func didTapStart() {
        let personalInfoVC = PersonalInfoViewController()
        navigationController?.pushViewController(personalInfoVC, animated: true)
    }
    
    func configureForRestart() {
        startButton.setTitle("Restart", for: .normal)
        startButton.backgroundColor = .systemGreen
    }
}

