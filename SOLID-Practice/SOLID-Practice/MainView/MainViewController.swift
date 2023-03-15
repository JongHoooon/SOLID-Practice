//
//  MainViewController.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/15.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let subjects: [String] = [
        "OCP",
        "LSP",
        "DIP",
        "Coordinator",
        "Network"
    ]
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return subjects.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let subject = subjects[indexPath.row]
        cell.textLabel?.text = subject
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            print("test")
        default:
            print("default")
        }
    }
}

private extension MainViewController {
    func configureLayout() {
        tableView.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
}

