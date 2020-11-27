//
//  ViewController.swift
//  MorrTask
//
//  Created by gulam ali on 27/11/20.
//

import UIKit
import MaterialComponents.MaterialTextFields


class ViewController: UIViewController {
    
    @IBOutlet weak var expiryDATE: MDCTextField!
    @IBOutlet weak var firstname: MDCTextField!
    @IBOutlet weak var cardNumberTxtfld: MDCTextField!
    @IBOutlet weak var CvvTxt: MDCTextField!
    @IBOutlet weak var lastname: MDCTextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    
    fileprivate var txtnm0 : MDCTextInputControllerOutlined?
    fileprivate var txtnm1 : MDCTextInputControllerOutlined?
    fileprivate var txtnm2 : MDCTextInputControllerOutlined?
    fileprivate var txtnm3 : MDCTextInputControllerOutlined?
    fileprivate var txtnm4 : MDCTextInputControllerOutlined?
    private var GreenColor : Int = 0x4FAC4F
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetMaterialTextFields()
        cardNumberTxtfld.delegate = self
        expiryDATE.delegate = self
        CvvTxt.delegate = self
        firstname.delegate = self
        lastname.delegate = self
        submitBtn.layer.cornerRadius = 6.0
    }
    
    //MARK:>>> MaterialTexfields Setup
    
    private func SetMaterialTextFields(){
        self.txtnm0 = MDCTextInputControllerOutlined(textInput: self.cardNumberTxtfld)
        self.txtnm0?.activeColor = UIColor(hexValue: GreenColor)
        self.txtnm0?.normalColor = .lightGray
        self.txtnm0?.disabledColor = .lightGray
        self.txtnm0?.floatingPlaceholderActiveColor = UIColor(hexValue: GreenColor)
        self.txtnm0?.textInput?.clearButton.isHidden = true
        
        
        self.txtnm1 = MDCTextInputControllerOutlined(textInput: self.expiryDATE)
        self.txtnm1?.activeColor = UIColor(hexValue: GreenColor)
        self.txtnm1?.normalColor = .lightGray
        self.txtnm1?.disabledColor = .lightGray
        self.txtnm1?.floatingPlaceholderActiveColor = UIColor(hexValue: GreenColor)
        self.txtnm1?.textInput?.clearButton.isHidden = true
        
        self.txtnm2 = MDCTextInputControllerOutlined(textInput: self.CvvTxt)
        self.txtnm2?.activeColor = UIColor(hexValue: GreenColor)
        self.txtnm2?.normalColor = .lightGray
        self.txtnm2?.disabledColor = .lightGray
        self.txtnm2?.floatingPlaceholderActiveColor = UIColor(hexValue: GreenColor)
        self.txtnm2?.textInput?.clearButton.isHidden = true
        
        self.txtnm3 = MDCTextInputControllerOutlined(textInput: self.firstname)
        self.txtnm3?.activeColor = UIColor(hexValue: GreenColor)
        self.txtnm3?.normalColor = .lightGray
        self.txtnm3?.disabledColor = .lightGray
        self.txtnm3?.floatingPlaceholderActiveColor = UIColor(hexValue: GreenColor)
        self.txtnm3?.textInput?.clearButton.isHidden = true
        
        self.txtnm4 = MDCTextInputControllerOutlined(textInput: self.lastname)
        self.txtnm4?.activeColor = UIColor(hexValue: GreenColor)
        self.txtnm4?.normalColor = .lightGray
        self.txtnm4?.disabledColor = .lightGray
        self.txtnm4?.floatingPlaceholderActiveColor = UIColor(hexValue: GreenColor)
        self.txtnm4?.textInput?.clearButton.isHidden = true
    }
    
    //MARK:>>> Luhn Algorithm check
    
    func luhnCheck(_ number: String) -> Bool {
        var sum = 0
        let digitStrings = number.reversed().map { String($0) }
        
        for tuple in digitStrings.enumerated() {
            if let digit = Int(tuple.element) {
                let odd = tuple.offset % 2 == 1
                
                switch (odd, digit) {
                case (true, 9):
                    sum += 9
                case (true, 0...8):
                    sum += (digit * 2) % 9
                default:
                    sum += digit
                }
            } else {
                return false
            }
        }
        return sum % 10 == 0
    }
    
    //MARK:>>> Expiry date Validation
    
    func expDateValidation(dateStr:String) {
        
        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)
        
        let enteredYear = Int(dateStr.suffix(2)) ?? 0 // get last two digit from entered string as year
        let enteredMonth = Int(dateStr.prefix(2)) ?? 0 // get first two digit from entered string as month
        print(dateStr) // This is MM/YY Entered by user
        
        if enteredYear > currentYear {
            if (1 ... 12).contains(enteredMonth) {
                print("Entered Date Is Right")
                txtnm1?.setErrorText(nil, errorAccessibilityValue: nil)
            } else {
                print("Entered Date Is Wrong")
            }
        } else if currentYear == enteredYear {
            if enteredMonth >= currentMonth {
                if (1 ... 12).contains(enteredMonth) {
                    print("Entered Date Is Right")
                    txtnm1?.setErrorText(nil, errorAccessibilityValue: nil)
                } else {
                    print("Entered Date Is Wrong")
                }
            } else {
                print("Entered Date Is Wrong")
            }
        } else {
            print("Entered Date Is Wrong")
        }
        
    }
    
    private func successAlert(msg:String){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func TextFieldsValidation(){
        if cardNumberTxtfld.text == ""{
            txtnm0?.setErrorText(ValidationErrors.Cardnumber, errorAccessibilityValue: nil)
        }else if expiryDATE.text == ""{
            txtnm1?.setErrorText(ValidationErrors.ExpiryDate, errorAccessibilityValue: nil)
        }else if CvvTxt.text == ""{
            txtnm2?.setErrorText(ValidationErrors.CvvNumber, errorAccessibilityValue: nil)
        }else if firstname.text == ""{
            txtnm3?.setErrorText(ValidationErrors.Firstname, errorAccessibilityValue: nil)
        }else if lastname.text == ""{
            txtnm4?.setErrorText(ValidationErrors.Lastname, errorAccessibilityValue: nil)
        }else{
            print("All well")
            successAlert(msg: "")
        }
    }
    
    @IBAction func submitPayment(_ sender: UIButton) {
        TextFieldsValidation()
        print("show error")
    }
    
    
}

//MARK:>>> Textfield Protocols

extension ViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == cardNumberTxtfld{
            if textField.text == ""{
                txtnm0?.setErrorText(nil, errorAccessibilityValue: nil)
            }else{
                let check = luhnCheck(cardNumberTxtfld.text ?? "")
                if check == false{
                    txtnm0?.setErrorText(InvalidErrors.Cardnumber, errorAccessibilityValue: nil)
                }else{
                    txtnm0?.setErrorText(nil, errorAccessibilityValue: nil)
                }
            }
        }else if textField == expiryDATE{
            if textField.text == ""{
                txtnm1?.setErrorText(nil, errorAccessibilityValue: nil)
            }
            else if textField.text!.count < 5{
                txtnm1?.setErrorText(InvalidErrors.ExpiryDate, errorAccessibilityValue: nil)
            }else{
                txtnm1?.setErrorText(nil, errorAccessibilityValue: nil)
            }
        }else if textField == CvvTxt{
            if textField.text == ""{
                txtnm2?.setErrorText(nil, errorAccessibilityValue: nil)
            }else if textField.text!.count < 3{
                txtnm2?.setErrorText(InvalidErrors.CvvNumber, errorAccessibilityValue: nil)
            }else{
                txtnm2?.setErrorText(nil, errorAccessibilityValue: nil)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField.isFirstResponder {
            
            if textField == cardNumberTxtfld{
                if range.location < 16{
                    
                    let allowedCharacters = CharacterSet(charactersIn:"+0123456789")
                    let characterSet = CharacterSet(charactersIn: string)
                    
                    return allowedCharacters.isSuperset(of: characterSet)
                }else{
                    return false
                }
            }else if textField == expiryDATE{
                guard let oldText = textField.text, let r = Range(range, in: oldText) else {
                    return true
                }
                let updatedText = oldText.replacingCharacters(in: r, with: string)
                
                if string == "" {
                    if updatedText.count == 2 {
                        textField.text = "\(updatedText.prefix(1))"
                        return false
                    }
                } else if updatedText.count == 1 {
                    if updatedText > "1" {
                        return false
                    }
                } else if updatedText.count == 2 {
                    if updatedText <= "12" { //Prevent user to not enter month more than 12
                        textField.text = "\(updatedText)/" //This will add "/" when user enters 2nd digit of month
                    }
                    return false
                } else if updatedText.count == 5 {
                    self.expDateValidation(dateStr: updatedText)
                } else if updatedText.count > 5 {
                    return false
                }
            }else if textField == CvvTxt{
                if range.location < 3{
                    
                    let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
                    let characterSet = CharacterSet(charactersIn: string)
                    txtnm2?.setErrorText(nil, errorAccessibilityValue: nil)
                    return allowedCharacters.isSuperset(of: characterSet)
                }else{
                    return false
                }
            }else if textField == firstname || textField == lastname{
                let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
                let characterSet = CharacterSet(charactersIn: string)
                
                return allowedCharacters.isSuperset(of: characterSet)
            }
            
        }
        
        return true
        
    }
    
}


/*
 enum CardType: String {
 case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
 
 static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]
 
 var regex : String {
 switch self {
 case .Amex:
 return "^3[47][0-9]{5,}$"
 case .Visa:
 return "^4[0-9]{6,}([0-9]{3})?$"
 case .MasterCard:
 return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
 case .Diners:
 return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
 case .Discover:
 return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
 case .JCB:
 return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
 case .UnionPay:
 return "^(62|88)[0-9]{5,}$"
 case .Hipercard:
 return "^(606282|3841)[0-9]{5,}$"
 case .Elo:
 return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
 default:
 return ""
 }
 }
 }
 extension UITextField{
 
 func validateCreditCardFormat()-> (type: CardType, valid: Bool) {
 // Get only numbers from the input string
 var input = self.text!
 let numberOnly = input.stringByReplacingOccurrencesOfString("[^0-9]", withString: "", options: .RegularExpressionSearch)
 
 var type: CardType = .Unknown
 var formatted = ""
 var valid = false
 
 // detect card type
 for card in CardType.allCards {
 if (matchesRegex(card.regex, text: numberOnly)) {
 type = card
 break
 }
 }
 
 // check validity
 valid = luhnCheck(numberOnly)
 
 // format
 var formatted4 = ""
 for character in numberOnly.characters {
 if formatted4.characters.count == 4 {
 formatted += formatted4 + " "
 formatted4 = ""
 }
 formatted4.append(character)
 }
 
 formatted += formatted4 // the rest
 
 // return the tuple
 return (type, valid)
 }
 
 func matchesRegex(regex: String!, text: String!) -> Bool {
 do {
 let regex = try NSRegularExpression(pattern: regex, options: [.CaseInsensitive])
 let nsString = text as NSString
 let match = regex.firstMatchInString(text, options: [], range: NSMakeRange(0, nsString.length))
 return (match != nil)
 } catch {
 return false
 }
 }
 
 func luhnCheck(number: String) -> Bool {
 var sum = 0
 let digitStrings = number.characters.reverse().map { String($0) }
 
 for tuple in digitStrings.enumerate() {
 guard let digit = Int(tuple.element) else { return false }
 let odd = tuple.index % 2 == 1
 
 switch (odd, digit) {
 case (true, 9):
 sum += 9
 case (true, 0...8):
 sum += (digit * 2) % 9
 default:
 sum += digit
 }
 }
 
 return sum % 10 == 0
 }
 }
 */
