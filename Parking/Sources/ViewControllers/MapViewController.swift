//
//  MapViewController.swift
//  Parking
//
//  Created by 신동오 on 2023/05/19.
//

import UIKit
import NMapsMap
import CoreLocation

enum CommonUIConstant {
    static let markerWidth:Double = 30
    static let markerHeight:Double = markerWidth * 1.3
    static let markerIconImage = NMF_MARKER_IMAGE_BLACK
}

class MapViewController: UIViewController, NMFMapViewTouchDelegate {
    
    // MARK: - Private property
    
    private let locationManager = CLLocationManager()
    private lazy var naverMapView = NMFNaverMapView(frame: view.frame)
    private let parkinglotDataManager = ParkinglotDataManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Configure
        configure()
        
        // MARK: - 처음 위치로 화면 이동
        moveCameraFirst()
        
        // MARK: - Marker 표시
        markAll()
    }
    
    // MARK: - Private function
    
    private func configure() {
        configureLocation()
        configureNaverMapView()
    }
    
    private func configureLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func configureNaverMapView() {
        view.addSubview(naverMapView)
        naverMapView.showCompass = true
        naverMapView.showLocationButton = true
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
        param.zoom(to: 12)
        param.tilt(to: 0)
        param.rotate(to: 0)
        naverMapView.mapView.moveCamera(NMFCameraUpdate(params: param))
    }
    
    private func moveCamera(latitude: Double, longitude: Double) {
        
    }
    
    private func markLocation(latitude: Double, longitude: Double) {
        let marker = NMFMarker(position: NMGLatLng(lat: latitude, lng: longitude))
        marker.width = CommonUIConstant.markerWidth
        marker.height = CommonUIConstant.markerHeight
        marker.iconImage = CommonUIConstant.markerIconImage
        marker.mapView = naverMapView.mapView
    }
    
    private func markAll() {
        let items = parkinglotDataManager.record
        items?.forEach({ record in
            if let lat = Double(record.위도), let lon = Double(record.경도) {
                markLocation(latitude: lat, longitude: lon)
            }
            else {
                print("no lat,lon")
            }
        })
    }
    
}
