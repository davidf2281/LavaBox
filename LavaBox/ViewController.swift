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
        self.view.frame = NSScreen.main!.frame
        
        addPlotView()
        
        //********************************************
        let ambientTemperature : Celsius      = 20
        let initialWaterTemperature : Celsius = 18
        let targetWaterTemperature : Celsius  = 57.5
        let heaterPower : Watts = 800;
        //********************************************
        
        let box = Container(externalLength: 0.4, externalWidth: 0.297, externalHeight: 0.283, wallThickness: 0.02, thermalConductivity: 0.037)
        
        // Calibrate for the real world by applying empirically derived data for energy loss at a given temperature differential
        box.calibrateForMeasuredEnergyLoss(energyLoss: 38469, time: 600, externalTemperature: 27.4, internalTemperature: 60)
        
        let heater = Heater(maxOutputPower: heaterPower)
        
        let waterBody = WaterBody(length: 0.36, width: 0.26, height: 0.13, initialTemperature: initialWaterTemperature)
        
        let heaterController = HeaterController(heater: heater, temperatureTarget: targetWaterTemperature)
        
        let simulator = Simulator(container: box, waterBody: waterBody, heater: heater, heaterController: heaterController)
        
        let results = simulator.simulate(timeStep: 1, duration: 60 * 60 * 2, externalTemperature: ambientTemperature)
        
        self.plotView.simulationResults = results
    }
    
    func addPlotView()
    {
        self.plotView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.plotView)
        
        let views = ["plotView" : self.plotView]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[plotView]-(200)-|", options:NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[plotView]-(75)-|", options:NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: nil, views: views))
    }
}

