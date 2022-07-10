//
//  FeedController.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    
     var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    // MARK: - Properties
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        let image = UIImage(named: "twitter_logo_blue")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit

        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        navigationItem.titleView = imageView
        
        
    }
    
    func configureLeftBarButton() {
        guard let user = user else { return }
        guard let url = URL(string: user.profileImageURL) else { return }
        profileImageView.sd_setImage(with: url, completed: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
}
