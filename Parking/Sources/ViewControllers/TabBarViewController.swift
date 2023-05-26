//
//  TabBarViewController.swift
//  Parking
//
//  Created by 신동오 on 2023/05/26.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Private Property
    
    private let viewController1 = UIViewController()
    private let viewController2 = MapViewController()
    private let viewController3 = UIViewController()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Function
    
    private func configure() {
        setViewControllers()
        configureUI()
    }
    
    private func setViewControllers() {
        let viewControllers = [viewController1, viewController2, viewController3]
        self.setViewControllers(viewControllers, animated: true)
        
        if let items = self.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "star.fill")
            items[0].image = UIImage(systemName: "star")
            items[0].title = "즐겨찾기"
            
            items[1].selectedImage = UIImage(systemName: "map.fill")
            items[1].image = UIImage(systemName: "map")
            items[1].title = "지도"
            
            items[2].selectedImage = UIImage(systemName: "gearshape.fill")
            items[2].image = UIImage(systemName: "gearshape")
            items[2].title = "설정"
        }
    }
    
    private func configureUI() {
        viewController1.view.backgroundColor = .yellow
        viewController3.view.backgroundColor = .blue
        
        tabBar.tintColor = UIConstant.mainUIColor
        tabBar.backgroundColor = .white
    }

}
