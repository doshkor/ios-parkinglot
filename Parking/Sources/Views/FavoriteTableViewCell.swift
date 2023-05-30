//
//  FavoriteTableViewCell.swift
//  Parking
//
//  Created by 신동오 on 2023/05/27.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CustomCell"
    
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 13
        return view
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "car.top.radiowaves.rear.left.and.rear.right")
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    let iconBackgroundView: UIView = {
        let view = UIView(frame: .init(x: 0, y: 0, width: 20, height: 20))
        view.layer.cornerRadius = view.bounds.size.width/2
        view.backgroundColor = UIConstant.mainUIColor
        return view
    }()
    
    let iconTextLabel: UILabel = {
        let label = UILabel()
        label.text = "유"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "parkinglot name"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "address"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.286, green: 0.314, blue: 0.341, alpha: 1)
        return label
    }()
    
    let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "information"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.286, green: 0.314, blue: 0.341, alpha: 0.7)
        return label
    }()
    
    // MARK: - Function
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Function
    
    private func configure() {
        configureUI()
        configureHierarchy()
    }
    
    private func configureUI() {
        contentView.backgroundColor = UIConstant.favoriteTableViewColor
    }
    
    private func configureHierarchy() {
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(iconBackgroundView)
        iconBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(iconTextLabel)
        iconTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(informationLabel)
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        configureSubviewsConstraints()
    }
    
    private func configureSubviewsConstraints() {
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            cellBackgroundView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            cellBackgroundView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            cellBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            
            photoImageView.topAnchor.constraint(equalTo: self.cellBackgroundView.topAnchor, constant: 20),
            photoImageView.bottomAnchor.constraint(equalTo: self.cellBackgroundView.bottomAnchor, constant: -20),
            photoImageView.leadingAnchor.constraint(equalTo: self.cellBackgroundView.leadingAnchor, constant: 10),
            photoImageView.widthAnchor.constraint(equalToConstant: self.frame.width * 27 / 100),
            
            iconBackgroundView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 27),
            iconBackgroundView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 15),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: 20),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: 20),
            
            iconTextLabel.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            iconTextLabel.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),
            iconTextLabel.widthAnchor.constraint(equalToConstant: 10),
            iconTextLabel.heightAnchor.constraint(equalToConstant: 15),
            
            nameLabel.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: iconBackgroundView.trailingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 26),
            
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: iconBackgroundView.leadingAnchor),
            addressLabel.heightAnchor.constraint(equalToConstant: 18),
            addressLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor),
            
            informationLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor),
            informationLabel.leadingAnchor.constraint(equalTo: iconBackgroundView.leadingAnchor),
            informationLabel.heightAnchor.constraint(equalToConstant: 18),
            informationLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor),
        ])
    }
    
}
