return {
  'tigion/nvim-asciidoc-preview',
  cmd = { 'AsciiDocPreview' },
  ft = { 'asciidoc' },
  build = 'cd server && npm install',
  opts = {
    server = {
      converter = 'js',
    },
    preview = {
      position = 'current',
    },
  },
}
