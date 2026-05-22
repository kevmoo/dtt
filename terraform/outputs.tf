output "service_url" {
  value       = data.google_cloud_run_v2_service.service.uri
  description = "URL of our deployed serverless Dart Cloud Run service container."
}

output "eventarc_trigger_ids" {
  value       = [ google_eventarc_trigger.trigger_user-written.id ]
  description = "Resource identifiers tracking active Eventarc triggers."
}
