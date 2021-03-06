//
//  QRCodeView.swift
//  Character Tracker
//
//  Created by Isaac Lyons on 8/6/20.
//  Copyright © 2020 Isaac Lyons. All rights reserved.
//

import SwiftUI

protocol SwiftUIModalDelegate {
    func dismiss()
}

struct QRCodeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var shareURL: URL?
    @State private var showingShareSheet: Bool = false
    
    var name: String?
    var qrCode: CGImage
    var delegate: SwiftUIModalDelegate? = nil
    
    var shareButton: some View {
        Button(action: {
            guard let url = PortController.shared.saveTempQRCode(cgImage: self.qrCode) else { return }
            self.shareURL = url
            self.showingShareSheet = true
        }) {
            Image.init(systemName: "square.and.arrow.up")
                .imageScale(.large)
        }
    }
    
    var doneButton: some View {
        Button("Done") {
            self.delegate?.dismiss()
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        if shareURL != nil {
            // If we don't have anything observing shareURL,
            // it won't update, meaning it'll be nil when
            // we try accessing it for the Share Sheet.
            EmptyView()
        }
        Image(decorative: qrCode, scale: 1)
            .resizable()
            .scaledToFit()
            .navigationBarTitle("\(name ?? "QR Code")", displayMode: .inline)
            .navigationBarItems(leading: shareButton, trailing: doneButton)
            .sheet(isPresented: $showingShareSheet, onDismiss: {
                PortController.shared.clearFilesFromTempDirectory()
            }) {
                if self.shareURL != nil {
                    ShareSheet(activityItems: [self.shareURL!])
                }
        }
    }
}
