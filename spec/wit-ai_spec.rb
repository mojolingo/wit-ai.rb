# encoding: utf-8

require 'spec_helper'

describe WitAI do
  let(:api_key) { 'abc123' }

  subject { WitAI.new_client api_key }

  let(:message_body) { 'how many people between Tuesday and Friday?' }
  let(:intent) { 'query_metrics' }

  let(:interpretation) do
    <<-JSON
      {
        "msg_id": "ba0fcf60-44d3-4499-877e-c8d65c239730",
        "msg_body": "how many people between Tuesday and Friday?",
        "outcome": {
          "intent": "query_metrics",
          "entities": {
            "metric": {
              "value": "metric_visitors",
              "body": "people"
            },
            "datetime": [
              {
                "value": {
                  "from": "2013-10-21T00:00:00.000Z",
                  "to": "2013-10-22T00:00:00.000Z"
                },
                "body": "Tuesday"
              },
              {
                "value": {
                  "from": "2013-10-24T00:00:00.000Z",
                  "to": "2013-10-25T00:00:00.000Z"
                },
                "body": "Friday"
              }
            ]
          },
          "confidence": 0.979
        }
      }
    JSON
  end

  context "interpreting a string of text" do
    before do
      stub_request(:get, "https://api.wit.ai/message?q=#{message_body}")
        .with(headers: {'Authorization' => "Bearer abc123"})
        .to_return(body: interpretation, headers: {'Content-Type' => 'application/json'})
    end

    it "should return the interpretation as a Hash" do
      result = subject.interpret message_body
      result['msg_body'].should == message_body
      result['outcome']['intent'].should == intent
      result['outcome']['entities']['metric']['value'].should == 'metric_visitors'
    end
  end
end
