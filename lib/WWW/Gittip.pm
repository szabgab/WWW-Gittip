package WWW::Gittip;
use strict;
use warnings;

use LWP::Simple qw(get);
use JSON qw(from_json);

our $VERSION = '0.02';

=head1 NAME

WWW::Gittip - Implementing the Gittip API more or less

=head1 SYNOPSIS

  use WWW::Gittip;
  my $charts = WWW::Gittip->charts;

  my $user_charts = WWW::Gittip->user_charts('szabgab');

=head1 DESCIPTION

The API docs of Gittp: L<https://github.com/gittip/www.gittip.com#api>

When necessary, you can get an API key from your account on Gittip at L<https://www.gittip.com/about/me/account>

=head2 charts

Returns an array reference from /about/charts.json
Each element in the array has the following fields:

    {
        "active_users" => 50,
        "charges"      => 25.29,
        "date"         => "2012-06-22",
        "total_gifts"  => 62.08,
        "total_users"  => 621,
        "weekly_gifts" => 30.08,
        "withdrawals"  => 0.00
    },

=cut


sub charts {
	my $url = "https://www.gittip.com/about/charts.json";
	return _get($url);
}

=head2 user_charts

   WWW::Gittip->user_charts(USERNAME);

Returns an array referene from /%username/charts.json
Each element in the array has the following fields:

   {
     'date'     => '2012-06-08',
     'npatrons' => 0,
     'receipts' => '0',
     'ts_start' => '2012-06-08T12:02:45.182409+00:00'
   }


=cut


sub user_charts {
	my ($self, $username) = @_;

	#croak "Invalid username '$username'" if $username eq 'about';

	my $url = "https://www.gittip.com/$username/charts.json";
	return _get($url);
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
	return _get($url);
}

=head2 stats

Returns a reference to a hash from /about/stats.json
with lots of keys...

=cut



sub stats {
	my $url = 'https://www.gittip.com/about/stats.json';
	return _get($url);
}

=head2 communities

See L<https://github.com/gittip/www.gittip.com/issues/2014>

L<https://www.gittip.com/for/perl/?limit=20&offset=20>

L<https://github.com/gittip/www.gittip.com/issues/2408>

Currently only returns an empty list.

=cut

sub communities {
	my $url = 'https://www.gittip.com/for/communities.json';
	return _get($url);
}

# https://www.gittip.com/about/tip-distribution.json
# returns an array of numbers \d+\.\d\d  (over 8000 entries), probably the full list of tips.


sub _get {
	my ($url) = @_;

	my $charts = get $url;
	if (not defined $charts or $charts eq '') {
		warn "Empty return\n";
		return [];
	}
	my $data = eval { from_json $charts };
	if ($@) {
		warn $@;
		warn "Data received: '$charts'\n";
		$data = [];
	}
	return $data;
}



=head1 AUTHOR

Gabor Szabo L<http://perlmaven.com/>

=head1 LICENSE

Copyright (c) 2014, Gabor Szabo L<http://szabgab.com/>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;


