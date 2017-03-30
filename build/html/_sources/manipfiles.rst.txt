.. _manipfiles:

Manipulating files in the shell
-------------------------------

We did several experiments on human tissue samples and really hit it with the sequencing bat. We did Illumina ChIP-seq, RNA-seq, exome and whole genome sequencing (we had money to burn). We also did PacBio and Nanopore sequencing (because why not).
We have varying numbers of samples for each sequencing platform and type.

We get our data back from the sequencing center as FASTQ/Fast5 files, and
we stick them all in a folder called raw_data. This data is actually
the data we're going to use for the rest of the day. Lot's of "mock" files in here otherwise it'd take way too long to download all of them.
The only file that we are going to work with is in the illumina/rnaseq folder. Can you identify which one is real?

We want to be able to look at these files and do some things with them.

.. _wilds:

Wild cards
----------

Navigate to the `~/tutorial-shell-genomics/raw_data/illumina/rnaseq` directory. This
directory contains our FASTQ files. If we type::
    ls
    
we will see that files have long file names ending with .fastq

The `*` character is a shortcut for "everything". Thus, if
you enter `ls *`, you will see all of the contents of a given
directory. Now try this command::

    ls *fastq

This lists every file that ends with a `fastq`. This command::

    ls ~/tutorial-shell-genomics/src/*.sh

Lists every file in `~/tutorial-shell-genomics/src` that ends in the characters `.sh`.

We have single-end sequencing, so for every sample we have one file.

So how does this actually work? Well...when the shell (bash) sees a
word that contains the `*` character, it automatically looks for filenames
that match the given pattern. In this case, it identified four such
files. Then, it replaced the `*fastq` with the list of files, separated
by spaces.

What happens if you do `*fastq`?

**Exercise**

Do each of the following using a single `ls` command without navigating to a different directory.

1.  List all of the files in `processed_data/bams` that start with 'a'
2.  List all of the files in `processed_data/bams` that contain 'sorted'
3.  List all of the files in `processed_data/bams` that end with '.bai'

BONUS: List all of the files in 'processed_data/bams' that contain 'sorted' and end with '.bam'

.. _commandhist

Command History
---------------

You can easily access previous commands.  Hit the up arrow.
Hit it again.  You can step backwards through your command history.
The down arrow takes your forwards in the command history.

^ = Control key

^+C will cancel the command you are writing, and give you a fresh prompt.

^+R will do a reverse-search through your command history.  This is very useful.

You can also review your recent commands with the `history` command.  Just enter::

    history

to see a numbered list of recent commands, including this just issues
`history` command.  You can reuse one of these commands directly by
referring to the number of that command.

If your history looked like this:

    259  ls *
    260  ls ~/tutorial-shell-genomics/src/*.sh
    261  ls ~/tutorial-shell-genomics/processed_data/bams/*.bam*

then you could repeat command #260 by simply entering:

    !260

(that's an exclamation mark).

.. note:: Find the line number in your history for the last exercise (listing files in /bin) and reissue that command.

.. _examinefiles:

Examining Files
---------------

We now know how to switch directories, run programs, and look at the
contents of directories, but how do we look at the contents of files?

The easiest way to examine a file is to just print out all of the
contents using the program `cat`. Enter the following command::

    cat SRR5229450.subset.fastq

This prints out the contents of the `SRR5229450.subset.fastq` file. Science!

**Exercise**

1.  Print out the contents of the `~/tutorial-shell-genomics/src/hisat2_pass1.sh`
    file. What does this file contain?

2.  Without changing directories, (you should still be in `tutorial-shell-genomics`),
    use one short command to print the contents of all of the files in
    the `~/tutorial-shell-genomics/src` directory.

Make sure we're in the right place for the next set of the lessons. We
want to be in the `shell` directory. Check if you're there with `pwd`
and if not navigate there. One way to do that would be::

    cd ~/tutorial-shell-genomics/raw_data/illumina/rnaseq

`cat` is a terrific program, but when the file is really big, it can
be annoying to use. The program, `less`, is useful for this
case. Enter the following command:

    less SRR5229450.subset.fastq

`less` opens the file, and lets you navigate through it. The commands
are identical to the `man` program.

**Some commands in `less`**

| key     | action |
| ------- | ---------- |
| "space" | to go forward |
|  "b"    | to go backwarsd |
|  "g"    | to go to the beginning |
|  "G"    | to go to the end |
|  "q"    | to quit |

`less` also gives you a way of searching through files. Just hit the
"/" key to begin a search. Enter the name of the word you would like
to search for and hit enter. It will jump to the next location where
that word is found. Try searching the `ATG`. If you hit "/" then "enter", `less` will just repeat
the previous search. `less` searches from the current location and
works its way forward. If you are at the end of the file and search
for the word "cat", `less` will not find it. You need to go to the
beginning of the file and search.

For instance, let's search for the sequence `SRR5229450.149` in our file.
You can see that we go right to that sequence and can see
what it looks like.

Remember, the `man` program actually uses `less` internally and
therefore uses the same commands, so you can search documentation
using "/" as well!

There's another way that we can look at files, and in this case, just
look at part of them. This can be particularly useful if we just want
to see the beginning or end of the file, or see how it's formatted.

The commands are `head` and `tail` and they just let you look at
the beginning and end of a file respectively::

    head SRR5229450.subset.fastq
    tail SRR5229450.subset.fastq

The `-n` option to either of these commands can be used to print the
first or last `n` lines of a file. To print the first/last line of the
file use::

    head -n 1 SRR5229450.subset.fastq
    tail -n 1 SRR5229450.subset.fastq


.. _search:

Searching files
---------------

We showed a little how to search within a file using `less`. We can also
search within files without even opening them, using `grep`. Grep is a command-line
utility for searching plain-text data sets for lines matching a string or regular expression.
Let's give it a try!

Let's search for that sequence SRR5229450.149 in the SRR5229450.subset.fastq file.

    grep SRR5229450.149 SRR5229450.subset.fastq

We get back the whole line that had 'SRR5229450.149' in it. What if we wanted all
four lines, the whole part of that FASTQ sequence, back instead.

    grep -A 3 SRR5229450.149 SRR5229450.149

The `-A` flag stands for "after match" so it's returning the line that
matches plus the three after it. The `-B` flag returns that number of lines
before the match.

**Exercise**

1. Search for the sequence 'GATCGGAAGAGCACACGTCTGAACTCC' in the
SRR5229450.subset.fastq file and in the output have the
sequence name and the sequence. e.g.  
@M00967:43:000000000-A3JHG:1:2114:11799:28499 1:N:0:188  
TACGGAGGATGCGAGCGTTATCCGGATTTATTGGGTTTAAAGGGTGCGTAGGCGGGATGCAG

2. Search for that sequence in all the FASTQ files. (this step is a bit of a mock exercise as if you had many .fastq files)

.. _redirect:

Redirection
-----------

We're excited we have all these sequences that we care about that we
just got from the FASTQ files. That is a really important motif
that is going to help us answer our important question. But all those
sequences just went whizzing by with grep. How can we capture them?

We can do that with something called "redirection". The idea is that
we're redirecting the output to the terminal (all the stuff that went
whizzing by) to something else. In this case, we want to print it
to a file, so that we can look at it later.

The redirection command for putting something in a file is `>`

Let's try it out and put all the sequences that contain 'GATCGGAAGAGCACACGTCTGAACTCC'
from all the files in to another file called 'good-data.txt'

    grep -B 2 GATCGGAAGAGCACACGTCTGAACTCC * > good-data.txt

The prompt should sit there a little bit, and then it should look like nothing
happened. But type `ls`. You should have a new file called good-data.txt. Take
a look at it and see if it has what you think it should.

There's one more useful redirection command that we're going to show, and that's
called the pipe command, and it is `|`. It's probably not a key on
your keyboard you use very much. What `|` does is take the output that
scrolling by on the terminal and then can run it through another command.
When it was all whizzing by before, we wished we could just slow it down and
look at it, like we can with `less`. Well it turns out that we can! We pipe
the `grep` command through `less`

    grep GATCGGAAGAGCACACGTCTGAACTCC * | less

Now we can use the arrows to scroll up and down and use `q` to get out.

We can also do something tricky and use the command `wc`. `wc` stands for
`word count`. It counts the number of lines or characters. So, we can use
it to count the number of lines we're getting back from our `grep` command.
And that will magically tell us how many sequences we're finding. We're

    grep GATCGGAAGAGCACACGTCTGAACTCC * | wc

That tells us the number of lines, words and characters in the file. If we
just want the number of lines, we can use the `-l` flag for `lines`.

    grep GATCGGAAGAGCACACGTCTGAACTCC * | wc -l

Redirecting is not super intuitive, but it's really powerful for stringing
together these different commands, so you can do whatever you need to do.

The philosophy behind these command line programs is that none of them
really do anything all that impressive. BUT when you start chaining
them together, you can do some really powerful things really
efficiently. If you want to be proficient at using the shell, you must
learn to become proficient with the pipe and redirection operators:
`|`, `>`, `>>`.

**Exercise** 

Using redirection, can you get the 500th line in the SRR5229450.subset.fastq file?

.. _cmcr:

Creating, moving, copying, and removing
---------------------------------------

Now we can move around in the file structure, look at files, search files,
redirect. But what if we want to do normal things like copy files or move
them around or get rid of them. Sure we could do most of these things
without the command line, but what fun would that be?! Besides it's often
faster to do it at the command line, or you'll be on a remote server
like the VARI HPC or Amazon where you won't have another option.

The SraRunTable.txt file is one that tells us what sample name
goes with what sequences for an experiment in the Short Read Archive (SRA). This is a really important file, so
we want to make a copy so we don't lose it.

Lets copy the file using the `cp` command. The `cp`
command backs up the file. Navigate to the `data` directory and enter:

    cp SraRunTable.txt SraRunTable.txt_backup

Now `SraRunTable.txt_backup` has been created as a copy of `SraRunTable.txt`.

Let's make a `backup` directory where we can put this file.

The `mkdir` command is used to make a directory. Just enter `mkdir`
followed by a space, then the directory name.

    mkdir backup

We can now move our backed up file in to this directory. We can
move files around using the command `mv`. Enter this command:

    mv SraRunTable.txt_backup backup/

This moves `SraRunTable.txt_backup` into the directory `backup/` or
the full path would be... how would we know?

The `mv` command is also how you rename files. Since this file is so
important, let's rename it:

    mv SraRunTable.txt SraRunTable.txt_IMPORTANT

Now the file name has been changed to SraRunTable.txt_IMPORTANT. Let's delete
the backup file now:

    rm backup/stability.files_backup

The `rm` file removes the file. Be careful with this command. It doesn't
just nicely put the files in the Trash. They're really gone.


**Exercise**

Do the following:

1.  Rename the `SraRunTable.txt_IMPORTANT` file to `SraRunTable.txt`.
2.  Create a directory in the `rnaseq` directory called `new`
3.  Then, copy the `SraRunTable.txt` file into `new`

By default, `rm`, will NOT delete directories. You can tell `rm` to
delete a directory using the `-r` option. Let's delete that `new` directory
we just made. Enter the following command::

    rm -r new

## Writing files

We've been able to do a lot of work with files that already exist, but what
if we want to write our own files. Obviously, we're not going to type in
a FASTA file, but you'll see as we go through other tutorials, there are
a lot of reasons we'll want to write a file, or edit an existing file.

To write in files, we're going to use the program `nano`. We're going to create
a file that contains the favorite grep command so you can remember it for later. We'll name this file
'awesome.sh'.

    nano awesome.sh

Cue live coding!

Now we want to save the file and exit. At the bottom of nano, you see the "^X Exit". That
means that we use Ctrl-X to exit. Type `Ctrl-X`. It will ask if you want to save it. Type `y` for yes.
Then it asks if you want that file name. Hit 'Enter'.

Now you've written a file. You can take a look at it with less or cat, or open it up again and edit it.

**Exercise**

Open 'awesome.sh' and add "echo AWESOME!" after the grep command and save the file.

We're going to come back and use this file in just a bit.


## Running programs

Commands like `ls`, `rm`, `echo`, and `cd` are just ordinary programs
on the computer. A program is just a file that you can *execute*. The
program `which` tells you the location of a particular program. For
example:

    which ls

Might return "/bin/ls" (on Mac). Thus, we can see that `ls` is a program that
sits inside of the `/bin` directory. Now enter:

    which find

You will see that `find` is a program that sits inside of the
`/usr/bin` directory.

So ... when we enter a program name, like `ls`, and hit enter, how
does the shell know where to look for that program? How does it know
to run `/bin/ls` when we enter `ls`. The answer is that when we enter
a program name and hit enter, there are a few standard places that the
shell automatically looks. If it can't find the program in any of
those places, it will print an error saying "command not found". Enter
the command:

    echo $PATH

This will print out the value of the `PATH` environment variable. More
on environment variables later. Notice that a list of directories,
separated by colon characters, is listed. These are the places the
shell looks for programs to run. If your program is not in this list,
then an error is printed. The shell ONLY checks in the places listed
in the `PATH` environment variable.

Navigate to the `src` directory and list the contents. You will
notice that there is a program (executable file) called `hello.sh` in
this directory. Now, try to run the program by entering:

    hello.sh

You should get an error saying that hello.sh cannot be found. That is
because the directory `/home/username/tutorial-shell-genomics/src/hello.sh` is not in the
`PATH`. You can run the `hello.sh` program by entering:

    ./hello.sh

Remember that `.` is a shortcut for the current working
directory. This tells the shell to run the `hello.sh` program which is
located right here. So, you can run any program by entering the path
to that program. You can run `hello.sh` equally well by specifying::

    /home/username/tutorial-shell-genomics/src/hello.sh

Or by entering:

    ~/tutorial-shell-genomics/src/

When there are no `/` characters, the shell assumes you want to look
in one of the default places for the program.

## Writing scripts

We know how to write files and run scripts, so I bet you can guess where
this is headed. We're going to run our own script!

Go in to the 'rnaseq' directory where we created 'awesome.sh' before. Remember we wrote our
favorite grep command in there. Since we like it so much, we might want to run it
again, or even all the time. Instead of writing it out every time, we can just run it as
a script.

It's a command, so we should just be able to run it. Give it try.

    ./awesome.sh

Alas, we get `-bash: ./awesome.sh: Permission denied`. This is because we haven't told
the computer that it's a program. To do that we have to make it 'executable'. We do this
by changing its mode. The command for that is `chmod` - change mode. We're going to change the mode
of this file, so that it's executable and the computer knows it's OK to run it as a program.

    chmod +x awesome.sh

Now let's try running it again

    ./awesome.sh

Now you should have seen some output, and of course, it's AWESOME!
Congratulations, you just created your first shell script! You're set to rule the world.

.. _findingthings:

Finding files
-------------

The `find` program can be used to find files based on arbitrary
criteria. Navigate to the `data` directory and enter the following
command:

    find . -print

This prints the name of every file or directory, recursively, starting
from the current directory. Let's exclude all of the directories:

    find . -type f -print

This tells `find` to locate only files. Now try these commands:

    find . -type f -name "*1*"
    find . -type f -name "*1*" -or -name "*2*" -print
    find . -type f -name "*1*" -and -name "*2*" -print

The `find` command can acquire a list of files and perform some
operation on each file. Try this command out:

    find . -type f -exec grep ATG {} \;

This command finds every file starting from `.`. Then it searches each
file for a line which contains the pattern "ATG". The `{}` refers to
the name of each file. The trailing `\;` is used to terminate the
command.  This command is slow, because it is calling a new instance
of `grep` for each item the `find` returns.

A faster way to do this is to use the `xargs` command:

    find . -type f -print | xargs grep ATG

`find` generates a list of all the files we are interested in,
then we pipe them to `xargs`.  `xargs` takes the items given to it
and passes them as arguments to `grep`.  `xargs` generally only creates
a single instance of `grep` (or whatever program it is running).
