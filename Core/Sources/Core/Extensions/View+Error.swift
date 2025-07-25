//
//  View+Error.swift
//  SwiftUISampleApp
//
//  Created by James Swent on 7/23/25.
//

import Foundation
import SwiftUI

struct LocalizedAlertError<T>: LocalizedError {
    let underlyingError: LocalizedError
    var errorDescription: String? {
        underlyingError.errorDescription
    }
    var recoverySuggestion: String? {
        underlyingError.recoverySuggestion
    }

    init?(error: Error?) {
        guard let localizedError = error as? LocalizedError else { return nil }
        underlyingError = localizedError
    }

    init?(state: ScreenState<T>) {
        guard let localizedError = state.error as? LocalizedError else { return nil }
        underlyingError = localizedError
    }
}

extension View {
    func errorAlert<T>(state: Binding<ScreenState<T>>) -> some View {
        let localizedAlertError = LocalizedAlertError(state: state.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button(NSLocalizedString("OK", bundle: .module, comment: "")) {
                state.wrappedValue.toData()
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "")
        }
    }
}
