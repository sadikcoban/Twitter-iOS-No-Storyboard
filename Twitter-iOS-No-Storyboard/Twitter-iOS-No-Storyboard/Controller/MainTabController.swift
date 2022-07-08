//
//  MainTabController.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
    func configureViewControllers(){
        
        let feed = templateNavigationController(image: UIImage(named: "home_unselected"), rootVC: FeedController())
        let explore = templateNavigationController(image: UIImage(named: "search_unselected"), rootVC: ExploreController())
        let notifications = templateNavigationController(image: UIImage(named: "like_unselected"), rootVC: NotificationsController())
        let conversation = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootVC: ConversationController())


        viewControllers = [ feed, explore, notifications, conversation ]

        
    }
    
    func templateNavigationController(image: UIImage?, rootVC: UIViewController) -> UINavigationController {
        
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.tabBarItem.image = image
        navVC.navigationBar.barTintColor = .green
        return navVC
    }

}
