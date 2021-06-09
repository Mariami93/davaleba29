//
//  ViewController.swift
//  MariamJoglidze29
//
//  Created by AltaSoftware MacMINI on 6/9/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pinchGestureLabel: UILabel!
    @IBOutlet weak var swipeGestureLabel: UILabel!
    @IBOutlet weak var longPressGestureLabel: UILabel!
    @IBOutlet weak var panGestureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGestureLabel.isUserInteractionEnabled = true
        longPressGestureLabel.isUserInteractionEnabled = true
        swipeGestureLabel.isUserInteractionEnabled = true
        pinchGestureLabel.isUserInteractionEnabled = true
        
        
        configureTapGesture()
        
        
        
    }
    
    func configureTapGesture(){
        
        let tapGestureForpanGestureLabel = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let tapGestureForlongPressGestureLabel = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let tapGestureForswipeGestureLabel = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let tapGestureForpinchGestureLabel = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        
        tapGestureForpanGestureLabel.numberOfTapsRequired = 1
        tapGestureForlongPressGestureLabel.numberOfTapsRequired = 1
        tapGestureForswipeGestureLabel.numberOfTapsRequired = 1
        tapGestureForpinchGestureLabel.numberOfTapsRequired = 1
        
        panGestureLabel.addGestureRecognizer(tapGestureForpanGestureLabel)
        longPressGestureLabel.addGestureRecognizer(tapGestureForlongPressGestureLabel)
        swipeGestureLabel.addGestureRecognizer(tapGestureForswipeGestureLabel)
        pinchGestureLabel.addGestureRecognizer(tapGestureForpinchGestureLabel)
        
    }
    
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        switch gesture.view?.tag {
        case 0:
            vc.gestureType = "UIPanGestureRecognizer"
        case 1:
            vc.gestureType = "UILongPressGestureRecognizer"
        case 2:
            vc.gestureType = "UISwipeGestureRecognizer"
        case 3:
            vc.gestureType = "UIPinchGestureRecognizer"
        default:
            break
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

