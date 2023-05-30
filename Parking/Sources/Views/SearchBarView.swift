//
//  SearchBarView.swift
//  Parking
//
//  Created by 신동오 on 2023/05/25.
//

import UIKit

enum Constant {
    static let iconImageFileName = "search-icon"
}

class SearchBarView: UIView {

    let textField = SearchBarTextField()
    let searchIcon = UIImageView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    // MARK: - Private Function
    
    private func configure() {
        configureAutoLayout()
        configureUI()
    }
    
    private func configureAutoLayout() {
        self.addSubview(textField)
        self.addSubview(searchIcon)
        textField.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        configureConstraints()
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 19),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -19),

            searchIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            searchIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            searchIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    private func configureUI() {
        let image = UIImage(named: Constant.iconImageFileName)
        searchIcon.image = image
        searchIcon.contentMode = .scaleAspectFit
        
        backgroundColor = .white
        
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.3
    }
    
}
