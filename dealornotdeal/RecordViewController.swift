//
//  RecordViewController.swift
//  dealornotdeal
//
//  Created by imac on 18/04/24.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet var scrPersonajes: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Llamar a la función para cargar y mostrar los datos
        mostrarRecords()
    }
    
    func mostrarRecords() {
        let ruta = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/Config.plist"
        let urlArchivo = URL(fileURLWithPath: ruta)
        
        do {
            let archivo = try Data(contentsOf: urlArchivo)
            let diccionario = try PropertyListSerialization.propertyList(from: archivo, format: nil) as! [[String:Any]]
            
            // Llamar a la función para dibujar los registros de usuarios
            print(diccionario)
            dibujarRecords(registros: diccionario)
            
        } catch {
            print("Error al leer el archivo plist")
        }
    }
    
    func dibujarRecords(registros: [[String:Any]]) {
        var y = 10.0
        let x = 10.0
        let h = 80.0
        let k = 10.0
        let w = scrPersonajes.frame.width - 2*x

        for usuario in registros {
            let nombre = usuario["nombre"] as! String
            let record = usuario["record"] as! Float

            // Vista contenedora para cada registro de usuario
            let vista = UIView(frame: CGRect(x: 10, y: y, width: w, height: h))
            vista.backgroundColor = .orange

            // Etiqueta para mostrar el nombre del usuario
            let lblNombre = UILabel(frame: CGRect(x: x, y: 5, width: w - 2*x, height: (h-10)*0.4))
            lblNombre.text = nombre
            lblNombre.font = UIFont.systemFont(ofSize: 24, weight: .regular)
            lblNombre.adjustsFontSizeToFitWidth = true
            lblNombre.minimumScaleFactor = 0.5

            // Etiqueta para mostrar el récord del usuario
            let lblRecord = UILabel(frame: CGRect(x: x, y: lblNombre.frame.origin.y + lblNombre.frame.height, width: w - 2*x, height: (h-10)*0.4))
            lblRecord.text = "Record: \(record)"
            lblRecord.font = UIFont.systemFont(ofSize: 22, weight: .regular)

            // Botón para detalles o acciones adicionales
            let btnDetalle = UIButton(frame: CGRect(x: 0, y: 0, width: vista.frame.width, height: vista.frame.height))
            btnDetalle.tag = 1
            // Puedes agregar un action específico para el botón si lo necesitas
            // btnDetalle.addTarget(self, action: #selector(tuMetodo), for: .touchUpInside)

            // Agregar las vistas a la vista contenedora
            vista.addSubview(lblNombre)
            vista.addSubview(lblRecord)
            vista.addSubview(btnDetalle)

            // Agregar la vista contenedora al scroll view
            scrPersonajes.addSubview(vista)

            // Actualizar la posición Y para el siguiente registro
            y += h + k
        }

        // Establecer el contenido del scroll view
        scrPersonajes.contentSize = CGSize(width: 0.0, height: y)
    }
    
    
    @IBAction func regresar() {
        dismiss(animated: true)
    }
}
