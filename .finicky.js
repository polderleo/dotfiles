module.exports = {
  defaultBrowser: "Firefox",
  options: {
    hideIcon: true,
    checkForUpdate: false
  },
  handlers: [
    {
      match: "meet.google.com/*",
      browser: "Chromium"
    }
  ]
}
