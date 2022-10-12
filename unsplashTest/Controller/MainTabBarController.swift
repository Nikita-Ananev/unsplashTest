//
//  MainTabBarController.swift
//  unsplashTest
//
//  Created by Никита Ананьев on 09.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let searchVC = PhotoCollectionVC()
        let searchBarItem = UITabBarItem(title: "Photo", image: UIImage(systemName: "photo")?.withTintColor(UIColor(named: "textColor")!), selectedImage: UIImage(systemName: "photo.fill"))
        searchVC.tabBarItem = searchBarItem
        
        let favoriteVC = FavoriteVC()
        let favoriteBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        favoriteVC.tabBarItem = favoriteBarItem
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        self.tabBar.tintColor = UIColor(named: "textColor")
        self.tabBar.unselectedItemTintColor = UIColor(named: "textUnselectedColor")
        self.viewControllers = [searchVC, favoriteVC]
    
        
    }
}
