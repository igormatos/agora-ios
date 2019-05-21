import UIKit.UIGestureRecognizerSubclass


class PanDirectionGestureRecognizer: UIPanGestureRecognizer {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if state == .began {
            let vel = velocity(in: view)
            if abs(vel.x) < abs(vel.y) {state = .cancelled}
        }
    }
}
