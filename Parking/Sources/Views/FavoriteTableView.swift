//
//  FavoriteTableView.swift
//  Parking
//
//  Created by 신동오 on 2023/05/26.
//

import UIKit

class FavoriteTableView: UITableView {
    
    // MARK: - Private Property
    
    private lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 44))
        view.backgroundColor = UIConstant.favoriteTableViewHeaderColor
        return view
    }()
    
    private lazy var headerText: UILabel = {
       let label = UILabel()
        label.text = "즐겨찾기"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero, style: .plain)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Function
    
    func configureAutoLayout() {
        tableHeaderView = headerView
        
        headerView.addSubview(headerText)
        headerText.translatesAutoresizingMaskIntoConstraints = false
        headerText.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        headerText.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
    }
    
    // MARK: - Private Function
    
    private func configure() {
        register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        configureUI()
    }
    
    private func configureUI(){
        backgroundColor = UIConstant.favoriteTableViewColor
    }
    
}
