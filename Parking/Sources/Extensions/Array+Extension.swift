//
//  Array+Extension.swift
//  Parking
//
//  Created by 신동오 on 2023/05/30.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
}
