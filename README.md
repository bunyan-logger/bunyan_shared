# Bunyan.Shared

<!-- bunyan_header -->

### Summary

The Bunyan logging system uses plugs to source events and to write log
messages. These plugs are loaded as dependencies of Bunyan.

Both the plugins and the main Bunyan program need access to the
functions that define the log levels. Splitting the levels into their
own application resolves the circular dependencies.

We also need to share the definition of a log message.