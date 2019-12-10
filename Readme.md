# Stegano

The problem statement can be found [here](https://ocw.cs.pub.ro/courses/iocla/teme/tema-1). It's main subject is security/data protection using images.

## Table of Contents

- [Stegano](#stegano)
  - [Table of Contents](#table-of-contents)
  - [LSB](#lsb)
    - [Implementation](#implementation)

## LSB

For this task (the 4th), I had to implement a way to store a message in an image, based on the "least-significant bit" technique. Bytes from the image are changed, storing the bits of the message in the lsb position. 

### Implementation

The way the "lsb_encode" function works is the following:

- read the parameters
- convert "byte_id" to int
- move the pointer to the image to the starting position (img + byte_id - 1)
- loop throgh the bytes of the message
- extract the bits. If it is 0, create a mask = 11111110 and apply it to the image byte (mask & img). If not, create mask = 00000001 and apply it to the image (mask | img)
- move to the next byte in the image
- after each bit was stored, move to the next byte of the message

© 2019 Grama Nicolae, 322CA