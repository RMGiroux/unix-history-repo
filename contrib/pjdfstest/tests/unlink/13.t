#!/bin/sh
# vim: filetype=sh noexpandtab ts=8 sw=8
# $FreeBSD: head/tools/regression/pjdfstest/tests/unlink/13.t 211352 2010-08-15 21:24:17Z pjd $

desc="unlink returns EFAULT if the path argument points outside the process's allocated address space"

dir=`dirname $0`
. ${dir}/../misc.sh

echo "1..2"

expect EFAULT unlink NULL
expect EFAULT unlink DEADCODE
