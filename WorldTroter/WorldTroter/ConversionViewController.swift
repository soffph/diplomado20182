

import Foundation
import UIKit
class ConversionViewController: UIViewController {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var fahrenheitValue: Measurement<UnitTemperature>?{
    //opcional puede o no tener un valor
        didSet {
            updateCelsiusLabel()
            }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        //add a computed property for the Celsius value. This value will be computed based on the Fahrenheit value
        if let fahrenheitValue = fahrenheitValue {
            //First you check to see whether there is a Fahrenheit value.
            return fahrenheitValue.converted(to: .celsius)
            //conversión a celcius con
        } else {
            return nil }
    }
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf }()
    
    //Any time the Fahrenheit value changes, the Celsius label needs to be updated
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
//          celsiusLabel.text = "\(celsiusValue.value)"
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true }
    }
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
    
//        if let text = textField.text, !text.isEmpty {
//            //validaciíon: cuando no hay texto en textfield no se ajuste el height de la etiqueta a cero y se suban las otras etiquetas
//            celsiusLabel.text = text
//            //si hay un texto y ese texto no esta vacío lo manda a la etiqueta
//        } else {
//            celsiusLabel.text = "???"
//            //si esta vacío le coloca un ???
//        }
//        //celsiusLabel.text = textField.text iguala la etiqueta de 100 a lo que se escribe en el textfield
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}
