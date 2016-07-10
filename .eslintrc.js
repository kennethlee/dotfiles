module.exports = {
  "extends": "airbnb",

  "parser": "babel-eslint",

  "env": {
    "es6": true,
    "browser": true,
    "node": true,
  },

  "parserOptions": {
    "ecmaVersion": 6,
    "sourceType": "module",
    "ecmaFeatures": {
      "jsx": true,
    },
  },

  "plugins": [
    "react",
  ],

  "rules": {
    "eqeqeq": 2,
  },
};

