---
layout: default
title: Debugging with PHPStorm
---

Setting up PHPStorm to debug PHP applications inside a Web Starter VM is
pretty easy.

1\) Tell PHPStorm to listen for incoming xdebug connections by clicking
the little telephone icon in the top right corner. It turns green.

![]({{site.baseurl}}/images/localdev/debugging-phpstorm/phpstorm_incoming.png)

2\) Mark a line as a "break point" by clicking beside the line number, to
add a red dot. This is where PHPStorm will pause execution.

![]({{site.baseurl}}/images/localdev/debugging-phpstorm/add_breakpoint.png)

3\) In any web browser, visit a page on your local dev environment that
should go past that break point. (actually that example is a bad one
because it's a drush command) Add the parameter <span
class="c6">?XDEBUG\_SESSION\_START=cam\_is\_muscular</span> to the end
of your URL. The value can really be anything, but that value in
particular makes it better.

That's it! The page will stay "loading" and PHPStorm will steal focus
from the browser to show you the debugger on that line. Below the code,
you'll see the "debug pane", which shows all the variables in the
environment as of that line. You can click into arrays and objects to
see the value of everything you have available, even globals like
\$\_GET!  On the left of the variables is a backtrace of "how it got
here". You can click up to each level and see the current environment
there, too.

![]({{site.baseurl}}/images/localdev/debugging-phpstorm/current_stack.png)

You can use the pointy-clicky icons if you like, but you'll be stronger,
healthier, happier, and more successful in life if you use the keyboard
shortcuts:

-   **F8**: Step over: Go to the next line and pause there.
-   **F7**: Step into: There's a function in the currently
    highlighted line. Step "into" that function and pause on the
    first line. If there are multiple functions, it will go through them
    one at a time.
-   **Shift+F7**: Smart step into: (PHPStorm 7 and up) like "step into",
    but offers you a choice of which function to step into on a line
    with multiple functions.
-   **Alt+F8**: Evaluate expression: Run some arbitrary code in the
    middle of execution. Find out what happens when you unset(\$\_GET)
    partway through a request!
-   **Alt+F9**: Run to cursor: Run normally until wherever your cursor
    is situated.
-   **Cmd+Alt+R**: Resume: Resume running until you find another
    breakpoint, if any.

Notes and Troubleshooting

### Is there an easier way to start a debug session?

Why, yes! I'm glad you asked. Xdebug can also be triggered from a
browser cookie. There are a ton of browser plugins that make it very
convenient to trigger xdebug this way. I use [The Easiest XDebug for
Firefox](https://addons.mozilla.org/en-US/firefox/addon/the-easiest-xdebug/),
but find one you like! Not that older versions of web-starter have a
varnish configuration that filters out the Xdebug cookie, so either
update web-starter or access your site directly through NGINX at
http://localhost:8081/.

### I'm getting weird errors about being unable to find a local path to somethingorother. What do I do?

The three things needed to get Xdebug working are: the browser has to
trigger the server to start a connection, something needs to be
listening for that connection, and it has to be able to relate paths on
the server to paths on its' local copy. This is a problem with that
third step. PHPStorm is getting a message like "I'm running
/vagrant/public/index.php now, what line do you want me to stop on?" But
it doesn't know where that is on your computer. You have to set up a
mapping between paths on the vagrant box and paths on your own computer.

The error message in PHPStorm 9 links to the place to fix the problem.
On previous versions, go to Run &gt; Edit Configurations &gt; Default
&gt; PHP Remote Debug. Add or modify a server configuration for
10.11.12.14, and map the project's root directory to /vagrant .

![]({{site.baseurl}}/images/localdev/debugging-phpstorm/debug_config.png)

### I'm debugging and I've changed the code, but it ignores my changes!

Though it looks like you can edit the code as it's running, you can't...
it will keep running on the version of the file that was loaded into
memory. You'll have to refresh, or use "Evaluate expression" to mimic
the changes you're making in code as you go.
