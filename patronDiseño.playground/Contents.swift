//: Playground - noun: a place where people can play

import UIKit
//DEcordadores
protocol Taco{
    var costo: Double{ get }
    var descipcion: String { get }
    
}
class TacoVegetariano: Taco{
    var costo: Double{
        get{
            return 30.0
        }
    }
    var descipcion: String{
        get{
            return "Taco de champiñones con queso"
        }
    }
}
class TacoDecorador: Taco{
    var tacoInstance : Taco
    var costo: Double{
        get{
           return tacoInstance.costo
        }
    }
    
    var descipcion: String{
        get{
            return tacoInstance.descipcion
        }
    }
    //inyectar el taco en esa misma clase a traves del constructor
    required init(taco: Taco) {
        self.tacoInstance = taco
    }
}
class Cilantro: TacoDecorador{
    override var costo: Double{
        get{
            return tacoInstance.costo + 20
        }
    }
    override var descipcion: String{
        get{
            return tacoInstance.descipcion + "Con Cilantro"
        }
    }
    required init(taco: Taco) {
        super.init(taco: taco)
    }
}
class Aguacate: TacoDecorador{
    override var costo: Double{
        get{
            return tacoInstance.costo + 50
        }
    }
    override var descipcion: String{
        get{
            return tacoInstance.descipcion + "Con Aguacate"
        }
    }
}

var mitaco : Taco = TacoVegetariano()
mitaco = Cilantro(taco: mitaco)
mitaco = Aguacate(taco: mitaco)


