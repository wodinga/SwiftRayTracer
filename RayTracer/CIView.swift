//
//  CIView.swift
//  RayTracer
//
//  Created by Rafael Garcia on 1/3/18.
//  Copyright © 2018 Ayy Lmao LLC. All rights reserved.
//

import Cocoa

class CIView: NSView {
    let rect = NSRect(x: 0, y: 0, width: 800, height: 400)
    let image:CIImage
   
    required init?(coder: NSCoder) {
        //Time how long it takes to perform this action
        let t0 = CFAbsoluteTimeGetCurrent()
        image = imageFromPixels(Int(rect.width), Int(rect.height))
        let t1 = CFAbsoluteTimeGetCurrent()
        print(t1-t0)
        super.init(coder: coder)
        //Set view to this nice little rect so we don't have to manually resize
        self.frame = rect
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let context = NSGraphicsContext.current?.cgContext

        if let cgImg = image.cgImage {
            context?.draw(cgImg, in: rect)
        }
    }
    
}
