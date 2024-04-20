//
//  UserData.swift
//  dealornotdeal
//
//  Created by imac on 18/04/24.
//

import UIKit

class UserData: NSObject {
    var nombre: String
    var record: Int
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
    
    func crearUsuariosPorDefectoSiNecesario() {
        if cargarUsuarios().isEmpty {
            let usuariosPredefinidos: [(nombre: String, record: Int)] = [
                ("Usuario 1", 100000),
                ("Usuario 2", 75000),
                ("Usuario 3", 60000),
                ("Usuario 4", 55000),
                ("Usuario 5", 40000)
            ]
            
            var usuarios: [[String:Any]] = []
            for usuarioPredefinido in usuariosPredefinidos {
                let usuario: [String:Any] = ["nombre": usuarioPredefinido.nombre, "record": usuarioPredefinido.record]
                usuarios.append(usuario)
            }
            
            guardarUsuarios(usuarios)
        }
    }
    
    func subirDatos(record: Int, nombreJugador: String) {
        var usuarios: [[String:Any]] = cargarUsuarios()
        
        // Agregar el nuevo usuario
        let nuevoUsuario: [String: Any] = ["nombre": nombreJugador, "record": record]
        usuarios.append(nuevoUsuario)
        
        // Ordenar los usuarios por récord de mayor a menor
        usuarios.sort { ($0["record"] as! Int) > ($1["record"] as! Int) }
        
        // Mantener solo los primeros 5 usuarios
        if usuarios.count > 5 {
            usuarios = Array(usuarios.prefix(5))
        }
        
        // Guardar los usuarios actualizados
        guardarUsuarios(usuarios)
    }
    
    func cargarUsuarios() -> [[String:Any]] {
        let ruta = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/Config.plist"
        let urlArchivo = URL(fileURLWithPath: ruta)
        
        if let diccionarioExistente = try? PropertyListSerialization.propertyList(from: Data(contentsOf: urlArchivo), options: [], format: nil) as? [[String: Any]] {
            return diccionarioExistente
        } else {
            return []
        }
    }
    
    func guardarUsuarios(_ usuarios: [[String:Any]]) {
        let ruta = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/Config.plist"
        let urlArchivo = URL(fileURLWithPath: ruta)
        
        do {
            let datos = try PropertyListSerialization.data(fromPropertyList: usuarios, format: .xml, options: 0)
            try datos.write(to: urlArchivo)
            print("Datos guardados exitosamente en \(ruta)")
        } catch {
            print("Error al guardar el archivo plist: \(error)")
        }
    }
}
