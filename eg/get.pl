#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

use lib 'lib';

use WWW::Gittip;
use Data::Dumper qw(Dumper);

my ($what, @params) = @ARGV;

usage() if not $what;

my $gt = WWW::Gittip->new;
if ($what eq 'charts') {
	my $charts = $gt->charts();
	print Dumper $charts;
} elsif ($what eq 'user_charts') {
	usage() if @params != 1;
	my $charts = $gt->user_charts($params[0]);
	print Dumper $charts;
} elsif ($what eq 'paydays') {
	my $paydays = $gt->paydays();
	print Dumper $paydays;
} elsif ($what eq 'stats') {
	my $stats = $gt->stats();
	print Dumper $stats;
} elsif ($what eq 'communities') {
	my $empty = $gt->communities();
	print Dumper $empty;
} elsif ($what eq 'mycommunities') {
	#use File::HomeDir;
	#my $gittiprc = File::HomeDir->my_home . '/.gittip';

	my $gittiprc = "$ENV{HOME}/.gittip";
	#die if not -e $gittiprc;
	my %config;
	open my $fh, '<', $gittiprc or die "Could not open '$gittiprc'\n";
	while (my $row = <$fh>) {
		chomp $row;
		my ($field, $key) = split /=/,  $row;
		$config{$field} = $key;
	}
	$gt->api_key($config{api_key});
	my $communities = $gt->communities();
	print Dumper $communities;
} else {
	usage();
}


sub usage {
	die <<"END";

Usage: $0 [charts|paydays|stats|communities|mycommunities]
       $0 user_charts USERNAME

END
}
