//
//  TPSwitcher.swift
//  TPCustomSwitcher
//
//  Created by GlebRadchenko on 11/18/16.
//  Copyright © 2016 Applikator. All rights reserved.
//

import UIKit

@IBDesignable
class TPSwitcher: UIControl {
    public var borderWidth: CGFloat = 1.5 {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable
    public var borderColor: UIColor! {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable
    public var selectedColor: UIColor! {
        didSet {
            selectedView.backgroundColor = selectedColor
        }
    }
    @IBInspectable
    public var selectedTextColor: UIColor! {
        didSet {
            selectedLabels.forEach { (label) in
                label.textColor = selectedTextColor
            }
        }
    }
    
    @IBInspectable
    public var textColor: UIColor! {
        didSet {
            labels.forEach { (label) in
                label.textColor = textColor
            }
        }
    }
    
    public var textFont: UIFont? = UIFont(name: "HelveticaNeue", size: 14) {
        didSet {
            (labels + selectedLabels).forEach { (label) in
                label.font = textFont
            }
        }
    }
    public var sliderMargin: CGFloat = 2.0 {
        didSet {
            setNeedsLayout()
        }
    }
    public var titles: [String] = [] {
        didSet {
            resetLabels()
        }
    }
    
    public var atomicSlideDuration: CGFloat = 0.5
    public var dumping: CGFloat = 0.4
    public var velocity: CGFloat = 0.2
    
    private var labels: [UILabel] = []
    private var labelsView = UIView()
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var selectedLabels: [UILabel] = []
    private var selectedLabelsView = UIView()
    private lazy var selectedLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    private(set) var labelsMaskView: UIView = UIView()
    fileprivate var selectedView: UIView = UIView()
    
    fileprivate var tapGesture: UITapGestureRecognizer!
    fileprivate var panGesture: UIPanGestureRecognizer!
    
    private(set) var selectedIndex: Int = 0
    
    public init(titles: [String]) {
        super.init(frame: .zero)
        self.titles = titles
        initialSetup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = rect.height / 2
        clipsToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        guard labels.count > 0 else {
            return
        }
        let sliderWidth = bounds.width / CGFloat(labels.count) - sliderMargin * 2.0
        
        selectedView.frame = CGRect(x: sliderMargin + bounds.width / CGFloat(labels.count) * CGFloat(selectedIndex),
                                    y: sliderMargin,
                                    width: sliderWidth,
                                    height: bounds.height - sliderMargin * 2.0)
        
        labelsView.frame = bounds
        labelsStackView.frame = labelsView.bounds
        
        selectedLabelsView.frame = bounds
        selectedLabelsStackView.frame = selectedLabelsView.bounds
        
        selectedView.layer.rounded()
        labelsMaskView.layer.rounded()
        labelsMaskView.frame = selectedView.frame
        
    }
    func initialSetup() {
        addSubview(labelsView)
        labelsView.addSubview(labelsStackView)
        addSubview(selectedView)
        addSubview(selectedLabelsView)
        selectedLabelsView.addSubview(selectedLabelsStackView)
        
        labelsMaskView.backgroundColor = .white
        selectedLabelsView.layer.mask = labelsMaskView.layer
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapGesture)
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned))
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
        
        resetLabels()
    }
    func resetLabels() {
        labels.forEach {
            labelsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        titles.forEach { (title) in
            let newLabel = UILabel()
            newLabel.text = title
            newLabel.textColor = textColor
            newLabel.font = textFont
            newLabel.textAlignment = .center
            newLabel.lineBreakMode = .byTruncatingTail
            labels.append(newLabel)
            labelsStackView.addArrangedSubview(newLabel)
            
            let newSelectedlabel = UILabel()
            newSelectedlabel.text = title
            newSelectedlabel.textColor = selectedTextColor
            newSelectedlabel.font = textFont
            newSelectedlabel.textAlignment = .center
            newSelectedlabel.lineBreakMode = .byTruncatingTail
            selectedLabels.append(newSelectedlabel)
            selectedLabelsStackView.addArrangedSubview(newSelectedlabel)
        }
    }
    
    func tapped(_ recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: self)
        let index = Int(point.x / (bounds.width / CGFloat(titles.count)))
        setSelected(index, animated: true)
    }
    
    var recognizedLocation: CGFloat = 0.0
    func panned(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            recognizedLocation = selectedView.frame.origin.x
            break
        case .changed:
            let xTranslation = recognizer.translation(in: self).x
            var frame = selectedView.frame
            frame.origin.x = recognizedLocation
            frame.origin.x += xTranslation
            let sliderWidth = bounds.width / CGFloat(labels.count) - sliderMargin * 2.0
            if frame.origin.x > self.frame.width - sliderWidth {
                frame.origin.x = self.frame.width - sliderWidth - sliderMargin
            }
            if frame.origin.x < 0.0 {
                frame.origin.x = sliderMargin
            }
            selectedView.frame = frame
            labelsMaskView.frame = frame
        default:
            let point = recognizer.location(in: self)
            var index = Int(point.x / (bounds.width / CGFloat(titles.count)))
            if index < 0 { index = 0 }
            if index >= titles.count { index = titles.count - 1 }
            setSelected(index, animated: true)
            break
        }
    }
    
    public func setSelected(_ index: Int, animated: Bool) {
        guard index < titles.count else { return }
        let delta = CGFloat(abs(selectedIndex - index)) == 0 ? 1 : CGFloat(abs(selectedIndex - index))
        let animationTime = delta * atomicSlideDuration
        if selectedIndex != index {
            self.selectedIndex = index
            sendActions(for: .valueChanged)
        }
        if animated {
            UIView.animate(withDuration: TimeInterval(animationTime),
                           delay: 0,
                           usingSpringWithDamping: dumping,
                           initialSpringVelocity: velocity,
                           options: [.beginFromCurrentState, .curveEaseOut],
                           animations: {
                            self.layoutSubviews()
            }, completion: nil)
        } else {
            layoutSubviews()
        }
    }
}
extension CALayer {
    func rounded() {
        cornerRadius = bounds.height / 2
    }
}
extension TPSwitcher: UIGestureRecognizerDelegate {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGesture {
            let point = gestureRecognizer.location(in: self)
            return selectedView.frame.contains(point)
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}
