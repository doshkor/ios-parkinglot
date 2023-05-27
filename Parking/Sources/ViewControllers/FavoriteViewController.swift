//
//  FavoriteViewController.swift
//  Parking
//
//  Created by 신동오 on 2023/05/26.
//

import UIKit

struct Item: Hashable {
    let id: Int
    let title: String
}

class FavoriteViewController: UIViewController {
    
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
    
    private let tableView = FavoriteTableView()
    private var dataSource: UITableViewDiffableDataSource<Int, Record>!

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Function
    
    private func configure() {
        configureDataSource()
        configureUI()
        configureAutoLayout()
        tableView.delegate = self
    }
    
    private func configureDataSource() {
        
        dataSource = UITableViewDiffableDataSource<Int, Record>(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
            
//            cell.nameLabel.text = item.주차장명
//            cell.addressLabel.text = item.소재지도로명주소
            
//            NSLayoutConstraint.activate([
//                cell.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 20),
//                cell.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -20)
//            ])
            
            return cell
        }
        
        tableView.dataSource = dataSource
        
        // 스냅샷 생성
        var snapshot = NSDiffableDataSourceSnapshot<Int, Record>()
        snapshot.appendSections([0])
        snapshot.appendItems(testData!.records)
        
        // 스냅샷 적용
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureAutoLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        tableView.configureAutoLayout()
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

// MARK: - Extension: UITableViewDelegate

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
