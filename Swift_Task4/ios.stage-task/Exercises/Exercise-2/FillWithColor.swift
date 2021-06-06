import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        struct Point: Hashable {
            var rowP: Int
            var columnP: Int
            
            init(rowP: Int, columnP: Int) {
                self.rowP = rowP
                self.columnP = columnP
            }
        }
        
        guard image.count >= 1 && row >= 0 && column >= 0  else {
            return image
        }
        
        guard image.count - 1 >= row else {
            return image
        }
        
        guard image[row].count - 1 >= column else {
            return image
        }
        
        var finalImage = image
        let initialPoint: Point = Point(rowP: row, columnP: column)
        
        
        
        let pointValue: Int = image[row][column]

        var queue: Set<Point> = []
        var markedPoints: Set<Point> = []
        queue.insert(initialPoint)
        
        while queue.count != 0 {
        
        fillPoints(queue: &queue, markedPoints: &markedPoints)
            
        }
        func fillPoints(queue: inout Set<Point>, markedPoints: inout Set<Point>) {
            print("in cycle")
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
//                fillPoints(queue: &queue, markedPoints: &markedPoints, pointToFill: nearPoint)
                }
            }
//            Right point
            if point.columnP < image[row].count-1 {
                let nearPoint = Point(rowP: point.rowP, columnP: point.columnP + 1)
                if image[nearPoint.rowP][nearPoint.columnP] == pointValue && !markedPoints.contains(nearPoint) {
                    queue.insert(nearPoint)
//                fillPoints(queue: &queue, markedPoints: &markedPoints, pointToFill: nearPoint)
                }
            }
//            Upper point
            if point.rowP > 0 {
                let nearPoint = Point(rowP: point.rowP - 1, columnP: point.columnP)
                if image[nearPoint.rowP][nearPoint.columnP] == pointValue && !markedPoints.contains(nearPoint) {
                    queue.insert(nearPoint)
//                fillPoints(queue: &queue, markedPoints: &markedPoints, pointToFill: nearPoint)
                }
            }
//            Lower point
            if point.rowP < image.count - 1 {
                let nearPoint = Point(rowP: point.rowP + 1, columnP: point.columnP)
                if image[nearPoint.rowP][nearPoint.columnP] == pointValue && !markedPoints.contains(nearPoint)  {
                    queue.insert(nearPoint)
//                fillPoints(queue: &queue, markedPoints: &markedPoints, pointToFill: nearPoint)
                }
            }
            queue.remove(point)
            
        }
        print(finalImage)
        return finalImage
    }
}
