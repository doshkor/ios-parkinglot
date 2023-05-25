//
//  MapViewController.swift
//  Parking
//
//  Created by 신동오 on 2023/05/19.
//

import UIKit
import NMapsMap
import CoreLocation

fileprivate enum CommonUIConstant {
    
    // MARK: - Marker
    static let markerWidth:Double = 30
    static let markerHeight:Double = markerWidth * 1.3
    static let markerIconImage = NMF_MARKER_IMAGE_GRAY
    
    // MARK: - Initail Config
    static let zoomLevelAtFirst = 12.0
    
}

class MapViewController: UIViewController {
    
    // MARK: - Private property
    private let locationManager = CLLocationManager()
    private let parkinglotDataManager = ParkinglotDataManager()
    
    private lazy var naverMapView = NMFNaverMapView(frame: view.frame)
    private let searchTextField = SearchBarTextField(frame: .zero)
    
    private var markers: [NMFMarker] = []
    private var zoomlevel: Double = CommonUIConstant.zoomLevelAtFirst {
        didSet {
            markers.forEach { marker in
                marker.fitSize(to: zoomlevel)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Configure
        configure()
        
        // MARK: - 처음 위치로 화면 이동
        
        moveCameraFirst()
        
        // MARK: - Marker 표시
        markAll()
        
        searchTextField.delegate = self
    }
    
    // MARK: - Override Function
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private function
    
    private func configure() {
        configureLocation()
        configureNaverMapView()
        configureUIConstraints()
    }
    
    private func configureLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func configureNaverMapView() {
        naverMapView.mapView.addCameraDelegate(delegate: self)
        
        view.addSubview(naverMapView)
        naverMapView.showCompass = true
        naverMapView.showLocationButton = true
    }
    
    private func configureUIConstraints() {
        view.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func moveCameraFirst() {
        // 추후 사용자가 마지막으로 사용한 위치에 대해서 캐싱하기
        // locationManager가 위치를 받는게 더 느리면 어떻게 처리할까?
        guard let latitude = locationManager.location?.coordinate.latitude,
              let longitude = locationManager.location?.coordinate.longitude
        else {
            return
        }
        let location = NMGLatLng(lat: latitude, lng: longitude)
        moveCameraTo(location: location)
    }
    
    private func moveCameraTo(location: NMGLatLng) {
        let param = NMFCameraUpdateParams()
        param.scroll(to: location)
        param.zoom(to: CommonUIConstant.zoomLevelAtFirst)
        param.tilt(to: 0)
        param.rotate(to: 0)
        naverMapView.mapView.moveCamera(NMFCameraUpdate(params: param))
    }
    
    private func moveCamera(latitude: Double, longitude: Double) {
        
    }
    
    private func markLocation(latitude: Double, longitude: Double) {
        let marker = NMFMarker(position: NMGLatLng(lat: latitude, lng: longitude))
        marker.fitSize(to: naverMapView.mapView.zoomLevel)
        marker.iconImage = CommonUIConstant.markerIconImage
        marker.mapView = naverMapView.mapView
        self.markers.append(marker)
    }
    
    private func markAll() {
        let items = parkinglotDataManager.record
        items?.forEach({ record in
            if let lat = Double(record.위도), let lon = Double(record.경도) {
                markLocation(latitude: lat, longitude: lon)
            }
            else {
                // 데이터에 위도,경도가 없는 경우
            }
        })
    }
    
}

// MARK: - Extenstion: NMFMapViewCameraDelegate

extension MapViewController: NMFMapViewCameraDelegate {
    
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
    }
    
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
    }
    
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        if mapView.zoomLevel != self.zoomlevel {
            self.zoomlevel = mapView.zoomLevel
        }
    }
    
}

// MARK: - Extension: UISearchTextFieldDelegate
extension MapViewController: UISearchTextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
}

// MARK: - Fileprivate

fileprivate extension NMFMarker {
    
    func fitSize(to zoomLevel: Double) {
        switch zoomLevel {
        case ...5:
            self.width = 1
            self.height = 1 * 1.3
        case 5...6:
            self.width = 2
            self.height = 2 * 1.3
        case 6...7:
            self.width = 3
            self.height = 3 * 1.3
        case 7...8:
            self.width = 4
            self.height = 4 * 1.3
        case 8...9:
            self.width = 6
            self.height = 6 * 1.3
        case 9...10:
            self.width = 9
            self.height = 9 * 1.3
        case 10...11:
            self.width = 12
            self.height = 12 * 1.3
        case 11...12:
            self.width = 15
            self.height = 15 * 1.3
        case 12...13:
            self.width = 18
            self.height = 18 * 1.3
        case 13...14:
            self.width = 21
            self.height = 21 * 1.3
        case 14...:
            self.width = 24
            self.height = 24 * 1.3
        default:
            self.width = 5
            self.height = 5
        }
    }
    
}
