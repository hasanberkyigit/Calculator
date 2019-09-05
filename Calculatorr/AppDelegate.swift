//
//  AppDelegate.swift
//  Calculatorr
//
//  Created by hasanberk yigit on 16.08.2019.
//  Copyright © 2019 hasanberk yigit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupView()

        return true
    }
    
    //MARK: - Private Methods
    
    private func setupView(){
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

}

