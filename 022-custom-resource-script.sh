#!/bin/bash

msfconsole -r $HOME/code/zen/022-custom-resource-script.rc

function via-msfconsole() {
  msfconsole
  # automatically exploit the machine
  resource /home/xp/code/zen/022-custom-resource-script.rc
}
