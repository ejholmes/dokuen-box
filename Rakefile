@user = ENV['ROOT_USER'] || 'root'
@host = ENV['HOST'] || 'localhost'
@port = ENV['PORT'] || '22'

desc "Run the chef recipes on the server"
task :provision do
  exec <<-EOF
  tar --exclude-from=.gitignore -cj . | ssh -o 'StrictHostKeyChecking no' "#{@user}@#{@host}" -p #{@port} '
  sudo rm -rf ~/chef &&
  mkdir ~/chef &&
  cd ~/chef &&
  tar xj &&
  sudo bash install.sh '
  EOF
end

desc "Test the chef recipes in a Vagrant VM"
task 'vagrant:provision' => ['vagrant:keys', 'vagrant:credentials', :provision] do
end

namespace :vagrant do

  desc "Test the chef recipes in a clean Vagrant VM"
  task 'provision:clean' => ['vagrant:destroy', 'vagrant:provision'] do
  end

  desc "SSH into the VM"
  task :ssh do
    exec "vagrant ssh"
  end

  task :credentials do
    @user = 'root'
    @host = 'localhost'
    @port = 2222
  end

  task :destroy do
  end

  task :start do
  end

  task :keys do
    @user = 'vagrant'
    @host = 'localhost'
    @port = 2222
    key = File.read(File.expand_path('~/.ssh/id_rsa.pub'))
    identity_file = File.expand_path('~/.vagrant.d/insecure_private_key')
    system <<-EOF
    cat ~/.ssh/id_rsa.pub > authorized_keys &&
    scp -o 'StrictHostKeyChecking no' -P #{@port} -i #{identity_file} authorized_keys "#{@user}@#{@host}:" &&
    ssh -o 'StrictHostKeyChecking no' "#{@user}@#{@host}" -p #{@port} -i #{identity_file} '
    sudo mkdir -p /root/.ssh &&
    sudo mv authorized_keys /root/.ssh/authorized_keys &&
    sudo chown root /root/.ssh/authorized_keys &&
    sudo chmod 400 /root/.ssh/authorized_keys ' &&
    rm authorized_keys
    EOF
  end
end
