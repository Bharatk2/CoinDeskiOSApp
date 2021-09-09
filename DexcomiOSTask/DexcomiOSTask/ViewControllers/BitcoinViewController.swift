//
//  BitcoinViewController.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import UIKit
import Combine
class BitcoinViewController: UIViewController {
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var timeStamp: UILabel!
    var bitcoinViewModel = BitcoinViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    var usdViewModel: USDViewModel? {
        didSet {
            updateUSDViews()
        }
    }
    
    var eurViewModel: EURViewModel? {
        didSet {
            updateEURViews()
        }
    }
    
    var gbpViewModel: GBPViewModel? {
        didSet {
            updateGBPViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControllerUpdate()
    }

    @IBAction func segmentedControllerTapped(_ sender: UISegmentedControl) {
        DispatchQueue.main.async {
            self.viewDidLoad()
        }
      
    }
    
    func segmentedControllerUpdate() {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            bitcoinViewModel.$usdCurrency
               .receive(on: DispatchQueue.main)
               .sink { [weak self] items in
                self?.usdViewModel = items
              
               }
               .store(in: &subscriptions)
            self.updateUSDViews()
            
        case 1:
            
            bitcoinViewModel.$eurCurrency
               .receive(on: DispatchQueue.main)
               .sink { [weak self] items in
                self?.eurViewModel = items
               }
               .store(in: &subscriptions)
            
        case 2:
            bitcoinViewModel.$gbpCurrency
               .receive(on: DispatchQueue.main)
               .sink { [weak self] items in
                self?.gbpViewModel = items
               }
               .store(in: &subscriptions)
            
        default:
            break
        }
    }
    
    func updateUSDViews() {
        guard let usdViewModel = self.usdViewModel else { return }
        currencyLabel.text = usdViewModel.currency
        priceLabel.text = usdViewModel.rate
        descriptionLabel.text = usdViewModel.description
    }
    
    func updateEURViews() {
        guard let eurViewModel = self.eurViewModel else { return }
        currencyLabel.text = eurViewModel.currency
        priceLabel.text = eurViewModel.rate
        descriptionLabel.text = eurViewModel.description
    }
    func updateGBPViews() {
        guard let gbpViewModel = self.gbpViewModel else { return }
        currencyLabel.text = gbpViewModel.currency
        priceLabel.text = gbpViewModel.rate
        descriptionLabel.text = gbpViewModel.description
    }
    
}

