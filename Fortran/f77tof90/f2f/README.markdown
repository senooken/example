<!-- -*- markdown -*- -->

# FORTRAN to Fortran

f2f is a [Perl](http://en.wikipedia.org/wiki/Perl) script which does much of the tedious work of converting FORTRAN 77 source code into modern [Fortran](http://en.wikipedia.org/wiki/Fortran). There seems to be a lot of Fortran hate in the world, and I think this comes from people who have been forced to use FORTRAN 77 at some time or another. Hopefully, this program will make you a less hateful person.

Download [f2f](http://bitbucket.org/lemonlab/f2f/downloads).

## USAGE:
> f2f [inputfile [outputfile]]

 e.g.:
> f2f legacycode.f legacycode.f90

I wrote this program for my own needs, a long time ago, and I have successfully used it many times. It has generally worked well for me with standard FORTRAN 77 source code, but can sometimes give problems on mixed 77/90 code. I can't guarantee it will spit out code that suits your aesthetic tastes, nor can I guarantee that it will generate code that compiles (you may need to make an edit or two first). In some cases it can generate really wacky code, especially if you feed it really wacky code. So I make no guarantees, but hopefully it makes your life easier rather than harder.

