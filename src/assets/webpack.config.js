const _resolve = require('path').res;
const sync = require('glob').sync;
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const _loader = MiniCssExtractPlugin.loader;
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = (_env, _options) => ({
  devtool: 'source-map',
  resolve: {
    alias: {
        react: _resolve(__dirname, './node_modules/react'),
        'react-dom': _resolve(__dirname, './node_modules/react-dom')
    }
    },
  optimization: {
    minimizer: [
      new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry: {
      './js/app.js': ['./js/app.js'].concat(sync('./vendor/**/*.js'))
  },
  output: {
    filename: 'app.js',
    path: _resolve(__dirname, '../priv/static/js')
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.css$/,
        use: [_loader, 'css-loader']
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: '../css/app.css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }])
  ]
});
