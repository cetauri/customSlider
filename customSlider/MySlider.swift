//
//  MySlider.swift
//  customSlider
//
//  Created by cetauri on 7/19/16.
//  Copyright © 2016 smc. All rights reserved.
//

import UIKit
class MySlider: UIControl
{
    var currentPosition : Float = 0.0
        {
        didSet
        {
            updateLayers()
        }
    }
    
    var currentBuffer : Float = 0.0
        {
        didSet
        {
            updateLayers()
        }
    }
    
    var backgroundLayerColor : UIColor = UIColor.lightGrayColor()
    var progressLayerColor : UIColor = UIColor.redColor()
    var bufferLayerColor : UIColor = UIColor.darkGrayColor()
    var positionRingLayerColor : UIColor = UIColor.grayColor()
    
    private var backgroundLayer : CAShapeLayer!
    private var progressLayer : CAShapeLayer!
    private var bufferLayer : CAShapeLayer!
    private var positionRingLayer : CAShapeLayer!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        initialize()
    }
    
    override func drawRect(rect: CGRect)
    {
        updateLayers()
    }
    
    private func initialize()
    {
        self.backgroundColor = UIColor.clearColor()
        
        backgroundLayer = CAShapeLayer()
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        backgroundLayer.path = UIBezierPath(rect: CGRect(x: 0, y: (self.frame.size.height / 2) - self.frame.size.height / 4, width: self.frame.size.width, height: self.frame.size.height / 2.0)).CGPath
        backgroundLayer.fillColor = backgroundLayerColor.CGColor
        backgroundLayer.backgroundColor = UIColor.clearColor().CGColor
        
        progressLayer = CAShapeLayer()
        progressLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        bufferLayer = CAShapeLayer()
        bufferLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        positionRingLayer = CAShapeLayer()
        positionRingLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        self.layer.addSublayer(backgroundLayer)
        self.layer.addSublayer(bufferLayer)
        self.layer.addSublayer(progressLayer)
        self.layer.addSublayer(positionRingLayer)
        
        updateLayers()
    }
    
    private func updateLayers()
    {
        updateProgressLine()
        updateBufferLine()
        updatePositionRing()
    }
    
    private func updateProgressLine()
    {
        var w = (self.frame.size.width * CGFloat(currentPosition)) + self.frame.size.height / 4
        
        if w > self.frame.size.width
        {
            w = self.frame.size.width
        }
        
        progressLayer.path = UIBezierPath(rect: CGRect(x: 0, y: (self.frame.size.height / 2) - self.frame.size.height / 4, width: w, height: self.frame.size.height / 2)).CGPath
        progressLayer.fillColor = progressLayerColor.CGColor
        progressLayer.backgroundColor = UIColor.clearColor().CGColor
    }
    
    private func updateBufferLine()
    {
        var w = self.frame.size.width * CGFloat(currentBuffer)
        
        bufferLayer.path = UIBezierPath(rect: CGRect(x: 0, y: (self.frame.size.height / 2) - self.frame.size.height / 4, width: w, height: self.frame.size.height / 2)).CGPath
        bufferLayer.fillColor = bufferLayerColor.CGColor
        bufferLayer.backgroundColor = UIColor.clearColor().CGColor
    }
    
    private func updatePositionRing()
    {
        var _x = self.frame.size.width * CGFloat(currentPosition)
        
        if _x > self.frame.size.width - self.frame.size.height
        {
            _x = self.frame.size.width - self.frame.size.height
        }
        
        positionRingLayer.path = UIBezierPath(ovalInRect: CGRect(x: _x, y: 0, width: self.frame.size.height, height: self.frame.size.height)).CGPath
        positionRingLayer.fillColor = positionRingLayerColor.CGColor
        positionRingLayer.backgroundColor = UIColor.clearColor().CGColor
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        let point = touch.locationInView(self)
        
        var _xb = (self.frame.size.width * CGFloat(currentBuffer)) - self.frame.size.height
//        if (point.x < _xb) && (point.x > 0)
//        {
            currentPosition = Float(point.x / self.frame.size.width)
            self.setNeedsDisplay()
//        }
        return true
    }
}