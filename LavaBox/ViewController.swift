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
    let plotView : PlotView
    
    required init?(coder: NSCoder)
    {
        self.plotView = PlotView(frame: NSRect(x: 0, y: 0, width: 0, height: 0))

        super.init(coder: coder)
    }
    
    override func viewDidLoad()
    {
        addPlotView()
        
        let ambientTemperature : Celsius = 20
        
        let waterBody = WaterBody(length: 0.36, width: 0.26, height: 0.13, initialTemperature: 25)
        
        let box = Container(externalLength: 0.4, externalWidth: 0.297, externalHeight: 0.283, wallThickness: 0.02, thermalConductivity: 0.03)
        
        let heater = Heater(maxOutputPower: 100)
        
        // Calibrate for the real world by applying empirically derived data for energy loss at a given temperature differential
        box.calibrateForMeasuredEnergyLoss(energyLoss: 38469, time: 600, externalTemperature: 27.4, internalTemperature: 60)
        
        let simulator = Simulator(container: box, waterBody: waterBody, heater: heater)
        
        let results = simulator.simulate(timeStep: 1, duration: 60 * 60 * 24, externalTemperature: ambientTemperature)
        
        self.plotView.simulationResults = results
    }
    
    func addPlotView()
    {
        self.plotView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.plotView)
        
        let views = ["plotView" : self.plotView]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[plotView]|", options:NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[plotView]|", options:NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: views))

    }
}

