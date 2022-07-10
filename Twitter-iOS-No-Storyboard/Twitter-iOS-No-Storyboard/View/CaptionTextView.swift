//
//  CaptionTextView.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 10.07.2022.
//

import UIKit

class CaptionTextView: UITextView {
    
    // MARK: - Properties
    
    private lazy var placeHolderLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.textColor = .darkGray
        view.text = "What's happening?"
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?){
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .white
        font = .systemFont(ofSize: 16)
        isScrollEnabled = false
        textColor = .black

        addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.trailing.bottom.equalToSuperview()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTextChange), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Selectors
    @objc func didTextChange(){
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
