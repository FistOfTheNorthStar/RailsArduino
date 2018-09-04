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
  //mold (10x) is calculated using pine averages
  var m24 = moldIndex(t24, h24);

  var t_week = $("#week").data("t");
  var h_week = $("#week").data("h");
  var d_week = [6,5,4,3,2,1,0];
  var m_week = moldIndex(t_week, h_week);

  var t_month = $("#month").data("t");
  var h_month = $("#month").data("h");
  var d_month = [3,2,1,0];
  var m_month = moldIndex(t_month, h_month);

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
    configChart(t24, h24, d24, m24, '24 Hours backwards');
  });

  document.getElementById('pastWeek').addEventListener('click', function() {
    configChart(t_week, h_week, d_week, m_week, 'Last 7 days');	
  });

  document.getElementById('pastMonth').addEventListener('click', function() {
    configChart(t_month, h_month, d_month, m_month, 'Past Month in weeks');
  });

  function configChart(arrayT, arrayH, arrayD, arrayM, labelString){

    var dataSet = [{
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


    if (arrayT.length == 4){
      var add_MI10 = {
        label: 'MoldIndex10 (10+ problem)',
        fill: false,
        backgroundColor: window.chartColors.green,
        borderColor: window.chartColors.green,
        data: arrayM,
      }
      dataSet.push(add_MI10); 
    }
    
    config.data.datasets = dataSet;
    config.options.scales.xAxes[0].scaleLabel.labelString = labelString;
    config.data.labels = arrayD;
    window.moldPlot.update();
  }

  function moldIndex(arrayT, arrayH){
    var moldI = [];
    var days = 0;
    const arrayL = arrayT.length;
    if (arrayL == 7) {
      days = 7;
    } else if (arrayL ==4) {
      days = 28;
    }
    for (var i = 0; i < arrayL; i++){
      var tempM10x = days*16/(Math.pow(7,-0.68*Math.log(arrayT[i])-13.9*Math.log(arrayH[i])-0.33+66.02));
      moldI.push(tempM10x);
    }
    return moldI;
  }
});
