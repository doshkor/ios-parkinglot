//
//  MapViewController.swift
//  Parking
//
//  Created by 신동오 on 2023/05/19.
//

import UIKit
import NMapsMap
import CoreLocation

fileprivate enum LocalConstant {
    static let zoomLevelAtFirst = 12.0
}

class MapViewController: UIViewController {
    
    // MARK: - Private property
    private let locationManager = CLLocationManager()
    private let parkinglotDataManager = ParkinglotDataManager()
    
    private lazy var naverMapView = NMFNaverMapView(frame: view.frame)
    private let searchBarView = SearchBarView()
    
    private var selectedMarker: NMFMarker? {
        didSet {
            oldValue?.iconImage = UIConstant.markerIconImage
        }
        willSet {
            newValue?.iconImage = UIConstant.markerSelectedIconImage
        }
    }
    private var markers: [NMFMarker] = []
    private var zoomlevel: Double = LocalConstant.zoomLevelAtFirst {
        didSet {
            markers.forEach { marker in
                marker.fitSize(accordingTo: zoomlevel)
            }
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Configure
        configure()
        
        // MARK: - 처음 위치로 화면 이동
        
        moveCameraFirst()
        
        // MARK: - Marker 표시
        markAll()
    }
    
    // MARK: - Override Function
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private function
    
    private func configure() {
        searchBarView.textField.delegate = self
        
        configureLocation()
        configureNaverMapView()
        configureHierarchy()
    }
    
    private func configureLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func configureNaverMapView() {
        naverMapView.mapView.addCameraDelegate(delegate: self)
        
        naverMapView.showCompass = true
        naverMapView.showLocationButton = true
    }
    
    private func configureHierarchy() {
        view.addSubview(naverMapView)
        
        view.addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        
        configureSubviewsConstraints()
    }
    
    private func configureSubviewsConstraints() {
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            searchBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
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
        param.zoom(to: LocalConstant.zoomLevelAtFirst)
        param.tilt(to: 0)
        param.rotate(to: 0)
        naverMapView.mapView.moveCamera(NMFCameraUpdate(params: param))
    }
    
    private func moveCamera(latitude: Double, longitude: Double) {
        
    }
    
    private func markAll() {
        let items = parkinglotDataManager.record
        items?.forEach {
            markLocation(of: $0)
        }
    }
    
    private func markLocation(of record: Record) {
        guard let marker = NMFMarker(record: record) else {
            return
        }
        marker.captionText = record.주차장명.contains("주차장") ? record.주차장명 : record.주차장명 + "주차장"
        marker.fitSize(accordingTo: naverMapView.mapView.zoomLevel)
        marker.touchHandler = { (overlay) in
            self.selectedMarker = marker
            self.presentModal(with: record)
            return true
        }
        marker.mapView = naverMapView.mapView
        markers.append(marker)
    }
    
    private func presentModal(with record: Record) {
        let vc = ParkinglotDetailModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        
        let randomInt = Int.random(in: 1...3)
        vc.photoImageView.image = UIImage(named: "parkinglot-image\(randomInt)")
        vc.nameLabel.text = record.주차장명.contains("주차장") ? record.주차장명 : record.주차장명 + "주차장"
        vc.addressLabel.text = record.소재지도로명주소 != "" ? record.소재지도로명주소 : record.소재지지번주소
        var informationText: String = ""
        if record.주차장구분 != "" {
            informationText += record.주차장구분
        }
        if record.요금정보 != "" {
            informationText += " / \(record.요금정보)"
        }
        if record.추가단위시간 != "" && record.추가단위시간 != "0" && record.추가단위요금 != "" && record.추가단위요금 != "0" {
            informationText += " / \(record.추가단위시간)분 \(record.추가단위요금)원"
        }
        vc.informationLabel.text = informationText
        vc.phoneNumberLabel.text = record.전화번호 != "" ? record.전화번호 : "전화번호가 없습니다"
        
        switch record.요금정보 {
        case "유료":
            vc.paidLabel.layer.backgroundColor = UIConstant.mainUIColor.cgColor
            vc.paidLabel.textColor = .white
        case "무료":
            vc.freeLabel.layer.backgroundColor = UIConstant.mainUIColor.cgColor
            vc.freeLabel.textColor = .white
        default:
            break
        }
        
        self.present(vc, animated: false)
    }
    
}

// MARK: - Extenstion: NMFMapViewCameraDelegate

extension MapViewController: NMFMapViewCameraDelegate {
    
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
    }
    
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
    }
    
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        if mapView.zoomLevel != zoomlevel {
            zoomlevel = mapView.zoomLevel
        }
    }
    
}

// MARK: - Extension: UISearchTextFieldDelegate
extension MapViewController: UISearchTextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBarView.searchIcon.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            searchBarView.searchIcon.isHidden = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBarView.textField.endEditing(true)
        return true
    }
    
}

// MARK: - Fileprivate

fileprivate extension NMFMarker {
    
    // MARK: - Init
    
    convenience init?(record: Record) {
        if let 위도 = Double(record.위도), let 경도 = Double(record.경도) {
            self.init(position: NMGLatLng(lat: 위도, lng: 경도))
            configureAttributes()
        }
        else {
            return nil
        }
    }
    
    // MARK: - Public Function
    
    func fitSize(accordingTo zoomLevel: Double) {
        switch zoomLevel {
        case ...5:
            self.width = 2
            self.height = 2 * 1.3
        case 5...6:
            self.width = 2
            self.height = 2 * 1.3
        case 6...7:
            self.width = 2
            self.height = 2 * 1.3
        case 7...8:
            self.width = 2
            self.height = 2 * 1.3
        case 8...9:
            self.width = 4
            self.height = 4 * 1.3
        case 9...10:
            self.width = 7
            self.height = 7 * 1.3
        case 10...11:
            self.width = 10
            self.height = 10 * 1.3
        case 11...12:
            self.width = 12
            self.height = 12 * 1.3
        case 12...13:
            self.width = 14
            self.height = 14 * 1.3
        case 13...14:
            self.width = 16
            self.height = 16 * 1.3
        case 14...15:
            self.width = 18
            self.height = 18 * 1.3
        case 15...16:
            self.width = 21
            self.height = 21 * 1.3
        case 16...:
            self.width = 24
            self.height = 24 * 1.3
        default:
            self.width = 5
            self.height = 5
        }
    }
    
    // MARK: - Private Function
    
    private func configureAttributes() {
        isHideCollidedCaptions = true
        isHideCollidedSymbols = true
        
        iconTintColor = UIConstant.mainUIColor
        iconImage = UIConstant.markerIconImage
        
        captionMinZoom = LocalConstant.zoomLevelAtFirst
    }
    
}

extension MapViewController: FavoriteViewControllerDelegate {
    
    func favoriteViewController(favoriteViewController: FavoriteViewController,willDisplay record: Record) {
        let 위도 = Double(record.위도)!
        let 경도 = Double(record.경도)!
        moveCameraTo(location: NMGLatLng(lat: 위도, lng: 경도))
        naverMapView.mapView.zoomLevel = 12
        
        let selectedMarker = markers.first { marker in
            marker.position == NMGLatLng(lat: 위도, lng: 경도)
        }
        selectedMarker?.iconImage = UIConstant.markerSelectedIconImage
        presentModal(with: record)
    }
    
}
