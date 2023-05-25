//
//  SearchTextField.swift
//  Parking
//
//  Created by 신동오 on 2023/05/25.
//

import UIKit

class SearchTextField: UITextField {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Override init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: - Private Function
    
    private func configure() {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
        
        font = UIFont.systemFont(ofSize: 17)
        textColor = .black
        
        backgroundColor = .white
        borderStyle = .roundedRect
        
        let placeholderText = "어디로 갈까요?"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.3
    }
    
}
