import SwiftUI
import WebKit

struct CompassWebView: UIViewRepresentable {
    let context: PreviewContext
    let reloadKey: UUID

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let signature = "\(self.context.lang)|\(self.context.device)|\(self.context.orientation)|\(reloadKey.uuidString)"
        guard context.coordinator.signature != signature else {
            return
        }

        context.coordinator.signature = signature
        loadPreview(into: webView)
    }

    private func loadPreview(into webView: WKWebView) {
        guard
            let htmlURL = Bundle.main.url(forResource: "tidb-sales-kit", withExtension: "html", subdirectory: "content"),
            let html = try? String(contentsOf: htmlURL, encoding: .utf8)
        else {
            webView.loadHTMLString("<html><body><p>Unable to load preview content.</p></body></html>", baseURL: nil)
            return
        }

        let payload: [String: String] = [
            "lang": context.lang,
            "device": context.device,
            "orientation": context.orientation
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: [])
        let jsonString = jsonData.flatMap { String(data: $0, encoding: .utf8) } ?? "{}"
        let injected = "<script>window.__TIDB_COMPASS_CONTEXT__ = \(jsonString);</script>\n" + html

        webView.loadHTMLString(injected, baseURL: htmlURL.deletingLastPathComponent())
    }

    final class Coordinator {
        var signature = ""
    }
}
