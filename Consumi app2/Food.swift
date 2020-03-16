class Food {
    var protein: Int
    var fat: Int
    var carb: Int
    var amount: Int
    var name:String
    var measure:String
    
    init(_ name:String, _ protein:Int, _ fat:Int, _ carb:Int, _ amount:Int, _ measure:String){
        self.protein = protein
        self.fat = fat
        self.carb = carb
        self.name = name
        self.amount = amount
        self.measure = measure
    }
}
