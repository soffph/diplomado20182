//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
func funcion(palabra: String){
    print("hola \(palabra)")
}
var variable = funcion
variable("sofia")
funcion(palabra: "tu")

//si un numero es primo

func primo( num: Int) -> String{
    //si el modulo
    if num == 1{
        print("primo")}
    for i in 2 ... num{
        if i % num == 0{
            return "no es primo "
        }}
    return "primo"
}
//: factorial recursivo
func factorial ( fac : Int ) -> Int{
    if fac == 0 {
        return 1
    }else {
        return fac * factorial(fac: fac - 1 )
    }
}
//:fibonacci recursivo
func fibonacci (fib : Int) -> Int{
    if fib < 2 {
        return fib
    }else{
        return fibonacci(fib: fib - 1) + fibonacci(fib: fib - 2)
    }
}
print(primo(num: 7 ))
factorial(fac: 2)
fibonacci(fib: 5)

//: dada una cadena checar si es palindromo
func palindromo ( pal : String) -> Bool{
    if String(pal.reversed()) == pal{
        return true
    }
    return false
}
palindromo(pal: "anitalavalatina")
var prueba: String = " hola que pedo"

prueba.contains("a")

//: Comparar si dos cadenas tiene los mismos caracteres

func comparaCaracter ( car : String, car2 : String) -> Bool{
    if car.count == car2.count{
        for i in car {
            if car2.contains( i ) != true{
                return false
            }
        }
        return true
    }
    return false
}

func sayHello(to: String, and: String = "Sofia"){
    print("Hello \(to) and \(and)")
}
sayHello(to: "Jorge")

//operador ternario
let a = 15
let b = 4
var largest : Int
largest = a > b ? a : b

