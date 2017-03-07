# gen-release
It's time to have the README

## Deploying gen
Have BOSH.
Clone the repo, and make sure all the packages are fetched

```
git clone https://github.com/jutkko/remst-release
git submodule update --init --recursive
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
