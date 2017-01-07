
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <libconfig.h++> //This library needs the "-lconfig++" adding to Project Properties > Build > Linker > Libraries
#include <wiringPi.h>			//This library needs the "-lwiringPi" adding to Project Properties > Build > Linker > Libraries

using namespace std;
using namespace libconfig;

// This example reads the configuration file 'example.cfg' and displays
// some of its contents.

int main(int argc, char **argv)
{
  Config cfg;

  // Read the file. If there is an error, report it and exit.
  try
  {
    cfg.readFile("blinkled.cfg");
  }
  catch(const FileIOException &fioex)
  {
    std::cerr << "I/O error while reading file." << std::endl;
    return(EXIT_FAILURE);
  }
  catch(const ParseException &pex)
  {
    std::cerr << "Parse error at " << pex.getFile() << ":" << pex.getLine()
              << " - " << pex.getError() << std::endl;
    return(EXIT_FAILURE);
  }

  // Get the store name.
  try
  {
    string startup_message = cfg.lookup("startup_message");
    cout << "startup_message: " << startup_message << endl << endl;
  }
  catch(const SettingNotFoundException &nfex)
  {
    cerr << "No 'startup_message' setting in configuration file." << endl;
  }

  const Setting& root = cfg.getRoot();

  // blink_led
  try
  {
    const Setting &blink_led = root["blink_led"];
    int pin = blink_led["pin"];
    int wait_ms = blink_led["wait_ms"];

    if(blink_led.lookupValue("pin", pin)
         && blink_led.lookupValue("wait_ms", wait_ms)){
        cout << "Pin:" << setw(10) << right << pin << endl;
        cout << "Wait_ms:" << setw(10) << right << wait_ms << endl;

    	wiringPiSetup();

    	pinMode(pin, OUTPUT);

    	for (;;) {
    		digitalWrite(pin, 1);     // On
    		delay(wait_ms);               // mS
    		digitalWrite(pin, 0);     // Off
    		delay(wait_ms);
    	}
    	return 0;
    }
    else{
        cout << "Error" << endl;
    }
  }
  catch(const SettingNotFoundException &nfex)
  {
    // Ignore.
  }
  return(EXIT_SUCCESS);
}

// eof
