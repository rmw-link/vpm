module.exports = {
  plugins: [{
    name: 'preset-default',
    params: {
      floatPrecision:4,
      overrides: {
        removeDimensions:true,
        removeViewBox:false,
      },
    },
  }, ],
};
