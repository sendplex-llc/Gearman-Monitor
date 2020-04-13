<?php

/**
 * Gearman Monitor configuration file
 *
 * The following server fields are available:
 *  - address: Gearman server address, hostname and port
 *  - name: Gearman server name to display in Gearman Monitor interface
 *
 * Example:
 * $cfgServers[$i]['address'] = '192.168.0.10:4730';
 * $cfgServers[$i]['name'] = 'Gearman server 1';
 * ++ $i;
 *
 * $cfgServers[$i]['address'] = '192.168.1.1:7003';
 * $cfgServers[$i]['name'] = 'Gearman server 2';
 * ++ $i;
 */

$i = 0;
$cfgServers = array();

$cfgServers[$i]['address'] = 'prod_gearmand:8888';
$cfgServers[$i]['name'] = 'Production';
++ $i;

$cfgServers[$i]['address'] = 'stag_staggearmand:8888';
$cfgServers[$i]['name'] = 'Staging';
++ $i;

$cfgServers[$i]['address'] = 'dev_devgearmand:8888';
$cfgServers[$i]['name'] = 'Development';
++ $i;