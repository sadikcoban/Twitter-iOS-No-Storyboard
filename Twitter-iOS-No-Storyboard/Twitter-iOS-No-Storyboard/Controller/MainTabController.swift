//
//  MainTabController.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit
import SnapKit
import Firebase

class MainTabController: UITabBarController {
    
    private var user: User? {
        didSet {
            print("running didset")
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            feed.user = user
        }
    }
    
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
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - API
    
    func fetchUser(){
        UserService.shared.fetchUser { user in
            print(user.username)
            self.user = user
        }
    }
    func authenticateUserAndConfigureUI(){

        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } else {
            configureViewControllers()
            configureUI()
            fetchUser()
        }
    }
    
    // MARK: - Selectors
    @objc func didTapActionButton(){
        guard let user = user else { return }
        let nav = UINavigationController(rootViewController: UploadTweetController(user: user))
        nav.modalPresentationStyle = .fullScreen

        present(nav, animated: true)
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
