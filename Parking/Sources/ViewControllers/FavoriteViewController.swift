//
//  FavoriteViewController.swift
//  Parking
//
//  Created by 신동오 on 2023/05/26.
//

import UIKit

protocol FavoriteViewControllerDelegate: AnyObject {
    func favoriteViewController(favoriteViewController:FavoriteViewController,willDisplay record: Record)
}

class FavoriteViewController: UIViewController {
    
    let testImages: [UIImage] = {
        var images: [UIImage] = []
        guard let image1 = UIImage(named: "parkinglot-image1"),
              let image2 = UIImage(named: "parkinglot-image2"),
              let image3 = UIImage(named: "parkinglot-image3")
        else {
            return []
        }
        images = [image1, image2, image3]
        return images
    }()
    
    let testData: ParkinglotDTO? = {
        guard let fileLocation = Bundle.main.url(forResource: "FavoriteMock", withExtension: "json"),
              let data = try? String(contentsOf: fileLocation).data(using: .utf8),
              let parsedData = try? JSONDecoder().decode(ParkinglotDTO.self, from: data)
        else {
            return nil
        }
        
        return parsedData
    }()
    
    // MARK: - Private Property
    
    private let titleView = FavoriteTitleView()
    private let tableView = FavoriteTableView()
    private var dataSource: UITableViewDiffableDataSource<Int, Record>!
    
    var delegate: FavoriteViewControllerDelegate?

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Functionas
    
    private func configure() {
        configureDataSource()
        configureUI()
        configureHierarchy()
        tableView.delegate = self
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, Record>(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
            
            
            
            let randomInt = Int.random(in: 1...3)
            cell.photoImageView.image = UIImage(named: "parkinglot-image\(randomInt)")
            cell.nameLabel.text = item.주차장명.contains("주차장") ? item.주차장명 : item.주차장명 + "주차장"
            cell.addressLabel.text = item.소재지도로명주소 != "" ? item.소재지도로명주소 : item.소재지지번주소
            var informationText: String = ""
            if item.주차장구분 != "" {
                informationText += item.주차장구분
            }
            if item.요금정보 != "" {
                informationText += " / \(item.요금정보)"
            }
            if item.추가단위시간 != "" && item.추가단위시간 != "0" && item.추가단위요금 != "" && item.추가단위요금 != "0" {
                informationText += " / \(item.추가단위시간)분 \(item.추가단위요금)원"
            }
            cell.informationLabel.text = informationText
            
            switch item.요금정보 {
            case "유료":
                cell.iconBackgroundView.backgroundColor = UIConstant.mainUIColor
                cell.iconTextLabel.text = "유"
                cell.iconTextLabel.textColor = .white
            case "무료":
                cell.iconBackgroundView.backgroundColor = .white
                cell.iconBackgroundView.layer.borderWidth = 1
                cell.iconBackgroundView.layer.borderColor = UIConstant.mainUIColor.cgColor
                cell.iconTextLabel.text = "무"
                cell.iconTextLabel.textColor = UIConstant.mainUIColor
            default:
                break
            }
            
            return cell
        }
        
        tableView.dataSource = dataSource
        
        // 스냅샷 생성
        var snapshot = NSDiffableDataSourceSnapshot<Int, Record>()
        snapshot.appendSections([0])
        if let testData = testData {
            snapshot.appendItems(testData.records)
        }
        else {}
        
        // 스냅샷 적용
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureHierarchy() {
        view.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        configureSubviewsConstraints()
    }
    
    private func configureSubviewsConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

// MARK: - Extension: UITableViewDelegate

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tabBarController?.selectedIndex = 1
        guard let record = testData?.records[safe: indexPath.row] else { return }
        delegate?.favoriteViewController(favoriteViewController: self, willDisplay: record)
    }

}
