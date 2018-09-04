<img src="http://drive.google.com/uc?export=view&id=1IVHWSDFdLt1bUA0j2tvHg0UQ_al2ZVG4" alt="Early Results">

# Easy Arduino Rails Project

The project is about connecting Arduino to RaspberryPi (or any other computer) via serial.

This project includes using an Arduino Mega with HTU21D to read temperature in Celcius and relative humidity. This is run in the background, and then you watch the results on a plot. This is just a small project and it is easy to customize to your needs and do more advanced playing around with the plotting. The HTU21D could have been connected directly via I2C to the Raspbian, but that was not the point here, other sensors will require some kind of microcontroller in between (Arduino being simple and well supported).

## Background

The project for me is to create an easy system where I can see how often humidity is above EHR 60%, which is the 'magic' limit after which our friend the MOLD will start growing. This is the low limit for some rarer species, but you will definitey get mold if levels exceed ERH 75% But this can be used in any way you see fit, and to understand how easy it is to create standalone systems even with Rails. You not need to worry about space on your Rasbperry Pi as the temperature and humidity are only collected every half an hour.

## Get started with Arduino
I have included the HTU21D libraries, so you don't need to do anything else than connect the HTU21D to the correct pins. Since I have a Mega it was trivial SDA and SCL to their own ports, plus connect GDN with 5V, then upload the code and you are ready to go.

## Get started Rails
Install bundler if you haven't already.
Once you've cloned the repo run `bundle install` and create the databases with `rake db:create` you should already have MySQL setup and check the database config settings in the config folder. Run the only migration needed `rails db:migrate`.
The you need to check the port which you have connected your Arduino (or any compatible device) then add it to `config/config.yml` change the `port_str` to what you have connected.
Remeber never put any passwords into git, so remember to add config files to .gitignore if you are going to use this in production.

# Start collecting data
Run `./start_dev.sh` to start the process of collecting data.
remember to run `./stop_dev.sh` if you stop collecting.

## Chart.js
Chart.js is used to do the plotting
https://github.com/coderbydesign/chart-js-rails
You can fix the graphs how ever you like and fix and fix and fix.

Hopefully this can get you started in using Rails with Arduino. You can edit as you please.

## Raspbian

Be prepared to do a bit of extra configuring.
There are major differences as development was done in OSX that you need to take into account if you are goint to use Raspbian on the RaspberryPi. First remember that installing all the necessary dependencies you might need to make sure that the user you are running as will have sufficient privileges.
Check MySQL sock and change it in the database.yml, run `mysqladmin variables | grep 'socket'` and add that.
Remember to check where Arduino is connected and add it to the config.yml, for me it was `/dev/ttyAMC0`
I would consider installing a lighter OS, but you might get into other trouble.
Then you need to comment out `bootsnap` from the `Gemfile` and `config/boot.rb`, it does not compile correctly.

### ToDo

- Run this on a Raspberry Pi with a touch screen
- Fix a few different Charts in order to see when you are at risk of Mold!
- Create email alerts if Rel/H goes over EHR 60% for 3 hours and exceeds EHR75% at any time

### Information on molds
http://www.euro.who.int/__data/assets/pdf_file/0017/43325/E92645.pdf


