output "service_url" {
  value       = google_cloud_run_v2_service.service.uri
  description = "URL of our deployed serverless Dart Cloud Run service container."
}

output "eventarc_trigger_ids" {
  value = [
    for t in google_eventarc_trigger.trigger_* : t.id
  ]
  description = "Resource identifiers tracking active Eventarc triggers."
}
