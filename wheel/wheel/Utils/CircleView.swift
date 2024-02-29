import UIKit

struct CircleModel {
    var id: Int
    var content: String
}

class CircleView: UIView {
    var dataSource: [CircleModel]? {
        didSet {
            setNeedsDisplay()
        }
    }

    let distanceFromEdgeToCenter: CGFloat = 45.0
    let labelOffset: CGFloat = 15.0

    override func draw(_ rect: CGRect) {
        guard let models = dataSource else {
            return
        }

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2.0

        let context = UIGraphicsGetCurrentContext()
        context?.clear(rect)

        let anglePerSection = (2.0 * CGFloat.pi) / CGFloat(models.count)

        var startAngle: CGFloat = 0.0
        var endAngle: CGFloat = anglePerSection

        for model in models {
            let color = UIColor.randomColor()
            let string = model.content

            let label = UILabel()
            label.tag = model.id
            label.textAlignment = .left
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = UIColor.white
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5 // Adjust the minimum scale factor as needed
            label.lineBreakMode = .byClipping // Use clipping to prevent truncation

            let maxLabelWidth = radius - distanceFromEdgeToCenter
            let labelSize = string.size(withAttributes: [NSAttributedString.Key.font: label.font])
            let scaledLabelWidth = min(labelSize.width, maxLabelWidth)
            label.bounds.size = CGSize(width: scaledLabelWidth, height: labelSize.height)
            label.text = string

            let labelCenter = CGPoint(
                x: center.x + ((radius - distanceFromEdgeToCenter - labelOffset) * cos(startAngle + anglePerSection/2)),
                y: center.y + ((radius - distanceFromEdgeToCenter - labelOffset) * sin(startAngle + anglePerSection/2))
            )

            let rotationAngle = atan2(center.y - labelCenter.y, center.x - labelCenter.x)
            label.transform = CGAffineTransform(rotationAngle: rotationAngle)

            label.center = CGPoint(
                x: labelCenter.x + (labelOffset * cos(rotationAngle)),
                y: labelCenter.y + (labelOffset * sin(rotationAngle))
            )

            addSubview(label)

            context?.setFillColor(color.cgColor)
            context?.move(to: center)
            context?.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            context?.fillPath()

            startAngle += anglePerSection
            endAngle += anglePerSection
        }
    }
}
