/*: Spinning page
 --------
 ### Overview
 This playground page allows you to experiment with a basic spin animation applied to a ball
 
 As part of the experiment you will be able to:
 * modify the amount of Spinning
 * modify the timing of the Spinning
 
 All changes you make will be visible in the Assistant Editor's timeline view
 
 --------
 */

import UIKit
import PlaygroundSupport

//: We start by creating a container view to visualize results interactively
let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 400.0, height: 400))
containerView.backgroundColor = .white()

//: Next we add a small notched ball which we will spin
let ball = Ball(radius: 25)
containerView.addSubview(ball)
ball.center = containerView.center

//: * experiment:
//: Check out the effect of various timing functions:
//:     1. the default `easeInOut`
//:     2. a custom speed-up curve
//:     3. a spring with damping
//:
//: You can change the parameters of each naturally

//: 1. default `easeInOut` function
//let timing = UICubicTimingParameters(animationCurve: .easeInOut)

//: 2. a custom speed-up curve
//let timing = UICubicTimingParameters(controlPoint1: CGPoint(x: 1.0, y: 0), controlPoint2: CGPoint(x:1.0, y: 1))

//: 3. a spring with damping
//:
//: * note: the spin will overshoot its set target and slowly come back to equilibrium
let timing = UISpringTimingParameters(dampingRatio: 0.4)

//:  --------
//: Create the animator with a duration of 6s and the timing selected above
let animator = UIViewPropertyAnimator(duration: 6.0, timingParameters: timing)

//:  --------
//: Define a base rotation of a half turn
let rotationAnimation: ()->Void = {
    ball.rotate(angle: CGFloat.pi)
}


//: * experiment:
//: Change the number of times you add the half sping animation to the ball to change the total spin
let repeats = 3
for _ in 1...repeats {
    animator.addAnimations(rotationAnimation)
}

//: Change the ball color once the animation has completed
animator.addCompletion({ (position) in
    ball.backgroundColor = .blue()
})

//: Start the animation
animator.startAnimation()

PlaygroundPage.current.liveView = containerView
