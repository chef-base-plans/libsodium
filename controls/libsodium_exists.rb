title 'Tests to confirm libsodium libraries exist'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libsodium")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libsodium' do
  impact 1.0
  title 'Ensure libsodium libraries exist as expected'
  desc '
  We check that the three folders that libsodium installs are present.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty}
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "include")}") do
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "lib")}") do
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
