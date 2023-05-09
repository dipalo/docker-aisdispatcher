#!/usr/bin/env bash

EXITCODE=0

loginctl user-status ais
USER_STATUS=$?
if [ $USER_STATUS -ne 0 ] ; then
    loginctl enable-linger ais
    EXITCODE=$?
fi

exit $EXITCODE
