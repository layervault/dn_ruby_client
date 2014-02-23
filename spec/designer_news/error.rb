require 'spec_helper'

describe DesignerNews::Response::Error do
  it "raises a BadRequest exception when the status is 400" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 400 }
    ex = DesignerNews::Response::Error.from_response(response)
    expect(ex).to be_instance_of DesignerNews::Response::BadRequest
  end

  it "raises a Unauthorized exception when the status is 401" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 401}
    ex = DesignerNews::Response::Error.from_response(response)
    expect(ex).to be_instance_of DesignerNews::Response::Unauthorized
  end

  it "raises a Frobidden exception when the status is 403" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 403}
    ex = DesignerNews::Response::Error.from_response(response)
    expect(ex).to be_instance_of DesignerNews::Response::Forbidden
  end

  it "raises a NotFound exception when the status is 404" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 404}
    ex = DesignerNews::Response::Error.from_response(response)
    expect(ex).to be_instance_of DesignerNews::Response::NotFound
  end

  it "raises a NotAcceptable exception when the status is 406" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 406}
    ex = DesignerNews::Response::Error.from_response(response)
    expect(ex).to be_instance_of DesignerNews::Response::NotAcceptable
  end

  it "raises a ClientError exception when the status is 407" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 407}
    ex = DesignerNews::Response::Error.from_response(response)
    expect(ex).to be_instance_of DesignerNews::Response::ClientError
  end

  it "raises a InternalServerError exception when the status is 500" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 500}
    ex = DesignerNews::Response::Error.from_response(response)
    expect(ex).to be_instance_of DesignerNews::Response::InternalServerError
  end

  it "raises a NotImplemented exception when the status is 501" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 501}
    ex = DesignerNews::Response::Error.from_response(response)
    expect(ex).to be_instance_of DesignerNews::Response::NotImplemented
  end

  it "raises a BadGateway exception when the status is 502" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 502}
    ex = DesignerNews::Response::Error.from_response(response)
    expect(ex).to be_instance_of DesignerNews::Response::BadGateway
  end

  it "raises a ServiceUnavailable exception when the status is 503" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 503}
    ex = DesignerNews::Response::Error.from_response(response)
    expect(ex).to be_instance_of DesignerNews::Response::ServiceUnavailable
  end

  it "raises a ServiceError exception when the status is 504" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 504}
    ex = DesignerNews::Response::Error.from_response(response)
    expect(ex).to be_instance_of DesignerNews::Response::ServerError
  end
end