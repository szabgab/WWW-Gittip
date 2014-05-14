#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

use lib 'lib';

use WWW::Gittip;
use Data::Dumper qw(Dumper);

my $charts = WWW::Gittip->charts();
print Dumper $charts;

#my $paydays = WWW::Gittip->paydays();
#print Dumper $paydays;

#my $stats = WWW::Gittip->stats();
#print Dumper $stats;

