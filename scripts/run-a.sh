#!/bin/sh

erl -proto_dist inet_tls -sname a -ssl_dist_optfile inet-dist-tls.config -eval "net_kernel:verbose(2)."
