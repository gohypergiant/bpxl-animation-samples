import UIKit

public class Ball: UIView {
    
    public init(radius: CGFloat) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: radius * 2, height: radius * 2)))

        self.layer.cornerRadius = radius
        self.backgroundColor = .red()
        
        let indicator = UIView(frame: .zero)
        self.addSubview(indicator)
        indicator.backgroundColor = .white()
        indicator.frame.size = CGSize(width: 20, height: 10)
        indicator.frame.origin = CGPoint(x: self.bounds.maxX - 20, y: self.bounds.midY - 5)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func rotate(angle: CGFloat) {
        self.transform = self.transform.rotate(angle)
    }
}
