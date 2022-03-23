// 3 Sum

extension Collection where Element: Equatable {
    func formUniqueIndex(after index: inout Index) {
        var prev = index
        repeat {
            prev = index
            formIndex(after: &index)
        } while index < endIndex && self[prev] == self[index]
    }
}


extension BidirectionalCollection where Element: Equatable {
    func formUniqueIndex(before index: inout Index) {
        var prev = index
        repeat {
            prev = index
            formIndex(before: &index)
        } while index > startIndex && self[prev] == self[index]
    }
}


func threeSum<T: BidirectionalCollection>(_ collection: T, target: T.Element) -> [[T.Element]]
    where T.Element: Numeric & Comparable {
    let sorted = collection.sorted()
    var ret: [[T.Element]] = []
    var l = sorted.startIndex
    
    ThreeSum: while l < sorted.endIndex {
        defer {
            sorted.formUniqueIndex(after: &l)
        }
        
        var m = sorted.index(after: l)
        var r = sorted.index(before: sorted.endIndex)
        
        TwoSum: while m < r && r < sorted.endIndex {
            let sum = sorted[l] + sorted[m] + sorted[r]
            if sum == target {
                ret.append([sorted[l], sorted[m], sorted[r]])
                sorted.formUniqueIndex(after: &m)
                sorted.formUniqueIndex(before: &r)
            } else if sum <= target {
                sorted.formUniqueIndex(after: &m)
            } else {
                sorted.formUniqueIndex(before: &r)
            }
        }
    }
    return ret
}

let res = threeSum([-1, 0, 1, 2, -1, -4], target: 0)
print(res)
