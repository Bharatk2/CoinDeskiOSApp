//
//  BitcoinViewController.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import UIKit
import Combine
class BitcoinViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    //MARK: - Properties
    var bitcoinViewModel = BitcoinViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Computed Properties
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
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControllerUpdate()
    }
    //MARK: - IBOutlet Actions
    @IBAction func segmentedControllerTapped(_ sender: UISegmentedControl) {
        // Whenever segmentedcontroller is having user interaction it will load the view again.
        DispatchQueue.main.async {
            self.viewDidLoad()
        }
      
    }
    
    //MARK: - Helper Method
    func segmentedControllerUpdate() {
        // we are using our segmented controller index to bind our properties and update the view
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
            
            bitcoinViewModel.$gbpCurrency
               .receive(on: DispatchQueue.main)
               .sink { [weak self] items in
                self?.gbpViewModel = items
               }
               .store(in: &subscriptions)
            
        case 2:
            bitcoinViewModel.$eurCurrency
               .receive(on: DispatchQueue.main)
               .sink { [weak self] items in
                self?.eurViewModel = items
               }
               .store(in: &subscriptions)
            
        default:
            break
        }
    }
    
    func updateUSDViews() {
        guard let usdViewModel = self.usdViewModel else { return }
        currencyLabel.text = usdViewModel.currency
        priceLabel.text = "$\(usdViewModel.rate)"
        descriptionLabel.text = usdViewModel.description
    }
    
    func updateEURViews() {
        guard let eurViewModel = self.eurViewModel else { return }
        currencyLabel.text = eurViewModel.currency
        priceLabel.text = "€\(eurViewModel.rate)"
        descriptionLabel.text = eurViewModel.description
    }
    func updateGBPViews() {
        guard let gbpViewModel = self.gbpViewModel else { return }
        currencyLabel.text = gbpViewModel.currency
        priceLabel.text = "£\(gbpViewModel.rate)"
        descriptionLabel.text = gbpViewModel.description
    }
    
}

