//
//  File.swift
//  FindMyVehicle
//
//  Created by ndyyy on 02/01/24.
//

import Foundation
import UIKit
import CoreLocation

class HeadingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
    
    var headingAccuracy: CLLocationDirectionAccuracy = 60 {
        didSet {
            headingArcLayer.path = arcPath(angleInDegrees: CGFloat(headingAccuracy))
            headingArcLayer.isHidden = (headingAccuracy >= 90)
        }
    }
    
    private var headingArcLayer: CAShapeLayer!
    
    private func didLoad() {
        if headingArcLayer == nil {
            headingArcLayer = CAShapeLayer()
            headingArcLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.type = .radial
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            
            gradientLayer.colors = [
                UIColor.systemBlue.withAlphaComponent(0.0).cgColor,
                UIColor.systemBlue.withAlphaComponent(0.8).cgColor,
                UIColor.systemBlue.withAlphaComponent(0.0).cgColor
            ]
            
            gradientLayer.frame = bounds
            gradientLayer.mask = headingArcLayer
            
            layer.addSublayer(gradientLayer)
        }
    }
    
    func arcPath(angleInDegrees: CGFloat) -> CGPath {
        
        let bezierPath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.size.width/2, y: bounds.size.height/2),
            radius: bounds.size.height/2,
            startAngle: (-90-angleInDegrees) * CGFloat.pi / 180,
            endAngle: (-90+angleInDegrees) * CGFloat.pi / 180,
            clockwise: true
        )
        
        bezierPath.addLine(to: CGPoint(x: bounds.size.width/2, y: bounds.size.height/2))
        
        return bezierPath.cgPath
    }
}


import UIKit

class YourViewController: UIViewController {
    var headingView: HeadingView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create an instance of HeadingView
        headingView = HeadingView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        // Set any other properties or customize the view as needed

        // Add the HeadingView to your view hierarchy
        view.addSubview(headingView)
        
//        for i in 0...360 {
//            if i % 5 == 0 {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 500) {
//                    self.headingView.headingAccuracy = Double(i)
//                }
//            }
//        }
        
        headingView.headingAccuracy = 30

    }
}


#Preview {
    YourViewController()
}
