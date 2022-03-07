module.exports = {
  plugins: [{
    name: 'preset-default',
    params: {
      floatPrecision:4,
      overrides: {
        cleanupNumericValues: {
          floatPrecision: 4,
        },
        removeDimensions:true,
        removeViewBox:false,
      },
    },
  }, ],
};
