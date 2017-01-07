/*
 * HelloWorld.cpp
 *
 *  Created on: Dec 30, 2016
 *      Author: vagrant
 */

#include <iostream>
#include <cstdlib>
#include <iomanip>
#include "../include/easylogging++.h"
INITIALIZE_EASYLOGGINGPP



using namespace std;
using namespace el;



int main(int argc, char **argv) {

	// Use default logger
	el::Logger* defaultLogger = el::Loggers::getLogger("default");
	defaultLogger->info("Reading config file ...");
	defaultLogger->warn("My first warn log message %v %v %v", 123, 222, "test warn message");
	defaultLogger->error("My first error log message %v %v %v", 458.8, 222, "test error message");

	return 0;
}

