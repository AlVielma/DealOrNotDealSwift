//
//  MenuViewController.swift
//  dealornotdeal
//
//  Created by imac on 26/03/24.
//

import UIKit
import AVFoundation
class MenuViewController: UIViewController {

    
    @IBOutlet var diseño: [UIButton]!
    
    @IBOutlet weak var botonmusica: UIButton!
    var estado = true
    var imagen: UIImage? = nil
    var player : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for buton in diseño{
            buton.layer.cornerRadius = 20
            buton.layer.borderColor = UIColor.yellow.cgColor
            buton.layer.borderWidth = 2
        }
        
        reproducirMusicaFondo()
    }
    

    
    @IBAction func musicabutton() {
        estado.toggle()
        
        actualizarImagenBoton()
    }
    
    func actualizarImagenBoton() {
        let nombreImagen: String
        if estado {
            nombreImagen = "consonido.png"
            player?.play()
        } else {
            nombreImagen = "sinsonido.png"
            player?.stop()
        }
        
        let imagen = UIImage(named: nombreImagen)
        
        botonmusica.setImage(imagen, for: .normal)
    }
    
    func reproducirMusicaFondo() {
        if let url = Bundle.main.url(forResource: "musicafondo", withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                
                player?.numberOfLoops = -1
                
                player?.play()
            } catch {
                print("Error al reproducir la música de fondo: \(error.localizedDescription)")
            }
        }
    }
}
