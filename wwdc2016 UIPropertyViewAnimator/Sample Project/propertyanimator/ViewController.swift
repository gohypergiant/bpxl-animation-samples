//
//  ViewController.swift
//  propertyanimator
//
//  Created by Michael Gachet on 28/06/16.
//  Copyright © 2016 blackpixel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ball: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ball.layer.cornerRadius = 0.5 * ball.frame.width
        ball.backgroundColor = .blue()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        let target = sender.location(in: self.view)
        let translationAnimation: () -> Void = {
            self.ball.center = target
        }
        let rotationAnimation: () -> Void = {
            self.ball.transform = self.ball.transform.rotate(CGFloat.pi)
        }
        
        switch ballAnimator.state {
        case .inactive:
            // Start to translate and rotate the ball
            ball.backgroundColor = .blue()
            ballAnimator.addAnimations(translationAnimation)
            ballAnimator.addAnimations(rotationAnimation)
            ballAnimator.startAnimation()
            ballAnimator.addCompletion({ (position) in
                self.ball.backgroundColor = .red()
            })
        case .active:
            if !ballAnimator.isRunning {
                // Resume a paused animation by moving the target to the new tap position
                ballAnimator.addAnimations(translationAnimation)
                ballAnimator.startAnimation()
            } else {
                // Add 3 complete turns of the ball to the existing animation
                for _ in 1...6 {
                    ballAnimator.addAnimations(rotationAnimation)
                }
            }
        default: break
        }
    }

    @IBAction func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        if ballAnimator.isRunning {
            ballAnimator.pauseAnimation()
        }
    }
    
    @IBAction func handle2FingersTap(_ sender: UITapGestureRecognizer) {
        if ballAnimator.isRunning {
            ballAnimator.pauseAnimation()
            ballAnimator.isReversed = !ballAnimator.isReversed
            ballAnimator.startAnimation()
        }
    }
    
    lazy var ballAnimator: UIViewPropertyAnimator = {
        let timingFunction = UICubicTimingParameters(animationCurve: .easeInOut)
        return UIViewPropertyAnimator(duration: 2.0, timingParameters: timingFunction)
    } ()
}

