//
//  CoinListTableViewCell.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import UIKit
import Combine
class CoinListTableViewCell: UITableViewCell {
    // MARK: - Properties
    var coinlabel = UILabel()
    var symbolLabel = UILabel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    var coinViewModel: CoinViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        handleConstraints()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        handleConstraints()
    }
    
    // MARK: - Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        handleConstraints()
    }
    
    // MARK: - Helper Methods
   private func handleConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        // coinLabel set up
        coinlabel.font = UIFont(name: "AvenirNext-Semibold", size: 17)
        coinlabel.textColor = UIColor(named: "#4A4A4A")
        coinlabel.textAlignment = .center
        coinlabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(coinlabel)
        
        // coinLabel label Constraints
        coinlabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        coinlabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        
        // symbolLabel setup
        symbolLabel.font = UIFont(name: "AvenirNext-Semibold", size: 17)
        symbolLabel.textColor = UIColor(named: "#4A4A4A")
        symbolLabel.textAlignment = .center
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(symbolLabel)
        
        // symbolLabel constraints
        symbolLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        symbolLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
    }
    
    private func bindViewModel() {
        guard let coinViewModel = self.coinViewModel else { return }
        // we are getting the published coinViewModel properties to assign our labelText
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
