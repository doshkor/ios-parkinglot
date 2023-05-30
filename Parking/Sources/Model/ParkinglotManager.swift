//
//  ParkinglotManager.swift
//  Parking
//
//  Created by 신동오 on 2023/05/24.
//

import Foundation

struct ParkinglotManager {
    
    // MARK: - Public property
    
    var records: [Record]? {
        get {
            return parkinglot?.records
        }
    }
    
    var favoriteRecords: [Record]? {
        get {
            return favoriteParkinglot.records
        }
    }
    
    // MARK: - Private Property
    
    private let parkinglot: ParkinglotDTO?
    private let favoriteParkinglot = FavoriteParkinglotManager.shared
    
    // MARK: - init()
    
    init() {
        guard let fileLocation = Bundle.main.url(forResource: "JsonData-Parking", withExtension: "json"),
              let data = try? String(contentsOf: fileLocation).data(using: .utf8),
              let parsedData = try? JSONDecoder().decode(ParkinglotDTO.self, from: data)
        else {
            self.parkinglot = nil
            print("fileload fail")
            return
        }
        
        self.parkinglot = parsedData
    }
    
}
