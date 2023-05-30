//
//  UIConstant.swift
//  Parking
//
//  Created by 신동오 on 2023/05/26.
//

import UIKit
import NMapsMap

enum UIConstant {
    
    // MARK: - Color
    static let mainUIColor = UIColor(red: 0, green: 0.196, blue: 0.892, alpha: 1)
    static let favoriteTableViewColor = UIColor(red: 0.914, green: 0.925, blue: 0.937, alpha: 1)
    static let favoriteTableViewHeaderColor = UIColor(red: 0.992, green: 0.992, blue: 0.992, alpha: 1)
    static let feeLabelTextColor = UIColor(red: 0.286, green: 0.314, blue: 0.341, alpha: 1)
    static let addressLabelTextColor = UIColor(red: 0.286, green: 0.314, blue: 0.341, alpha: 1)
    static let informationLabelTextColor = UIColor(red: 0.286, green: 0.314, blue: 0.341, alpha: 0.7)
    static let phoneNumberLabelTextColor = UIColor(red: 0.286, green: 0.314, blue: 0.341, alpha: 0.7)
    
    // MARK: - Marker
    static let markerWidth:Double = 30
    static let markerHeight:Double = markerWidth * 1.3
    static let markerIconImage = NMF_MARKER_IMAGE_BLACK
    static let markerSelectedIconImage = NMF_MARKER_IMAGE_RED
    
}
