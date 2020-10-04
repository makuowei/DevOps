New-VM -Name 'kube-master1' `
    -Location 'KubeLab (172.16.83.0)' `       # use Get-Folder to get a list of avaialble folders
    -VMHost  'kesxi3.kenma.com.hk' `
    -Datastore 'KESXI3-SSD1(1TB)' `
    -Version v14 `
    -GuestId 'centos8_64Guest' `              # Search for GuestOsIdentifier
    -NumCpu  2 `
    -MemoryMB '4096' `
    -DiskGB  '100' `
    -DiskStorageFormat Thin `
    -NetworkName  'dvKenNet' `
    -CD `
    -Description 'Kubernetes Master (172.16.83.10)' 
    
New-VM -Name 'kube-worker1' `
    -Location 'KubeLab (172.16.83.0)' `       # use Get-Folder to get a list of avaialble folders
    -VMHost  'kesxi4.kenma.com.hk' `
    -Datastore 'KESXI4-SSD1(1TB)' `
    -Version v14 `
    -GuestId 'centos8_64Guest' `              # Search for GuestOsIdentifier
    -NumCpu  2 `
    -MemoryMB '4096' `
    -DiskGB  '100' `
    -DiskStorageFormat Thin `
    -NetworkName  'dvKenNet' `
    -CD `
    -Description 'Kubernetes Worker Node 1 (172.16.83.11)' 

New-VM -Name 'kube-worker2' `
    -Location 'KubeLab (172.16.83.0)' `       # use Get-Folder to get a list of avaialble folders
    -VMHost  'kesxi3.kenma.com.hk' `
    -Datastore 'KESXI3-SSD1(1TB)' `
    -Version v14 `
    -GuestId 'centos8_64Guest' `              # Search for GuestOsIdentifier
    -NumCpu  2 `
    -MemoryMB '4096' `
    -DiskGB  '100' `
    -DiskStorageFormat Thin `
    -NetworkName  'dvKenNet' `
    -CD `
    -Description 'Kubernetes Worker Node 2 (172.16.83.12)' 