//
//  TopSnackBarView.swift
//  Talenta-chat
//
//  Created by Willa on 28/02/21.
//  Copyright © 2021 qiscus. All rights reserved.
//

import UIKit


class TopSnackBarView: UIView{
    
    @IBOutlet weak var errorLabelOutlet: UILabel!
    @IBOutlet weak var containerViewOutlet: UIView!
    @IBOutlet weak var topConstraintContainerView: NSLayoutConstraint!
    
    private let nibName: String = String(describing: TopSnackBarView.self)
    private let successBackground: UIColor = .systemGreen
    private let errorBackground: UIColor = .systemRed
    private var thisView: UIView?
    
    
    var viewWillDismiss: () -> Void = {}
    
    private var message: String?{
        didSet{
            
        }
    }
    private var isError: Bool?{
        didSet{
            
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    convenience init(message: String, isError: Bool){
        self.init()
        self.message = message
        self.isError = isError
        
        errorLabelOutlet.text = message
        containerViewOutlet.backgroundColor = isError ? errorBackground : successBackground
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        
        // determine containerView posisition, ignore the heght because we use constarint
        UIView.animate(withDuration: 0.2) { [unowned self] in
            self.containerViewOutlet.frame = CGRect(x: 0, y: self.containerViewOutlet.frame.height, width: self.containerViewOutlet.frame.width, height: (self.containerViewOutlet.frame.height))
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let window = UIApplication.shared.windows.first{
            thisView?.frame = window.frame
        }
    }
    
    
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        thisView = view
        setupViewUI()
    }
    
    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
           return nib.instantiate(withOwner: self, options: nil).first as? UIView
       }
    
    private func setupViewUI(){
        
        thisView?.backgroundColor = .clear
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TopSnackBarView.dismissView))
//        self.addGestureRecognizer(tapGesture)
        
        // initial position outside window
        self.containerViewOutlet.frame = CGRect(x: 0, y: 0, width: self.containerViewOutlet.frame.width, height: (self.containerViewOutlet.frame.height))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [weak self] in
            self?.dismissView()
        }
        
    }
    
    @objc private func dismissView(){
        viewWillDismiss()
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else {return}
            self.layoutIfNeeded()
            self.topConstraintContainerView.constant = -self.containerViewOutlet.frame.height
            self.layoutIfNeeded()
        }) { [weak self] (_) in
            guard let self = self else {return}
            self.removeFromSuperview()
        }

    }
       
    
}
