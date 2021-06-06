import Foundation

public extension Int {
    
    var roman: String? {
        var intValue = self
        var romanString = ""
        guard intValue >= 1 && intValue <= 3999 else {
            return nil
        }
        
        let conversionList: [(Int, String)] =    [(1000, "M"),
                                                  (900, "CM"),
                                                  (500, "D"),
                                                  (400, "CD"),
                                                  (100, "C"),
                                                  (90, "XC"),
                                                  (50, "L"),
                                                  (40, "XL"),
                                                  (10, "X"),
                                                  (9, "IX"),
                                                  (5, "V"),
                                                  (4, "IV"),
                                                  (1, "I")]
        for entity in conversionList {
            while intValue >= entity.0 {
                intValue -= entity.0
                romanString += entity.1
        }
        }
        
       return romanString
    }
}
