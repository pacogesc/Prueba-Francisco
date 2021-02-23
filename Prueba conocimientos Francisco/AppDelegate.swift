//
//  AppDelegate.swift
//  Prueba conocimientos Francisco
//
//  Created by Francisco Guerrero Escamilla on 21/02/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        //NotificationCenter.default.addObserver(self, selector: #selector(locationDidChangeAuthorization), name: NSNotification.Name.init(kLocationDidChangeAuthorization), object: nil)
        
        return true
    }
    
    //MARK: - Location Authorizartion
    
    @objc private func locationDidChangeAuthorization(_ notification: Notification) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        guard let rootViewController = window.rootViewController else { return }
        let alertController = UIAlertController(title: "Ubicación no autorizada", message: "Para el correcto funcionamiento de la aplicación por favor permita que utilice siempre su ubicación.", preferredStyle: .alert)
        alertController.addAction(.init(title: "De acuerdo", style: .default, handler: openSettings(_:)))
        rootViewController.present(alertController, animated: true, completion: nil)
    }
    
    private func openSettings(_ alert: UIAlertAction) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, options: [:]) { (success) in
                print("Settings opened: \(success)")
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

