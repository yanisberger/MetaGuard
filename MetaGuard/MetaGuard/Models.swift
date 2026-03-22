//
//  Models.swift
//  MetaGuard
//
//  Created by Yanis Berger on 22.03.2026.
//

import Foundation
import CoreLocation

enum RiskLevel: Int, Comparable{
    case none = 0
    case low = 1
    case medium = 2
    case high = 3
    
    static func < (lhs: RiskLevel, rhs: RiskLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    var label: String {
        switch self {
        case .none:   return "Safe"
        case .low:    return "Low Risk"
        case .medium: return "Medium Risk"
        case .high:   return "High Risk"
        }
    }
    struct MetadataField: Identifiable {
        let id = UUID()
        let name: String
        let rawValue: String
        let riskLevel: RiskLevel
        let explanation: String
    }
    
    struct PhotoMetadata {
        // Location
        var gpsCoordinates: CLLocationCoordinate2D?
        var gpsAltitude: Double?
        var gpsSpeed: Double?
        var cameraDirection: Double?
        
        // Device identity
        var deviceModel: String?
        var softwareVersion: String?
        var lensModel: String?
        var cameraType: String?         // front vs back
        
        // Time
        var dateTaken: Date?
        var timezone: String?
        
        // Behaviour
        var accelerationVector: String?
        
        // Unique identifiers
        var photoIdentifier: String?
        var contentIdentifier: String?
        
        // FaceDetection
        var faceDetected: Bool = false
    }
    
    struct RiskReport {
        let metadata: PhotoMetadata
        let fields: [MetadataField]
        
        var overallRisk: RiskLevel {
            fields.map(\.riskLevel).max() ?? .none
        }
    }
}
