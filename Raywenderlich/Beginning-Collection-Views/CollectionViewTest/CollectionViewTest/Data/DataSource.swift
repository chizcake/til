/**
* Copyright (c) 2017 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Notwithstanding the foregoing, you may not use, copy, modify, merge, publish, 
* distribute, sublicense, create a derivative work, and/or sell copies of the 
* Software in any work that is designed, intended, or marketed for pedagogical or 
* instructional purposes related to programming, coding, application development, 
* or information technology.  Permission for such use, copying, modification,
* merger, publication, distribution, sublicensing, creation of derivative works, 
* or sale is expressly withheld.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

final class Section: Equatable, CustomStringConvertible {
    private(set) var title: String
    private(set) var parks: [Park]

    var isEmpty: Bool {
        return parks.isEmpty
    }

    init(title: String) {
        self.title = title
        self.parks = [Park]()
    }

    func appendPark(_ park: Park) {
        parks.append(park)
    }

    func appendPark() {
        guard let lastPark = parks.last else { return }
        parks.append(lastPark)
    }

    func removePark(at index: Int) {
        guard index < parks.count else { return }
        parks.remove(at: index)
    }

    static func ==(lhs: Section, rhs: Section) -> Bool {
        return lhs.title == rhs.title
    }

    var description: String {
        return "\n=== \(title) [\(parks.count)] ===\n\(parks)"

    }
}

struct Park: Equatable, CustomStringConvertible {
    var name: String
    var state: String
    var date: String
    var photo: String
    var index: Int

    init(name: String, state: String, date: String, photo: String, index: Int) {
        self.name = name
        self.state = state
        self.date = date
        self.photo = photo
        self.index = index
    }

    init(copying park: Park) {
        self.init(name: park.name, state: park.state, date: park.date, photo: park.photo, index: park.index)
    }

    static func ==(lhs: Park, rhs: Park) -> Bool {
        return (lhs.name == rhs.name)
            && (lhs.state == rhs.state)
            && (lhs.date == rhs.date)
            && (lhs.photo == rhs.photo)
            && (lhs.index == rhs.index)
    }

    var description: String {
        return name
    }
}

final class DataSource: CustomStringConvertible {

    private var sections = [Section]()
	
	var numberOfSections: Int {
		return sections.count
	}

    func numberOfParks(in sectionIdx: Int) -> Int {
        let section = sections[sectionIdx]
        return section.parks.count
    }
	
	// MARK:- Public
	init() {
		initiateParkInformation()
	}
	
	func deleteItemsAtIndexPaths(_ indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let section = sections[indexPath.section]
            section.removePark(at: indexPath.item)
        }
	}

    func deleteSectionsIfNeeded() {
        let newSections = sections.filter({$0.isEmpty == false})
        sections = newSections
    }
	
//    func moveParkAtIndexPath(_ indexPath: IndexPath, toIndexPath newIndexPath: IndexPath) {
//        if indexPath == newIndexPath { return }
//
//        let index = absoluteIndexForIndexPath(indexPath)
//        var nationalPark = parks[index]
//        nationalPark.state = sections[newIndexPath.section].title
//        let newIndex = absoluteIndexForIndexPath(newIndexPath)
//        parks.remove(at: index)
//        parks.insert(nationalPark, at: newIndex)
//    }
	
	func indexPathForNewRandomPark() -> IndexPath? {
		let index = Int(arc4random_uniform(UInt32(sections.count)))
		let section = sections[index]

        if section.isEmpty { return nil }
        return IndexPath(item: section.parks.count, section: index)
	}
	
	func indexPathForPark(_ park: Park) -> IndexPath? {
        guard let section = sections.filter({$0.title == park.state}).first else { return nil }
        for (index, currentPark) in section.parks.enumerated() {
            if currentPark == park, let sectionIdx = sections.index(of: section) {
                return IndexPath(item: index, section: sectionIdx)
            }
        }
        return nil
	}
	
    func parkForItemAtIndexPath(_ indexPath: IndexPath) -> Park? {
        guard indexPath.section < sections.count else { return nil }
        let parks = sections[indexPath.section].parks

        if indexPath.item < parks.count {
            return parks[indexPath.item]
        }
        return nil
    }

	func sectionAtIndexPath(_ indexPath: IndexPath) -> Section? {
        guard indexPath.section < sections.count else { return nil }
        return sections[indexPath.section]
	}

    var description: String {
        return "\(sections)"
    }
	
	// MARK:- Private
	private func initiateParkInformation() {
        guard let path = Bundle.main.path(forResource: "NationalParks", ofType: "plist") else { return }
        guard let dictArray = NSArray(contentsOfFile: path) else { return }
		sections.removeAll(keepingCapacity: false)

        for item in dictArray {
            if let dict = item as? NSDictionary,
               let name = dict["name"] as? String,
               let state = dict["state"] as? String,
               let date = dict["date"] as? String,
               let photo = dict["photo"] as? String,
               let index = dict["index"] as? Int {
                    let park = Park(name: name, state: state, date: date, photo: photo, index: index)
                    if sections.filter({ $0.title == state }).isEmpty {
                        sections.append(Section(title: state))
                    }
                    if let section = sections.filter({$0.title == state}).first {
                        section.appendPark(park)
                    }
                }
        }
	}
}
