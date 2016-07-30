//
//  ViewController.swift
//  LavaBox
//
//  Created by David Fearon on 26/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

class ViewController: NSViewController
{
    
    override func viewDidLoad()
    {
        let box = Container(externalLength: 0.4, externalWidth: 0.297, externalHeight: 0.283, wallThickness: 0.02, thermalConductivity: 0.03)
        
        print(box.surfaceArea)
    }
}

