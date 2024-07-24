resource "aws_api_gateway_rest_api" "api_getway" {
  name        = "task_api"
  description = "API Gateway to nlb"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_getway.id
  parent_id   = aws_api_gateway_rest_api.api_getway.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.api_getway.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id             = aws_api_gateway_rest_api.api_getway.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP"
  uri                     = "http://${aws_lb.network_load_balancer.dns_name}"

   connection_type = "INTERNET"

}
