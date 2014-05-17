#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;
use Test::Deep;

plan tests => 5;

use WWW::Gittip;

# 123  or  123.3  or 123.45
my $MONEY = re('\d+(\.\d\d?)?$');

# '2012-06-15'
my $DATE = re('^\d\d\d\d-\d\d-\d\d$'),

# '2012-06-15T11:09:54.298416+00:00'
my $TIMESTAMP = re('^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d\.\d+\+\d\d:\d\d$');

my $gt = WWW::Gittip->new;
isa_ok $gt, 'WWW::Gittip';

subtest charts => sub {
	plan tests => 1;
	my $chart_entry = {
		"active_users" => re('^\d+$'),
		"charges"      => $MONEY,
		"date"         => $DATE,
		"total_gifts"  => $MONEY,
		"total_users"  => re('^\d+$'),
		"weekly_gifts" => $MONEY,
		"withdrawals"  => $MONEY, 
	};

	my $charts = $gt->charts();
	#diag scalar @$charts;
	cmp_deeply($charts, array_each($chart_entry), 'charts');
};

subtest user_chars => sub {
	plan tests => 2;
	my $charts_user = $gt->user_charts('szabgab');
	#diag scalar @$charts_user;
	#diag explain $charts_user;
	my $user_chart_entry_old = {
		'date'     => $DATE,
		'npatrons' => re('^\d+$'),
		'receipts' => $MONEY,
	};
	my $user_chart_entry_new = {
		'date'     => $DATE,
		'npatrons' => re('^\d+$'),
		'receipts' => $MONEY,
		'ts_start' => $TIMESTAMP,
	};
	my $user_chart_entry = any($user_chart_entry_old, $user_chart_entry_new);

	#diag explain $charts_user->[0];
	#cmp_deeply $charts_user->[0], $user_chart_entry_old;
	#cmp_deeply $charts_user->[0], $user_chart_entry_new;
	#cmp_deeply $charts_user->[0], any($user_chart_entry_old, $user_chart_entry_new);
	#cmp_deeply $charts_user->[0], $user_chart_entry;
	
	cmp_deeply($charts_user, array_each($user_chart_entry), 'user_charts');

	my $invalid = $gt->user_charts('a/b');
	cmp_deeply $invalid, [], 'invalid requets';
};

subtest communities => sub {
	plan tests => 1;
	my $empty = $gt->communities;
	#diag explain $data;
	cmp_deeply $empty, {
		'communities' => []
	};
};

subtest api_key => sub {
	my $api_key = get_api_key();
	if ($api_key) {
		plan tests => 1;
	} else {
		plan skip_all => 'API_KEY is needed';
	}

	# If user is logged in, the method returns a list of all the communities.
	$gt->api_key($api_key);
	my $communities = $gt->communities;

	#diag explain $communities;
	my $expected_community = {
           'is_member' => isa('JSON::PP::Boolean'),
           'name'      => re('^[\w., -]+$'),
           'nmembers'  => re('^\d+$'),
           'slug'      => re('^[\w-]+$'),
    };
	#cmp_deeply($communities->{communities}[0], $expected_community);
	cmp_deeply($communities->{communities}, array_each($expected_community));

};

#my $paydays = WWW::Gittip->paydays();
#print Dumper $paydays;

#my $stats = WWW::Gittip->stats();
#print Dumper $stats;

exit;



sub get_api_key {
	my $gittiprc = "$ENV{HOME}/.gittip";
	#die if not -e $gittiprc;
	my %config;
	if (open my $fh, '<', $gittiprc) {
		while (my $row = <$fh>) {
			chomp $row;
			my ($field, $key) = split /=/,  $row;
			$config{$field} = $key;
		}
	}
	return $config{api_key};
}

