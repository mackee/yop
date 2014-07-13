package Yop::Model::Member;
use 5.10.1;
use warnings;
use utf8;
use Yop;
use boolean;
use Data::Validator;
use Yop;
use Time::Piece::Plus;
use SQL::Maker;
use Furl;
use JSON::XS;
use JSON::Types;

use constant (
    KUIPERBELT_SEND_ENDPOINT => "http://localhost:5002/send"
);

use MouseX::Types;
use MouseX::Types::Mouse "Str";

subtype "MemberName",
    as Str,
    where { m/[A-Z]{3,16}/ },
    message { "invalid name. name is A-Z characters and 3-16 charcters." };

sub join {
	my $class = shift;

	state $rule = Data::Validator->new(
		name => "MemberName",
		uuid => "Str",
	);
	my $args = $rule->validate(@_);
	my $now = localtime;
	my $teng = Yop->bootstrap->db;
	my $member = $teng->single("member", { name => $args->{name} });
    if (!defined $member) {
        $member =
    		$teng->insert("member", {
    			name       => $args->{name},
    			uuid       => $args->{uuid},
    			created_at => $now->mysql_datetime,
    			updated_at => $now->mysql_datetime,
    		});
    }
    else {
        if ($member->uuid ne $args->{uuid}) {
        	$member->update({
                uuid       => $args->{uuid},
                updated_at => $now->mysql_datetime,
            });
        }
    }

    return { result => bool true };
}

sub send {
    my $class = shift;

    state $rule = Data::Validator->new(
        name        => "MemberName",
        uuid        => "Str",
        target_name => "MemberName",
    );
    my $args = $rule->validate(@_);

    my $teng = Yop->bootstrap->db;
    my $member = $teng->single("member", { name => $args->{name} });
    if (!defined $member || $member->uuid ne $args->{uuid}) {
        return { result => bool false };
    }

    my $target_member = $teng->single("member", { name => $args->{target_name} });
    if (!defined $target_member) {
        return { result => bool false };
    }

    state $furl = Furl->new(
        agent   => "Yop",
        timeout => 10,
    );
    state $json = JSON::XS->new;
    my $body = $json->encode({
        UUID    => $target_member->uuid,
        from    => $member->name,   
        message => "Yop",
    });

    $furl->post(KUIPERBELT_SEND_ENDPOINT, [], $body);
    return { result => bool true };
}