//
//  ViewController.swift
//  Consumi app2
//
//  Created by Danilo da Rocha Lira Araújo on 12/03/20.
//  Copyright © 2020 Danilo da Rocha Lira Araújo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet var labelProtein: UILabel!
    @IBOutlet var labelFat: UILabel!
    @IBOutlet var labelCarb: UILabel!
    @IBOutlet var labelCalories: UILabel!
    @IBOutlet var foodAmount: UITextField!
    @IBOutlet var labelMeasure: UILabel!
    @IBOutlet var foodPicker: UIPickerView!
    @IBOutlet var foodInput: UITextField!
    @IBOutlet weak var calorieGoalLabel: UILabel!
    
    var selectedFood:Food? = nil
    var currentProtein:Int = 0
    var currentCarb:Int = 0
    var currentFat:Int = 0
    var currentCal:Int = 0
    var calorieGoal:Double?
    
    let alert = UIAlertController(title: "Registro de Refeição", message: "A sua refeição foi registrada com sucesso", preferredStyle: .alert)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calorieGoal = round(UserDefaults.standard.value(forKey: "calorieGoal") as? Double ?? 0)
        
        if let calorie = self.calorieGoal {
            self.calorieGoalLabel.text = String(calorie)
        }
        
        foodPicker.delegate = self
        foodPicker.dataSource = self
        self.foodPicker.isHidden = true
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    
        
        // Do any additional setup after loading the view.
    }

    @IBAction func pressFoodInput() {
        self.foodPicker.isHidden = false
    }
    @IBAction func registerFood() {
        if let selectedFood = self.selectedFood {
            if let currentAmount = self.foodAmount.text {
                self.currentProtein += selectedFood.protein * Int(currentAmount)! / selectedFood.amount
                self.currentCarb += selectedFood.carb * Int(currentAmount)! / selectedFood.amount
                self.currentFat += selectedFood.fat * Int(currentAmount)! / selectedFood.amount
                self.currentCal += 4 * self.currentCarb + 4 * self.currentProtein + 9 * self.currentFat
                self.updateValues()
                
                self.present(alert, animated: true)
                self.cleanLabels()
            }
        }
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return Database.shared.foods.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return Database.shared.foods[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.foodInput.text = Database.shared.foods[row].name
        self.selectedFood = Database.shared.foods[row]
        self.foodPicker.isHidden = true
        self.labelMeasure.text = Database.shared.foods[row].measure
    }
    
    func updateValues() {
        self.labelFat.text = String(self.currentFat) + "g"
        self.labelProtein.text =  String(self.currentProtein) + "g"
        self.labelCarb.text =  String(self.currentCarb) + "g"
        self.labelCalories.text = String(self.currentCal)
    }
    
    func cleanLabels(){
        self.foodInput.text = ""
        self.foodAmount.text = ""
        self.labelMeasure.text = "Grama"
    }
    
    @IBAction func registerNewFood(_ sender: Any) {
        if let registerFoodController = storyboard?.instantiateViewController(identifier: "RegisterFoodController") as! RegisterFoodController? {
            registerFoodController.foodDelegate = self
            present(registerFoodController, animated: true, completion: nil)
        }
    }
}

extension ViewController: RegisterFoodDelegate{
    func updateFoodList() {
        foodPicker.reloadAllComponents()
    }
    
    
}
