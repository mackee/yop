use strict;
use warnings;
use utf8;

use Test::Time;
use Test::More;
use Test::Fatal;
use Yop;
use Yop::Model::Member;
use Time::Piece::Plus;
use Path::Tiny;
use Test::Mock::Guard qw/mock_guard/;
use JSON::XS qw/decode_json/;

sub initdb {
	my $teng = Yop->bootstrap->db;
	$teng->do(qq{DROP TABLE IF EXISTS member});
	my $schema = path(join "/", Yop->base_dir(), "sql", "sqlite.sql")->slurp;
	$teng->do($schema);

	return $teng;
}

subtest "join: success" => sub {
	my $teng = initdb();
	my $now = localtime;

	subtest "first join" => sub {
		my $result =
			Yop::Model::Member->join(
				name => "PAPIX",
				uuid => "papix_no_uuid",
			);
		ok $result->{result};

		my $member = $teng->single("member", { name => "PAPIX" });
		ok $member;
		is $member->uuid, "papix_no_uuid";
		is $member->$_, $now->mysql_datetime for qw/updated_at created_at/;
	};

	sleep 1;

	subtest "update" => sub {
		my $result =
			Yop::Model::Member->join(
				name => "PAPIX",
				uuid => "papix_no_uuid_sono2",
			);
		ok $result->{result};

		my $member = $teng->single("member", { name => "PAPIX" });
		ok $member;
		is $member->uuid, "papix_no_uuid_sono2";
		is $member->created_at, $now->mysql_datetime;
		is $member->updated_at, $now->add(1)->mysql_datetime;
	};
};

subtest "join: fail" => sub {
	my $teng = initdb();
	my $now = localtime;

	subtest "invalid names" => sub {
		my $exception = exception {
			Yop::Model::Member->join(
				name => "papix",
				uuid => "papix_no_uuid",
			);
		};
		like $exception, qr/invalid name\. name is A\-Z characters and 3\-16 charcters\./;
	};
};

subtest "send" => sub {
	my $teng = initdb();
	my $now = localtime;
	Yop::Model::Member->join(
		name => "PAPIX",
		uuid => "papix_no_uuid",
	);
	Yop::Model::Member->join(
		name => "MOZNION",
		uuid => "moznion_no_uuid",
	);

	my $guard = mock_guard "Furl" => {
		post => sub {
			my ($furl, $endpoint, $headers, $body) = @_;
			is $endpoint, Yop::Model::Member::KUIPERBELT_SEND_ENDPOINT;
			is_deeply $headers, [];
			is_deeply decode_json($body), {
				UUID    => "moznion_no_uuid",
				message => "Yop",
				from    => "PAPIX",
			}; 
		},
	};
	Yop::Model::Member->send(
		name        => "PAPIX",
		uuid        => "papix_no_uuid",
		target_name => "MOZNION",
	);
};

done_testing();