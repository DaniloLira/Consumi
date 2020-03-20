//
//  RegisterFoodController.swift
//  Consumi app2
//
//  Created by Danilo da Rocha Lira Araujo on 16/03/20.
//  Copyright © 2020 Danilo da Rocha Lira Araújo. All rights reserved.
//

import UIKit

protocol RegisterFoodDelegate {
    func updateFoodList()
}

class RegisterFoodController: UIViewController {

    var foodDelegate: RegisterFoodDelegate?
    let alert = UIAlertController(title: "Registro de Alimento", message: "Seu novo alimento foi cadastrado", preferredStyle: .alert)
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var amountInput: UITextField!
    @IBOutlet weak var measureInput: UITextField!
    
    @IBOutlet weak var proteinInput: UITextField!
    @IBOutlet weak var carbInput: UITextField!
    @IBOutlet weak var fatInput: UITextField!
    @IBOutlet weak var registerFoodButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.registerFoodButton.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickRegisterFood(_ sender: Any) {
        print(self.nameInput.text! == "")
        if self.nameInput.text! != "" && self.measureInput.text! != "" && self.proteinInput.text! != "" &&
            self.fatInput.text! != "" && self.carbInput.text! != "" && self.amountInput.text! != ""{
            let food:Food = Food(self.nameInput.text!, Int(self.proteinInput.text!)!, Int(self.fatInput.text!)!,
                                 Int(self.carbInput.text!)!, Int(self.amountInput.text!)!, self.measureInput.text!)
            
            
            if (!self.foodIsRegistered(name: self.nameInput.text!)){
                Database.shared.foods.append(food)
                self.alert.message = "Seu novo alimento foi cadastrado"
                self.foodDelegate?.updateFoodList()
            } else {
                alert.message = "O alimento já foi registrado anteriormente"
            }
            
            self.cleanFields()
            present(alert, animated: true)
            
        } else {
            alert.message = "Algum campo não foi preenchido"
            present(alert, animated: true)
        }
    }
    
    func cleanFields(){
        self.nameInput.text = ""
        self.amountInput.text = ""
        self.measureInput.text = ""
        self.proteinInput.text = ""
        self.carbInput.text = ""
        self.fatInput.text = ""
    }
    
    func foodIsRegistered(name: String) -> Bool{
        for food in Database.shared.foods{
            if (name == food.name){
                return true
            }
        }
        return false
    }


}

