import XCTest

class Solution {
    var wordResult = [String]()
    func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
        var characterIndexDic = [Character: [Int]]()
        for (index, word) in wordDict.enumerated() {
            characterIndexDic[word.first!, default: [Int]()].append(index)
        }
        searchWord(s, wordDict, characterIndexDic, [String]())
        return wordResult
    }
    
    func searchWord(_ s: String, _ wordDict: [String], _ characterIndexDic: [Character: [Int]], _ result: [String]) {
        let currentCharacter = [Character](s)[0]
        if let indexArray = characterIndexDic[currentCharacter] {
            for index in indexArray {
                let compareWord = wordDict[index]
                if let foundIndex = s.index(of: compareWord),
                   s.distance(from: s.startIndex, to: foundIndex) == 0 {
                    var result = result
                    result.append(compareWord)
                    let startIndex = s.endIndex(of: compareWord)
                    if startIndex != s.endIndex {
                        searchWord(String(s[startIndex!..<s.endIndex]), wordDict, characterIndexDic, result)
                    } else {
                        wordResult.append(result.joined(separator: " "))
                    }
                }
            }
        }
    }
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let results = sol.wordBreak("catsanddog", ["cat","cats","and","sand","dog"])
        let answer = ["cats and dog","cat sand dog"]
        var isEqual = true
        for result in results {
            if !answer.contains(result) {
                isEqual = false
            }
        }
        XCTAssertTrue(isEqual)
    }

    func testSolution_02() {
        let sol = Solution()
        let results = sol.wordBreak("pineapplepenapple", ["apple","pen","applepen","pine","pineapple"])
        let answer = ["pine apple pen apple","pineapple pen apple","pine applepen apple"]
        var isEqual = true
        for result in results {
            if !answer.contains(result) {
                isEqual = false
            }
        }
        XCTAssertTrue(isEqual)
    }

    func testSolution_03() {
        let sol = Solution()
        let results = sol.wordBreak("catsandog", ["cats","dog","sand","and","cat"])
        XCTAssertEqual(results, [])
    }
    
    func testSolution_04() {
        let sol = Solution()
        let results = sol.wordBreak("aaaaaaa", ["aaaa","aa","a"])
        let answers = ["a a a a a a a","aa a a a a a","a aa a a a a","a a aa a a a","aa aa a a a","aaaa a a a","a a a aa a a","aa a aa a a","a aa aa a a","a aaaa a a","a a a a aa a","aa a a aa a","a aa a aa a","a a aa aa a","aa aa aa a","aaaa aa a","a a aaaa a","aa aaaa a","a a a a a aa","aa a a a aa","a aa a a aa","a a aa a aa","aa aa a aa","aaaa a aa","a a a aa aa","aa a aa aa","a aa aa aa","a aaaa aa","a a a aaaa","aa a aaaa","a aa aaaa"]
        var isEqual = true
        for answer in answers {
            if !results.contains(answer) {
                isEqual = false
            }
        }
        XCTAssertTrue(isEqual)
    }
}

SolutionTests.defaultTestSuite.run()
