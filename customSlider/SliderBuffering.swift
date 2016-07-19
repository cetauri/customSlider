//
//  SliderBuffering.swift
//  customSlider
//
//  Created by cetauri on 7/19/16.
//  Copyright © 2016 smc. All rights reserved.
//

import UIKit
class SliderBuffering:UISlider {
    let bufferProgress =  UIProgressView(progressViewStyle: .Default)
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        
//        self.minimumTrackTintColor = UIColor.clearColor()
//        self.maximumTrackTintColor = UIColor.clearColor()
//        bufferProgress.backgroundColor = UIColor.redColor()//()
//        bufferProgress.userInteractionEnabled = false
//        bufferProgress.progress = 0.0
//        bufferProgress.progressTintColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.5)
//        bufferProgress.trackTintColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
//        self.addSubview(bufferProgress)
    }
    
    override func trackRectForBounds(bounds: CGRect) -> CGRect {
        
//        bounds.size.height = bounds.size.height + 50
        
        return CGRectMake(0, 0, bounds.size.width, 10)
    }
}