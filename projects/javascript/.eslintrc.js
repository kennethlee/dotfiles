module.exports = {
  root: true,
  env: {
    browser: true,
    es6: true,
    node: true,
  },
  extends: [
    // "eslint:recommended",
    "airbnb",
    "airbnb/hooks",
    // make sure Prettier is last so that it gets a chance to overeride other configs.
    "plugin:prettier/recommended",
  ],
  parserOptions: {
    ecmaVersion: 2017,
    sourceType: "module",
    jsx: true,
    ecmaFeatures: {
      experimentalObjectRestSpread: true,
    },
  },
  plugins: ["react", "prettier"],
  rules: {
    "comma-dangle": [2, "always-multiline"],
    "prettier/prettier": [2, { trailingComma: "all" }],
  },
};
