//
//  Depts.swift
//  BRElementPackage
//
//  Created by Shine on 2020/1/2.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation

struct Department : Codable {
    var BranchName : String?
    var Dep : String?
    
    enum BelowDept : Codable{
        case all , Finance , HR , IT_Dept
    }
}

extension Department.BelowDept : CaseIterable{}

extension Department.BelowDept : RawRepresentable{
    typealias RawValue = String
    init?(rawValue: String) {
        switch rawValue {
            case "all": self = .all
            case "Finance" : self = .Finance
            case "HR" : self = .HR
            case "IT_Dept" : self = .IT_Dept
            default: return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .all: return "all"
        case .Finance: return "Finance"
        case .HR: return "HR"
        case .IT_Dept: return "IT_Dept"
        }       
    }    
}


extension Department{
    static func loadDepts() ->[Department]{
        guard let url = Bundle.main.url(forResource: "dept", withExtension: ".json"),let data = try? Data(contentsOf: url) else {return []}
        
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode([Department].self, from: data) else {
            return []
        }
        return result
        
    }
}
