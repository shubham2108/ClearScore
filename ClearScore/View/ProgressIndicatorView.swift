//
//  ProgressIndicatorView.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 29/06/2022.
//

import UIKit

final class ProgressIndicatorView: UIView {
    
    // To round the layer corners
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    // To create a border around the layer
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // To set border color of the layer
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // To set progress bar color
    @IBInspectable var progressBarColor: UIColor = .clear {
        didSet { setNeedsDisplay() }
    }
    
    // To set progress bar width
    @IBInspectable var progressBarWidth: CGFloat = 5 {
        didSet { setNeedsDisplay() }
    }
    
    // To display progress in percentage
    // `0` indicate no circle(No progress)
    // `100` indicate a full circle(full progress)
    var progressBarPercentage: Double = .zero {
        didSet {
            showProgress()
        }
    }
    
    private lazy var circleLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.frame = bounds
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = progressBarColor.cgColor
        circleLayer.lineWidth = progressBarWidth
        circleLayer.strokeEnd = 0.0
        circleLayer.lineCap = .round
        return circleLayer
    }()
    
    // It returns circular Bezier path based on the percentage
    private lazy var circlePath: UIBezierPath = {
        var percentage = progressBarPercentage < 0 ? 0 : progressBarPercentage
        percentage = percentage > 100 ? 100 : percentage
        
        let fullCircle = CGFloat.pi * 2
        let arcAngle = fullCircle * (percentage / 100)
        let startArcAngle = -CGFloat.pi / 2.0
        
        return UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
            radius: (frame.size.width - 10)/2,
            startAngle: startArcAngle,
            endAngle: startArcAngle + arcAngle,
            clockwise: true)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func showProgress() {
        layer.addSublayer(circleLayer)
        //Animate the progress
        animateCircle()
    }
    
    // To animate the progress bar
    private func animateCircle(duration: TimeInterval = 1) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        
        animation.duration = duration
        
        animation.fromValue = 0
        animation.toValue = 1
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = 1.0
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
}
