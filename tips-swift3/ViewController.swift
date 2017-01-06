//
//  ViewController.swift
//  tips-swift3
//
//  Created by mny on 12/7/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var tipPercentages = [0.18, 0.2, 0.22]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        refreshTipPercentages()
        selectSegment()
        calculate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        
        UserDefaults.standard.set(tipControl.selectedSegmentIndex, forKey: "selected_segment")
        UserDefaults.standard.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        calculate()
    }

    
/*** helper func ***/
    
    func refreshTipPercentages(){
        var tipLow = UserDefaults.standard.string(forKey: "tip_low") ?? "18.0"
        var tipMid = UserDefaults.standard.string(forKey: "tip_mid") ?? "20.0"
        var tipHigh = UserDefaults.standard.string(forKey: "tip_high") ?? "22.0"
        
        print("TVC: tip percents without symbol")
        print(tipLow)
        print(tipMid)
        print(tipHigh)
        
        tipPercentages[0] = (tipLow as NSString).doubleValue / 100.0
        tipPercentages[1] = (tipMid as NSString).doubleValue / 100.0
        tipPercentages[2] = (tipHigh as NSString).doubleValue / 100.0
        
        tipLow += "%"
        tipMid += "%"
        tipHigh += "%"
        
        print("TVC: tip percents with symbol")
        print(tipLow)
        print(tipMid)
        print(tipHigh)
        
        tipControl.setTitle(tipLow, forSegmentAt: 0)
        tipControl.setTitle(tipMid, forSegmentAt: 1)
        tipControl.setTitle(tipHigh, forSegmentAt: 2)
        
    }
    
    func selectSegment() {
        let selectedSegment = UserDefaults.standard.string(forKey: "selected_segment") ?? "0"
        
        tipControl.selectedSegmentIndex = Int(selectedSegment)!
        
    }
    
    func calculate(){
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
}

