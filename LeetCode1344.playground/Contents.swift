import XCTest

class Solution {
    func angleClock(_ hour: Int, _ minutes: Int) -> Double {
        let hour = hour_angel(hour, minutes)
        let minutes = minute_angle(minutes)
        let result = abs(hour - minutes)
        return result > 180 ? Double(360) - result : result
    }
    
    func hour_angel(_ hour: Int, _ minutes: Int) -> Double {
        let angle = Double(hour * 30) + (Double(minutes) / Double(60) * Double(30))
        return angle >= 360 ? angle - 360 : angle
    }
    
    func minute_angle(_ minutes: Int) -> Double {
        return Double(360) * Double(minutes) / Double(60)
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.angleClock(12, 30)
        XCTAssertEqual(result, 165)
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.angleClock(3, 30)
        XCTAssertEqual(result, 75)
    }
    
    func testSolution_03() {
        let sol = Solution()
        let result = sol.angleClock(3, 15)
        XCTAssertEqual(result, 7.5)
    }
}

SolutionTests.defaultTestSuite.run()
