#!/bin/sh

. "${TEST_SCRIPTS_DIR}/unit.sh"

define_test "3 nodes, no LVS, current disconnected"

setup_nodes <<EOF
192.168.20.41
192.168.20.42
192.168.20.43
EOF

setup_lvs <<EOF
EOF

ctdb_state="\
NODEMAP
0       192.168.20.41   0x1     CURRENT RECMASTER
1       192.168.20.42   0x0
2       192.168.20.43   0x0

IFACES
:Name:LinkStatus:References:
:eth2:1:2:
:eth1:1:4:

VNNMAP
654321
0
1
2
"

#####

required_result 10 <<EOF
../client/ctdb_client.c:293 Failed to connect client socket to daemon. Errno:No such file or directory(2)
../common/cmdline.c:167 Failed to connect to daemon
Failed to init ctdb
Failed to detect which PNN this node is
Is this node part of a CTDB cluster?
EOF

simple_test list <<EOF
$ctdb_state
EOF

#####

required_result 10 <<EOF
../client/ctdb_client.c:293 Failed to connect client socket to daemon. Errno:No such file or directory(2)
../common/cmdline.c:167 Failed to connect to daemon
Failed to init ctdb
Failed to detect which PNN this node is
Is this node part of a CTDB cluster?
EOF

simple_test master <<EOF
$ctdb_state
EOF

#####

required_result 10 <<EOF
../client/ctdb_client.c:293 Failed to connect client socket to daemon. Errno:No such file or directory(2)
../common/cmdline.c:167 Failed to connect to daemon
Failed to init ctdb
Failed to detect which PNN this node is
Is this node part of a CTDB cluster?
EOF

simple_test list <<EOF
$ctdb_state
EOF

#####

required_result 10 <<EOF
../client/ctdb_client.c:293 Failed to connect client socket to daemon. Errno:No such file or directory(2)
../common/cmdline.c:167 Failed to connect to daemon
Failed to init ctdb
Failed to detect which PNN this node is
Is this node part of a CTDB cluster?
EOF

simple_test status <<EOF
$ctdb_state
EOF
