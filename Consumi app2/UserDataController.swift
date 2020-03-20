//
//  UserDataController.swift
//  Consumi app2
//
//  Created by Danilo da Rocha Lira Araujo on 19/03/20.
//  Copyright © 2020 Danilo da Rocha Lira Araújo. All rights reserved.
//

import UIKit


class UserDataController: UIViewController {

    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var sexInput: UISegmentedControl!
    @IBOutlet weak var goalPicker: UIPickerView!
    
    var weight:Double = 0
    var sex:String = ""
    var goals:[String] = ["Emagrecer", "Manter", "Crescer"]
    var goal:String = ""
    
    let alert = UIAlertController(title: "Registro de Dados", message: "Por favor, preencha seu peso (Em Kg)", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalPicker.delegate = self
        goalPicker.dataSource = self
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    }
    
    @IBAction func pressContinueButton(_ sender: Any) {
        if (weightInput.text != ""){
            self.weight = Double(self.weightInput.text!)!
            
            switch self.sexInput.selectedSegmentIndex{
                case 0:
                    self.sex = "Feminino"
                case 1:
                    self.sex = "Masculino"
                default:
                    break
            }
            
            let calorieGoal:Double = calculateGoalCalorie(sex: self.sex, goal: self.goal, weight: self.weight)
            
            if let mainScreen = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController?{
                mainScreen.calorieGoal = calorieGoal
                present(mainScreen, animated: true)
            }
            
        } else {
            present(alert, animated: true)
        }
    }
    
    func calculateGoalCalorie(sex:String, goal:String, weight:Double) -> Double{
       var result:Double
        
        if (sex == "Feminino"){
            result  =  (0.062 * weight + 2.036) * 239
        } else {
            result = (0.063 * weight + 2.896) * 239
        }
        switch goal{
            case "Emagrecer":
                result -= 500
            case "Crescer":
                result += 500
            default:
                break
        }
        
        return result
    }
}

extension UserDataController: UIPickerViewDelegate, UIPickerViewDataSource {
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return self.goals.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return self.goals[row]
    }

    //Select some item
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.goal = self.goals[row]
    }
    
    
}
