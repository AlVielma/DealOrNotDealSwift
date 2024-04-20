//
//  UserData.swift
//  dealornotdeal
//
//  Created by imac on 18/04/24.
//

import UIKit

class UserData: NSObject {
        var nombre: String
        var record: Float
        static var shared: UserData!
        
        override init() {
            nombre = ""
            record = 0
        }
        
        static func sharedUserData() -> UserData {
            if shared == nil {
                shared = UserData()
            }
            return shared
        }
    
    func crearUsuarios() {
        var usuarios: [[String:Any]] = []

        let usuariosPredefinidos: [(nombre: String, record: Int)] = [
            ("Usuario 1", 100000),
            ("Usuario 2", 75000),
            ("Usuario 3", 60000),
            ("Usuario 4", 55000),
            ("Usuario 5", 40000)
        ]

        for usuarioPredefinido in usuariosPredefinidos {
            let usuario: [String:Any] = ["nombre": usuarioPredefinido.nombre, "record": usuarioPredefinido.record]
            usuarios.append(usuario)
        }

        guardarArchivo(diccionario: usuarios)
    }
    func guardarArchivo(diccionario: [[String:Any]]) {
        let ruta = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/Config.plist"
        let urlArchivo = URL(fileURLWithPath: ruta)
        
        do {
            let datos = try PropertyListSerialization.data(fromPropertyList: diccionario, format: .xml, options: 0)
            try datos.write(to: urlArchivo)
        } catch {
            print("Error al guardar el archivo plist")
        }
    }
}
