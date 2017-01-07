/*
 * config.cpp
 *
 *  Created on: Jan 4, 2017
 *      Author: vagrant
 */



/* ----------------------------------------------------------------------------
   libconfig - A library for processing structured configuration files
   Copyright (C) 2005-2010  Mark A Lindner
   This file is part of libconfig.
   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public License
   as published by the Free Software Foundation; either version 2.1 of
   the License, or (at your option) any later version.
   This library is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.
   You should have received a copy of the GNU Library General Public
   License along with this library; if not, see
   <http://www.gnu.org/licenses/>.
   ----------------------------------------------------------------------------
*/

#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <libconfig.h++> //This library needs the "-lconfig++" adding to Project Properties > Build > Linker > Libraries


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
    cfg.readFile("config.cfg");
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
    int led = blink_led["led"];
    int delay = blink_led["delay"];

    if(blink_led.lookupValue("led", led)
         && blink_led.lookupValue("delay", delay)){
        cout << "Led:" << setw(10) << right << led << endl;
        cout << "Delay:" << setw(10) << right << delay << endl;
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
