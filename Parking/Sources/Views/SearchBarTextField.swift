//
//  SearchBarTextField.swift
//  Parking
//
//  Created by 신동오 on 2023/05/25.
//

import UIKit

fileprivate enum Constants {
    
    static let koreanLanguage = "ko-KR"
    static let placeholderText = "주차장 이름, 주소를 검색해 보세요!"
    
}

class SearchBarTextField: UITextField {
    
    // MARK: - Public Property
    
    override var textInputMode: UITextInputMode? {
        // 추후 로직 간소화 하기
            for inputMode in UITextInputMode.activeInputModes {
                if inputMode.primaryLanguage! == Constants.koreanLanguage {
                    return inputMode
                }
            }
        
        return super.textInputMode
    }
    
    // MARK: - Public Property
    
    
    // MARK: - Required Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Override Init
    
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
        
        let placeholderText = Constants.placeholderText
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        
        // text 입력 자동으로 바뀌는 현상 제거, ex) appld -> applied
        autocorrectionType = .no
        
        // 검색 버튼 생성
        returnKeyType = .search
        
        // 입력시 삭제 버튼 추가
        clearButtonMode = .always
        // rightView 입력시 안된다???~
    }
    
}
