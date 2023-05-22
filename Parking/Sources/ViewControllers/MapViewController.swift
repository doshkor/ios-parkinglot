//
//  MapViewController.swift
//  Parking
//
//  Created by 신동오 on 2023/05/19.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
    }
    
}
