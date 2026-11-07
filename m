Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794086831;
	b=SF9n0VSPu/6R+wp1RAGMLI2AxDJL2DsrdyNejuV6YdrERbBGyuLYHsNUY+zNdc6piERs
	 6ntUN4Z3oLGtTeGHyyHSIZtZe3mftwMDZbUDq2/mEFaTLt/9BNogfwvnuy3PAaXxS1aIj
	 jGJxMh1EuiyYl7I79sHUcZxdtJaj0ZEvr4eblxQm9r0xrKC4JbhK0weF/RLFclnQe5XOr
	 dYXLJY7W9MO2AOK49WaqaBnMBE0T0P5ZjAU+LmKXIGWoRg8Pd/p9WDWJFgsnKx6xUHjKN
	 WdY1mdaypAPLRVxfKgC7Zvr2OXY8zRrB0K4t3oav/83VyzOvCklC5Z84TnSU/sZ3rSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794086831;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sX3gH2xgoEuu4dUy6fGw+evos/FKeYQArXF37SyCnV0=;
	b=sv3JqWHJ8BQ/LHDF8deSiE1J1Ol7wKSBBSa3MYsIuqrRrmg7cZq5kmRj5nmc9kX1vbcy
	 MTFDIUM8n0iRSMVJDaWrJCKwpNRo/bad/LoXgcNUfDMoCcj0g+TobRSbNAsOvRcXFY/0e
	 y780/LLiHuixk7KLqoxJ0y3sutUbQyJONRJaYHWtI0HsbqNB/bnpMR/la31PlPQSsidtl
	 Jtq3VMzm+QJG+NCXCQaVU0+k1PP4Wim9yk0TzP7O1jmXMyYN0c8Z0v0WWeB4LcJ8IytE/
	 B96qK4fSWp6UqDpBvl9pQJyIek5Ms91N7Cerof9R/9jdgXO+KH69a6kzcgY5rcSabjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TA4oHfqP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358EF606A326;
	Sat,  7 Nov 2026 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TA4oHfqP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114791F0089F;
	Sat,  7 Nov 2026 21:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794086830;
	bh=sX3gH2xgoEuu4dUy6fGw+evos/FKeYQArXF37SyCnV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TA4oHfqPZyHIJb/lhZU4a549bA7my/gHwYFL/t3jtBt724GkZ5tjx4SGSXdLSfAZK
	 wLcB+VpwgP4eDeOM7cN6nEeMBJm/SLF3zIL6MvFK/RHXJlb3gpaoh9/+5+T7iLn5VI
	 EKYN06W8pVMYFuVN3NcRyFaPeVatc8NSk5t2DnT/+wKJeY6kyFybM3Z5dfhRTfNgFx
	 BbZMyPblcjfhY0dJOBF9EGQ6n7xWF+x09SAxkZfcKXJ3dUryop0T8+6o58q+VATGdK
	 ntG5UNUWjHVkojXMFlL5jlpZCVpGobWYRY+/nJs8UQ7pQLGnNBdOpoiOfOAoUAKr0i
	 co5WPHNuPJYBg==
Date: Sat, 7 Nov 2026 22:26:56 +0100
From: Joel Granados <joel.granados@kernel.org>
To: wen.yang@linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
Message-ID: <au-OY8br_l6vZ30X@hobbes>
References: <cover.1793204511.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ap2rq4zenvkdp2kv"
Content-Disposition: inline
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>


--ap2rq4zenvkdp2kv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
MIME-Version: 1.0

On Thu, Oct 29, 2026 at 12:34:39AM +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> struct ctl_table describes an entry with data, maxlen and, until this
> series, two untyped misc pointers in extra1 and extra2. Those two pointers
> have accumulated at least seven unrelated jobs: a fixed bound, a bound re=
ad
> through a pointer on every call, an object or namespace pointer, a small
> integer cookie encoded into the pointer, a lock signal, NULL standing for
> "no bound", and a value the core itself casts to unsigned int while
> validating a u8 range. Nothing in the entry says which job applies, so
> readers infer it from the handler, and the core gets it wrong where it
> treats extra1 as an unsigned int.
>=20
<... snip ...>
>   sysctl: convert core table bounds to numeric values
>   sysctl: store architecture sysctl bounds by value
>   sysctl: store crypto sysctl bounds by value
>   sysctl: store device sysctl bounds by value
>   sysctl: store filesystem sysctl bounds by value
>   sysctl: store message-queue sysctl bounds by value
>   sysctl: store kernel sysctl bounds by value
>   sysctl: store memory-management sysctl bounds by value
>   sysctl: store IPv6 scalar sysctl bounds by value
>   sysctl: store netfilter scalar sysctl bounds by value
>   sysctl: store RPC sysctl bounds by value
>   sysctl: store remaining network sysctl bounds by value
>   sysctl: store security sysctl bounds by value
>   io_uring: store its sysctl bounds by value
>   sysctl: refresh dynamic scheduler and PID bounds per call
>   sysctl: refresh device-dependent bounds per call
>   sysctl: refresh namespace IPC bounds per call
>   yama: preserve scope locking with numeric sysctl bounds
>   net: refresh core sysctl limits without bound pointers
>   sctp: resolve numeric ranges from the current namespace
>   rds: preserve live reconnect limits with numeric bounds
>   ipv4: preserve live and vector bounds with numeric sysctls
>   net: refresh fragment and remaining dynamic sysctl bounds
>   neighbour: derive sysctl ownership independently of bounds
>   net: resolve sysctl owners from their backing data
>   ipvs: derive sysctl ownership from numeric storage
>   sysctl: remove obsolete nr_open bound variables
>   ipv6: move address sysctl context to priv
>   ipv4: move device sysctl context to priv
>   netfilter: move logger sysctl context to priv
>   parport: move device sysctl context to priv
>   net: move namespace sysctl context to priv
>   arm64: move vector-length sysctl context to priv
>   sysctl: remove the extra pointers and the compatibility bounds read
>=20
>  arch/arm64/kernel/armv8_deprecated.c          |    4 +-
>  arch/arm64/kernel/fpsimd.c                    |   13 +-
>  arch/arm64/kernel/process.c                   |    4 +-
>  arch/powerpc/platforms/pseries/mobility.c     |    3 +
>  arch/riscv/kernel/process.c                   |    4 +-
>  arch/s390/appldata/appldata_base.c            |   12 +-
>  arch/s390/kernel/hiperdispatch.c              |    4 +-
>  arch/s390/kernel/topology.c                   |    8 +-
>  arch/sh/kernel/vsyscall/vsyscall.c            |    4 +-
>  arch/x86/entry/vdso/vdso32-setup.c            |    4 +-
>  arch/x86/kernel/cpu/bus_lock.c                |    4 +-
>  arch/x86/kernel/setup.c                       |    3 +
>  crypto/af_alg.c                               |    4 +-
>  drivers/base/firmware_loader/fallback_table.c |    8 +-
>  drivers/base/power/main.c                     |   21 +-
>  drivers/gpu/drm/i915/i915_perf.c              |   19 +-
>  drivers/gpu/drm/xe/xe_observation.c           |    4 +-
>  drivers/hv/hv_common.c                        |    4 +-
>  drivers/infiniband/core/iwcm.c                |    5 +-
>  drivers/infiniband/core/ucma.c                |    5 +-
>  drivers/net/vrf.c                             |   20 +-
>  drivers/parport/procfs.c                      |   51 +-
>  drivers/perf/arm_pmuv3.c                      |    4 +-
>  drivers/perf/riscv_pmu_sbi.c                  |    4 +-
>  drivers/scsi/scsi_sysctl.c                    |    5 +-
>  drivers/tty/tty_io.c                          |    4 +-
>  drivers/xen/balloon.c                         |    4 +-
>  fs/aio.c                                      |    5 +
>  fs/coredump.c                                 |   15 +-
>  fs/dcache.c                                   |   13 +-
>  fs/devpts/inode.c                             |   10 +-
>  fs/drop_caches.c                              |    4 +-
>  fs/eventpoll.c                                |    7 +-
>  fs/exec.c                                     |   10 +-
>  fs/file.c                                     |    5 -
>  fs/file_table.c                               |   12 +-
>  fs/fs-writeback.c                             |    4 +-
>  fs/fuse/sysctl.c                              |   24 +-
>  fs/lockd/svc.c                                |   18 +-
>  fs/namei.c                                    |   16 +-
>  fs/namespace.c                                |    3 +-
>  fs/nfs/nfs4sysctl.c                           |    6 +-
>  fs/notify/fanotify/fanotify_user.c            |   17 +-
>  fs/notify/inotify/inotify_user.c              |   14 +-
>  fs/pipe.c                                     |   11 +-
>  fs/proc/proc_sysctl.c                         |   62 +-
>  fs/sysctls.c                                  |    8 +-
>  fs/verity/init.c                              |    4 +-
>  fs/xfs/xfs_sysctl.c                           |   59 +-
>  include/linux/file.h                          |    2 -
>  include/linux/sysctl.h                        |   72 +-
>  include/net/neighbour.h                       |    3 +
>  io_uring/io_uring.c                           |    4 +-
>  ipc/ipc_sysctl.c                              |   53 +-
>  ipc/mq_sysctl.c                               |   22 +-
>  kernel/bpf/syscall.c                          |    8 +-
>  kernel/delayacct.c                            |    4 +-
>  kernel/events/callchain.c                     |    9 +-
>  kernel/events/core.c                          |    7 +-
>  kernel/fork.c                                 |    8 +-
>  kernel/hung_task.c                            |   30 +-
>  kernel/kexec_core.c                           |    4 +-
>  kernel/kprobes.c                              |    4 +-
>  kernel/kstack_erase.c                         |    4 +-
>  kernel/module/main.c                          |    4 +-
>  kernel/panic.c                                |   13 +-
>  kernel/pid.c                                  |   16 +-
>  kernel/pid_namespace.c                        |    6 +-
>  kernel/pid_sysctl.h                           |    6 +-
>  kernel/printk/sysctl.c                        |   22 +-
>  kernel/rcu/tree_stall.h                       |    9 +-
>  kernel/sched/autogroup.c                      |    4 +-
>  kernel/sched/core.c                           |    8 +-
>  kernel/sched/deadline.c                       |   29 +-
>  kernel/sched/fair.c                           |    6 +-
>  kernel/sched/rt.c                             |   13 +-
>  kernel/sched/topology.c                       |    4 +-
>  kernel/sys.c                                  |    8 +-
>  kernel/sysctl-test.c                          | 1357 +++++++++++++++--
>  kernel/sysctl.c                               |   43 +-
>  kernel/time/jiffies.c                         |    3 +-
>  kernel/time/timer.c                           |    4 +-
>  kernel/ucount.c                               |    7 +-
>  kernel/watchdog.c                             |   35 +-
>  lib/test_sysctl.c                             |  135 +-
>  mm/compaction.c                               |   19 +-
>  mm/filemap.c                                  |    4 +-
>  mm/memory-failure.c                           |   16 +-
>  mm/mmap.c                                     |   28 +-
>  mm/nommu.c                                    |    4 +-
>  mm/oom_kill.c                                 |    4 +-
>  mm/page-writeback.c                           |   25 +-
>  mm/page_alloc.c                               |   28 +-
>  mm/swap_state.c                               |    5 +-
>  mm/userfaultfd.c                              |    4 +-
>  mm/util.c                                     |   10 +-
>  mm/vmscan.c                                   |    8 +-
>  mm/vmstat.c                                   |    4 +-
>  net/core/neighbour.c                          |  101 +-
>  net/core/sysctl_net_core.c                    |  129 +-
>  net/ieee802154/6lowpan/reassembly.c           |   30 +-
>  net/ipv4/devinet.c                            |   53 +-
>  net/ipv4/ip_fragment.c                        |   34 +-
>  net/ipv4/route.c                              |    8 +-
>  net/ipv4/sysctl_net_ipv4.c                    |  408 +++--
>  net/ipv6/addrconf.c                           |  163 +-
>  net/ipv6/icmp.c                               |   17 +-
>  net/ipv6/ndisc.c                              |    3 +-
>  net/ipv6/netfilter/nf_conntrack_reasm.c       |   30 +-
>  net/ipv6/reassembly.c                         |   30 +-
>  net/ipv6/route.c                              |   11 +-
>  net/ipv6/sysctl_net_ipv6.c                    |   53 +-
>  net/mpls/af_mpls.c                            |   58 +-
>  net/mptcp/ctrl.c                              |   29 +-
>  net/netfilter/ipvs/ip_vs_ctl.c                |  157 +-
>  net/netfilter/nf_conntrack_standalone.c       |   45 +-
>  net/netfilter/nf_hooks_lwtunnel.c             |    4 +-
>  net/netfilter/nf_log.c                        |   67 +-
>  net/phonet/sysctl.c                           |    6 +-
>  net/rds/ib_sysctl.c                           |   23 +-
>  net/rds/sysctl.c                              |   32 +-
>  net/rds/tcp.c                                 |   11 +-
>  net/rxrpc/sysctl.c                            |   51 +-
>  net/sctp/sysctl.c                             |  148 +-
>  net/smc/smc_sysctl.c                          |   42 +-
>  net/sunrpc/xprtrdma/svc_rdma.c                |   39 +-
>  net/sunrpc/xprtrdma/transport.c               |   27 +-
>  net/sunrpc/xprtsock.c                         |   26 +-
>  net/tipc/sysctl.c                             |   18 +-
>  net/vmw_vsock/af_vsock.c                      |    4 +-
>  net/x25/sysctl_net_x25.c                      |   23 +-
>  security/keys/sysctl.c                        |   25 +-
>  security/loadpin/loadpin.c                    |    4 +-
>  security/yama/yama_lsm.c                      |   10 +-
>  134 files changed, 3075 insertions(+), 1525 deletions(-)
>=20
> --=20
> 2.25.1
>=20

Do you need to broaden the To: and CC?

  For starters, I noticed that you missed Kees. Additionally, there are
  the maintainers for the files and subsystems involved that are not
  included in the communication.
  I understand that it is difficult to know who to include in the To and
  CC, but I would at least add the mailing lists of the various
  subsystems (and at least one of its maintainers).


Is there a specific plan regarding upstreaming all this?

  I'm assuming that you made extra{1,2} coexist with min,max to make the
  review easier. Right? You expect the whole series to go upstream in one
  go. right?


There are some ctl_tables that you missed.

  I see that the kernel test robot has found a few cases where you
  missed removing the extra{1,2} variables. Are these false positives?
  It is helpful to have a script that makes sure that every case is
  addressed in the series. Could you use sed and/or coccinelle to
  "prove" that all the call sites are handled?

Best

Joel

--ap2rq4zenvkdp2kv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrvl5cACgkQupfNUreW
QU/vYQv/WZrS2rKj8SmBKwD/cma7VfyTIGiOv0QoFvnSIQicen7nWmtAK0MF1hfm
aLQp+fQSjFuQCVCoVLpc4kipZxMVMIF1Hs4JKrlc5hVKYHMGJVeBa+9wmSR3ehvb
44t1BUa26EhCwsMDQAf/lp36ULb30wLxoEp6AmbexdYIz3f8oqwWk/SWkVlO2EF2
Xbwydsfskfh5Phdm8lU1P9s5bt6zuMrVTmDOlvCuElzEf+CYGHmU2/NMeKCUGMTv
CLU+iT63IWn8vfwke2sPQu6XrVnih7Ov7qbnhiQ8cVY5P6cuitvJx8ywBBGjswVy
6StHJ/r2Idf6FNZgB/Xx1xH5S3+b1T4XrqBFC+j6esBeD37L7DTCgitAn3rbj5Ha
5WxKnGYccTWdYWSGVs28IAYYxtxZn5Tsvoa1KZcu7T9VE15xnux2Yz4aBdHFttdV
jqWyw9dFR6IQdMoksEtEJBivD9/FlIkrUIKiKOEdwUSzsabie234vSdXR/Qe4NZ+
mAurunx6
=fIp4
-----END PGP SIGNATURE-----

--ap2rq4zenvkdp2kv--
