provider "kubernetes" {
  config_path = "~/.kube/config"  # Path to your kubeconfig
}

resource "kubernetes_deployment" "tf_app_deployment" {
  metadata {
    name = "tf-app-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "tf-app"
      }
    }

    strategy {
      type = "RollingUpdate"  # Enable rolling updates

      rolling_update {
        max_surge       = 1
        max_unavailable = 1
      }
    }

    template {
      metadata {
        labels = {
          app = "tf-app"
        }
      }

      spec {
        container {
          name  = "tf-app-container"
          image = "sorinmatei/tf-app:latest"  # Replace with your Docker Hub image
          image_pull_policy = "Always"
          port {
            container_port = 3000
          }
        }
      }
    }
  }

  lifecycle {
    // Trigger rolling restart by using kubectl
    ignore_changes = [
      "metadata",
      "spec",
      "status",
    ]

    on_failure {
      execute = [
        "sh",
        "-c",
        "kubectl rollout restart deployment tf-app-deployment -n your-namespace",
      ]
    }
  }
}
