import XCTest

// 沒辦法解決迴圈 [[1,0],[0,1]]
class Solution2 {
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        var result = [Int]()
        if prerequisites.count > 0 {
            var prereqDic = [Int: [Int]]()
            for item in prerequisites {
                if prereqDic[item[0]] == nil {
                    prereqDic[item[0]] = [Int]()
                }
                prereqDic[item[0]]!.append(item[1])
            }
            for i in 0..<numCourses {
                if result.count == numCourses {
                    break
                }
                let temp = findPreCourse(i, &prereqDic, result)
                result.append(contentsOf: temp)
            }
        } else {
            for i in 0..<numCourses {
                result.append(i)
            }
        }
        return result
    }
    
    func findPreCourse(_ course: Int, _ prereqDic: inout [Int: [Int]], _ already: [Int]) -> [Int] {
        var result = [Int]()
        if let preCourse = prereqDic[course] {
            for c in preCourse {
                if already.contains(c) {
                    continue
                }
                result.append(contentsOf: findPreCourse(c, &prereqDic, already))
            }
            if !already.contains(course) {
                result.append(course)
            }
            prereqDic.removeValue(forKey: course)
        } else {
            result.append(course)
        }
        return result
    }
}

class Solution {
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        var prereqArray = [[Int]](repeating: [Int](), count: numCourses)
        
        for item in prerequisites {
            prereqArray[item[0]].append(item[1])
        }
        
        var result = [Int]()
        var courses = [Bool](repeating: false, count: numCourses)
        for i in 0..<numCourses {
            if isCircle(prereqArray, [Bool](repeating: false, count: numCourses), i) {
                return [Int]()
            }
            if prereqArray[i].count == 0 && !courses[i] {
                result.append(i)
                courses[i] = true
            } else {
                if !courses[i] {
                    let temparray = courseChain(prereqArray, &courses, i)
                    if temparray.count > 0 {
                        result.append(contentsOf: temparray)
                    }
                }
            }
        }
        
        return result
    }
    
    func isCircle(_ prereqArray: [[Int]], _ records: [Bool], _ index: Int) -> Bool {
        if records[index] {
            return true
        }
        var records = records
        records[index] = true
        
        for item in prereqArray[index] {
            if isCircle(prereqArray, records, item) {
                return true
            }
        }
        
        return false
    }
    
    func courseChain(_ prereqArray: [[Int]], _ courseInResult: inout [Bool], _ index: Int) -> [Int] {
        var result = [Int]()
        for item in prereqArray[index] {
            if courseInResult[item] {
                continue
            }
            let temparray = courseChain(prereqArray, &courseInResult, item)
            if temparray.count > 0 {
                result.append(contentsOf: temparray)
            }
        }
        if !courseInResult[index] {
            result.append(index)
            courseInResult[index] = true
        }
        return result
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.findOrder(2, [[1,0]])
        XCTAssertEqual(result, [0,1])
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.findOrder(4, [[1,0],[2,0],[3,1],[3,2]])
        XCTAssertEqual(result, [0,1,2,3])
        //or
//        XCTAssertEqual(result, [0,2,1,3])
    }

    func testSolution_03() {
        let sol = Solution()
        let result = sol.findOrder(1, [])
        XCTAssertEqual(result, [0])
    }

    func testSolution_04() {
        let sol = Solution()
        let result = sol.findOrder(2, [[1,0],[0,1]])
        XCTAssertEqual(result, [])
    }
    
    func testSolution_05() {
        let sol = Solution()
        let result = sol.findOrder(2, [[0,1]])
        XCTAssertEqual(result, [1,0])
    }
}

SolutionTests.defaultTestSuite.run()
