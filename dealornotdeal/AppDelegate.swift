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
        //abrirArchivo()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func abrirArchivo()
    {
        let datos = UserData.sharedUserData()
        let ruta = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] + "/Config.plist"
    let urlArchivo = URL(fileURLWithPath: ruta)
        do
            {
                let archivo = try Data.init(contentsOf: urlArchivo)
                let diccionario = try PropertyListSerialization.propertyList(from: archivo, format: nil) as! [String:Any]
                
                datos.nombre = diccionario["nom"] as! String
                datos.record = diccionario["rec"] as! Float

            }
            catch
            {
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
    
    


}

