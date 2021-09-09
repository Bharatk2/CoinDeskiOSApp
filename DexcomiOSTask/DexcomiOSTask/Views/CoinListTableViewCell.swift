//
//  CoinListTableViewCell.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import UIKit
import Combine
class CoinListTableViewCell: UITableViewCell {
    
    var coinlabel = UILabel()
    var symbolLabel = UILabel()
    private var cancellables = Set<AnyCancellable>()
    var coinViewModel: CoinViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        handleConstraints()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        handleConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        handleConstraints()
    }
    
    func handleConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        
        coinlabel.font = UIFont(name: "AvenirNext-Semibold", size: 17)
        coinlabel.textColor = UIColor(named: "#4A4A4A")
        coinlabel.textAlignment = .center
        coinlabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(coinlabel)
        
        // ingredientslabel label Constraints
        coinlabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        coinlabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        
        // measureLabel name setup
        symbolLabel.font = UIFont(name: "AvenirNext-Semibold", size: 17)
        symbolLabel.textColor = UIColor(named: "#4A4A4A")
        symbolLabel.textAlignment = .center
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(symbolLabel)
        
        // mealNameLabel name constraints
        symbolLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        symbolLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
    }
    
    private func bindViewModel() {
        guard let coinViewModel = self.coinViewModel else { return }
        coinViewModel.$name
            .receive(on: DispatchQueue.main)
            .sink { name in
                self.coinlabel.text = name
            }.store(in: &cancellables)
        
        coinViewModel.$symbol
            .receive(on: DispatchQueue.main)
            .sink { name in
                self.symbolLabel.text = name
            }.store(in: &cancellables)
    }
}
