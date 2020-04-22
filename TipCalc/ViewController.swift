//
//  ViewController.swift
//  TipCalc
//
//  Created by Eyobed Tegegne on 6/12/18.
//  Copyright © 2018 Eyobed Tegegne. All rights reserved.
//

// A simple tip calculator to calculate tip based on given percentage and also leveraging a picker view to add a custom tip

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var tfBill: UITextField!
    @IBOutlet weak var segConTip: UISegmentedControl!
    @IBOutlet weak var pvTip: UIPickerView!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pvTip.selectRow(1, inComponent: 0, animated: false)
        
        tfBill.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doSegConChange(_ sender: Any) {
        let seg = segConTip.selectedSegmentIndex
        let segTitle = segConTip.titleForSegment(at: seg) // "10%"
        
        if segTitle != "Other" {
            if let justPerc = segTitle?.replacingOccurrences(of: "%", with: "") {
                if let percVal = Double.init(justPerc) {
                    pvTip.selectRow(Int(percVal/10.0), inComponent: 0, animated: true)
                pvTip.selectRow(Int(percVal.truncatingRemainder(dividingBy: 10.0)), inComponent: 1, animated: true)
                }
            }
        }
        
        doCalc()
        
    }
    
    @IBAction func handleTFChange(_ sender: Any) {
//        lblInput.text = "$" +  (tfBill.text ?? "")
        doCalc()
    }

    func doCalc() {
        if let txt = tfBill.text {
            if let dbl = Double(txt) {
                calcTip(billAmt: dbl)
            }
        }
    }
    
    func calcTip(billAmt : Double) {
        let tipAmt = billAmt * determineTipPercentage()
        
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        
        lblTip.text = nf.string(for: tipAmt)
        lblTip.textColor = UIColor.green
        lblTotal.text = nf.string(for: tipAmt + billAmt)
        lblTotal.textColor = UIColor.red
    }
    
    func determineTipPercentage() -> Double {
        return Double((pvTip.selectedRow(inComponent: 0) * 10) + pvTip.selectedRow(inComponent: 1)) / 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        segConTip.selectedSegmentIndex = 3
        doCalc()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }

}

