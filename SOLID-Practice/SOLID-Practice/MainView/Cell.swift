//
//  Cell.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/15.
//

import UIKit

final class Cell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
