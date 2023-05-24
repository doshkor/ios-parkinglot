//
//  ParkinglotDataManager.swift
//  Parking
//
//  Created by 신동오 on 2023/05/24.
//

import Foundation

struct ParkinglotDataManager {
    
    // MARK: - Public property
    
    var record: [Record]? {
        get {
            return parkinglot?.records
        }
    }
    
    // MARK: - Private Property
    
    private let parkinglot: ParkinglotDTO?
    
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
