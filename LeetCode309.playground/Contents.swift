import XCTest

// 策略：
// 1. 計算平均值
// 2. 低於平均值買進，高於平均值賣出
// 3. 遇到買入點先存進一個 array 裡，遇到賣出點存進另一個 array (要存 index 和 price)
// 4. 買入點的 list 是空的的時候，遇到賣出點就跳過
// 5. 買入賣出全部存完之後，開始比對 （遞迴），賣出的 index 不能小於買入 index
// 6. 賣出之後檢查賣出的下一個 index (cooldown) 是不是有在買入或賣出的 array 裡，有的話要刪掉，然後進入下個遞迴，最後無法買賣的時候把賺的錢存起來(array)
// 7. 最後拿array 裡最大的出來
// 遇到 [3,2,6,5,0,3] 會失效， 因為平均是 3.166666666666667 ， 0, 3 會被分配到買點
class Solution2 {
    struct StockData {
        let index: Int
        let price: Int
    }
    
    var profitList = [Int]()
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count == 1 {
            return 0
        }
        
        var max = prices.max()!
        var prices = prices
        while prices.first == max {
            prices.removeFirst()
            if prices.count > 0 {
                max = prices.max()!
            } else {
                break
            }
        }
        
        if prices.count == 0 || prices.count == 1 {
            return 0
        }
        
        let average = Double(prices.reduce(0, {$0 + $1})) / Double(prices.count)
        var buyList = [StockData]()
        var sellList = [StockData]()
        for (index, price) in prices.enumerated() {
            if Double(price) < average {
                buyList.append(StockData(index: index, price: price))
            } else {
                if buyList.isEmpty {
                    continue
                }
                sellList.append(StockData(index: index, price: price))
            }
        }
        
        findProfit(buyList, sellList, 0)
        
        return profitList.max() ?? 0
    }
    
    func findProfit(_ buyList: [StockData], _ sellList: [StockData], _ profit: Int) {
        printList(buyList, sellList)
        if buyList.count == 0 || sellList.count == 0 {
            print("final profit: \(profit)")
            print("=======================")
            profitList.append(profit)
            return
        }
    
        for (buyIndex, buyItem) in buyList.enumerated() {
            for (sellIndex, sellItem) in sellList.enumerated() {
                if buyItem.index < sellItem.index {
                    print("buy(\(buyItem.index), \(buyItem.price)), sell(\(sellItem.index), \(sellItem.price))")
                    let currentProfit = sellItem.price - buyItem.price
                    print("currentProfit:\(currentProfit), profit:\(profit)")
                    var buyList = buyList
                    if buyIndex + 1 < buyList.count {
                        buyList = [StockData](buyList[buyIndex + 1..<buyList.endIndex])
                    } else {
                        buyList = [StockData](buyList[buyIndex..<buyList.endIndex])
                        buyList.remove(at: 0)
                    }
                    
                    buyList = removeCooldown(sellItem.index, buyList)
                    print("buyList:\(buyList)")
                    var sellList = sellList
                    sellList.remove(at: sellIndex)
                    sellList = removeCooldown(sellItem.index, sellList)
                    if !buyList.isEmpty {
                        removeInvalid(buyList[0].index, &sellList)
                    }
                    print("sellList:\(sellList)")
                    findProfit(buyList, sellList, profit + currentProfit)
                }
            }
        }
    }
    
    func removeCooldown(_ index: Int, _ list: [StockData]) -> [StockData] {
        var list = list
        for i in 0..<list.count {
            if list[i].index == index + 1 {
                list.remove(at: i)
                break
            }
        }
        return list
    }
    
    func removeInvalid(_ index: Int, _ list: inout [StockData]) {
        var i = 0
        while i < list.count {
            if list[i].index < index {
                list.remove(at: i)
            } else {
                break
            }
        }
    }
    
    func printList(_ buyList: [StockData], _ sellList: [StockData]) {
        var str = ""
        for list in buyList {
            str += "(\(list.index),\(list.price)) "
        }
        print("--- print buy:\(str)")
        str = ""
        for list in sellList {
            str += "(\(list.index),\(list.price)) "
        }
        print("--- print sell:\(str)")
    }
}

// 乾脆一個一個往後找，找所有的狀況
// 遇到 1000 組的會過不了
class Solution3 {
    var profitList = [Int]()
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count == 1 {
            return 0
        }
        
        var max = prices.max()!
        var prices = prices
        while prices.first == max {
            prices.removeFirst()
            if prices.count > 0 {
                max = prices.max()!
            } else {
                break
            }
        }
        
        if prices.count == 0 || prices.count == 1 {
            return 0
        }
        findProfit(prices, 0)
        return profitList.max() ?? 0
    }
    
    func findProfit(_ prices: [Int], _ profit: Int) {
        if prices.count == 0 || prices.count == 1 {
            profitList.append(profit)
//            print("final profit: \(profit)")
//            print("=======================")
            return
        }
        
        for (i, buy) in prices.enumerated() {
            var prices = prices
            if i + 1 < prices.count {
                prices = [Int](prices[i + 1..<prices.endIndex])
            } else {
//                print("\(i)+1 >= \(prices.count), break")
                findProfit([], profit)
                break
            }
            for (j, sell) in prices.enumerated() {
                if sell > buy {
//                    print("prices: \(prices), buy(\(buy)), sell(\(sell))")
                    let currentProfit = sell - buy
//                    print("currentProfit:\(currentProfit), profit:\(profit)")
                    var nextPrices = prices
                    if j + 2 < prices.count {
                        nextPrices = [Int](prices[j + 2..<prices.endIndex])
                        findProfit(nextPrices, profit + currentProfit)
//                        print("prices: \(prices), buy(\(buy)), sell(\(sell)) -- back")
                    } else {
                        findProfit([], profit + currentProfit)
//                        print("prices: \(prices), buy(\(buy)), sell(\(sell)) -- back")
                    }
                }
            }
        }
    }
}

// 看別人解的
// https://www.youtube.com/live/auOdCkdU0Vg?feature=share
class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count == 1 {
            return 0
        }
        var maxSellMap = [Int](repeating: 0, count: prices.count)
        var maxProfitMap = [Int](repeating: 0, count: prices.count)
        
        maxSellMap[0] = 0
        maxProfitMap[0] = 0
        
        maxSellMap[1] = max(0, -prices[0] + prices[1])
        maxProfitMap[1] = maxSellMap[1]
        
        for i in 2..<prices.count {
            var max_p = 0
            // j = 0
            var p = -prices[0] + prices[i]
            if p > max_p {
                max_p = p
            }
            
            // j = 1
            p = -prices[1] + prices[i]
            if p > max_p {
                max_p = p
            }
            
            for j in 2..<i {
                p = maxProfitMap[j - 2] - prices[j] + prices[i]
                if p > max_p {
                    max_p = p
                }
            }
            maxSellMap[i] = max_p
            maxProfitMap[i] = max(maxProfitMap[i - 1], maxSellMap[i])
        }
        return maxProfitMap[prices.count - 1]
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.maxProfit([1,2,3,0,2])
        XCTAssertEqual(result, 3)
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.maxProfit([1])
        XCTAssertEqual(result, 0)
    }

    func testSolution_03() {
        let sol = Solution()
        let result = sol.maxProfit([4,1,2])
        XCTAssertEqual(result, 1)
    }

    func testSolution_04() {
        let sol = Solution()
        let result = sol.maxProfit([2,1])
        XCTAssertEqual(result, 0)
    }

    func testSolution_05() {
        let sol = Solution()
        let result = sol.maxProfit([3,2,6,5,0,3])
        XCTAssertEqual(result, 7)
    }

    func testSolution_06() {
        let sol = Solution()
        let result = sol.maxProfit([6,1,3,2,4,7])
        XCTAssertEqual(result, 6)
    }

    func testSolution_07() {
        let sol = Solution()
        let result = sol.maxProfit([1,11,2,7,4])
        XCTAssertEqual(result, 10)
    }
    
    func testSolution_08() {
        let sol = Solution()
        let result = sol.maxProfit([70,4,83,56,94,72,78,43,2,86,65,100,94,56,41,66,3,33,10,3,45,94,15,12,78,60,58,0,58,15,21,7,11,41,12,96,83,77,47,62,27,19,40,63,30,4,77,52,17,57,21,66,63,29,51,40,37,6,44,42,92,16,64,33,31,51,36,0,29,95,92,35,66,91,19,21,100,95,40,61,15,83,31,55,59,84,21,99,45,64,90,25,40,6,41,5,25,52,59,61,51,37,92,90,20,20,96,66,79,28,83,60,91,30,52,55,1,99,8,68,14,84,59,5,34,93,25,10,93,21,35,66,88,20,97,25,63,80,20,86,33,53,43,86,53,55,61,77,9,2,56,78,43,19,68,69,49,1,6,5,82,46,24,33,85,24,56,51,45,100,94,26,15,33,35,59,25,65,32,26,93,73,0,40,92,56,76,18,2,45,64,66,64,39,77,1,55,90,10,27,85,40,95,78,39,40,62,30,12,57,84,95,86,57,41,52,77,17,9,15,33,17,68,63,59,40,5,63,30,86,57,5,55,47,0,92,95,100,25,79,84,93,83,93,18,20,32,63,65,56,68,7,31,100,88,93,11,43,20,13,54,34,29,90,50,24,13,44,89,57,65,95,58,32,67,38,2,41,4,63,56,88,39,57,10,1,97,98,25,45,96,35,22,0,37,74,98,14,37,77,54,40,17,9,28,83,13,92,3,8,60,52,64,8,87,77,96,70,61,3,96,83,56,5,99,81,94,3,38,91,55,83,15,30,39,54,79,55,86,85,32,27,20,74,91,99,100,46,69,77,34,97,0,50,51,21,12,3,84,84,48,69,94,28,64,36,70,34,70,11,89,58,6,90,86,4,97,63,10,37,48,68,30,29,53,4,91,7,56,63,22,93,69,93,1,85,11,20,41,36,66,67,57,76,85,37,80,99,63,23,71,11,73,41,48,54,61,49,91,97,60,38,99,8,17,2,5,56,3,69,90,62,75,76,55,71,83,34,2,36,56,40,15,62,39,78,7,37,58,22,64,59,80,16,2,34,83,43,40,39,38,35,89,72,56,77,78,14,45,0,57,32,82,93,96,3,51,27,36,38,1,19,66,98,93,91,18,95,93,39,12,40,73,100,17,72,93,25,35,45,91,78,13,97,56,40,69,86,69,99,4,36,36,82,35,52,12,46,74,57,65,91,51,41,42,17,78,49,75,9,23,65,44,47,93,84,70,19,22,57,27,84,57,85,2,61,17,90,34,49,74,64,46,61,0,28,57,78,75,31,27,24,10,93,34,19,75,53,17,26,2,41,89,79,37,14,93,55,74,11,77,60,61,2,68,0,15,12,47,12,48,57,73,17,18,11,83,38,5,36,53,94,40,48,81,53,32,53,12,21,90,100,32,29,94,92,83,80,36,73,59,61,43,100,36,71,89,9,24,56,7,48,34,58,0,43,34,18,1,29,97,70,92,88,0,48,51,53,0,50,21,91,23,34,49,19,17,9,23,43,87,72,39,17,17,97,14,29,4,10,84,10,33,100,86,43,20,22,58,90,70,48,23,75,4,66,97,95,1,80,24,43,97,15,38,53,55,86,63,40,7,26,60,95,12,98,15,95,71,86,46,33,68,32,86,89,18,88,97,32,42,5,57,13,1,23,34,37,13,65,13,47,55,85,37,57,14,89,94,57,13,6,98,47,52,51,19,99,42,1,19,74,60,8,48,28,65,6,12,57,49,27,95,1,2,10,25,49,68,57,32,99,24,19,25,32,89,88,73,96,57,14,65,34,8,82,9,94,91,19,53,61,70,54,4,66,26,8,63,62,9,20,42,17,52,97,51,53,19,48,76,40,80,6,1,89,52,70,38,95,62,24,88,64,42,61,6,50,91,87,69,13,58,43,98,19,94,65,56,72,20,72,92,85,58,46,67,2,23,88,58,25,88,18,92,46,15,18,37,9,90,2,38,0,16,86,44,69,71,70,30,38,17,69,69,80,73,79,56,17,95,12,37,43,5,5,6,42,16,44,22,62,37,86,8,51,73,46,44,15,98,54,22,47,28,11,75,52,49,38,84,55,3,69,100,54,66,6,23,98,22,99,21,74,75,33,67,8,80,90,23,46,93,69,85,46,87,76,93,38,77,37,72,35,3,82,11,67,46,53,29,60,33,12,62,23,27,72,35,63,68,14,35,27,98,94,65,3,13,48,83,27,84,86,49,31,63,40,12,34,79,61,47,29,33,52,100,85,38,24,1,16,62,89,36,74,9,49,62,89])
        XCTAssertEqual(result, 13755)
    }
}

SolutionTests.defaultTestSuite.run()

