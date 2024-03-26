//
//  MenuViewController.swift
//  dealornotdeal
//
//  Created by imac on 26/03/24.
//

import UIKit

class MenuViewController: UIViewController {

    
    @IBOutlet var diseño: [UIButton]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for buton in diseño{
            buton.layer.cornerRadius = 20
            buton.layer.borderColor = UIColor.yellow.cgColor
            buton.layer.borderWidth = 2
        }
    }
    

   

}
