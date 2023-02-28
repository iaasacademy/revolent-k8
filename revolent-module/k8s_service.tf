resource "kubernetes_service" "main" {
  metadata {
    name = "${var.project_name}-${var.environment}"
  }
  spec {
    selector = {
      app = "${var.project_name}"
    }
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}

output "website_url" {
  value = kubernetes_service.main.status.0.load_balancer.0.ingress.0.hostname
}
