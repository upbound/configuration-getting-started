"""
This file was generated by the KCL auto-gen tool. DO NOT EDIT.
Editing this file might prove futile when you re-run the KCL auto-gen generate command.
"""

{
    apiVersion = "platform.acme.co/v1alpha1"
    kind = "NodePool"
    metadata = {
        name = option("resourcename")
    }
    spec = {
        parameters = {
            nodeConfig = [
                {
                    machineType = "e2-medium"
                    preemptible = True
                    nodeCount = 1
                    serviceAccountRef = {
                    }
                    clusterRef = {
                    }
                }
            ]
        }
    }
}
