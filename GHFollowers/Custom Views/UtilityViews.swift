//
//  UtilityViews.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 09/06/22.
//

import SwiftUI

struct IdentifiableAlert: Identifiable {
    var id: String
    var alert: () -> Alert
}

struct IdentifiableSafariView: Identifiable {
    var id: String
    var safari: () -> SFSafariViewWrapper
}
