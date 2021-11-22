//
//  FlashdecksApp.swift
//  Flashdecks
//
//  Created by Antonio on 12/11/21.
//

import SwiftUI

@main
struct FlashdecksApp: App {
    @StateObject var useFlashdecks = UseFlashdecks()
    var body: some Scene {
        WindowGroup {
            FinalStatsPage().environment(\.colorScheme,.light)
                .environmentObject(useFlashdecks)

        }
    }
}
