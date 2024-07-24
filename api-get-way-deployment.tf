resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  depends_on = [aws_api_gateway_integration.api_gateway_integration]
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = "prod"
}
output "api_gateway_url" {
  value = aws_api_gateway_deployment.api_gateway_deployment.invoke_url
}
