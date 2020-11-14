//
//  ViewController.swift
//  textLineHeight
//
//  Created by JSilver on 2020/09/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        heightLabel.text = "\(label.bounds.height)"
    }
    
    func setUpLayout() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red
        ]
        
        label.attributedText = NSAttributedString(string: "주행요금은 반납 후 등록하신 결제카드로 자동 결제됩니다.주행요금은 거리에 따른 구간별 차등 적용하여 계산됩니다", attributes: attributes)
        
        label.setLineHeight(20)
    }
}

extension UILabel {
    func setLineHeight(_ lineHeight: CGFloat) {
        // Guard: this condition always satisfied.
        guard let text = text else { return }
        
        // Get attributed string. if it isn't exist, create new mutable attributed string.
        let mutableAttributedString = (attributedText?.mutableCopy() ?? NSMutableAttributedString(string: text)) as? NSMutableAttributedString
        
        // Get all attributes of full range of attributed string.
        var attributes = mutableAttributedString?.attributes(at: 0, effectiveRange: nil) ?? [:]
        
        // Get paragraph style from attributes. if it isn't exist, create new mutable paragraph style.
        let paragraphStyle = ((attributes[.paragraphStyle] as? NSParagraphStyle)?.mutableCopy() ?? NSMutableParagraphStyle()) as? NSMutableParagraphStyle
        // Set minimum line height of label
        paragraphStyle?.minimumLineHeight = lineHeight
        
        // Update attributes.
        attributes[.paragraphStyle] = paragraphStyle
        // Gap of between custom line height and font's line height.
        // Divide 2 for align center.
        // Divide 2 by descender and leading.
        attributes[.baselineOffset] = (lineHeight - font.lineHeight) / 4
        
        // Update attributed string.
        mutableAttributedString?.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
        
        attributedText = mutableAttributedString
    }
}
