// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.
//= jquery
const channels = require.context('.', true, /channels\.js$/)
channels.keys().forEach(channels)