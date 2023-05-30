//
//  ParkinglotDetailModalViewController.swift
//  Parking
//
//  Created by 신동오 on 2023/05/30.
//

import UIKit

class ParkinglotDetailModalViewController: UIViewController {
    
    // MARK: - Public Property
    
    let favoriteIamgeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "favorite-Icon")
        return imageView
    }()
    
    let photoIamgeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "car.top.radiowaves.rear.left.and.rear.right")
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    let paidLabel: UILabel = {
        let label = UILabel()
        label.text = "유료"
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 0.286, green: 0.314, blue: 0.341, alpha: 1).cgColor
        label.textColor = UIColor(red: 0.286, green: 0.314, blue: 0.341, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.layer.cornerRadius = 9
        label.textAlignment = .center
        return label
    }()
    
    let freeLabel: UILabel = {
        let label = UILabel()
        label.text = "무료"
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 0.286, green: 0.314, blue: 0.341, alpha: 1).cgColor
        label.textColor = UIColor(red: 0.286, green: 0.314, blue: 0.341, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.layer.cornerRadius = 9
        label.textAlignment = .center
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
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
    
    let phoneIamgeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "phone-Icon")
        return imageView
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "telephone"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.286, green: 0.314, blue: 0.341, alpha: 0.7)
        return label
    }()
    
    // MARK: - Private Property
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    private let defaultHeight: CGFloat = 220
    private var currentContainerHeight: CGFloat = 220
    private let dismissibleHeight: CGFloat = 150
    private lazy var maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - view.safeAreaLayoutGuide.layoutFrame.height
    private let maxDimmedAlpha: CGFloat = 0.6
    
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPanGesture()
        configureHierarchy()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    // MARK: - Private Function
    
    private func configureHierarchy() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        view.addSubview(favoriteIamgeView)
        view.addSubview(photoIamgeView)
        view.addSubview(paidLabel)
        view.addSubview(freeLabel)
        view.addSubview(nameLabel)
        view.addSubview(addressLabel)
        view.addSubview(informationLabel)
        view.addSubview(phoneIamgeView)
        view.addSubview(phoneNumberLabel)
        
        configureSubviewsConstraints()
    }
    
    private func configureSubviewsConstraints() {
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        favoriteIamgeView.translatesAutoresizingMaskIntoConstraints = false
        photoIamgeView.translatesAutoresizingMaskIntoConstraints = false
        paidLabel.translatesAutoresizingMaskIntoConstraints = false
        freeLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneIamgeView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false

        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            favoriteIamgeView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 13),
            favoriteIamgeView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -23),
            favoriteIamgeView.widthAnchor.constraint(equalToConstant: 22),
            favoriteIamgeView.heightAnchor.constraint(equalToConstant: 21),
            
            photoIamgeView.widthAnchor.constraint(equalToConstant: 110),
            photoIamgeView.heightAnchor.constraint(equalToConstant: 90),
            photoIamgeView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            photoIamgeView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            paidLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 65),
            paidLabel.leadingAnchor.constraint(equalTo: photoIamgeView.trailingAnchor, constant: 25),
            paidLabel.widthAnchor.constraint(equalToConstant: 50),
            paidLabel.heightAnchor.constraint(equalToConstant: 18),
            
            freeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 65),
            freeLabel.leadingAnchor.constraint(equalTo: paidLabel.trailingAnchor, constant: 4),
            freeLabel.widthAnchor.constraint(equalToConstant: 50),
            freeLabel.heightAnchor.constraint(equalToConstant: 18),
            
            nameLabel.topAnchor.constraint(equalTo: paidLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: photoIamgeView.trailingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 26),
            
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: photoIamgeView.trailingAnchor, constant: 25),
            addressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20),
            addressLabel.heightAnchor.constraint(equalToConstant: 18),
            
            informationLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor),
            informationLabel.leadingAnchor.constraint(equalTo: photoIamgeView.trailingAnchor, constant: 25),
            informationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20),
            informationLabel.heightAnchor.constraint(equalToConstant: 18),
            
            phoneIamgeView.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 2.7),
            phoneIamgeView.leadingAnchor.constraint(equalTo: photoIamgeView.trailingAnchor, constant: 25),
            phoneIamgeView.widthAnchor.constraint(equalToConstant: 12.4),
            phoneIamgeView.heightAnchor.constraint(equalToConstant: 12.4),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: phoneIamgeView.trailingAnchor, constant: 3.64),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20),
            phoneNumberLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight && isDraggingDown {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
        default:
            break
        }
    }
    
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    private func setupView() {
        view.backgroundColor = .clear
    }
    
    private func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    private func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
        
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
}


