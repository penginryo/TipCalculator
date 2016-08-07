//
//  ViewController.swift
//  TipCalculator
//
//  Created by Ryo Makabe on 2016-08-07.
//  Copyright © 2016 ryomakabe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var inputField: UITextField!
	@IBOutlet weak var tipPercent: UILabel!
	@IBOutlet weak var tipValue: UILabel!
	@IBOutlet weak var totalValue: UILabel!
	
	@IBOutlet weak var tipSlider: UISlider!
	
	var inputFieldFloat: Float = 0.00
	var ttt: String!
	var tipPercentValue: Int!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		inputField.delegate = self
		inputField.keyboardType = .DecimalPad
		
		initSlider()
		addDoneButton()
	}

	func textFieldDidBeginEditing(textField: UITextField) {
		inputField.text = ""
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		if inputField.text != "" {
			inputFieldFloat = Float(inputField.text! ?? "0")!
			inputField.text = String(format: "%.2f", inputFieldFloat)
			inputField.text = "$" + inputField.text!
			
			updateTipAndTotal()
		}
	}
	
	func calcTipAmount(price: Float) -> Float{
		return price * (floor(tipSlider.value) * 0.01)
	}
	
	func updateTipAndTotal() {
		let tip = calcTipAmount(Float(inputFieldFloat))
		
		tipValue.text = "$" + String(format: "%.2f", tip)
		totalValue.text = "$" + String(format: "%.2f", tip + Float(inputFieldFloat))
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func initSlider() {
		tipSlider.minimumValue = 0
		tipSlider.maximumValue = 100
		
		tipSlider.value = 10
		
		setCurrentSliderValue()
	}
	
	func setCurrentSliderValue() {
		tipPercentValue = Int(tipSlider.value)
		tipPercent.text = "(" + String(tipPercentValue) + "%)"
	}
	
	func addDoneButton() {
		let keyboardToolbar = UIToolbar()
		keyboardToolbar.sizeToFit()
		let flexBarButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace,
		                                    target: nil, action: nil)
		let doneBarButton = UIBarButtonItem(barButtonSystemItem: .Done,
		                                    target: view, action: #selector(UIView.endEditing(_:)))
		keyboardToolbar.items = [flexBarButton, doneBarButton]
		inputField.inputAccessoryView = keyboardToolbar
	}
	

	@IBAction func valueSlider(sender: UISlider) {
		setCurrentSliderValue()
		updateTipAndTotal()
	}

}

