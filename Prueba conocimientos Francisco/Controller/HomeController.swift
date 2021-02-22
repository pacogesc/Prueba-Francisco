//
//  HomeController.swift
//  Prueba conocimientos Francisco
//
//  Created by Francisco Guerrero Escamilla on 21/02/21.
//

import UIKit

class HomeController: UITabBarController {
    
    //MARK: - Properties
    
    let homeController = HomeCollectionController()
    let myProgressController = ProgressController()
    let profileController = ProfileController()
    
    //MARK: - Init
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - Helpers
    
    private func setupView() {
        view.backgroundColor = .white
        configureTabBar()
    }
    
    private func configureTabBar() {
        let homeItem = UITabBarItem()
        homeItem.title = "Inicio"
        homeItem.image = UIImage(systemName: ImageName.homeImage)
        homeController.tabBarItem = homeItem
        
        let activityItem = UITabBarItem()
        activityItem.title = "Mi Actividad"
        activityItem.image = UIImage(systemName: ImageName.progressImage)
        myProgressController.tabBarItem = activityItem
        
        let profileItem = UITabBarItem()
        profileItem.title = "Perfil"
        profileItem.image = UIImage(systemName: ImageName.profileImage)
        profileController.tabBarItem = profileItem
        
        self.viewControllers = [homeController, myProgressController, profileController]
        self.selectedViewController = homeController
        self.selectedIndex = 0
    }
    
    //MARK: - Selector

}
