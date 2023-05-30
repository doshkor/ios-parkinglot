//
//  FavoriteParkinglotManager.swift
//  Parking
//
//  Created by 신동오 on 2023/05/30.
//

import Foundation

class FavoriteParkinglotManager {

    // MARK: - Static Property
    
    static let shared = FavoriteParkinglotManager()
    
    // MARK: - Public Property
    
    var records: [Record]? {
        get {
            return favoriteParkinglot?.records
        }
    }
    
    // MARK: - Private Property
    
    private var favoriteParkinglot: ParkinglotDTO?
    
    // MARK: - Private Init
    
    private init() {
        guard let fileLocation = Bundle.main.url(forResource: "FavoriteMock", withExtension: "json"),
              let data = try? String(contentsOf: fileLocation).data(using: .utf8),
              let parsedData = try? JSONDecoder().decode(ParkinglotDTO.self, from: data)
        else {
            self.favoriteParkinglot = nil
            print("fileload fail")
            return
        }
        self.favoriteParkinglot = parsedData
    }
    
}
