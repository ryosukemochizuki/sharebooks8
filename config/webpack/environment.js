const { environment } = require('@rails/webpacker')

// jQueryとpopper.jsをwebpackで全ての環境で利用できるようにする
const webpack = require('webpack')

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
  })
)

module.exports = environment
