//
//  SettingsViewController.swift
//  tips-swift3
//
//  Created by mny on 1/4/17.
//  Copyright © 2017 ccsf. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var setTipControl: UISegmentedControl!
    @IBOutlet weak var setTipStepper: UIStepper!

    
/*** ViewController Lifecycle func ***/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        refreshTipPercentages()
        selectSegment()
        setStepperValue()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        
        saveValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
/*** IBAction func ***/
    
    @IBAction func onSetTipControlChanged(_ sender: Any) {
        setStepperValue()
    }
    
    @IBAction func onStepperChanged(_ sender: UIStepper) {
        let newTipPercentage = String(Int(sender.value)) + "%"
        let currentIndex = setTipControl.selectedSegmentIndex
        
        setTipControl.setTitle(newTipPercentage, forSegmentAt: currentIndex)
        
        //print(newTipPercentage)
    }

    
/*** helper func ***/
    
    func setStepperValue(){
        let currentTipPercentage = setTipControl.titleForSegment(at: setTipControl.selectedSegmentIndex)!
        let endIndex = currentTipPercentage.index(currentTipPercentage.endIndex, offsetBy: -1)
        
        setTipStepper.value = Double(currentTipPercentage.substring(to: endIndex))!
        
        //print(setTipStepper.value)
        
    }
    
    func refreshTipPercentages(){
        var tipLow = UserDefaults.standard.string(forKey: "tip_low") ?? "18.0"
        var tipMid = UserDefaults.standard.string(forKey: "tip_mid") ?? "20.0"
        var tipHigh = UserDefaults.standard.string(forKey: "tip_high") ?? "22.0"
        
        print("TVC: tip percents without symbol")
        print(tipLow)
        print(tipMid)
        print(tipHigh)
        
        tipLow += "%"
        tipMid += "%"
        tipHigh += "%"
        
        print("TVC: tip percents with symbol")
        print(tipLow)
        print(tipMid)
        print(tipHigh)
        
        setTipControl.setTitle(tipLow, forSegmentAt: 0)
        setTipControl.setTitle(tipMid, forSegmentAt: 1)
        setTipControl.setTitle(tipHigh, forSegmentAt: 2)
        
    }
    
    func selectSegment() {
        let selectedSegment = UserDefaults.standard.string(forKey: "selected_segment") ?? "0"
        
        setTipControl.selectedSegmentIndex = Int(selectedSegment)!
        
    }
    
    func saveValues() {
        let tip_low_with_symbol = setTipControl.titleForSegment(at: 0)!
        let tip_mid_with_symbol = setTipControl.titleForSegment(at: 1)!
        let tip_high_with_symbol = setTipControl.titleForSegment(at: 2)!
        
        //print("SVC tip percentages with %")
        //print(tip_low_with_symbol)
        //print(tip_mid_with_symbol)
        //print(tip_high_with_symbol)
        
        let lowEndIndex = tip_low_with_symbol.index(tip_low_with_symbol.endIndex, offsetBy: -1)
        let midEndIndex = tip_mid_with_symbol.index(tip_mid_with_symbol.endIndex, offsetBy: -1)
        let highEndIndex = tip_high_with_symbol.index(tip_high_with_symbol.endIndex, offsetBy: -1)
        
        let tip_low = Int(tip_low_with_symbol.substring(to: lowEndIndex))
        let tip_mid = Int(tip_mid_with_symbol.substring(to: midEndIndex))
        let tip_high = Int(tip_high_with_symbol.substring(to: highEndIndex))
        
        //print("SVC tip percentages without %")
        //print(tip_low!)
        //print(tip_mid!)
        //print(tip_high!)
        
        UserDefaults.standard.set(tip_low, forKey: "tip_low")
        UserDefaults.standard.set(tip_mid, forKey: "tip_mid")
        UserDefaults.standard.set(tip_high, forKey: "tip_high")
        
        UserDefaults.standard.set(setTipControl.selectedSegmentIndex, forKey: "selected_segment")
   
        UserDefaults.standard.synchronize()

    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
