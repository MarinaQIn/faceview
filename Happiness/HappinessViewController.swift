//
//  HappinessViewController.swift
//  Happiness
//
//  Created by marina on 15/10/21.
//  Copyright © 2015年 marina. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaveViewDataSource {
    
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scaling:"))
        }
    }
    
    struct  Constans {
        static let HappinessGestureScale: CGFloat = 4.0
    }
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let changedHappiness = -Int(translation.y / Constans.HappinessGestureScale)
            if changedHappiness != 0 {
                hapiness += changedHappiness
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    var hapiness: Int = 75 {     //o = very sad, 100 = ecstatic
        didSet{
            hapiness = max(min(hapiness, 100), 0)
            print("hapiness = \(hapiness)")
            updateUI()
        }
    }
    
    func updateUI(){
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(hapiness - 50)/50
    }
}
