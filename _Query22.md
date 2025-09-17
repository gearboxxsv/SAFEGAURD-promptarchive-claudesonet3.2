/init

Plan carefully and innovate with pioneering code to achieve the following goals:

- Develop a plugin that incorporates the best practices for malware and virus detection, as outlined in the following
  references:
  @ref: https://www.tecmint.com/scan-linux-for-malware-and-rootkits/
  @ref: https://www.tecmint.com/install-linux-malware-detect-lmd-in-rhel-centos-and-fedora/

- Once the system is fully running, establish a regulated healthcheck process to monitor activities that are consistent
  with rootkit activity.

RootKit Hunter is a renowned, free, open-source, and user-friendly tool for scanning backdoors, rootkits, and local
exploits on POSIX-compliant systems like Linux.

As its name suggests, RootKit Hunter is a security monitoring and analyzing tool that thoroughly inspects a system to
identify hidden security vulnerabilities.

To install RootKit Hunter on Ubuntu and RHEL-based systems, use the following command:

or consider

Chkrootkit – A Linux Rootkit Scanners

Chkrootkit is another free, open-source rootkit detector that locally checks for signs of a rootkit on Unix-like
systems, helping to detect hidden security vulnerabilities.

The chkrootkit package includes a shell script that checks system binaries for rootkit modifications and various
security-related programs.

To install Chkrootkit on Debian-based systems, use the following command:

Work hard to consider the network of the future. The core will be default have a flag compromised:false. What attacks
will occur to change flag compromised:true? How can we make the system self-aware and heal itself when detection occurs?
Let’s call it the “kill switch” for the plugin.

This will ensure that a remote core in space, at sea, or in a smart city will always have a means to disable the
services running on an all-or-individual basis by process ID. This is crucial with API remote calls that may be running
during an attack. Track all processes at the core or supercore level, along with their type (local, decentralized,
remote). When it’s local, you can easily issue a “KILL -KILL PID.” When it’s decentralized, you need to message at least
two hosts and the target host. This concept of “N+2” for sharding the message allows a compromised core to have a “kill
switch” in queue on one of its peers or supercore nodes.

The first action of a compromised core enter the reboot processes, after roboot startup will check for the flag
compromised:true and run a full security scan, check for rootkits, malware, and any other security features. The second
step is to shutdown taking new jobs, kill all workers, and attempt to safely shutdown and restart. A core maintains a
security audit log and distributes this log to the supercore for redundancy. As sharding rules require, a core can use
eventual consistency models to recover from the restart, rerun security, and if all is okay, restart taking requests
from other peer cores. If the issues persist, it will enter a “zombie state.” Only the supercore can issue commands, and
it notifies any peer core that it’s out of service. If this zombie core is holding queued jobs, it will report a set of
requests to the supercore to reassign any jobs. These jobs will start based on contracts and connect to the origin core
to request a move contract, restart contract, and recover data. This eventual consistency model for data and service
recovery is a core element of the decentralized fabric. It’s designed to kill bad AI or ML jobs. If a supercore notifies
a worker on a remote core to cancel a contract or kill a process, it will do so with an acknowledgment message, complete
the contract notification to the origin node, and restart itself to ensure it’s healthy again. Once it’s healthy, it
will enter service by updating the status on the supercore and messaging known peers to send jobs for completion.


