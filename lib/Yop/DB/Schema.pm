package Yop::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'Yop::DB::Row';

table {
    name 'member';
    pk 'id';
    columns qw(id name uuid status created_at updated_at);
};

1;
