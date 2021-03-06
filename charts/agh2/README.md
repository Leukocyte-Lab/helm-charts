# AGH2-helm

## Usage

To install the latest version of this chart, download the Argushack helm repository and copy `values.yaml` as new file then fill the Database information & API Token.

After finished above, run `helm install` with new `values.yaml`:

``` bash
helm install agh . -f deployment-values.yaml
```

To install with namespace created:

``` bash
helm install agh . -f deployment-values.yaml --namespace agh --create-namespace
```

To upgrade AGH, run `helm upgrade`:

``` bash
# default namespace
helm upgrade agh . -f deployment-values.yaml -f upgrade.yaml

# specify namespace
helm upgrade agh . -f deployment-values.yaml -f upgrade.yaml --namespace agh
```

## deypoloyment-values.yaml

```
captain:
  jwtSecret: "01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b" # `jwt-secret` is required, plz enter random string no less then 10 letters
  keygen:       # `apiToken` & `accountID` is required, plz contact sales to get tokens
    apiToken: activ-token
    accountID: account-id
  db:
    name: captain-db
    username: agh
    password: password
    ip: 192.168.0.2
    port: 5432

core:
  db:
    # Replace the password & DB ip & port
    name: core-db
    username: agh
    password: password
    ip: 192.168.0.2
    port: 5432

exploitmgr:
  db:
    # Replace the password & DB ip & port
    name: exploitmgr-db
    username: agh
    password: password
    ip: 192.168.0.2
    port: 5432

template:
  db:
    # Replace the password & DB ip & port
    name: template-db
    username: agh
    password: password
    ip: 192.168.0.2
    port: 5432

minio:
  url: ""
  core:
    user: ""
    password: ""
  capt:
    user: ""
    password: ""

imageCredential:
  # Fill the username & password for image pulling
  registry: registry.lkc-lab.com
  username: robot$leukocyte-lab+username
  password: password123456789000
```

---
use above file as deployment.yaml
  
If first time install agh, need to add repo

``` bash
helm repo add lkclab https://charts.lkc-lab.com/
```

Install agh

``` bash
helm install agh lkclab/agh2 -f deployment.yaml --namespace agh --create-namespace
```

warning: Update helm repo before performing the products update process

``` bash
helm repo update
```

Update agh to new version

``` bash
helm upgrade agh2 lkclab/agh2 -f deployment.yaml --namespace agh
```
