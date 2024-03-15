//
//  SplashViewController.swift
//  dealornotdeal
//
//  Created by imac on 14/03/24.
//

import UIKit

class SplashViewController: UIViewController {
    
    
    @IBOutlet weak var imvsplash: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imvsplash.frame.origin.x = (view.frame.width - imvsplash.frame.width)/2
        
        imvsplash.frame.origin.y = view.frame.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5) {
            self.imvsplash.frame.origin.y  = (self.view.frame.height - self.imvsplash.frame.height)/2
            
        } completion: { band in
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                self.performSegue(withIdentifier: "sgSplash", sender: nil)
            }
        }
    }


   

}
