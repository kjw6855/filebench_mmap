#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
#
# Copyright 2007 Sun Microsystems, Inc.  All rights reserved.
# Use is subject to license terms.
#

set $dir=/mnt/tmpfs
set $nfiles=1000
set $meandirwidth=20
set $meanfilesize=16k
set $nthreads=100
set $iosize=1m
set $meanappendsize=16k

define fileset name=bigfileset,path=$dir,size=$meanfilesize,entries=$nfiles,dirwidth=$meandirwidth,prealloc=100
define fileset name=logfiles,path=$dir,size=$meanfilesize,entries=1,dirwidth=$meandirwidth,prealloc

define process name=filereader,instances=1
{
  thread name=filereaderthread,memsize=10m,instances=$nthreads
  {
    flowop openfile name=openfile1,filesetname=bigfileset,fd=1
    flowop mmapfile name=mmapfile1,fd=1
    flowop munmapfile name=munmapfile1,fd=1
    flowop closefile name=closefile1,fd=1
  }
}

echo  "Web-server Version 3.0 personality successfully loaded"
usage "Usage: set \$dir=<dir>"
usage "       set \$meanfilesize=<size>   defaults to $meanfilesize"
usage "       set \$nfiles=<value>    defaults to $nfiles"
usage "       set \$meandirwidth=<value>  defaults to $meandirwidth"
usage "       set \$nthreads=<value>  defaults to $nthreads"
usage "       set \$iosize=<size>     defaults to $iosize"
usage "       run runtime (e.g. run 60)"

run 6
