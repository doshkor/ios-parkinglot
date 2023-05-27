//
//  FavoriteTableViewCell.swift
//  Parking
//
//  Created by 신동오 on 2023/05/27.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CustomCell"
    
    lazy var favoriteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 13
        return view
    }()
    
     let photoIamgeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "car.top.radiowaves.rear.left.and.rear.right")
         imageView.layer.cornerRadius = 15
         imageView.backgroundColor = .systemPink
        return imageView
    }()
    
//     lazy var iconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "location.square.fill")
//        return imageView
//    }()
//
//     let nameLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
//
//    private lazy var nameStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [iconImageView, nameLabel])
//        stackView.axis = .horizontal
//        return stackView
//    }()
//
//     let addressLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
//
//     let informationLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
//
//    private lazy var textStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [nameStackView, addressLabel, informationLabel])
//        stackView.axis = .vertical
//        return stackView
//    }()
    
    // MARK: - Function
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Function
    
    private func configure() {
        
        self.contentView.backgroundColor = UIConstant.favoriteTableViewColor
        
        contentView.addSubview(favoriteView)
        favoriteView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(photoIamgeView)
        photoIamgeView.translatesAutoresizingMaskIntoConstraints = false
        
//        contentView.addSubview(textStackView)
//        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
            favoriteView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            favoriteView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            favoriteView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            favoriteView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            
            photoIamgeView.topAnchor.constraint(equalTo: self.favoriteView.topAnchor, constant: 20),
            photoIamgeView.bottomAnchor.constraint(equalTo: self.favoriteView.bottomAnchor, constant: -20),
            photoIamgeView.leadingAnchor.constraint(equalTo: self.favoriteView.leadingAnchor, constant: 10),
            photoIamgeView.widthAnchor.constraint(equalToConstant: self.frame.width * 27 / 100),
            
        ])
    }
    
}
