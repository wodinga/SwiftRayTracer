//
//  ViewController.swift
//  RayTracer
//
//  Created by Rafael Garcia on 1/2/18.
//  RayTracer implemented in Swift. This is based on this tutorial http://bit.ly/2ApdZ8P
//

import Cocoa
import CoreImage
class ViewController: NSViewController {

    @IBOutlet var CIView: CIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

