#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

use lib 'lib';

use WWW::Gittip;
use Data::Dumper qw(Dumper);


#my $charts = WWW::Gittip->charts();
#print Dumper $charts;

#my $paydays = WWW::Gittip->paydays();
#print Dumper $paydays;

#my $stats = WWW::Gittip->stats();
#print Dumper $stats;

#my $empty = WWW::Gittip->communities();
#print Dumper $empty;


#use File::HomeDir;
#my $gittiprc = File::HomeDir->my_home . '/.gittip';
my $gittiprc = "$ENV{HOME}/.gittip";
#die if not -e $gittiprc;
my %config;
if (open my $fh, '<', $gittiprc) {
	while (my $row = <$fh>) {
		chomp $row;
		my ($field, $key) = split /=/,  $row;
		$config{$field} = $key;
	}
	my $communities = WWW::Gittip->communities();
	print Dumper $communities;
}

