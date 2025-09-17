think hard about this concept.  safeguard will need to have a pip install safeguard.  plan and implement the full scope of
creating the .whl(.zip) archive.  think hard on how best implement the code base to protect ip, reverse engineering, 
and expose the system to hacking by release of a python library.
then
write the codebase, configuration files for pip, related copyright files, meta data files for pip use, a shell script to 
completed the build of the .whl file and any signature for cryptographic/sha validation we can use to ensure that the
library in use has not been modified by anyone.
