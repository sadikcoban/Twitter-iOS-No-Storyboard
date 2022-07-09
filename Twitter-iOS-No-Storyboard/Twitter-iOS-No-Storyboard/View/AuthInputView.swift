//
//  AuthInputView.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit

class AuthInputView: UIView {
    
    private let image: UIImage
    private let viewTintColor: UIColor
    private let textFieldHint: String
    private let isSecure: Bool
    private let keyboardType: UIKeyboardType
    let textFieldDelegate: UITextFieldDelegate
    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = image
        view.tintColor = viewTintColor
        return view
    }()
    
    private(set) lazy var textField: UITextField = {
        let view = UITextField()
        view.tintColor = viewTintColor
        view.textColor = viewTintColor
        view.font = .systemFont(ofSize: 16)
        view.isSecureTextEntry = isSecure
        view.attributedPlaceholder = NSAttributedString(string: textFieldHint, attributes: [NSAttributedString.Key.foregroundColor : viewTintColor])
        view.keyboardType = keyboardType
        view.delegate = textFieldDelegate
        return view
    }()
    
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = viewTintColor
        return view
    }()
    
    init(image: UIImage,
         tintColor: UIColor,
         hintText: String,
         isSecure: Bool = false,
         keyboard: UIKeyboardType,
         delegate: UITextFieldDelegate
    ) {
        self.image = image
        self.viewTintColor = tintColor
        self.textFieldHint = hintText
        self.isSecure = isSecure
        self.keyboardType = keyboard
        self.textFieldDelegate = delegate
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("initCoder has not been implemented")
    }
    
    func configureUI(){
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.width.equalTo(20)
        }
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        containerView.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.height.equalTo(0.75)
        }
        
        
        
    }
    
    
    
    
}
