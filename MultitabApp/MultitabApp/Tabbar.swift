//
//  Tabbar.swift
//  MultitabApp
//
//  Created by nika razmadze on 02.07.25.
//

import UIKit

extension SceneDelegate {
    func makeRootTabBarController() -> UITabBarController {

        let onboardingVC = OnboardingViewController()
        let profileVC    = ProfileViewController()
        let settingsVC   = EditProfileViewController()

        onboardingVC.tabBarItem = {
            let item = UITabBarItem(
                title: "Onboarding",
                image: UIImage(systemName: "1.circle"),
                tag: 0
            )
            item.selectedImage = UIImage(systemName: "1.circle.fill")
            return item
        }()

        profileVC.tabBarItem = {
            let item = UITabBarItem(
                title: "Profile",
                image: UIImage(systemName: "person.circle"),
                tag: 1
            )
            item.selectedImage = UIImage(systemName: "person.circle.fill")
            return item
        }()

        settingsVC.tabBarItem = {
            let item = UITabBarItem(
                title: "edit",
                image: UIImage(systemName: "gearshape"),
                tag: 2
            )
            item.selectedImage = UIImage(systemName: "gearshape.fill")
            return item
        }()

        let onboardingNav = UINavigationController(rootViewController: onboardingVC)
        let profileNav    = UINavigationController(rootViewController: profileVC)

        let tabController = UITabBarController()
        tabController.viewControllers = [onboardingNav, profileNav, settingsVC]

        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.orange

            appearance.stackedLayoutAppearance.selected.iconColor = .white
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.white
            ]

            appearance.stackedLayoutAppearance.normal.iconColor = .gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.gray
            ]

            tabController.tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabController.tabBar.scrollEdgeAppearance = appearance
            }
        } else {
            tabController.tabBar.barTintColor = UIColor.orange
            tabController.tabBar.tintColor = UIColor.white
            tabController.tabBar.unselectedItemTintColor = UIColor.gray
        }

        return tabController
    }
}

