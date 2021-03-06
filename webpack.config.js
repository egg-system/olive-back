const path = require('path');
const webpack = require('webpack');
const ManifestPlugin = require('webpack-manifest-plugin')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')

module.exports = {
  entry: './frontend/app.tsx',
  output: {
    filename: "[name]-[hash].js",
    path: path.join(__dirname, 'src', 'public', 'assets', 'javascripts', 'webpack')
  },
  module: {
    rules: [
      {
        test: /\.(ts|tsx)$/,
        loader: 'ts-loader',
      },
      {
        test: /\.css$/,
        use:['style-loader', 'css-loader']
      },
      {
        test: /\.scss$/,
        use: [
          { loader: process.env.NODE_ENV !== 'production' ? 'style-loader' : MiniCssExtractPlugin.loader},
          { loader: 'css-loader', options: { modules: true } },
          { loader: 'postcss-loader',
            options: {
              plugins: function () {
                return [
                  require('precss'),
                  require('autoprefixer')
                ];
              }
            }
          },
          { loader: 'sass-loader'}
        ]
      },
      {
        test: /.(png|jpg|jpeg|gif|svg|woff|woff2|ttf|eot)$/,
        use: "url-loader?limit=100000"
      },
    ],
  },
  resolve: {
    modules:[path.join(__dirname, 'node_modules')],
    extensions: ['.js', '.jsx', '.ts', '.tsx']
  },
  plugins: [
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: 'jquery',
      jquery: 'jquery',
      "window.jQuery": 'jquery',
    }),
    new ManifestPlugin({
      writeToFileEmit: true
    }),
    new MiniCssExtractPlugin({
      filename: '[name].css'
    }),
  ],
};