import UIKit

class DragView: UIView {
    var isDragActive = false {
        didSet {
            setNeedsDisplay(bounds)
        }
    }

    override func draw(_ rect: CGRect) {
        var path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addArc(withCenter: CGPoint(x: rect.height, y: rect.height), radius: rect.height, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2 * 3, clockwise: true)
        path.addLine(to: CGPoint(x: rect.width - rect.height, y: 0))
        path.addArc(withCenter: CGPoint(x: rect.width - rect.height, y: rect.height), radius: rect.height, startAngle: CGFloat.pi / 2 * 3, endAngle: 0, clockwise: true)
        path.close()
        UIColor.white.setFill()
        path.fill()
        path = UIBezierPath()
        path.move(to: CGPoint(x: rect.width / 3, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width * 2 / 3, y: rect.height / 2))
        path.lineWidth = rect.height / 5
        path.lineCapStyle = .round
        if isDragActive {
            UIColor.lightGray.setStroke()
        } else {
            UIColor.lightGray.withAlphaComponent(0.4).setStroke()
        }
        path.stroke()
    }
}
