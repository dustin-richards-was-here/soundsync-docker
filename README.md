# soundsync-docker

A Docker container to easily run [Soundsync](https://github.com/geekuillaume/soundsync) on any Linux computer with PulseAudio.

## What works?
- PulseAudio passthrough
- soundsync-docker can see other Soundsync nodes on the network

## What doesn't work (yet)?
- Other Soundsync nodes can't see soundsync-docker
	- I'm guessing this can be fixed with some additional network configuration when building/running the container
	- This doesn't mean that other Soundsync nodes can't stream to soundsync-docker, just that the container's node doesn't appear in their web interface
	- Can still connect other nodes to the container's node, just has to be done from the container's host PC at the moment
- Can't use soundsync-docker as a Spotify Connect device, probably due to the same reason as above
- I'd guess the Airplay receiver functionality is also broken, but I don't have any iOS devices to easily test with