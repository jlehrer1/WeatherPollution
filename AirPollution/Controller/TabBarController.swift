//
//  TabBarControllerViewController.swift
//  AirPollution
//
//  Created by Julian Lehrer on 2/10/19.
//  Copyright © 2019 Julian Lehrer. All rights reserved.
//

import UIKit
import CoreLocation

class TabBarController: UITabBarController, CLLocationManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.blue
        
        setupTabBar()
    }
    
    func setupTabBar() {
        let tabItem1 = self.tabBar.items?[0]
        tabItem1?.image = UIImage(named: "healthy")
        
        let tabItem2 = self.tabBar.items?[1]
        tabItem2?.image = UIImage(named: "unhealthy")
        
    }
    
}
