Shell
===

The packaged Unlight swf client.

## Requirements

* Java 21.0+
* Apache Ant 1.19+
* Flex SDK 4.16
* Adobe AIR SDK 50.2

## Build with Ant

To build the swf client, run the following command:

```sh
ant -DSDK_HOME=/path/to/flex-sdk
```

To package the bundled client, run the following command:

```sh
ant -DSDK_HOME=/path/to/flex-sdk -DCERTIFICATE_PASSWORD=secret -DSERVER=server-address -d package
```

The certificate can be generated using the following command:

```sh
adt -certificate -cn SelfSigned 2048-RSA cert/Unlight.p12 secret
```
