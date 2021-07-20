# AGH2-helm

## Usage

To install the latest version of this chart, download the Argushack helm repository and edit the `values.yaml` to fill Database infromation & API Token.

After finished above, run `helm install`:

``` bash
helm install agh .
```

To install with namespace created:

``` bash
helm install --namepsace agh --create-namespace agh .
```
