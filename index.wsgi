import os, sys
os.chdir(os.path.dirname(__file__))
sys.path.append(os.path.dirname(__file__))
sys.stdout=sys.stderr

import bottle
from main import application
