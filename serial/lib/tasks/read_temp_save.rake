desc "Read Temp/Humd from Arduino and save"
task read_th_save: :environment do
  port_str = APP_CONFIG['port_str']
  baud_rate = APP_CONFIG['baud_rate']
  data_bits = APP_CONFIG['data_bits']
  stop_bits = APP_CONFIG['stop_bits']
  parity = SerialPort::NONE
  sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

  # Flushing worked on the OSX, but for Raspbian new methods needed
  #sp.flush_input

  th_temp = ""
  while s = sp.gets
    s = s.chomp
    if s.length == 11
      th_temp = s
      break
    elsif s.length > 11
      th_temp = s[s.length-11,s.length]
      break
    end
  end
  humd_temp_array = th_temp.split(",")
  sp.close  

  if humd_temp_array.size != 2
    return
  end
  temperature = humd_temp_array[0].to_f
  humidity = humd_temp_array[1].to_f
  TempHumd.create(temperature: temperature, humidity: humidity) 
end
