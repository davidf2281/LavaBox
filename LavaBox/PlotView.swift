//
//  PlotView.swift
//  LavaBox
//
//  Created by David Fearon on 31/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

class PlotView: NSView
{
    var simulationResults : SimulationResults?
    
    override func draw(_ dirtyRect: NSRect)
    {
        super.draw(dirtyRect)

        let bounds = self.bounds
        
        // Fill background:
        NSColor(calibratedRed: 0.95, green: 0.95, blue: 0.95, alpha: 1).set()
        NSRectFill(bounds)
        
        // Plot graph:
        NSColor.red().set()
        if let simulationResults = self.simulationResults
        {
            let xStep = bounds.width / CGFloat(simulationResults.count)

            let yStep = bounds.height / 100 // ie, max Y value = 100 degrees
            
            for dataPoint in simulationResults
            {
                let x = CGFloat(dataPoint.time) * xStep
                let y = CGFloat(dataPoint.temperature) * yStep
                
                let point = CGRect(x: x, y: y, width: 2, height: 2)
                
                NSRectFill(point)
            }
        }
    }
}
