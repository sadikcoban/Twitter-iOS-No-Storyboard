//
//  MainTabController.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit
import SnapKit

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func didTapActionButton(){
        navigationController?.pushViewController(FeedController(), animated: true)
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.height.width.equalTo(56)
            make.bottom.equalToSuperview().offset(-100)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func configureViewControllers(){
        
        let feed = templateNavigationController(image: UIImage(named: "home_unselected"), rootVC: FeedController())
        let explore = templateNavigationController(image: UIImage(named: "search_unselected"), rootVC: ExploreController())
        let notifications = templateNavigationController(image: UIImage(named: "like_unselected"), rootVC: NotificationsController())
        let conversation = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootVC: ConversationController())

        self.viewControllers = [ feed, explore, notifications, conversation ]
       

        
    }
    
    func templateNavigationController(image: UIImage?, rootVC: UIViewController) -> UIViewController {
        
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.tabBarItem.image = image
        navVC.isNavigationBarHidden = false
        return navVC
    }

}
