# Signatures

Unfortunately I'm not super familiar with signature formats and such in the Apple Ecosystem.

However using a HEX Editor and a lot of coffeee, I'm confident I can break the signature algorithm.

The signatures of the request seem to have two parts, a longer top part, and a shorter bottom part.

The payload is in between these two parts.

A 32-bit big endian unsigned number represents the payload size, and directly following the payload is a 32-bit big endian unsigned number representing the remaining bytes in the signature (however do note that there seem to be two trailing null characters).

The first section contains what seems to be a header, then a length for some signature data at position 0x4A.

Update: After a lot of work, I found the signature algorithm, and have been attempting to figure out it's origin. Turns out it's a custom algorithm just for Content Caching.

I've got a few options here:

1. Isolate the disassembled signature algorithm, and attempt to convert it to usable assembly. (Tough due to the use of a switch table...)
2. Create a binary patcher which goes into the signature algorithm as an entry-point, then require any external server to call this binary over an RPC.
3. Develop a Frida script to spawn the AssetCache server and hijack the registration data then kill the server.

I prefer Option 1, but it's going to be a huge pain. Might need to contact others for assistance in cracking the algorithm, it's really just a bunch of magic numbers.

I think I will start with a hybrid of Option 2 and Option 3, where I will make a server that does the registration for me by hijacking the AssetCache binary.

Good news is, after registration is at least possible, the rest is super easy!
