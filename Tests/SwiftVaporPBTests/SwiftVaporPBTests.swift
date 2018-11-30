import XCTest
import Vapor
import SwiftProtobuf

@testable import SwiftVaporPB

final class SwiftVaporPBTests: XCTestCase {
    var pb: PB<BookInfo>?
    var bookInfo : BookInfo?
    override func setUp() {
        bookInfo   =   BookInfo.with { (bookInfo:inout BookInfo) in
            bookInfo.id = 123
            bookInfo.author = "Jack"
            bookInfo.title = "Hello World"
        }
        do{
            
            pb  = try  PB<BookInfo>.with { (bookInfo:inout BookInfo) in
                bookInfo.id = 123
                bookInfo.author = "Jack"
                bookInfo.title = "Hello World"
            }
            XCTAssert(pb?.entry != nil, "转化失败")
            print(pb?.entry == bookInfo)
            XCTAssert(pb?.entry == bookInfo, "\(String(describing: pb?.entry)) == \(bookInfo)")
        }catch{
            XCTAssert(error != nil, "\(error)")
        }
    }
    func testPBBase(){
        XCTAssert(pb?.pb.entry != nil, "测试失败")
        XCTAssert(pb?.pb.textFormatString() == bookInfo?.textFormatString(), "测试失败")
        XCTAssert(pb?.pb.textString == pb?.textString, "测试失败")
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }
    
    static var allTests = [
        ("testExample", testExample),
        ]
    func testPB() -> Void {
        let bookInfo : BookInfo =   BookInfo.with { (bookInfo:inout BookInfo) in
            bookInfo.id = 123
            bookInfo.author = "Jack"
            bookInfo.title = "Hello World"
        }
        do{
            let pb: PB<BookInfo> = try  PB<BookInfo>.with { (bookInfo:inout BookInfo) in
                bookInfo.id = 123
                bookInfo.author = "Jack"
                bookInfo.title = "Hello World"
            }
            XCTAssert(pb.entry != nil, "转化失败")
            print(pb.entry == bookInfo)
            XCTAssert(pb.entry == bookInfo, "\(String(describing: pb.entry)) == \(bookInfo)")
        }catch{
            XCTAssert(error != nil, "\(error)")
        }
    }
    func testPBTextFormate() -> Void {
        
        XCTAssert(bookInfo?.textFormatString() == pb?.textString, "\(bookInfo?.textFormatString()) <=> \(pb?.textString)")
    }
}
