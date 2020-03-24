//
//  Database.swift
//  Consumi app2
//
//  Created by Danilo da Rocha Lira Araujo on 17/03/20.
//  Copyright © 2020 Danilo da Rocha Lira Araújo. All rights reserved.
//

import Foundation


class Database {
    var foods:[Food] = []
    static let shared = Database()
    
    private init(){
        self.foods = [
            Food("Arroz", 2, 2, 20, 100, "Gramas"),
            Food("Feijao", 2, 2, 20, 100, "Gramas"),
            Food("Maçã", 2, 2, 20, 1, "Unidades"),
            Food("Banana", 2, 2, 20, 1, "Unidades"),
            Food("Lasanha", 2, 2, 20, 100, "Gramas")
        ]
    }
}
