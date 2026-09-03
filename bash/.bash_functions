#!/bin/bash

function dhere {
    find -path './*' -prune -type d -print0 |
        xargs -0r du * -s |
        sort -rn |
        awk '{
            size = $1;
            if ( size / 2**20 > 1 ) {
                chr = "G";
                size = size / 2**20;
            }
            else if ( size / 2**10 > 1 ) {
                chr = "M";
                size = size / 2**10;
            }
            else chr = "k";
            printf "%6.1f%s  %s\n", size, chr, $2;
        }'
}
