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
            if(self.contadorrounds == 8){
                
            }
            if(self.contadorrounds  == 12){
                
            }
            
        
        }
            
            
        
        msj.addAction(ok)
        present(msj, animated: true)
        
        self.contadorrounds += 1
        self.contadoround.text = "Ronda \(self.contadorrounds)"
        

    }
    
    
    func llamarAlBanco() {
      // Calcular el total de dinero restante en los maletines
      var totalDinero = 0
      for precio in precios {
        if let precioInt = Int(precio.text!.replacingOccurrences(of: "$", with: "")) {
          totalDinero += precioInt
        }
      }

      // Generar un porcentaje aleatorio entre 20% y 80%
      let porcentajeOferta = Double.random(in: 0.2...0.8)

      // Calcular la oferta del banquero
      let ofertaBanquero = Int(Double(totalDinero) * porcentajeOferta)

      // Mostrar un mensaje al jugador con la oferta del banquero
      let mensajeOferta = "El banquero te ofrece $\(ofertaBanquero). ¿Aceptas la oferta?"
      let alerta = UIAlertController(title: "¡Oferta del Banquero!", message: mensajeOferta, preferredStyle: .alert)

      // Acción para aceptar la oferta
      let aceptarOferta = UIAlertAction(title: "Aceptar", style: .default) { _ in
        // Terminar el juego
        //self.terminarJuego(conOferta: ofertaBanquero)
      }

      // Acción para rechazar la oferta
      let rechazarOferta = UIAlertAction(title: "Rechazar", style: .cancel)

      // Agregar las acciones al UIAlertController
      alerta.addAction(aceptarOferta)
      alerta.addAction(rechazarOferta)

      // Presentar el UIAlertController al jugador
      present(alerta, animated: true)
        if(self.contadorrounds == 5){
            
        }
        if(self.contadorrounds == 8){
        
        }
        if(self.contadorrounds == 11){
            
        }
        if(self.contadorrounds == 15){
            
        }
        return
       
    }

    
   
   
}
