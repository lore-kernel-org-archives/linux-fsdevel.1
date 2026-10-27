Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104266;
	b=oC0JJoyb8MK3SmafJPt24+cJwp9bidMl5KNlMHPYECaRljqxwPxf0/srGz+TJBhFWoMD
	 /bR4UMoQ8VM7EcRmJhPnrfhNKhaL5usmK00+ONoAUzQF8LKrjLHxhRJoTMZJEhN+oB8Gp
	 Wss+unF901KS58l5PxkjkxXN2E2TIgAoytpRQtF3p34BaiXadwExLkJDfyBK8ImH6c7ZQ
	 FaClvaeG3h8OwYJ4GpsXTjAfLVez80UuP8cluxtkxthjZ2E/23fE1qgLEMEJMjEjxt1cg
	 gk0acVRu9V+tbyUTPoJoMG7ATP78jLB94RARs9vnWpzStkULU6QbR2VUnWbJzpJAWDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104266;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=VXeK02TnSN/N1W4lY7aK9bGHn3P1rPx6NvHhSHG6Yqg=;
	b=z13nVF4XuIJ5K85Ub7sTBLl+U8K7RhOPu9DzvVHCRXmlyBq0QrdRteDNePuxAEQfsywR
	 lMbGS80KgGQ/j7jGHkJ4jH/rRIv0pbSf1G6lUGgMQEcbztgCh02dGT6Ny+pCOAQLHY1qT
	 2Tc8xeVAe0PI3+iv0ghakDTqIRfYuL69ENjgyFHBP9GVHXxA3W+t0BnOSOQg4RB6vKO6P
	 Xwa5zRIfg26bKIqkB7auiRIMs9HwIASkptW0jIAzOkfTPVNdpF++D5PCzRiKs3kkqH9a4
	 cni2OlpwJHyoj3ujScg+9X4NGcYd+Bk/OKxZ6rMcaTug9AOxJha66aSujf1yvv5hnkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jfsy5GTq;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C705606AA09;
	Tue, 27 Oct 2026 12:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C705606AA09
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jfsy5GTq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793104266; x=1824640266;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=z7DW7fW9sgN9905YYvTKfRlug1e3i8b3ME8FWPiFrE0=;
  b=Jfsy5GTqV+bscoPJxiDrFUrfrV6UXJrQUsJWIuR4gzhTOp1uxrQyrqc9
   fAsUPXna5yfeATMltfFoivu/QT9uejbm87gTCe46UK/MErW92OGDPL3Hq
   4bIgyPDIWgVC9EvwyhqhpCIcF7hVrklpBy50aiuvDGRmJL+WvIphzm5CD
   8GGDAHChBbJE4SstGxQHCg684WNVmTqDg47Fm+HCNcjHSdopSa+MsG34x
   hRULw2MxvuMNnMwdQiykASxenTvzPcoOecVFmHgoYC8thu4EnI3sIQRJ+
   RGJzI8KBZZBk9Sz9T9h/ZmQ8B+2Ryhubhwo+/IY7a0O2zNmI9utbUGzt3
   Q==;
X-CSE-ConnectionGUID: TzDGSF1OQrGgRltQEpxV+Q==
X-CSE-MsgGUID: 9/x0r3vXS62MG8t6bhTBlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1701969"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1701969"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:31:05 -0700
X-CSE-ConnectionGUID: oZu1MjGySWa8o7gtaYvi9A==
X-CSE-MsgGUID: KzmK8HYXSmGuOLk2VVlxbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4575354"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:31:01 -0700
Date: Tue, 27 Oct 2026 20:30:58 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>, Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>, linux-fsdevel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [linus:master] [selftests/proc]  ca5480fb53:
 kselftests.proc.proc-maps-race.fail
Message-ID: <202610271934.fd287c3f-lkp@intel.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Hello,

kernel test robot noticed "kselftests.proc.proc-maps-race.fail" on:

commit: ca5480fb53fa73cb5816b696b103826daedab1ca ("selftests/proc: add /pro=
c/pid/smaps_rollup tearing tests") https://git.kernel.org/cgit/linux/kernel=
/git/torvalds/linux.git master

[test failed on linux-next/master f1ac44c32cba88ad65dcecd4a279661d14e93651]

in testcase: kselftests
version: kselftests-x86_64-d6d3455d8751-1_20261013
with following parameters:

  group: proc


config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GH=
z (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610271934.fd287c3f-lkp@intel.com


KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-9=
=2E4-kselftests-ca5480fb53fa73cb5816b696b103826daedab1ca
2026-10-26 14:37:46 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2026-10-26 14:37:46 make -j36 TARGETS=3Dproc run_tests
  CC       fd-001-lookup
  CC       fd-002-posix-eq
  CC       fd-003-kthread
  CC       proc-2-is-kthread
  CC       proc-loadavg-001
  CC       proc-maps-race
  CC       proc-net-dev-lseek
  CC       proc-empty-vm
  CC       proc-self-map-files-001
  CC       proc-pid-vm
  CC       proc-self-map-files-002
  CC       proc-self-isnt-kthread
  CC       proc-self-syscall
  CC       proc-self-wchan
  CC       proc-subset-pid
  CC       proc-uptime-001
  CC       proc-uptime-002
  CC       read
  CC       proc-tid0
  CC       self
  CC       setns-dcache
  CC       setns-sysvipc
  CC       thread-self
  CC       proc-multiple-procfs
  CC       proc-fsconfig-hidepid
  CC       proc-pidns
# timeout set to 300
# selftests: proc: fd-001-lookup
ok 1 selftests: proc: fd-001-lookup
# timeout set to 300
# selftests: proc: fd-002-posix-eq
ok 2 selftests: proc: fd-002-posix-eq
# timeout set to 300
# selftests: proc: fd-003-kthread
ok 3 selftests: proc: fd-003-kthread
# timeout set to 300
# selftests: proc: proc-2-is-kthread
ok 4 selftests: proc: proc-2-is-kthread
# timeout set to 300
# selftests: proc: proc-loadavg-001
ok 5 selftests: proc: proc-loadavg-001
# timeout set to 300
# selftests: proc: proc-maps-race
# TAP version 13
# 1..6
# # Starting 6 tests from 2 test cases.
# #  RUN           proc_maps_race.maps.test_maps_tearing_from_split ...
# #            OK  proc_maps_race.maps.test_maps_tearing_from_split
# ok 1 proc_maps_race.maps.test_maps_tearing_from_split
# #  RUN           proc_maps_race.maps.test_maps_tearing_from_resize ...
# #            OK  proc_maps_race.maps.test_maps_tearing_from_resize
# ok 2 proc_maps_race.maps.test_maps_tearing_from_resize
# #  RUN           proc_maps_race.maps.test_maps_tearing_from_remap ...
# #            OK  proc_maps_race.maps.test_maps_tearing_from_remap
# ok 3 proc_maps_race.maps.test_maps_tearing_from_remap
# #  RUN           proc_maps_race.smaps.test_maps_tearing_from_split ...
# Expected stats:                                                          =
   Rss 892 kB
#                                                              Pss 82 kB
#                                                        Pss_Dirty 82 kB
#                                                         Pss_Anon 54 kB
#                                                         Pss_File 24 kB
#                                                        Pss_Shmem 3 kB
#                                                     Shared_Clean 0 kB
#                                                     Shared_Dirty 860 kB
#                                                    Private_Clean 0 kB
#                                                    Private_Dirty 32 kB
#                                                       Referenced 892 kB
#                                                        Anonymous 120 kB
#                                                              KSM 0 kB
#                                                         LazyFree 0 kB
#                                                    AnonHugePages 0 kB
#                                                   ShmemPmdMapped 0 kB
#                                                    FilePmdMapped 0 kB
#                                                   Shared_Hugetlb 0 kB
#                                                  Private_Hugetlb 0 kB
#                                                             Swap 0 kB
#                                                          SwapPss 0 kB
#                                                           Locked 0 kB
# Actual stats:                                                            =
 Rss 892 kB
#                                                              Pss 81 kB
#                                                        Pss_Dirty 81 kB
#                                                         Pss_Anon 54 kB
#                                                         Pss_File 24 kB
#                                                        Pss_Shmem 3 kB
#                                                     Shared_Clean 0 kB
#                                                     Shared_Dirty 860 kB
#                                                    Private_Clean 0 kB
#                                                    Private_Dirty 32 kB
#                                                       Referenced 892 kB
#                                                        Anonymous 120 kB
#                                                              KSM 0 kB
#                                                         LazyFree 0 kB
#                                                    AnonHugePages 0 kB
#                                                   ShmemPmdMapped 0 kB
#                                                    FilePmdMapped 0 kB
#                                                   Shared_Hugetlb 0 kB
#                                                  Private_Hugetlb 0 kB
#                                                             Swap 0 kB
#                                                          SwapPss 0 kB
#                                                           Locked 0 kB
# # proc-maps-race.c:961:test_maps_tearing_from_split:Expected 0 (0) !=3D c=
ompare_smaps_rollup(self, &orig_stats, &stats) (0) # # test_maps_tearing_fr=
om_split: Test terminated by timeout
# #          FAIL  proc_maps_race.smaps.test_maps_tearing_from_split
# not ok 4 proc_maps_race.smaps.test_maps_tearing_from_split
# #  RUN           proc_maps_race.smaps.test_maps_tearing_from_resize ...
# Expected stats:                                                          =
   Rss 956 kB
#                                                              Pss 83 kB
#                                                        Pss_Dirty 83 kB
#                                                         Pss_Anon 54 kB
#                                                         Pss_File 26 kB
#                                                        Pss_Shmem 3 kB
#                                                     Shared_Clean 0 kB
#                                                     Shared_Dirty 924 kB
#                                                    Private_Clean 0 kB
#                                                    Private_Dirty 32 kB
#                                                       Referenced 956 kB
#                                                        Anonymous 120 kB
#                                                              KSM 0 kB
#                                                         LazyFree 0 kB
#                                                    AnonHugePages 0 kB
#                                                   ShmemPmdMapped 0 kB
#                                                    FilePmdMapped 0 kB
#                                                   Shared_Hugetlb 0 kB
#                                                  Private_Hugetlb 0 kB
#                                                             Swap 0 kB
#                                                          SwapPss 0 kB
#                                                           Locked 0 kB
# Actual stats:                                                            =
 Rss 956 kB
#                                                              Pss 83 kB
#                                                        Pss_Dirty 83 kB
#                                                         Pss_Anon 54 kB
#                                                         Pss_File 25 kB
#                                                        Pss_Shmem 3 kB
#                                                     Shared_Clean 0 kB
#                                                     Shared_Dirty 924 kB
#                                                    Private_Clean 0 kB
#                                                    Private_Dirty 32 kB
#                                                       Referenced 956 kB
#                                                        Anonymous 120 kB
#                                                              KSM 0 kB
#                                                         LazyFree 0 kB
#                                                    AnonHugePages 0 kB
#                                                   ShmemPmdMapped 0 kB
#                                                    FilePmdMapped 0 kB
#                                                   Shared_Hugetlb 0 kB
#                                                  Private_Hugetlb 0 kB
#                                                             Swap 0 kB
#                                                          SwapPss 0 kB
#                                                           Locked 0 kB
# # proc-maps-race.c:1050:test_maps_tearing_from_resize:Expected 0 (0) !=3D=
 compare_smaps_rollup(self, &orig_stats, &stats) (0) # # test_maps_tearing_=
=66rom_resize: Test terminated by timeout
# #          FAIL  proc_maps_race.smaps.test_maps_tearing_from_resize
# not ok 5 proc_maps_race.smaps.test_maps_tearing_from_resize
# #  RUN           proc_maps_race.smaps.test_maps_tearing_from_remap ...
# Expected stats:                                                          =
   Rss 956 kB
#                                                              Pss 84 kB
#                                                        Pss_Dirty 84 kB
#                                                         Pss_Anon 54 kB
#                                                         Pss_File 26 kB
#                                                        Pss_Shmem 3 kB
#                                                     Shared_Clean 0 kB
#                                                     Shared_Dirty 924 kB
#                                                    Private_Clean 0 kB
#                                                    Private_Dirty 32 kB
#                                                       Referenced 956 kB
#                                                        Anonymous 120 kB
#                                                              KSM 0 kB
#                                                         LazyFree 0 kB
#                                                    AnonHugePages 0 kB
#                                                   ShmemPmdMapped 0 kB
#                                                    FilePmdMapped 0 kB
#                                                   Shared_Hugetlb 0 kB
#                                                  Private_Hugetlb 0 kB
#                                                             Swap 0 kB
#                                                          SwapPss 0 kB
#                                                           Locked 0 kB
# Actual stats:                                                            =
 Rss 956 kB
#                                                              Pss 83 kB
#                                                        Pss_Dirty 83 kB
#                                                         Pss_Anon 54 kB
#                                                         Pss_File 26 kB
#                                                        Pss_Shmem 3 kB
#                                                     Shared_Clean 0 kB
#                                                     Shared_Dirty 924 kB
#                                                    Private_Clean 0 kB
#                                                    Private_Dirty 32 kB
#                                                       Referenced 956 kB
#                                                        Anonymous 120 kB
#                                                              KSM 0 kB
#                                                         LazyFree 0 kB
#                                                    AnonHugePages 0 kB
#                                                   ShmemPmdMapped 0 kB
#                                                    FilePmdMapped 0 kB
#                                                   Shared_Hugetlb 0 kB
#                                                  Private_Hugetlb 0 kB
#                                                             Swap 0 kB
#                                                          SwapPss 0 kB
#                                                           Locked 0 kB
# # proc-maps-race.c:1141:test_maps_tearing_from_remap:Expected 0 (0) !=3D =
compare_smaps_rollup(self, &orig_stats, &stats) (0) # # test_maps_tearing_f=
rom_remap: Test terminated by timeout
# #          FAIL  proc_maps_race.smaps.test_maps_tearing_from_remap
# not ok 6 proc_maps_race.smaps.test_maps_tearing_from_remap
# # FAILED: 3 / 6 tests passed.
# # Totals: pass:3 fail:3 xfail:0 xpass:0 skip:0 error:0 not ok 6 selftests=
: proc: proc-maps-race # exit=3D1 # timeout set to 300 # selftests: proc: p=
roc-net-dev-lseek ok 7 selftests: proc: proc-net-dev-lseek # timeout set to=
 300 # selftests: proc: proc-empty-vm # protection_key_support: error: rv -=
1, errno 28 not ok 8 selftests: proc: proc-empty-vm # exit=3D1 # timeout se=
t to 300 # selftests: proc: proc-pid-vm ok 9 selftests: proc: proc-pid-vm #=
 timeout set to 300 # selftests: proc: proc-self-map-files-001 ok 10 selfte=
sts: proc: proc-self-map-files-001 # timeout set to 300 # selftests: proc: =
proc-self-map-files-002 ok 11 selftests: proc: proc-self-map-files-002 # ti=
meout set to 300 # selftests: proc: proc-self-isnt-kthread ok 12 selftests:=
 proc: proc-self-isnt-kthread # timeout set to 300 # selftests: proc: proc-=
self-syscall ok 13 selftests: proc: proc-self-syscall # timeout set to 300 =
# selftests: proc: proc-self-wchan ok 14 selftests: proc: proc-self-wchan #=
 timeout set to 300 # selftests: proc: proc-subset-pid ok 15 selftests: pro=
c: proc-subset-pid # timeout set to 300 # selftests: proc: proc-tid0 ok 16 =
selftests: proc: proc-tid0 # timeout set to 300 # selftests: proc: proc-upt=
ime-001 ok 17 selftests: proc: proc-uptime-001 # timeout set to 300 # selft=
ests: proc: proc-uptime-002 ok 18 selftests: proc: proc-uptime-002 # timeou=
t set to 300 # selftests: proc: read ok 19 selftests: proc: read # timeout =
set to 300 # selftests: proc: self ok 20 selftests: proc: self # timeout se=
t to 300 # selftests: proc: setns-dcache ok 21 selftests: proc: setns-dcach=
e # timeout set to 300 # selftests: proc: setns-sysvipc ok 22 selftests: pr=
oc: setns-sysvipc # timeout set to 300 # selftests: proc: thread-self ok 23=
 selftests: proc: thread-self # timeout set to 300 # selftests: proc: proc-=
multiple-procfs ok 24 selftests: proc: proc-multiple-procfs # timeout set t=
o 300 # selftests: proc: proc-fsconfig-hidepid ok 25 selftests: proc: proc-=
fsconfig-hidepid # timeout set to 300 # selftests: proc: proc-pidns # TAP v=
ersion 13 # 1..6 # # Starting 6 tests from 1 test cases.
# #  RUN           ns.pidns_mount_string_path ...
# #            OK  ns.pidns_mount_string_path
# ok 1 ns.pidns_mount_string_path
# #  RUN           ns.pidns_fsconfig_string_path ...
# #            OK  ns.pidns_fsconfig_string_path
# ok 2 ns.pidns_fsconfig_string_path
# #  RUN           ns.pidns_fsconfig_fd ...
# #            OK  ns.pidns_fsconfig_fd
# ok 3 ns.pidns_fsconfig_fd
# #  RUN           ns.pidns_reconfigure_remount ...
# #            OK  ns.pidns_reconfigure_remount
# ok 4 ns.pidns_reconfigure_remount
# #  RUN           ns.pidns_reconfigure_fsconfig_string_path ...
# #            OK  ns.pidns_reconfigure_fsconfig_string_path
# ok 5 ns.pidns_reconfigure_fsconfig_string_path
# #  RUN           ns.pidns_reconfigure_fsconfig_fd ...
# #            OK  ns.pidns_reconfigure_fsconfig_fd
# ok 6 ns.pidns_reconfigure_fsconfig_fd
# # PASSED: 6 / 6 tests passed.
# # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0 ok 26 selftests: p=
roc: proc-pidns


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261027/202610271934.fd287c3f-lkp@=
intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

