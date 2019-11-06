//
//  Finish_SampleTests.swift
//  Finish-SampleTests
//
//  Created by Shine on 2019/11/6.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import XCTest

class Finish_SampleTests: XCTestCase {
    
    
    class testTrainStoreObj : TrainDataProtocol{
        var params : paramsItem? 
        
        func fetchListData(_ complete : @escaping (TrainListItem , Error?)->())
        {
            var listItem = TrainListItem()
            //listItem.dataList = []
            listItem.dataList = [TimeData(Station: "1220", ARRTime: "1310")]
            complete(listItem , nil)
        }
        
    }
    
    private var testObj : TrainDataProtocol?
    private var testViewModel : TrainListViewModel?
    override func setUp() {
        testObj = testTrainStoreObj()
        testViewModel = TrainListViewModel(trainStoreObj: testObj)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
         let exp = expectation(description: "The data is not empty")
        testViewModel?.triggerDataFetch = { (item) in
            if let dataList = self.testViewModel?.outputs.dataList.value , !dataList.isEmpty  {
                for( _ , cellViewModel) in  dataList.enumerated(){
                    XCTAssertTrue(cellViewModel.mainTitle?.contains("1220") ?? false)
                }
               
                //do other check
                
                exp.fulfill()
            }
          
        }
      
        wait(for: [exp], timeout: 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}


