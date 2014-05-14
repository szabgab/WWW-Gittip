#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

use LWP::Simple qw(get);
use JSON qw(from_json);

use Data::Dumper qw(Dumper);
#my $charts = charts();
my $paydays = paydays();


=head2 charts

Returns an array reference from /about/charts.json
Each element in the array has the following fields:

    {
        "active_users" => 50,
        "charges"      => 25.29,
        "date"         => "2012-06-22",
        "total_gifts"  => 62.08,
        "total_users": => 621,
        "weekly_gifts" => 30.08,
        "withdrawals"  => 0.00
    },

=cut


sub charts {
	my $url = 'https://www.gittip.com/about/charts.json';
	my $charts = get $url;
	return from_json $charts;
}


=head2 paydays

/about/paydays.json

=cut

sub paydays {
	my $url = 'https://www.gittip.com/about/paydays.json';
	my $charts = get $url;
	return from_json $charts;
}

