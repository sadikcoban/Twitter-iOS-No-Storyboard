//
//  UploadTweetController.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 10.07.2022.
//

import UIKit

class UploadTweetController: UIViewController {
    
    private let user: User
    
    // MARK: - Properties
    private lazy var tweetButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Tweet", for: .normal)
        view.backgroundColor = .twitterBlue
        view.layer.cornerRadius = 16
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 16)
        view.addTarget(self, action: #selector(didTapTweetBtn), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        view.sd_setImage(with: URL(string: user.profileImageURL))
        
        return view
    }()
    
    private lazy var textView: CaptionTextView = {
        let view = CaptionTextView()
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Selectors
    @objc func didTapCancel(){
        dismiss(animated: true)
    }
    
    @objc func didTapTweetBtn(){
        
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        configureNavigationBar()
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
        }
        

        textView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        let stack = UIStackView(arrangedSubviews: [imageView, textView])
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(90)
            make.trailing.bottom.equalToSuperview()
        }
        
     
    }
    
    func configureNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(didTapCancel))
        
        tweetButton.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(32)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
    
    
}
