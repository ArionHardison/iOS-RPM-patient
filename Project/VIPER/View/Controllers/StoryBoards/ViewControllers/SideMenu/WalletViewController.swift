//
//  WalletViewController.swift
//  MiDokter User
//
//  Created by Vinod Reddy Sure on 12/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {

    @IBOutlet weak var labelAvailableBalanceValue: UILabel!
    @IBOutlet weak var textFieldAmount: HoshiTextField!
    @IBOutlet weak var buttonAddMoney: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialLoads()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }


}

extension WalletViewController {
    func initialLoads() {
        setupNavigationBar()

    }
    private func setupNavigationBar() {
         self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Wallent"
         Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
         self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)

    }
}
