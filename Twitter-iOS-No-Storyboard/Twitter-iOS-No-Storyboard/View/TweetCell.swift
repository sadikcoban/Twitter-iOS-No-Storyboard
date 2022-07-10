//
//  TweetCell.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 10.07.2022.
//

import UIKit

class TweetCell: UICollectionViewCell {
    static let identifier = "TweetCell"
    
    //private let tweet: Tweet
    
    // MARK: Properties
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        //view.sd_setImage(with: URL(string: user.profileImageURL))
        view.backgroundColor = .green
        
        return view
    }()
    
    private lazy var captionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        view.textColor = .black
        
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
   
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(8)
        }
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.backgroundColor = .blue
        addSubview(stack)

        stack.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(8)
        }
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        infoLabel.text = "Eddie Brock @venom"
        captionLabel.text = "Some caption text"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Selectors
    
    // MARK: Helpers
    
    
}
