# Yop
Yo private

## What's this?
[Yo](http://www.justyo.co/ "Yo") is simple communication tool.
This application is Yo clone using [Kuiperbelt](https://github.com/mackee/kuiperbelt "kuiperbelt") and Perl5.

## Install

```
$ go get github.com/mackee/kuiperbelt/cmd/ekbo
$ git clone https://github.com/mackee/yop
$ cd yop
$ cpanm Carton # you most install [cpanm](https://github.com/miyagawa/cpanminus "cpanm")
$ carton install
$ carton exec -- perl script/yop-and-ekbo-server
```

## Implementation

### kuiperbelt
[Kuiperbelt](https://github.com/mackee/kuiperbelt "kuiperbelt") is asynchronous protocol proxy written in Golang.

### Perl5 modules
[Amon2](http://amon.64p.org/ "Amon2") is simple and faster web framework in Perl5.
And using [Teng](https://metacpan.org/pod/Teng "Teng") that O/R Mapper in Perl5.
Also using Awesome modules. If you're interested, It is good to look the inside [cpanfile](cpanfile "cpanfile").

### Frontside
not implemented. comming soon.

### sound
Please replace "iyopon.mp3" your having interesting sound file :-P.

## author

[mackee](https://github.com/mackee) macopy123 [atttttt] gmail.com