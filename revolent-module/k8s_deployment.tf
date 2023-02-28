resource "kubernetes_deployment" "main" {
  for_each = toset(module.vpc.azs)
  metadata {
    name = "${var.project_name}-${each.key}-${var.environment}"
    labels = {
      app = "${var.project_name}"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "${var.project_name}"
      }
    }

    template {
      metadata {
        labels = {
          app = "${var.project_name}"
        }
      }

      spec {
        container {
          image             = var.docker_image
          name              = var.project_name
          image_pull_policy = "Always"
          port {
            container_port = 3000
          }

          env {
            name  = "TABLE_NAME"
            value = aws_dynamodb_table.dynamodb-table.name
          }

          env {
            name  = "REGION"
            value = var.aws_region
          }

        }
        node_selector = {
          "topology.kubernetes.io/zone" = each.key
        }
      }
    }
  }
}
