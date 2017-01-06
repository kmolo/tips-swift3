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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onSetTipControlChanged(_ sender: Any) {
        setStepperValue()
    }
    
    @IBAction func onStepperChanged(_ sender: UIStepper) {
        let newTipPercentage = String(Int(sender.value)) + "%"
        let currentIndex = setTipControl.selectedSegmentIndex
        
        setTipControl.setTitle(newTipPercentage, forSegmentAt: currentIndex)
        
        //print(newTipPercentage)
    }
    
    func setStepperValue(){
        let currentTipPercentage = setTipControl.titleForSegment(at: setTipControl.selectedSegmentIndex)!
        let endIndex = currentTipPercentage.index(currentTipPercentage.endIndex, offsetBy: -1)
        
        setTipStepper.value = Double(currentTipPercentage.substring(to: endIndex))!
        
        //print(setTipStepper.value)
        
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
