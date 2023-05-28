//
//  FavoriteTableView.swift
//  Parking
//
//  Created by 신동오 on 2023/05/26.
//

import UIKit

class FavoriteTableView: UITableView {
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero, style: .plain)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Function
    
    private func configure() {
        register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier)
        
        configureUI()
    }
    
    private func configureUI(){
        separatorStyle = .none
        contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        backgroundColor = UIConstant.favoriteTableViewColor
    }
    
}
