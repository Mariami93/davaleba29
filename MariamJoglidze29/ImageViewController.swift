//
//  ImageViewController.swift
//  MariamJoglidze29
//
//  Created by AltaSoftware MacMINI on 6/9/21.
//

import UIKit

class ImageViewController: UIViewController {
    
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    var gestureType: String!
    var pressStartTime: TimeInterval = 0.0
    
    @IBOutlet weak var centerX: NSLayoutConstraint!
    @IBOutlet weak var centerY: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if gestureType == "UIPanGestureRecognizer"{
            configurePanGesture()
        } else if gestureType == "UISwipeGestureRecognizer" {
            configureSwipeGesture()
        } else if gestureType == "UIPinchGestureRecognizer" {
            configurePinchGesture()
        } else if gestureType == "UILongPressGestureRecognizer" {
            configureLongPressGesture()
            
        }
        
    }
    
    func configurePanGesture(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        mainImage.isUserInteractionEnabled = true
        
        mainImage.addGestureRecognizer(panGesture)
        
    }
    
    func configureSwipeGesture(){
        
        resultLabel.isHidden = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
    }
    
    func configurePinchGesture(){
        resultLabel.isHidden = true

        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        mainImage.isUserInteractionEnabled = true
        
        mainImage.addGestureRecognizer(pinchGesture)
    }
    
    
    func configureLongPressGesture(){
        resultLabel.isHidden = true

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 0.01
        mainImage.isUserInteractionEnabled = true
        
        mainImage.addGestureRecognizer(longPressGesture)
    }
    
    
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        
        
        mainImage.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        resultLabel.text = "\(translation.x - translation.y)"
        
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                centerX.constant = centerX.constant + 50
            case .down:
                centerY.constant = centerY.constant + 50
            case .left:
                centerX.constant = centerX.constant - 50
            case .up:
                centerY.constant = centerY.constant - 50
            default:
                break
            }
        }
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
       
        var duration: TimeInterval = 0
        
        switch (gesture.state) {
        case .began:
            pressStartTime = NSDate.timeIntervalSinceReferenceDate
            
        case .ended:
            duration = NSDate.timeIntervalSinceReferenceDate - pressStartTime
            
            if duration >= 1 {
                resultLabel.text = "press is longer that 1 sec"
                mainImage.isHidden = true
            } else {
                self.navigationController?.popToRootViewController(animated: true)
                
            }
            
        default:
            break
        }
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        
        mainImage.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
        if mainImage.frame.size.height > view.frame.size.height || mainImage.frame.size.width > view.frame.size.width {
            
            self.mainImage.transform = .identity
        }
    }
}
