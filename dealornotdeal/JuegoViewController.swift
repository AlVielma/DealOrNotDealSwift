//
//  JuegoViewController.swift
//  dealornotdeal
//
//  Created by imac on 26/03/24.
//

import UIKit
import AVFoundation

class JuegoViewController: UIViewController {
    
    // Arreglo de maletines
    @IBOutlet var maletines: [UIButton]!
    // Contador
    @IBOutlet var contador: UILabel!
    // Contador de rondas
    @IBOutlet var contadoround: UILabel!
    // Los precios que salen abajo
    @IBOutlet var precios: [UILabel]!
    
    // Arreglo de los precios
    var precioss = [1, 10, 50, 100, 200, 400, 500, 1000, 5000, 10000, 50000, 100000, 200000, 400000, 500000, 1000000]
    var primerMaletinValor: Int = 0
    var index = -1
    var contadorx = 0
    var contadorrounds = 0
    
    var user = UserData()
    
    var sonidoBanquero: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mostrar los precios en los label
        for (i, label) in precios.enumerated() {
            // Convertir el valor entero a String
            let precioString = String(precioss[i])
            
            // Asignar el valor formateado al UILabel
            label.text = "$\(precioString)"
        }
        
        // Iniciar contador de tiempo
        iniciarContadorTiempo()
        
        // Cargar los sonidos
        cargarSonidos()
    }
    
    // Función para iniciar el contador de tiempo
    func iniciarContadorTiempo() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            // Incrementar el valor del contador
            self.contadorx += 1
            
            let minuto = self.contadorx / 60
            let segundos = self.contadorx % 60
            let tiempoFormateado = String(format: "%02d:%02d", minuto, segundos)
            
            // Actualizar el texto del UILabel del contador
            self.contador.text = tiempoFormateado
        }
    }
    
    // Función para cargar los sonidos
    func cargarSonidos() {
        do {
            if let path = Bundle.main.path(forResource: "llamada", ofType: "mp3") {
                let url = URL(fileURLWithPath: path)
                sonidoBanquero = try AVAudioPlayer(contentsOf: url)
            }
        } catch {
            print("Error al cargar los sonidos: \(error.localizedDescription)")
        }
    }
    
    
    // Función para reproducir el sonido del banquero
    func reproducirSonidoBanquero() {
        sonidoBanquero?.play()
    }
    
    @IBAction func abrirmaletin(_ sender: UIButton) {
        
        // Generar un índice aleatorio
        let randomIndex = Int.random(in: 0..<precioss.count)
        // Obtener el precio correspondiente al índice aleatorio
        let precioSeleccionado = precioss[randomIndex]
        
        // Si es el primer maletín, no cambiar la opacidad del label
        if primerMaletinValor == 0 {
            primerMaletinValor = precioSeleccionado
        } else {
            // Encontrar el label relacionado con el precio
            if let label = precios.first(where: { $0.text == "$\(precioSeleccionado)" }) {
                label.alpha = 0.2
            }
        }
        
        sender.setTitle("$\(precioSeleccionado)", for: .normal)
        //ocultar el boton
        sender.isHidden = true
        
        self.precioss.remove(at: randomIndex)
        print(precioSeleccionado)
        
        // Verificar si es el primer maletín
        if primerMaletinValor == precioSeleccionado {
            // Es el primer maletín, no mostramos la alerta
            return
        }

           // Mostrar alerta con el valor del maletín
        //mostrarValorMaletinAlerta(precioSeleccionado)
        
        // Verificar si es el último maletín
        if contadorrounds == 15 {
            // Mostrar la alerta de resultado final
            mostrarResultadoFinal()
        } else {
            // Incrementar el contador de rondas
            self.contadorrounds += 1
            self.contadoround.text = "Ronda \(self.contadorrounds)"
            
            // Llamar al banco cada ciertos maletines y/o rondas
            if self.contadorrounds == 5 || self.contadorrounds == 9 || self.contadorrounds == 12 || self.contadorrounds == 14 {
                // Reproducir sonido del banquero
                print(self.primerMaletinValor)
                reproducirSonidoBanquero()
                self.llamarAlBanco()
                
            }
        }
        
    }
    /*func mostrarValorMaletinAlerta(_ valor: Int) {
        let alerta = UIAlertController(title: "Valor del Maletín", message: "¡Has ganado $\(valor)!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alerta.addAction(okAction)
        present(alerta, animated: true)
    }*/
    
    func mostrarResultadoFinal() {
        let msj = UIAlertController(title: "Resultado Final", message: "¡Has ganado $\(primerMaletinValor)! Por favor, ingresa tu nombre:", preferredStyle: .alert)
        
        // Agregar un campo de texto para ingresar el nombre del jugador
        msj.addTextField { textField in
            textField.placeholder = "Nombre"
        }
        
        let ok = UIAlertAction(title: "Aceptar", style: .default) { [weak self] _ in
            // Obtener el nombre ingresado por el jugador
            guard let nombreJugador = msj.textFields?.first?.text, !nombreJugador.isEmpty else {
                // Si el nombre está vacío, mostrar un mensaje de error
                self?.mostrarAlertaNombreVacio()
                return
            }
            
            let mensajeFin = "¡\(nombreJugador), has ganado $\(self?.primerMaletinValor ?? 0)!"
            let alertaFin = UIAlertController(title: "¡Felicidades!", message: mensajeFin, preferredStyle: .alert)
            let finalizarJuego = UIAlertAction(title: "Finalizar", style: .default) { _ in
                
            }
            alertaFin.addAction(finalizarJuego)
            self?.present(alertaFin, animated: true)
        }
        msj.addAction(ok)
        
        present(msj, animated: true)
    }

    func mostrarAlertaNombreVacio() {
        let alertaNombreVacio = UIAlertController(title: "Error", message: "El nombre no puede estar vacío. Por favor, ingresa tu nombre.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Mostrar nuevamente el mensaje para ingresar el nombre
            self.mostrarResultadoFinal()
        }
        alertaNombreVacio.addAction(okAction)
        present(alertaNombreVacio, animated: true)
    }
    
    
    
    func llamarAlBanco() {
        // Calcular el total de dinero restante en los maletines
        var totalDinero = 0
        for precio in precios {
            if let precioInt = Int(precio.text!.replacingOccurrences(of: "$", with: "")) {
                totalDinero += precioInt
            }
        }

        // Generar un porcentaje aleatorio entre 10% y 30% para la oferta del banquero
        let porcentajeMinimo = 0.01
        let porcentajeMaximo = 0.05
        let porcentajeAleatorio = Double.random(in: porcentajeMinimo...porcentajeMaximo)

        // Calcular la oferta del banquero basada en el porcentaje aleatorio y el total de dinero restante
        let ofertaBanquero = Int(Double(totalDinero) * porcentajeAleatorio)

        // Mostrar la oferta del banquero al jugador
        let mensajeOferta = "El banquero te ofrece $\(ofertaBanquero) ¿Aceptas la oferta?"

        let alertaOferta = UIAlertController(title: "¡Oferta del Banquero!", message: mensajeOferta, preferredStyle: .alert)

        // Acción para aceptar la oferta
        let aceptarOferta = UIAlertAction(title: "Aceptar", style: .default) { _ in
            self.solicitarNombreJugador(ofertaBanquero: ofertaBanquero)
        }

        // Acción para rechazar la oferta
        let rechazarOferta = UIAlertAction(title: "Rechazar", style: .cancel){ _ in
           
            if self.contadorrounds == 14{
                self.mostrarAlertaIntercambio()
            }
        
        }

        // Agregar las acciones al UIAlertController de la oferta
        alertaOferta.addAction(aceptarOferta)
        alertaOferta.addAction(rechazarOferta)

        // Presentar el UIAlertController de la oferta al jugador
        present(alertaOferta, animated: true)
    }
    
    func mostrarAlertaIntercambio() {
        let alertaIntercambio = UIAlertController(title: "¡Atención!", message: "¡Estás a punto de abrir el penúltimo maletín!\n¿Deseas intercambiar tu primer maletín por el último que queda?", preferredStyle: .alert)

        let intercambiarAction = UIAlertAction(title: "Intercambiar", style: .default) { _ in
            self.intercambiarMaletines()
            
        }

        let mantenerAction = UIAlertAction(title: "Mantener", style: .cancel) { _ in
            // Continuar el juego sin intercambiar los maletines
        }

        alertaIntercambio.addAction(intercambiarAction)
        alertaIntercambio.addAction(mantenerAction)

        present(alertaIntercambio, animated: true)
    }
    
    func intercambiarMaletines() {
        guard let ultimoPrecio = precioss.last else {
            // No hay ningún maletín restante para intercambiar
            return
        }
        // Intercambiar los valores del primer y último maletín
        self.primerMaletinValor = ultimoPrecio
        
        // Crear un mensaje personalizado para mostrar al usuario
        let mensajeIntercambio = "¡Has intercambiado tu primer maletín por el último que queda y su valor es de $\(ultimoPrecio)! ¡Buena suerte con tu nueva elección!"
        
        // Mostrar la alerta con el mensaje personalizado
        let alertaIntercambio = UIAlertController(title: "Intercambio Exitoso", message: mensajeIntercambio, preferredStyle: .alert)
        
        // Agregar una acción para que el usuario pueda cerrar la alerta
        let okAction = UIAlertAction(title: "Aceptar", style: .default) { _ in
            self.solicitarNombreJugador(ofertaBanquero: self.primerMaletinValor)
        }
        
        // Agregar la acción a la alerta
        alertaIntercambio.addAction(okAction)
        
        // Presentar la alerta al usuario
        present(alertaIntercambio, animated: true)
    }

    


    func solicitarNombreJugador(ofertaBanquero: Int) {
        // Crear un UIAlertController para solicitar el nombre del jugador
        let alertaNombre = UIAlertController(title: "¡Felicidades!", message: "¡Has aceptado la oferta del banquero y has ganado $\(ofertaBanquero)!\nPor favor, ingresa tu nombre:", preferredStyle: .alert)

        // Agregar un campo de texto para ingresar el nombre del jugador
        alertaNombre.addTextField { textField in
            textField.placeholder = "Nombre"
        }

        // Acción para confirmar el nombre del jugador
        let confirmarNombre = UIAlertAction(title: "Confirmar", style: .default) { _ in
            // Obtener el nombre ingresado por el jugador
            guard let nombreJugador = alertaNombre.textFields?.first?.text, !nombreJugador.isEmpty else {
                // Si el nombre está vacío, mostrar un mensaje de error y volver a solicitar el nombre
                self.mostrarAlertaNombreVacio(ofertaBanquero: ofertaBanquero)
                return
            }
            self.terminarJuego(conOferta: ofertaBanquero, nombreJugador: nombreJugador)
        }

        // Agregar la acción para confirmar el nombre al UIAlertController
        alertaNombre.addAction(confirmarNombre)

        // Presentar el UIAlertController para solicitar el nombre al jugador
        present(alertaNombre, animated: true)
    }

    func mostrarAlertaNombreVacio(ofertaBanquero: Int) {
        // Mostrar una alerta indicando que el nombre no puede estar vacío
        let alertaNombreVacio = UIAlertController(title: "Error", message: "El nombre no puede estar vacío. Por favor, ingresa tu nombre.", preferredStyle: .alert)

        // Acción para cerrar la alerta y volver a solicitar el nombre
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.solicitarNombreJugador(ofertaBanquero: ofertaBanquero)
        }

        // Agregar la acción al UIAlertController
        alertaNombreVacio.addAction(okAction)

        // Presentar la alerta al jugador
        present(alertaNombreVacio, animated: true)
    }


    func terminarJuego(conOferta oferta: Int, nombreJugador: String) {
        let mensajeFin: String
        if oferta > 0 {
            mensajeFin = "\(nombreJugador), ¡felicidades! Has aceptado la oferta del banquero y has ganado $\(oferta)"
        } else {
            mensajeFin = "\(nombreJugador), ¡felicidades! Has rechazado la oferta del banquero y conservas el premio de tu maletín."
        }

        let alertaFin = UIAlertController(title: "¡Fin del Juego!", message: mensajeFin, preferredStyle: .alert)
        let finalizarJuego = UIAlertAction(title: "Finalizar", style: .default) { _ in
            // Llamar a la función para subir el récord del jugador
            UserData.sharedUserData().subirDatos(record: oferta, nombreJugador: nombreJugador)
            // Cerrar la vista actual
            self.dismiss(animated: true)
        }
        alertaFin.addAction(finalizarJuego)
        present(alertaFin, animated: true)
    }
   
    @IBAction func regresar() {
        dismiss(animated: true)
    }
    
}
