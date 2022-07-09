//
//  FeedController.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit

class FeedController: UIViewController {
    
    // MARK: - Properties
    
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

        navigationItem.titleView = imageView
    }
    
}
