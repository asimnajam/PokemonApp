//
//  NetworkMonitor.swift
//  RoutingInSwift
//
//  Created by Admin on 01/04/2022.
//

import Foundation
import Network

extension NWInterface.InterfaceType: CaseIterable {
    public static var allCases: [NWInterface.InterfaceType] = [.other, .wifi, .cellular, .loopback, .wiredEthernet]
}

enum NetworkStatus: String {
    case connected
    case disconnected
}

final class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()
    private let monitor: NWPathMonitor
    private let networkMonitorQueue = DispatchQueue(label: "com.networkMonitorQueue")
    @Published var networkType: NWInterface.InterfaceType = .wifi
    @Published var status: NetworkStatus = .connected
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func start() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self?.status = .connected
                } else {
                    self?.status = .disconnected
                }
            }
        }
        monitor.start(queue: networkMonitorQueue)
    }
    
    func stop() {
        monitor.cancel()
    }
}
