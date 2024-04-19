//
//  AppDelegate.swift
//  dealornotdeal
//
//  Created by imac on 14/03/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        crearUsuarios()
        abrirArchivo()
        return true
    }

    // MARK: - Crear usuarios aleatorios y guardarlos en el archivo plist
    
    func crearUsuarios() {
        var usuarios: [[String:Any]] = []

        for i in 1...5 {
            let nombre = "Usuario \(i)"
            let record = Float.random(in: 0.0...100.0)
            let usuario: [String:Any] = ["nombre": nombre, "record": record]
            usuarios.append(usuario)
        }
        guardarArchivo(diccionario: usuarios)
    }

    // MARK: - Métodos de archivo

    func abrirArchivo() {
        let datos = UserData.sharedUserData()
        let ruta = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/Config.plist"
        let urlArchivo = URL(fileURLWithPath: ruta)
        
        do {
            let archivo = try Data(contentsOf: urlArchivo)
            let diccionario = try PropertyListSerialization.propertyList(from: archivo, format: nil) as! [[String:Any]]
            
            // Actualizar los datos del usuario único en este ejemplo
            if let usuario = diccionario.first {
                datos.nombre = usuario["nombre"] as! String
                datos.record = usuario["record"] as! Float
            }
        } catch {
            print("Error al leer el archivo plist")
        }
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

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
