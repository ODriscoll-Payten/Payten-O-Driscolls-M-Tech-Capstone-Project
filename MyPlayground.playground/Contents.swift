import UIKit

func isDivisableBy (dividend: Int, first: Int, second: Int) -> Bool {
    let error = "numbers are not > 0" as! Error
    guard first > 0 && second > 0 else {
        return false
    }
    
    if dividend % first == 0 && dividend % second == 0 {
        return true
    } else {
        return false
    }
}

isDivisableBy(dividend: 10, first: 2, second: 5)
