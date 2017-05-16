# remst-release
It's time to have the README

## Deploying remst
Have BOSH.
Clone the repo, and make sure all the packages are fetched

```
git clone https://github.com/jutkko/remst-release
git submodule update --init --recursive
```

Please make sure that the network configuration in the remst-release manifest is
compatible with the cloud-config for your BOSH. If you are using a blank
BOSH-Lite, you can just do

```
bosh update cloud-config manifest/cloud-config.yml
```

Set the deployment to the manifest after adding the director uuid to the
manifest

```
bosh deployment manifest/remst.yml
```

Deploy!

```
bosh deploy
```
