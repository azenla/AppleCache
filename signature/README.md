# Signatures

Unfortunately I'm not super familiar with signature formats and such in the Apple Ecosystem.

However using a HEX Editor and a lot of coffeee, I'm confident I can break the signature algorithm.

The signatures of the request seem to have two parts, a longer top part, and a shorter bottom part.

The payload is in between these two parts.

A 32-bit big endian unsigned number represents the payload size, and directly following the payload is a 32-bit big endian unsigned number representing the remaining bytes in the signature (however do note that there seem to be two trailing null characters).
