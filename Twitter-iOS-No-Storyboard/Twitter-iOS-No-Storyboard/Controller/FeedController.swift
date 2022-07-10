//
//  FeedController.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit
import SDWebImage



class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
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
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.identifier)
        collectionView.backgroundColor = .white
        configureUI()
        fetchTweets()
    }
    
    // MARK: - API
    func fetchTweets(){
        TweetService.shared.fetchTweets { error, tweets in
            if let error = error {
                // TODO: - Handle error
                return
            }
            print("AA: \(tweets)")
        }
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

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.identifier, for: indexPath) as? TweetCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
