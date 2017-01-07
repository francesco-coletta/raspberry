/*
 * HelloWorld.cpp
 *
 *  Created on: Dec 30, 2016
 *      Author: vagrant
 */

#include <iostream>
#include <cstdlib>
#include <iomanip>
#include <wiringPi.h>			//This library needs the "-lwiringPi" adding to Project Properties > Build > Linker > Libraries
#include <libconfig.h++>			//This library needs the "-lconfig" adding to Project Properties > Build > Linker > Libraries


//#include "include/easylogging++.h"
//INITIALIZE_EASYLOGGINGPP



using namespace std;
//using namespace libconfig;
//using namespace el;


// LED Pin - wiringPi pin 0 is BCM_GPIO 17.

#define LED     0


int main(int argc, char **argv) {
	Config cfg;


	// Use default logger
	//el::Logger* defaultLogger = el::Loggers::getLogger("default");

	// Read the file. If there is an error, report it and exit.
	//char *config_file_name = "config.cfg";
	try
	{
		//LOG(INFO) << "Reading config file ...";
		//defaultLogger->info("Reading config file ...");
		cfg.readFile("config.cfg");
	}
	catch(const FileIOException &fioex)
	{
		//defaultLogger->error("I/O error while reading file");
		//LOG(ERROR) << "I/O error while reading file";

		//std::cerr << "I/O error while reading file." << std::endl;
		return(-1);
	}
	catch(const ParseException &pex)
	{
		std::cerr << "Parse error at " << pex.getFile() << ":" << pex.getLine()
					  << " - " << pex.getError() << std::endl;
		return(-1);
	}

	  // Get the store name.
	  try
	  {
	    string startup_message = cfg.lookup("startup_message");
	    std::cout << startup_message << std::endl << std::endl;
	    //defaultLogger->info("Startup message %v", startup_message);
	  }
	  catch(const SettingNotFoundException &nfex)
	  {
		  std::cerr << "No 'name' setting in configuration file." << std::endl;
	  }




	wiringPiSetup();

	pinMode(LED, OUTPUT);

	for (;;) {
		digitalWrite(LED, 1);     // On
		delay(500);               // mS
		digitalWrite(LED, 0);     // Off
		delay(500);
	}
	return 0;
}

