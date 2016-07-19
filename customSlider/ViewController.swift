//
//  ViewController.swift
//  customSlider
//
//  Created by cetauri on 7/19/16.
//  Copyright © 2016 smc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let bufferProgress =  UIProgressView(progressViewStyle: .Default)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let v = UIView(frame: CGRectMake(0, 0, 280, 20))
        v.backgroundColor = UIColor.clearColor()
        v.alpha = 0.3
        self.view.addSubview(v)
        
        for i in 0...280 {
            if i % 30 == 0 {
                let vv = UIView(frame: CGRectMake(CGFloat(i), 0, 10, 20))
                vv.backgroundColor = UIColor.magentaColor()
                print(vv.frame)
                v.addSubview(vv)
            }
            
        }
        
        UIGraphicsBeginImageContextWithOptions(v.bounds.size, false, 1)
        v.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let slider3 = SliderBuffering(frame:CGRectMake(20, 260, 280, 20))
        slider3.value = 0.1
        slider3.maximumTrackTintColor = UIColor.clearColor()
        slider3.minimumTrackTintColor = UIColor.clearColor()
        
        
        let img = image.resizableImageWithCapInsets(UIEdgeInsetsZero)

        slider3.setMinimumTrackImage(img, forState: .Normal)
        slider3.setMaximumTrackImage(image.alpha(0.5), forState: .Normal)
        self.view.addSubview(slider3)
        
        bufferProgress.frame = CGRectMake(0, 4, 280, 20)
        bufferProgress.tintColor = UIColor.darkGrayColor()
        bufferProgress.alpha = 0.5
        bufferProgress.progress = 0.0
        bufferProgress.layer.cornerRadius = 5
        bufferProgress.layer.masksToBounds = true
        bufferProgress.transform = CGAffineTransformMakeScale(1.0, 10/2)
        slider3.addSubview(bufferProgress)
        slider3.sendSubviewToBack(bufferProgress)

        NSTimer.scheduledTimerWithTimeInterval(1.0  , target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }
    
    func update() {
        let p = bufferProgress.progress
        bufferProgress.progress = p + 0.1
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension UIImage{
    
    func alpha(value:CGFloat)->UIImage
    {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        
        let ctx = UIGraphicsGetCurrentContext();
        let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height);
        
        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -area.size.height);
        CGContextSetBlendMode(ctx, CGBlendMode.Multiply);
        CGContextSetAlpha(ctx, value);
        CGContextDrawImage(ctx, area, self.CGImage);
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
}
