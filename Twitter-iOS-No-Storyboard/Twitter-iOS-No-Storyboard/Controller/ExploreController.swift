//
//  ExploreController.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit

class ExploreController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }

}

