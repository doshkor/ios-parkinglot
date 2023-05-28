//
//  FavoriteHeaderView.swift
//  Parking
//
//  Created by 신동오 on 2023/05/28.
//

import UIKit

class FavoriteTitleView: UIView {
    
    // MARK: - Private Property
    
    private let headerText: UILabel = {
        let label = UILabel()
        label.text = "즐겨찾기"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Function
    
    private func configure() {
        configureUI()
        configureHierarchy()
    }
    
    private func configureUI() {
        backgroundColor = UIConstant.favoriteTableViewHeaderColor
    }
    
    private func configureHierarchy() {
        addSubview(headerText)
        headerText.translatesAutoresizingMaskIntoConstraints = false
        
        configureSubviewsConstraints()
    }
    
    private func configureSubviewsConstraints() {
        NSLayoutConstraint.activate([
            headerText.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            headerText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            headerText.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
}
