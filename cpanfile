requires 'Amon2';
requires 'Amon2::Util';
requires 'Amon2::Web';
requires 'Amon2::Web::Dispatcher::RouterBoom';
requires 'Data::Validator';
requires 'File::Path';
requires 'File::ShareDir';
requires 'Furl';
requires 'Getopt::Long';
requires 'HTTP::Session2::ClientStore';
requires 'JSON::XS';
requires 'Module::Build';
requires 'Module::Functions';
requires 'MouseX::Types';
requires 'MouseX::Types::Mouse';
requires 'Plack::Builder';
requires 'Plack::Loader';
requires 'SQL::Maker';
requires 'Teng';
requires 'Teng::Row';
requires 'Teng::Schema::Declare';
requires 'Text::Xslate', '1.6001';
requires 'Time::Piece::Plus';
requires 'Try::Tiny';
requires 'URI::Escape';
requires 'Plack::App::Proxy';
requires 'Twiggy';
requires 'Starlet';
requires 'Proclet';
requires 'boolean';
requires 'parent';
requires 'perl', '5.010001';

on configure => sub {
    requires 'Module::CPANfile';
};

on test => sub {
    requires 'Plack::Test';
    requires 'Plack::Util';
    requires 'Test::More', '0.98';
    requires 'Test::Requires';
    requires 'Test::Time';
};

on develop => sub {
    requires 'Perl::Critic';
    requires 'Test::Perl::Critic';
};
