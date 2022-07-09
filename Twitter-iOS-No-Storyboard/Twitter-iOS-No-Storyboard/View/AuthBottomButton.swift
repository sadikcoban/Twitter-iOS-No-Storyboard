//
//  AuthBottomButton.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit

class AuthBottomButton: UIButton {
    
    private let firstPartString: String
    private let secondPartString: String
    private let textColor: UIColor
    private let bgColor: UIColor
    private let action: Selector
    private let target: Any
    
    init(firstPartString: String, secondPartString: String, textColor: UIColor, bgColor: UIColor, target: Any, selector: Selector) {
        self.firstPartString = firstPartString
        self.secondPartString = secondPartString
        self.textColor = textColor
        self.bgColor = bgColor
        self.target = target
        self.action = selector
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        configureButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureButton()
    }
    
    func configureButton(){
        
        let attributedTitle = NSMutableAttributedString(string: firstPartString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                                                              NSAttributedString.Key.foregroundColor: textColor])
        attributedTitle.append(NSAttributedString(string: secondPartString, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                                                                                         NSAttributedString.Key.foregroundColor: UIColor.white]))

        self.setAttributedTitle(attributedTitle, for: .normal)
        self.backgroundColor = backgroundColor
        self.addTarget(target, action: action, for: .touchUpInside)
        
    }
}
