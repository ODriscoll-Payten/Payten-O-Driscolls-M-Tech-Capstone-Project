import UIKit

var greeting = "Hello, playground"

func isDivisableBy (dividend: Int, first: Int, second: Int) -> Bool {
    
    guard first > 0 && second > 0 else {
        return false
    }
    
    if dividend % first == 0 && dividend % second == 0 {
        print("True")
        return true
       
    } else {
        print("False")
        return false
        
    }
}

isDivisableBy(dividend: 12, first: 6, second: 2)
