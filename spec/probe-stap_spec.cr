require "./spec_helper"

describe Probe::Stap do
  it "should emit probes" do
    probe_stap_emit(hello, "world")
    # Honestly not sure how to test this, maybe some fixtures,
    # compile them and run systemtap on them?
  end
end
