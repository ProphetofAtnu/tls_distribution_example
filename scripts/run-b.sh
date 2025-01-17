#!/bin/sh

erl -proto_dist inet_tls -sname b -ssl_dist_optfile inet-dist-tls.config -eval "net_kernel:verbose(2), net_adm:ping('a@mas-util-devn'), erlang:display(nodes())."
