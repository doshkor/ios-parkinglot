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
    
    // MARK: - Private Property
    
    private let tableView = FavoriteTableView()
    private var dataSource: UITableViewDiffableDataSource<Int, Item>!

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
    }
    
    private func configureDataSource() {
        
        dataSource = UITableViewDiffableDataSource<Int, Item>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = item.title
            return cell
        }
        
        tableView.dataSource = dataSource

        // 데이터 생성
        let items = [
            Item(id: 1, title: "Item 1"),
            Item(id: 2, title: "Item 2"),
            Item(id: 3, title: "Item 3")
        ]
        
        // 스냅샷 생성
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        
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

// MARK: - Extension: UITableViewDataSource

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        return cell
    }
    
}
