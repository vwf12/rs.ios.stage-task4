import Foundation

final class FillWithColor {
    
    struct Point: Hashable {
        var rowP: Int
        var columnP: Int
        
        init(rowP: Int, columnP: Int) {
            self.rowP = rowP
            self.columnP = columnP
        }
    }
    
    var finalImage = [[Int]]()
    var image = [[Int]]()
    var newColor: Int = 0
    var pointValue: Int = 0
    var row: Int = 0
    
    
    func fillPoints(queue: inout Set<Point>, markedPoints: inout Set<Point>) {

        guard queue.count > 0 else {
            return
        }
        
        guard let point = queue.first else {
            return
        }

        finalImage[point.rowP][point.columnP] = newColor
        markedPoints.insert(point)
        
//            Left point
        if point.columnP >= 1 {
            let nearPoint = Point(rowP: point.rowP, columnP: point.columnP - 1)
            if image[nearPoint.rowP][nearPoint.columnP] == pointValue && !markedPoints.contains(nearPoint){
                queue.insert(nearPoint)
            }
        }
//            Right point
        if image[row].count > 0 {
        if point.columnP < image[row].count-1 {
            let nearPoint = Point(rowP: point.rowP, columnP: point.columnP + 1)
            if image[nearPoint.rowP][nearPoint.columnP] == pointValue && !markedPoints.contains(nearPoint) {
                queue.insert(nearPoint)
            }
        }
        }
//            Upper point
        if point.rowP > 0 {
            let nearPoint = Point(rowP: point.rowP - 1, columnP: point.columnP)
            if image[nearPoint.rowP][nearPoint.columnP] == pointValue && !markedPoints.contains(nearPoint) {
                queue.insert(nearPoint)

            }
        }
//            Lower point
        if point.rowP < image.count - 1 {
            let nearPoint = Point(rowP: point.rowP + 1, columnP: point.columnP)
            if image[nearPoint.rowP][nearPoint.columnP] == pointValue && !markedPoints.contains(nearPoint)  {
                queue.insert(nearPoint)
            }
        }
        queue.remove(point)
    }
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        
        self.image = image
        self.row = row
        self.newColor = newColor
        
        guard image.count >= 1 && row >= 0 && column >= 0  else {
            print(1)
            return image
        }
        
        guard image.count - 1 >= row else {
            print(2)
            return image
        }
        
        guard image[row].count - 1 >= column else {
            print(3)
            return image
        }
        
        finalImage = image
        let initialPoint: Point = Point(rowP: row, columnP: column)
        pointValue = image[row][column]

        var queue: Set<Point> = []
        var markedPoints: Set<Point> = []
        queue.insert(initialPoint)
        
        while queue.count != 0 {
        fillPoints(queue: &queue, markedPoints: &markedPoints)
        }

        print(finalImage)
        return finalImage
    }
}
