import SwiftUI

public extension View {
    
    /**
     Attach a system notification view to the view.
     
     This alternative is deprecated and will be removed in a
     future version. Use the view or context-based extension
     instead.
     */
    
    @available(*, deprecated, message: "Use the view or context-based extension instead.")
    func systemNotification<Content: View>(
        @ViewBuilder _ notification: @escaping () -> SystemNotification<Content>) -> some View {
        let notif = notification()
        return ZStack(alignment: notif.configuration.edge.alignment) {
            self
            notif
        }
    }
}
