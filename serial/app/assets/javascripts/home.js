'use strict';
$(document).ready(function(){
  window.chartColors = {
    red: 'rgb(255, 99, 132)',
    orange: 'rgb(255, 159, 64)',
    yellow: 'rgb(255, 205, 86)',
    green: 'rgb(75, 192, 192)',
    blue: 'rgb(54, 162, 235)',
    purple: 'rgb(153, 102, 255)',
    grey: 'rgb(201, 203, 207)'
  };


  var t24 = $("#t24").data("t");
  var h24 = $("#t24").data("h");
  var d24 = [23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0];

  var t_week = $("#week").data("t");
  var h_week = $("#week").data("h");
  var d_week = [6,5,4,3,2,1,0];

  var t_month = $("#month").data("t");
  var h_month = $("#month").data("h");
  var d_month = [3,2,1,0];

  var config = {
    type: 'line',
    data: {
      labels: d24,
      datasets: [{
        label: 'Temperature C',
        backgroundColor: window.chartColors.red,
        borderColor: window.chartColors.red,
        data: t24,
        fill: false,
      }, {
        label: 'Humidity Rel%',
        fill: false,
        backgroundColor: window.chartColors.blue,
        borderColor: window.chartColors.blue,
        data: h24,
      }]
    },
    options: {
      responsive: true,
      title: {
        display: true,
        text: 'Mold Plotter'
      },
      tooltips: {
        mode: 'index',
        intersect: false,
      },
      hover: {
        mode: 'nearest',
        intersect: true
      },
      scales: {
        xAxes: [{
          display: true,
          scaleLabel: {
            display: true,
            labelString: '24 Hours backwards'
          }
        }],
        yAxes: [{
          display: true,
          scaleLabel: {
            display: true,
            labelString: 'Value'
          }
        }]
      }
    }
  };

  window.onload = function() {
    var ctx = document.getElementById('TempHum');
    window.moldPlot = new Chart(ctx, config);
  };

  document.getElementById('24Hours').addEventListener('click', function() {
    configChart(t24, h24, d24, '24 Hours backwards');
  });

  document.getElementById('pastWeek').addEventListener('click', function() {
    configChart(t_week, h_week, d_week, 'Last 7 days');	
  });

  document.getElementById('pastMonth').addEventListener('click', function() {
    configChart(t_month, h_month, d_month, 'Past Month in weeks');
  });

  function configChart(arrayT, arrayH, arrayD, labelString){

    config.data.datasets = [{
      label: 'Temperature C',
      backgroundColor: window.chartColors.red,
      borderColor: window.chartColors.red,
      data: arrayT,
      fill: false,
    }, {
      label: 'Humidity Rel%',
      fill: false,
      backgroundColor: window.chartColors.blue,
      borderColor: window.chartColors.blue,
      data: arrayH,
    }];
    config.options.scales.xAxes[0].scaleLabel.labelString = labelString;
    config.data.labels = arrayD;
    window.moldPlot.update();
  }
});
