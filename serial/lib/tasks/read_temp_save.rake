desc "Read Temp/Humd from Arduino and save"
task read_th_save: :environment do
  port_str = APP_CONFIG['port_str']
  baud_rate = APP_CONFIG['baud_rate']
  data_bits = APP_CONFIG['data_bits']
  stop_bits = APP_CONFIG['stop_bits']
  parity = SerialPort::NONE
  sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
  sp.flush_input
  humd_temp_array = sp.gets.chomp.split(",")
  sp.close
  if humd_temp_array.size != 2
    return
  end
  temperature = humd_temp_array[0].to_f
  humidity = humd_temp_array[1].to_f
  TempHumd.create(temperature: temperature, humidity: humidity) 
end
