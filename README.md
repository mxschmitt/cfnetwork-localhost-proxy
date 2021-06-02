# `URLSession` does not proxy loopback requests over socks proxy

## Reproduce it locally:

1. Clone the repository
2. Install the NPM dependencies: `npm install`
3. Run the Socks5 server: `npm run socks-proxy`
4. Run the http proxy server: `npm run http-proxy`
4. Execute the swift code: `swift main.swift`

Expected: localhost response contains the `Hello from the Socks proxy` response.
Actual: localhost response does not use the proxy and tries to call the localhost server directly. This causes in this example `connection refused`, because there is no server running.

This is reproducible for socks and http proxies.

## Related:

- https://developer.apple.com/forums/thread/681009#681009021