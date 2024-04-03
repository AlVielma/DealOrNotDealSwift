//
//  JuegoViewController.swift
//  dealornotdeal
//
//  Created by imac on 26/03/24.
//

import UIKit

class JuegoViewController: UIViewController {
    
    
    //Arreglo de maletines
    @IBOutlet var maletines: [UIButton]!
    //contador
    @IBOutlet var contador: UILabel!
    //contador de rondas
    @IBOutlet var contadoround: UILabel!
    //los precios que salen abajo
    @IBOutlet var precios: [UILabel]!
    //arreglo de los precios
    let precioss = [1, 10, 50, 100, 200, 400, 500, 1000, 5000, 10000, 50000, 100000, 200000, 400000, 500000, 1000000]
    
    let index = -1
    
    var contadorx = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //mostrar los precios en los label
        for (i, label) in precios.enumerated() {
            // Convertir el valor entero a String
            let precioString = String(precioss[i])
            
            // Asignar el valor formateado al UILabel
            label.text = "$\(precioString)"
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
              // Incrementar el valor del contador
             self.contadorx = self.contadorx + 1
              
              // Actualizar el texto del UILabel del contador
            self.contador.text = String(self.contadorx)
            }
        
        
    }
    
    func abrir_maletin(){
        
    }
    
    
    
    

   
}
