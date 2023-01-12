#!/bin/bash

# Runs pcapfix against all pcaps in a directory and moves the originals to the busted directory
mkdir busted

for f in *.*cap*; do
	pcapfix -d $f
	mv $f busted/

done