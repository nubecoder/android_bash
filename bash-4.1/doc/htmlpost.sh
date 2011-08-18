#! /bin/sh
#
# Some of these should really be done by man2html
#
# The ~/xxx links don't really work -- netscape doesn't expand the home
# directory of the user running navigator
#

sed -e 's|<B>gnu.bash.bug</B>|<A HREF="news:gnu.bash.bug">gnu.bash.bug</A>|g' \
    -e 's|<I>/bin/bash</I>|<A HREF="file:/bin/bash"><I>/bin/bash</I></A>|g' \
    -e 's|<I>/etc/profile</I>|<A HREF="file:/etc/profile"><I>/etc/profile</I></A>|g' \
    -e 's|<I>/data/local/.bash_profile</I>|<A HREF="file:/data/local/.bash_profile"><I>/data/local/.bash_profile</I></A>|g' \
    -e 's|<I>/data/local/.bash_login</I>|<A HREF="file:/data/local/.bash_login"><I>/data/local/.bash_login</I></A>|g' \
    -e 's|<I>/data/local/.profile</I>|<A HREF="file:/data/local/.profile"><I>/data/local/.profile</I></A>|g' \
    -e 's|<I>/data/local/.bashrc</I>|<A HREF="file:/data/local/.bashrc"><I>/data/local/.bashrc</I></A>|g' \
    -e 's|<I>~/.bash_logout</I>|<A HREF="file:~/.bash_logout"><I>~/.bash_logout</I></A>|g' \
    -e 's|<I>/data/local/.bash_history</I>|<A HREF="file:/data/local/.bash_history"><I>/data/local/.bash_history</I></A>|g' \
    -e 's|<I>/data/local/.inputrc</I>|<A HREF="file:/data/local/.inputrc"><I>/data/local/.inputrc</I></A>|g' \
    -e 's|<I>/etc/inputrc</I>|<A HREF="file:/etc/inputrc"><I>/etc/inputrc</I></A>|g'
