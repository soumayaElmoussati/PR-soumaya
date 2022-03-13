module.exports = {
  env: {
    "node": true,
    "es6": true
  },
  parserOptions: {
    "ecmaVersion": 8
  },
  extends: [
    'standard',
    'plugin:vue/recommended'
  ],
  plugins: [
    'vue'
  ],
  // rules: {
  //   'vue/script-indent': ['error', 2, { 'baseIndent': 1 }]
  // },
  overrides: [
    {
      files: ['*.vue'],
      rules: {
        indent: 'off'
      }
    }
  ]
}
