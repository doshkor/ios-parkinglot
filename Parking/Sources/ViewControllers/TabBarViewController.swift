//
//  TabBarViewController.swift
//  Parking
//
//  Created by 신동오 on 2023/05/26.
//

import UIKit
import Lottie

class TabBarViewController: UITabBarController {
    
    // MARK: - Private Property
    
    private var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "pin-animation")
        animationView.backgroundColor = .white
        animationView.alpha = 1
        return animationView
    }()
    
    private var animationBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let favoriteViewController = FavoriteViewController()
    private let mapViewController = MapViewController()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureAnimationView()
    }
    
    // MARK: - Private Function
    
    private func configure() {
        setViewControllers()
        configureUI()
        configureAnimationView()
    }
    
    private func setViewControllers() {
        let viewControllers = [favoriteViewController, mapViewController]
        self.setViewControllers(viewControllers, animated: true)
        
        favoriteViewController.delegate = mapViewController
        
        if let items = self.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "star.fill")
            items[0].image = UIImage(systemName: "star")
            items[0].title = "즐겨찾기"
            
            items[1].selectedImage = UIImage(systemName: "map.fill")
            items[1].image = UIImage(systemName: "map")
            items[1].title = "지도"
        }
    }
    
    private func configureUI() {
        tabBar.tintColor = UIConstant.mainUIColor
        tabBar.backgroundColor = .white
    }
    
    private func configureAnimationView() {
        view.addSubview(animationBackgroundView)
        animationBackgroundView.frame = view.frame
        animationBackgroundView.addSubview(animationView)
        animationView.frame = .init(x: 0, y: 0, width: 50, height: 50)
        animationView.center = animationBackgroundView.center
        animationView.alpha = 1
        
        animationView.play { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.animationBackgroundView.alpha = 0
            }, completion: { _ in
                self.animationBackgroundView.isHidden = true
                self.animationBackgroundView.removeFromSuperview()
            })
        }
    }

}
