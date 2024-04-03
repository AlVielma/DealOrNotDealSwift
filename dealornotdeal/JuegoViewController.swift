//
//  JuegoViewController.swift
//  dealornotdeal
//
//  Created by imac on 26/03/24.
//

import UIKit

class JuegoViewController: UIViewController {
    
    
    
    @IBOutlet var maletines: [UIButton]!
    
    @IBOutlet var contador: UILabel!
    
    @IBOutlet var contadoround: UILabel!
    
    
    @IBOutlet var precios: [UILabel]!
    
    let precioss = [1, 10, 50, 100, 200, 400, 500, 1000, 5000, 10000, 50000, 100000, 200000, 400000, 500000, 1000000]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
}
