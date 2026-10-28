Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205335;
	b=KOTbu6BiTbWsbBvlVvNv63AyrT+RBfIPaziPmrR0VIPs6tF9ypzhjjYNygrf3CkqhNBs
	 OCQ4dEAzf7dqxpLmuPNBxIpOiGAp7PrXbLiILjCMTLnpVcoYN9nd3f1/nMMOIsDIRASkU
	 D0IM3E5+YoHHNCLtr65N2U2T0upgo4Y3nAdGOrjjya+aTIER+MktI/snAT4uV8wKWrZ+Y
	 V6ijUIPkaTF6nqHW56kbkpoTzF7nclKpq1LWgzvbsCwwl3L5qU8QDQ2qxjITZwBw6bVBL
	 eqCFSBaQnLbbSmnm7ifc4ZHFebGudujLXbAs34hi/uR9kBYSvMTvqjHhkgutfVYDJTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205335;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eSJVk9WJ8TwOzvHAzVLHNZ3eQkg1W9FYi5MTfgC/WAQ=;
	b=tF0Kh0i6jvtB3FhPB10tmx7FqO94162uj3VonayEtpP7fTmU7iAFaD/BDxRaTtexhI5z
	 Vus3jiT1BbafGOwaIdShy1N8/OWfa1j1XYmwP95Dxt4SMLEoPSjve10GdLCA3kCGNyMOf
	 JP4uK8xVnX/sqmaAU4HCcuogN4/3qoDNi8OfZGpUAypt1gY/ZTGmWmcG1dLXUugVQJiMc
	 484sgX3J8B+sO4FoaeKoqXFew0I/rKae6QqXbJ4mZyjyimtDZmOZ6PymAz9Q96SeLyfVu
	 9R0//8KftarMDnNiOYRm55ScpLT1ocCvHmtaAV2c+t0juk+WrU8XwTw7ZsUa8I3dsHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QhdqNdZH;
	arc=none smtp.remote-ip=91.218.175.2
Received: from mta0.migadu.com (out-2.mta0.migadu.com [91.218.175.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B2606A329
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 619B2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QhdqNdZH
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/x5cJUjs6dz8xwPPDARHWQy9V1gBqG/JOXbQVRsU1o4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205332; v=1; x=1793810132;
 b=QhdqNdZHGtatkR3+r1ivDcogkmVDUHGGdHDUY60L5K+59DwUuQRXAUScnHrl9ywpsO+jH1uC
 0HOSCnC2+4aN/fx2Kdfvtmweal4SVcWJgKB2s2eu5NquMVH+28UEHgffLQyey7tcqG0L4yFcBhz
 b3UTM8XMms5pDqPj0KWf9sHg=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id dbb1ffa08404ce7f;
	Wed, 28 Oct 2026 16:35:26 +0000
X-Mizu-Trace-ID: dbb1ffa08404ce7f
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with typed bounds and context
Date: Thu, 29 Oct 2026 00:34:39 +0800
Message-Id: <cover.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

struct ctl_table describes an entry with data, maxlen and, until this
series, two untyped misc pointers in extra1 and extra2. Those two pointers
have accumulated at least seven unrelated jobs: a fixed bound, a bound read
through a pointer on every call, an object or namespace pointer, a small
integer cookie encoded into the pointer, a lock signal, NULL standing for
"no bound", and a value the core itself casts to unsigned int while
validating a u8 range. Nothing in the entry says which job applies, so
readers infer it from the handler, and the core gets it wrong where it
treats extra1 as an unsigned int.

The numeric half of this change is the direction Eric Biederman asked for:

  You can still save a lot more by turning .extra1 and .extra2
  into longs instead of keeping them as pointers and needing
  constants to be pointed at somewhere.

  [...] I don't see any reason why you want shared
  constants for such a handful of things.  Especially when
  it has proven to be error prone in the past.

min/max are plain unsigned long members, so the comparisons are ordinary
C and cannot be confused with a pointer. The shared const arrays that only
existed to give those pointers an address (sysctl_vals and
sysctl_long_vals) are removed as well.

The tree already records this direction. fs/proc/proc_sysctl.c documents
extra1/extra2 as "extra pointers usable by the proc handler routines" and
carries:

  XXX: we should eventually modify these to use long min / max [0]
  [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org

This series completes that TODO and removes the comment.

priv is this series' addition: the same pair of fields also hides handler
context, which a numeric bound cannot express, and keeping it out of data
is what removes the restore-before-delegate pattern.

The overloading is also a memory-safety hazard. The obvious alternative --
keep handler context in data and restore the value pointer in each handler
-- needs an original_data field in nine addrconf and two devinet handlers;
one missed restore turns a user-supplied integer into a write over a kernel
pointer. nf_log reaches the same problem from the other side: it replaces
data with a local buffer inside a single handler, so data means two things
within one function. This revision removes that temptation instead of
managing it.

The core is not exempt. sysctl_check_table_array() reads
*(unsigned int *)table->extra1 to validate a u8 range. That is only correct
while every u8 entry happens to point extra1/extra2 at an int or unsigned
int; a long bound, a context pointer or an encoded integer would be read as
four bytes of the wrong object. No such entry exists today, so this is a
latent class rather than a live bug, but the invariant is untyped and
unchecked, and nf_log already encodes an integer into extra1.

The refactor is the first five patches; they define the replacement
contract and prove it covers every entry shape the tree uses today.

  1. min/max hold numeric bounds by value, and priv holds handler context.
     The range converters read min/max whenever extra1 and extra2 are
     clear and keep reading the pointers while they are set, so existing
     callers keep working while they migrate and no parallel handler API or
     renamed symbol is introduced. Signed handlers read the bounds as
     signed longs, an absent endpoint is the type limit rather than NULL so
     zero stays a real bound, and a run-time range is refreshed before
     every call. Registration rejects priv on a standard handler.

  2. The debug test module is converted to numeric bounds as the first
     user.

  3. KUnit coverage for numeric bounds and the handlers that consume them:
     full type ranges, one-sided and zero bounds, entries without backing
     storage, explicit handlers for arrays and members, and rejection of
     writes that would partially commit.

  4. KUnit coverage for run-time ranges across the scalar widths and
     jiffies, run-time bound pointers, sibling bounds, typed context, owner
     derivation, bool, registration lifecycles, and simulated per-net
     duplication.

  5. KUnit coverage for priv: a standard handler must ignore it,
     registration must reject it with a standard handler, and
     re-registration must keep both the value pointer and the context. The
     same patch moves the debug module's dynamic-value entry to the
     data/priv shape.

On the CTLTBL_ENTRY_* constructors: I kept the naming and argument order you
suggested while reworking the series. As it turned out, no production table
needed them -- the converted entries read naturally as designated
initializers -- so I have not introduced them as a public API in this
version; the KUnit file keeps an equivalent constructor privately, so the
tests stay readable. I still think the public version is worth doing, and I
would be happy to send it as a follow-up once there are real users, so the
API and its callers can be reviewed together.

Everything after patch 5 is migration and adds no new contract. Patches
6-32 convert the remaining users and derive owners from their backing
storage. Patches 33-38 move handler context onto priv, one subsystem per
patch; each of those files is touched exactly once and goes straight from
the old pointer field to priv, with no intermediate data-as-context step.
Patch 39 removes the extra pointers and the compatibility read.

The parport conversion illustrates a concrete problem with the overloaded
fields. In the base tree, registration overwrites the spintime minimum
pointer in vars[0].extra1 with a port pointer. The range handler can then
check a write against data from struct parport instead of the intended
minimum. Moving the port context to priv and using numeric bounds also
corrects this existing bug. A separate fix can address it independently;
this RFC does not depend on that fix.

Entries that used a *_minmax handler with neither extra pointer relied on
NULL meaning "no bound". They now state their type limits explicitly to
preserve that behaviour when the pointer path disappears. These include
aio-max-nr, acpi_video_flags and nmi_wd_lpm_factor.

Owners that can still be recovered from data are deliberately left alone:
ipvs, neighbour, the fragment reassembly handlers, vsock, mptcp, rds and
smc keep using container_of() on their backing storage. priv is only for
entries where no such derivation exists. Mixed placement in data and priv
was considered and rejected because it recreates the guessing problem this
series removes.

Relative to the base tree, the final state removes all 841 extra1/extra2
assignments across 123 files, removes the shared sysctl_vals and
sysctl_long_vals arrays (21 references), and states bounds at each entry
(~574 new min/max initializers) instead of pointing at constants. The
sysctl ABI is unchanged; the parport spintime minimum is corrected as
described above.

The cost is 8 bytes per ctl_table entry on 64-bit (56 -> 64) and 4 bytes on
32-bit, because priv is appended; the range read path gains no indirection
and the migrated entries no longer dereference a bound pointer.

Wen Yang (39):
  sysctl: replace overloaded extra pointers with typed bounds and
    context
  test_sysctl: convert bounds to numeric values
  sysctl: add KUnit coverage for numeric bounds and handlers
  sysctl: cover runtime ranges and context lifecycles in KUnit
  sysctl: cover priv in KUnit and the debug test module
  sysctl: convert core table bounds to numeric values
  sysctl: store architecture sysctl bounds by value
  sysctl: store crypto sysctl bounds by value
  sysctl: store device sysctl bounds by value
  sysctl: store filesystem sysctl bounds by value
  sysctl: store message-queue sysctl bounds by value
  sysctl: store kernel sysctl bounds by value
  sysctl: store memory-management sysctl bounds by value
  sysctl: store IPv6 scalar sysctl bounds by value
  sysctl: store netfilter scalar sysctl bounds by value
  sysctl: store RPC sysctl bounds by value
  sysctl: store remaining network sysctl bounds by value
  sysctl: store security sysctl bounds by value
  io_uring: store its sysctl bounds by value
  sysctl: refresh dynamic scheduler and PID bounds per call
  sysctl: refresh device-dependent bounds per call
  sysctl: refresh namespace IPC bounds per call
  yama: preserve scope locking with numeric sysctl bounds
  net: refresh core sysctl limits without bound pointers
  sctp: resolve numeric ranges from the current namespace
  rds: preserve live reconnect limits with numeric bounds
  ipv4: preserve live and vector bounds with numeric sysctls
  net: refresh fragment and remaining dynamic sysctl bounds
  neighbour: derive sysctl ownership independently of bounds
  net: resolve sysctl owners from their backing data
  ipvs: derive sysctl ownership from numeric storage
  sysctl: remove obsolete nr_open bound variables
  ipv6: move address sysctl context to priv
  ipv4: move device sysctl context to priv
  netfilter: move logger sysctl context to priv
  parport: move device sysctl context to priv
  net: move namespace sysctl context to priv
  arm64: move vector-length sysctl context to priv
  sysctl: remove the extra pointers and the compatibility bounds read

 arch/arm64/kernel/armv8_deprecated.c          |    4 +-
 arch/arm64/kernel/fpsimd.c                    |   13 +-
 arch/arm64/kernel/process.c                   |    4 +-
 arch/powerpc/platforms/pseries/mobility.c     |    3 +
 arch/riscv/kernel/process.c                   |    4 +-
 arch/s390/appldata/appldata_base.c            |   12 +-
 arch/s390/kernel/hiperdispatch.c              |    4 +-
 arch/s390/kernel/topology.c                   |    8 +-
 arch/sh/kernel/vsyscall/vsyscall.c            |    4 +-
 arch/x86/entry/vdso/vdso32-setup.c            |    4 +-
 arch/x86/kernel/cpu/bus_lock.c                |    4 +-
 arch/x86/kernel/setup.c                       |    3 +
 crypto/af_alg.c                               |    4 +-
 drivers/base/firmware_loader/fallback_table.c |    8 +-
 drivers/base/power/main.c                     |   21 +-
 drivers/gpu/drm/i915/i915_perf.c              |   19 +-
 drivers/gpu/drm/xe/xe_observation.c           |    4 +-
 drivers/hv/hv_common.c                        |    4 +-
 drivers/infiniband/core/iwcm.c                |    5 +-
 drivers/infiniband/core/ucma.c                |    5 +-
 drivers/net/vrf.c                             |   20 +-
 drivers/parport/procfs.c                      |   51 +-
 drivers/perf/arm_pmuv3.c                      |    4 +-
 drivers/perf/riscv_pmu_sbi.c                  |    4 +-
 drivers/scsi/scsi_sysctl.c                    |    5 +-
 drivers/tty/tty_io.c                          |    4 +-
 drivers/xen/balloon.c                         |    4 +-
 fs/aio.c                                      |    5 +
 fs/coredump.c                                 |   15 +-
 fs/dcache.c                                   |   13 +-
 fs/devpts/inode.c                             |   10 +-
 fs/drop_caches.c                              |    4 +-
 fs/eventpoll.c                                |    7 +-
 fs/exec.c                                     |   10 +-
 fs/file.c                                     |    5 -
 fs/file_table.c                               |   12 +-
 fs/fs-writeback.c                             |    4 +-
 fs/fuse/sysctl.c                              |   24 +-
 fs/lockd/svc.c                                |   18 +-
 fs/namei.c                                    |   16 +-
 fs/namespace.c                                |    3 +-
 fs/nfs/nfs4sysctl.c                           |    6 +-
 fs/notify/fanotify/fanotify_user.c            |   17 +-
 fs/notify/inotify/inotify_user.c              |   14 +-
 fs/pipe.c                                     |   11 +-
 fs/proc/proc_sysctl.c                         |   62 +-
 fs/sysctls.c                                  |    8 +-
 fs/verity/init.c                              |    4 +-
 fs/xfs/xfs_sysctl.c                           |   59 +-
 include/linux/file.h                          |    2 -
 include/linux/sysctl.h                        |   72 +-
 include/net/neighbour.h                       |    3 +
 io_uring/io_uring.c                           |    4 +-
 ipc/ipc_sysctl.c                              |   53 +-
 ipc/mq_sysctl.c                               |   22 +-
 kernel/bpf/syscall.c                          |    8 +-
 kernel/delayacct.c                            |    4 +-
 kernel/events/callchain.c                     |    9 +-
 kernel/events/core.c                          |    7 +-
 kernel/fork.c                                 |    8 +-
 kernel/hung_task.c                            |   30 +-
 kernel/kexec_core.c                           |    4 +-
 kernel/kprobes.c                              |    4 +-
 kernel/kstack_erase.c                         |    4 +-
 kernel/module/main.c                          |    4 +-
 kernel/panic.c                                |   13 +-
 kernel/pid.c                                  |   16 +-
 kernel/pid_namespace.c                        |    6 +-
 kernel/pid_sysctl.h                           |    6 +-
 kernel/printk/sysctl.c                        |   22 +-
 kernel/rcu/tree_stall.h                       |    9 +-
 kernel/sched/autogroup.c                      |    4 +-
 kernel/sched/core.c                           |    8 +-
 kernel/sched/deadline.c                       |   29 +-
 kernel/sched/fair.c                           |    6 +-
 kernel/sched/rt.c                             |   13 +-
 kernel/sched/topology.c                       |    4 +-
 kernel/sys.c                                  |    8 +-
 kernel/sysctl-test.c                          | 1357 +++++++++++++++--
 kernel/sysctl.c                               |   43 +-
 kernel/time/jiffies.c                         |    3 +-
 kernel/time/timer.c                           |    4 +-
 kernel/ucount.c                               |    7 +-
 kernel/watchdog.c                             |   35 +-
 lib/test_sysctl.c                             |  135 +-
 mm/compaction.c                               |   19 +-
 mm/filemap.c                                  |    4 +-
 mm/memory-failure.c                           |   16 +-
 mm/mmap.c                                     |   28 +-
 mm/nommu.c                                    |    4 +-
 mm/oom_kill.c                                 |    4 +-
 mm/page-writeback.c                           |   25 +-
 mm/page_alloc.c                               |   28 +-
 mm/swap_state.c                               |    5 +-
 mm/userfaultfd.c                              |    4 +-
 mm/util.c                                     |   10 +-
 mm/vmscan.c                                   |    8 +-
 mm/vmstat.c                                   |    4 +-
 net/core/neighbour.c                          |  101 +-
 net/core/sysctl_net_core.c                    |  129 +-
 net/ieee802154/6lowpan/reassembly.c           |   30 +-
 net/ipv4/devinet.c                            |   53 +-
 net/ipv4/ip_fragment.c                        |   34 +-
 net/ipv4/route.c                              |    8 +-
 net/ipv4/sysctl_net_ipv4.c                    |  408 +++--
 net/ipv6/addrconf.c                           |  163 +-
 net/ipv6/icmp.c                               |   17 +-
 net/ipv6/ndisc.c                              |    3 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c       |   30 +-
 net/ipv6/reassembly.c                         |   30 +-
 net/ipv6/route.c                              |   11 +-
 net/ipv6/sysctl_net_ipv6.c                    |   53 +-
 net/mpls/af_mpls.c                            |   58 +-
 net/mptcp/ctrl.c                              |   29 +-
 net/netfilter/ipvs/ip_vs_ctl.c                |  157 +-
 net/netfilter/nf_conntrack_standalone.c       |   45 +-
 net/netfilter/nf_hooks_lwtunnel.c             |    4 +-
 net/netfilter/nf_log.c                        |   67 +-
 net/phonet/sysctl.c                           |    6 +-
 net/rds/ib_sysctl.c                           |   23 +-
 net/rds/sysctl.c                              |   32 +-
 net/rds/tcp.c                                 |   11 +-
 net/rxrpc/sysctl.c                            |   51 +-
 net/sctp/sysctl.c                             |  148 +-
 net/smc/smc_sysctl.c                          |   42 +-
 net/sunrpc/xprtrdma/svc_rdma.c                |   39 +-
 net/sunrpc/xprtrdma/transport.c               |   27 +-
 net/sunrpc/xprtsock.c                         |   26 +-
 net/tipc/sysctl.c                             |   18 +-
 net/vmw_vsock/af_vsock.c                      |    4 +-
 net/x25/sysctl_net_x25.c                      |   23 +-
 security/keys/sysctl.c                        |   25 +-
 security/loadpin/loadpin.c                    |    4 +-
 security/yama/yama_lsm.c                      |   10 +-
 134 files changed, 3075 insertions(+), 1525 deletions(-)

-- 
2.25.1

