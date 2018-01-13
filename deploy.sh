#!/bin/bash
tar czf - . | ssh banda259@nishilkohli.com "cd ~/public_html/nishil.in/  && tar xvzf -"
#
