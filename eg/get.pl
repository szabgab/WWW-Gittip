#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

use LWP::Simple qw(get);
use JSON qw(from_json);

use Data::Dumper qw(Dumper);
#my $charts = charts();
#my $paydays = paydays();
#print Dumper $paydays;
print Dumper stats();


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

Returns an array reference from /about/paydays.json
Each element in the array has the following fields:

     {
       'ach_fees_volume'    => '0',
       'ach_volume'         => '0',
       'charge_fees_volume' => '2.11',
       'charge_volume'      => '25.28',
       'nachs'              => 0,
       'nactive'            => 25
       'ncc_failing'        => 1,
       'ncc_missing'        => 18,
       'ncharges'           => 11,
       'nparticipants'      => 175,
       'ntransfers'         => 49,
       'ntippers'           => 12,
       'transfer_volume'    => '24.8',
       'ts_end'             => '2012-06-08T12:03:19.889215+00:00',
       'ts_start'           => '2012-06-08T12:02:45.182409+00:00',
     },

=cut

sub paydays {
	my $url = 'https://www.gittip.com/about/paydays.json';
	my $charts = get $url;
	return from_json $charts;
}

=head2 stats

Returns a reference to a hash from /about/stats.json
with lots of keys...

=cut

sub stats {
	my $url = 'https://www.gittip.com/about/stats.json';
	my $charts = get $url;
	return from_json $charts;
}

