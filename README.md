# PSNAPSHOT

**psnapshot** is free software,
and you are welcome to redistribute it under certain conditions.
See the GNU General Public Licence for details.

**psnapshot** is a simplified backup tool inspired in 
[rsnapshot](https://github.com/rsnapshot/rsnapshot) and 
written in python.

## INSTALLATION

For a quick installation:
    

* Run these commands from source code

        ./autogen.sh
        ./configure --sysconfdir=/etc
        sudo make install      

* To install from a distribution file only need run

        ./configure --sysconfdir=/etc
        sudo make install      


* Edit `/etc/psnapshot.conf` to set the directories to backup and the rest of 
parameters  following the examples of the configuration file.

If you wish, an installation without the default configuration is possible. 
After you can use the example file located at `/usr/local/etc/psnapshot.conf`:

    ./configure 
    sudo make install      

## FULL DESCRIPTION

**psnapshot** is a command line tool written in python to create snapshots of 
several
directories. The method used to backup it is similar to *backintime* or
*rsnapshot* but it solves some issues.

Like *rsnapshot* or *backintime*, *psnapshot* uses *rsync* to synchronize files 
keeping hardlinks for files not changed saving space. The main difference with 
*rsnapshot* is the no rotation of snapshots. **psnapshot** never renames the 
created directories for the snapshots. This improves the synchronization of the 
backups over the network when  several backup mirrors are required.

### BACKUPS CLEAN UP

**psnapshot** includes a clean up algorithm based on temporary slots. The 
algorithm is a simplified version of *backintime* algorithm. The clean up can be 
disabled in the configuration file using `CLEAN_ENABLE = False`

The clean up process uses temporary slots fixed at midnight. The number of slots 
and the width are defined by a pair of integers: (slots, width). The first 
integer *slots* is the number of snapshot to keep and the second *width* is a 
delta time to calculate next slot. 

Only one snapshot that match in the slot is kept. This is applied for each slot. 
You can define all slots as you want using a syntax of pairs (slots,width) in 
the configuration file.

In the following configuration example, the behavior is: to keep 10 snapshot per 
day and continue keeping 12 snapshot, one each 30 days, etc.

    KEEP_RULES = (
        (10,1),  # keep first 15 slots of one day
        (12,30), # keep next 12 slots of 30 days
        (3,365)  # keep next 3 of 365 days
    )
    
If you are unsure how this works, run **psnapshot** in dry mode with the 
verbosity level set to 2. In this mode, the standard output shows the slots and 
the snapshots candidates to be removed.

### LIMITATIONS

This preliminary version of psnapshot has been thought to keep no more than one 
snapshot by day. This datetime resolution will be improved in next versions.

## AUTHORS

Paulino Ruiz de Clavijo Vázquez <paulino@dte.us.es>