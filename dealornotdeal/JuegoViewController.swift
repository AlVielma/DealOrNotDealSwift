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
    
    @IBOutlet var micase: UILabel!
    
    //arreglo de los precios
    var precioss = [1, 10, 50, 100, 200, 400, 500, 1000, 5000, 10000, 50000, 100000, 200000, 400000, 500000, 1000000]
    
    var index = -1
    
    var contadorx = 0
    var contadorrounds = 0
    
    
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
            
            let minuto = self.contadorx / 60
            
            let segundos = self.contadorx % 60
            
            let tiempoFormateado = String(format: "%02d:%02d", minuto, segundos)
              
            // Actualizar el texto del UILabel del contador
                self.contador.text = tiempoFormateado
            }
        
        
        
        
    }
    
    
    
    
    @IBAction func abrirmaletin(_ sender: UIButton) {
        // Generar un índice aleatorio
        let randomIndex = Int.random(in: 0..<precioss.count)
        
        // Obtener el precio correspondiente al índice aleatorio
        let precioSeleccionado = precioss[randomIndex]
        
        //index = randomIndex
        
        //self.micase.text = "Tu case:\(index)"
   
        sender.setTitle("$\(precioSeleccionado)", for: .normal)
        
        //ocultar el boton
        sender.isHidden = true
        
        // Encontrar el label relacionado con el precio
        if let label = precios.first(where: { $0.text == "$\(precioSeleccionado)" }) {
        // Cambiar la opacidad del label
            label.alpha = 0.2
        }
        
        self.precioss.remove(at: randomIndex)
        
        print(precioSeleccionado)
        let msj = UIAlertController(title: "valor recibido", message: "\(precioSeleccionado)" , preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Aceptar", style: .default){ _ in
            if(self.contadorrounds == 5){
                self.llamarAlBanco()
            }
        
        }
            
            
        
        msj.addAction(ok)
        present(msj, animated: true)
        
        self.contadorrounds += 1
        self.contadoround.text = "Ronda \(self.contadorrounds)"
        

    }
    
    
    func calcularPorcentaje() -> Double {
        let valorTotalRestante = self.precioss.reduce(0, +)
        let porcentaje = (Double(valorTotalRestante) / Double(self.precioss.count)) / 1000000.0 * 100.0
            return porcentaje
        }
    
    func llamarAlBanco() {
        let porcentajeRestante = self.calcularPorcentaje()
            let oferta = porcentajeRestante * Double(arc4random_uniform(20) + 75) / 100 // Oferta entre el 75% y el 95% del porcentaje restante
            
            let ofertaFormateada = String(format: "%.2f", oferta)
            
            let alerta = UIAlertController(title: "Llamada del Banco", message: "El banco ofrece $\(ofertaFormateada) por tu maletín. ¿Aceptas?", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
                // Código para aceptar la oferta
            }))
            alerta.addAction(UIAlertAction(title: "Rechazar", style: .cancel, handler: nil))
            
            present(alerta, animated: true, completion: nil)
        }

   
}
