
#include <chrono>
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <libconfig.h++> //This library needs the "-lconfig++" adding to Project Properties > Build > Linker > Libraries
#include <wiringPi.h>			//This library needs the "-lwiringPi" adding to Project Properties > Build > Linker > Libraries
#include "../include/easylogging++.h"

using namespace std;
using namespace libconfig;
using namespace el;
using namespace std::chrono;

INITIALIZE_EASYLOGGINGPP

namespace raspberry{
    const char* CONFIG_FILE = "buttonblinkled.cfg";
    const int ON = 1;
    const int OFF = 0;
}

using namespace raspberry;



int main(int argc, char **argv)
{
	// Use default logger
	el::Logger* log = el::Loggers::getLogger("default");

    //led
    int pin_led;
    int wait_ms;

    //button
    int pin_button;
    int on_value;
    int off_value;
    int read_time_ms;

    // the following variables are unsigned long's because the time, measured in miliseconds,
    // will quickly become a bigger number than can be stored in an int.
    steady_clock::time_point last_debounce_time; // the last time the output pin was toggled
    steady_clock::time_point current_time;
    int debounce_delay = 50; // the debounce time; increase if the output flickers

    int led_state = ON;         // the current state of the output pin


    int button_current_state;
    int button_readed_state;       // the current reading from the input pin
    int button_last_state = OFF;   // the previous reading from the input pin

	// Read the file. If there is an error, report it and exit.
    Config cfg;
	try
	{
		log->info("Reading config file %v ...", CONFIG_FILE);
		cfg.readFile(CONFIG_FILE);
		log->info("Config file readed");
	}
	catch(const FileIOException &fioex)
	{
		log->error("I/O error while reading file.");
		//std::cerr << "I/O error while reading file." << std::endl;
		return(EXIT_FAILURE);
	}
	catch(const ParseException &pex)
	{
		log->error("Config file %v parse error at %v:%v - %v", CONFIG_FILE, pex.getFile(), pex.getLine(), pex.getError());
		//std::cerr << "Parse error at " << pex.getFile() << ":" << pex.getLine() << " - " << pex.getError() << std::endl;
		return(EXIT_FAILURE);
	}


	// Read config file
	try
	{
		string startup_message = cfg.lookup("startup_message");
		//cout << "startup_message: " << startup_message << endl << endl;
		log->info("---------------------");
		log->info("%v", startup_message);
		log->info("---------------------");
	}
	catch(const SettingNotFoundException &nfex)
	{
		log->error("No 'startup_message' setting in configuration file.");
		//cerr << "No 'startup_message' setting in configuration file." << endl;
	}

	const Setting& root = cfg.getRoot();
	try
	{
		const Setting &blink_led = root["blink_led"];
        pin_led = blink_led["pin"];
        wait_ms = blink_led["wait_ms"];

		if(!(blink_led.lookupValue("pin", pin_led)
				&& blink_led.lookupValue("wait_ms", wait_ms))){
			log->error("No blink config");
			return(EXIT_FAILURE);
		}
		log->info("Blink led: pin = %v, wait (ms) = %v", pin_led, wait_ms);
		//cout << "Pin:" << setw(10) << right << pin << endl;
		//cout << "Wait_ms:" << setw(10) << right << wait_ms << endl;

		const Setting &button = root["button"];
        pin_button = button["pin"];
        on_value = button["on_value"];
        off_value = button["off_value"];
        read_time_ms = button["read_time_ms"];
        debounce_delay = button["debounce_delay"];
		if(!(button.lookupValue("pin", pin_button)
				&& button.lookupValue("on_value", on_value)
                && button.lookupValue("off_value", off_value)
                && button.lookupValue("debounce_delay", debounce_delay)
				&& button.lookupValue("read_time_ms", read_time_ms))){
			log->error("No button config");
			return(EXIT_FAILURE);
		}
        log->info("Button: pin = %v, on value = %v, off value = %v, read time (ms) = %v", pin_button, on_value,
                off_value, read_time_ms);
    }
    catch (const SettingNotFoundException &nfex) {
        // Ignore.
    }

    //setup pin
    wiringPiSetup();
    pinMode(pin_led, OUTPUT);
    pinMode(pin_button, INPUT);

    digitalWrite(pin_led, OFF);

    last_debounce_time = steady_clock::now();
    button_current_state = off_value;
    button_last_state = off_value;
    button_readed_state = off_value;

    int button_status_changed = 0;
    for (;;) {
        button_readed_state = digitalRead(pin_button);
        log->info("button_current_state: %v, button_readed_state: %v", button_current_state, button_readed_state);

        // check to see if you just pressed the button
        // (i.e. the input went from LOW to HIGH),  and you've waited
        // long enough since the last press to ignore any noise:

        // If the switch changed, due to noise or pressing:
        if (button_readed_state != button_last_state) {
            log->info("Button status changed: %v -> %v", button_last_state, button_readed_state);
            // reset the debouncing timer
            last_debounce_time = steady_clock::now();
            button_status_changed = 1;
        }

        current_time = steady_clock::now();
        auto elapsed_milliseconds = duration_cast<milliseconds>(current_time - last_debounce_time);
        if (elapsed_milliseconds.count() > debounce_delay) {
            last_debounce_time = steady_clock::now();
            log->info("It is time to check button status (%v ms): %v", debounce_delay, elapsed_milliseconds.count());

            if (button_readed_state == on_value) {
                log->info("Button pressed: %v -> %v", button_last_state, button_readed_state);
                button_current_state = button_readed_state;
                if (led_state == ON) {
                    led_state = OFF;
                }
                else {
                    led_state = ON;
                }
                /*
                // only toggle the LED if the new button state is ON
                if (button_current_state == on_value) {
                    led_state = ON;
                }
                else {
                    led_state = OFF;
                }
                 */
            }
        }

        // set the LED:
        digitalWrite(pin_led, led_state);

        // save the reading.  Next time through the loop,
        // it'll be the lastButtonState:
        button_last_state = button_readed_state;

        delay(read_time_ms);
    }
	return(EXIT_SUCCESS);
}

// eof
