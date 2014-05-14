#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;
use Test::Deep;

plan tests => 1;

use WWW::Gittip;

# The MONEY fields can be 123   123.3   or 123.45
my $MONEY = re('\d+(\.\d\d?)?$');
my $chart_entry = {
        "active_users" => re('^\d+$'),
        "charges"      => $MONEY,
        "date"         => re('^\d\d\d\d-\d\d-\d\d$'),
        "total_gifts"  => $MONEY,
        "total_users"  => re('^\d+$'),
        "weekly_gifts" => $MONEY,
        "withdrawals"  => $MONEY, 
};

my $charts = WWW::Gittip->charts();
cmp_deeply($charts, array_each($chart_entry), 'chart');


#my $paydays = WWW::Gittip->paydays();
#print Dumper $paydays;

#my $stats = WWW::Gittip->stats();
#print Dumper $stats;


