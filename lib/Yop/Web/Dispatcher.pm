package Yop::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use Try::Tiny;
use Yop::Model::Member;
use JSON::Types;
use boolean;
use Log::Minimal;

get '/' => sub {
    my ($c) = @_;
    return $c->render("index.tx", {});
};

post '/join' => sub {
    my $c = shift;
    my $name = $c->req->param("name");
    my $uuid = $c->req->param("uuid");

    my $result = try {
        Yop::Model::Member->join(
            name => $name,
            uuid => $uuid,
        );
    }
    catch {
        critf($_);
        return +{ result => bool false };
    };

    return $c->render_json($result);
};

post '/send' => sub {
    my $c = shift;
    my $name = $c->req->param("name");
    my $uuid = $c->req->param("uuid");
    my $target_name = $c->req->param("target_name");

    my $result = try {
        Yop::Model::Member->send(
            name        => $name,
            uuid        => $uuid,
            target_name => $target_name,
        );
    }
    catch {
        critf($_);
        +{ result => false }
    };

    return $c->render_json($result);
};

1;