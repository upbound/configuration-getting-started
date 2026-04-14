# configuration-getting-started

An introductory example to Crossplane and Compositions using provider-nop. This will enable provisioning of several different fake resource types.

This repository contains a reference configuration for [Crossplane](https://crossplane.io) **v2**. This configuration is built with [provider-nop](https://marketplace.upbound.io/providers/crossplane-contrib/provider-nop), a Crossplane provider that simulates the creation of external resources. All composite resources are **namespaced** — claims are not used (they don't exist in Crossplane v2).

## Overview

This platform offers APIs for setting up a variety of basic resources that mirror what you'd find in a Cloud Service Provider such as AWS, Azure, or GCP. The resource types include:

* [Cluster](apis/primitives/cluster/), a resource that loosely represents a Kubernetes cluster.
* [NodePool](apis/primitives/nodepool/), a resource that loosely represents a Nodepool in a Kubernetes cluster.
* [Database](apis/primitives/database/), a resource that loosely represents a cloud database.
* [Network](apis/primitives/network/), a resource that loosely represents a cloud network resource.
* [Subnetwork](apis/primitives/subnetwork/), a resource that loosely represents a subnetwork resource within a cloud network.
* [ServiceAccount](apis/primitives/serviceaccount/), a resource that loosely represents a service account in the cloud.

This configuration also demonstrates the power of Crossplane to build abstractions called "compositions", which assemble multiple basic resources into a more complex resource. These are demonstrated with:

* [CompositeCluster](apis/composition-basics/compositecluster/), a resource abstraction that composes a cluster, nodepool, network, subnetwork, and service account.
* [AccountScaffold](apis/composition-basics/accountscaffold/), a resource abstraction that composes a service account, network, and subnetwork.

Learn more about Composite Resources in the [Crossplane
Docs](https://docs.crossplane.io/latest/concepts/compositions/).

## Quickstart

### Prerequisites

You need a running Crossplane v2 control plane. You can create a managed control plane on [Upbound](https://console.upbound.io), or run upstream Crossplane locally with [kind](https://kind.sigs.k8s.io/).

Install the `up` CLI:
```console
curl -sL https://cli.upbound.io | sh
```
See [up docs](https://docs.upbound.io/cli/) for more install options.

Alternatively, install the Crossplane CLI:
```console
curl -sL https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh | sh
```

### Install the Getting Started configuration

Install the configuration package:

```console
kubectl apply -f - <<EOF
apiVersion: pkg.crossplane.io/v1
kind: Configuration
metadata:
  name: configuration-getting-started
spec:
  package: xpkg.upbound.io/upbound/configuration-getting-started:v1.0.0
EOF
```

Wait for the configuration and all dependencies to become healthy:
```console
kubectl get configurations,providers,functions
```

Verify all XRDs are established:
```console
kubectl get xrd
```

You should see 8 XRDs, all with `ESTABLISHED=True` and an empty `OFFERED` column (no claims in v2).

## Using the Getting Started configuration

All resources are namespaced in Crossplane v2 — you apply XRs directly to a namespace instead of creating claims.

Create a custom defined cluster:
```console
kubectl apply -f examples/cluster/xr.yaml
```

Create a custom defined database:
```console
kubectl apply -f examples/database/xr.yaml
```

Create a composite cluster (composes 5 nested XRs):
```console
kubectl apply -f examples/compositecluster/xr.yaml
```

You can verify the status by inspecting the composite and managed resources:
```console
kubectl get managed,composite -n default
```

To delete the provisioned resources:
```console
kubectl delete -f examples/cluster/xr.yaml
kubectl delete -f examples/database/xr.yaml
kubectl delete -f examples/compositecluster/xr.yaml
```

To uninstall the configuration:
```console
kubectl delete configurations.pkg.crossplane.io configuration-getting-started
```

## Local development

Render compositions locally:

```console
make render
```

Run end-to-end tests:

```console
make e2e
```

> **Note**: The `render` target uses the `crossplane` CLI under the hood (`crossplane render`), which has no `up` equivalent for classic configuration packages.

## Next Steps

We recommend you check out one of Upbound's platform reference architectures to learn how to use Crossplane to provision real external resources:

* [AWS reference platform](https://github.com/upbound/platform-ref-aws/)
* [Azure reference platform](https://github.com/upbound/platform-ref-azure/)
* [GCP reference platform](https://github.com/upbound/platform-ref-gcp/)

## Questions?

For any questions, thoughts and comments don't hesitate to [reach
out](https://www.upbound.io/contact) or drop by
[slack.crossplane.io](https://slack.crossplane.io), and say hi!
