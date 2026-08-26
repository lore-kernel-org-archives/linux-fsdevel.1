Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C5C47D947;
	Wed, 26 Aug 2026 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773393; cv=none; b=YoVpAm7V46gV47K7VH00YKQF0OtcpgDVPfqyYj4KLNR76lURD4i2ze5VLfMo2DGjJA8IDdOi4lK1Abp/2jTlG1Ht50f6rm0YDZhsS19Z2wgxFj4v9n8/JqBc0ekM/8kforYVHRJEEkusL+FviMO6dWazSH2DqAEYSklVSz+Egsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773393; c=relaxed/simple;
	bh=bWzGvaX3SZYFolq7qkLCxsmhPthWPmFVyUCOFWplHw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbAkWBTaCHDSWbhHxuegVk+6mTB8SCGCKiIX2n6FTxtGLbD+Iyl/OXTIwQyq1yzkrQziY8Do765XdmWy70DE2xVGxyXq74dAHepC344QxAxW6pKPYBaHqn9xDaCg3XcCnAVT23c7QJ6X9mbYIJURYnEag2Q5vc3YIUXGp2cBhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2j2F5J+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2j2F5J+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B051F000E9;
	Wed, 26 Aug 2026 19:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773379;
	bh=kv7Awx2z94x0IGIpPwxYc/jiRFav1UCf39sBeKTilF4=;
	h=From:To:Cc:Subject:Date;
	b=V2j2F5J+ObzXRsdK8wgnLTEg9/nQqPLktbo/lgGF9baeLVxkeZh9cGvX+yKLFXvBK
	 AQi0sBRglnKlMHGKs3Rp2h5e3KaBlbbbyTNjlAN9SdXfmVM3zBgV9iCIy+XDO9UD2F
	 N/AmZGXzmxXpC47Yw7cuxY7A4rSUILiHfdQcLvWGe1WJ/FYQ0qMYxIKxtyPwkX4h6X
	 PkBTvqguPGYIvD0Xdk/SGXCD7ZDZAquztdEVqp+at/Uis6fbDUJN0rQSeRaLqPUqlZ
	 qTN/DGU3Th5A9g0FhNupLZLtKHoGQ3ssdBK+XY4F6vfiUhsxO5UU9Js3aelmNwEE4t
	 pp8Mb1JOMziMQ==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 00/30] sysctl: add context-bound field descriptors
Date: Wed, 26 Aug 2026 21:42:04 +0200
Message-ID: <cover.1787770053.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A few years ago Linus didn't like an IPC sysctl conversion which copied each
table and rewrote its entries for every IPC namespace [1]. I remembered that :)

After that, I tried creating a different API to avoid allocating tables [2], but
nobody really liked that interface either.  The discussion also pointed out that
a new interface should use self-describing, properly typed pointers rather than
adding more void pointer conventions to ctl_table.

This series is another attempt to address the underlying problem.

ctl_table works well when one static entry contains all the pointers consumed by
its proc handler.  It cannot describe a static set of sysctls whose data or
limits belong to a namespace, device, or another object selected at registration
time.  Such users commonly duplicate an otherwise static table and patch data,
extra1, extra2, mode, or proc_handler before registering it.  Some do so by
table index, making the fixup code depend on the exact ordering of a separate
descriptor array.  A table edit which misses the corresponding fixup can
silently bind a sysctl to the wrong value or limits.

The new API separates an immutable sysctl description from two levels of object
binding.  One struct sysctl_context belongs to the registration as a whole and
holds the namespace or other objects shared by the entire field array.  Each
struct sysctl_field then has accessors which derive the data and limits for that
particular entry from the shared context.  Resolved pointers therefore do not
have to be stored in a private copy of the descriptor array.  The typed field
variants also tie accessor return types to the standard proc handler selected by
the core, allowing the compiler to catch mismatches before a compatible
ctl_table entry is constructed.

The base context contains a union of typed namespace pointers.  It can also be
the first member of a subsystem-specific context, for example:

  struct mpls_dev_ctl_context {
          struct sysctl_context context;
          struct mpls_dev *mdev;
  };

The whole object is copied into the ctl_table_header allocation at registration.
An accessor which needs mdev recovers the enclosing object with container_of(),
while ordinary per-net accessors use ctx->ns.net_ns directly.  This keeps
subsystem-specific pointers out of the generic context, avoids an untyped
catch-all pointer, and gives the copied context the same lifetime as the
registered sysctls.

sysctl_field is analogous to ctl_table, not a replacement for it.  Existing
users are unchanged.  The sysctl core stores either descriptor type in
ctl_table_header and materializes a temporary ctl_table when entering the
existing proc handler, permission, or BPF interfaces.  This preserves those
interfaces while allowing converted users to share one static const field array
across all instances.

The remaining patches convert the dynamic users which motivated the API,
including ucounts, IPC, PID, networking, neighbour tables, and parport.  The
conversions remove per-instance table clones, offset and index fixups, and the
matching lifetime bookkeeping.  The series deliberately leaves ordinary static
ctl_table users alone.

Reducing memory use is a secondary result rather than the main reason for the
change.  I measured active kmalloc slab usage after creating N namespaces with:

  for i in `seq 1 N`; do
    unshare --ipc --mount --net --uts --user --cgroup --time --pid \
      --fork --kill-child --map-root-user /pause &
  done

N           Unpatched     Patched       Saving           Per namespace
100           8.51 MiB      4.80 MiB      3.71 MiB       38.00 KiB
500          73.78 MiB     55.13 MiB     18.64 MiB       38.18 KiB
1000        167.15 MiB    128.53 MiB     38.62 MiB       39.55 KiB
2000        358.81 MiB    284.55 MiB     74.27 MiB       38.02 KiB
5000        942.12 MiB    754.10 MiB    188.01 MiB       38.50 KiB

At 5000 namespaces this reduced the measured active slab footprint by
188.01 MiB, or about 38.5 KiB per namespace.

[1] https://lore.kernel.org/all/877d8kfmdp.fsf@email.froward.int.ebiederm.org/
[1] https://lore.kernel.org/all/cover.1654086665.git.legion@kernel.org/


Alexey Gladkov (30):
  proc: sysctl: address table entries by index
  sysctl: add unsigned int limit constants
  sysctl: add typed field descriptors

The first three patches introduce a new interface, while the rest convert all
dynamic ctl_table allocations to the new interface. Without them, it was hard to
understand what was needed from the new API.

  sysctl: use sysctl_field in ucounts
  sysctl: ipc: use sysctl_field in mq_sysctl
  sysctl: ipc: use sysctl_field in ipc_sysctl
  sysctl: use sysctl_field in pid sysctls
  sysctl: net: use sysctl_field in unix sysctl
  sysctl: net: use sysctl_field in xfrm sysctls
  sysctl: net: use sysctl_field for simple IPv4 per-net sysctls
  sysctl: net: use sysctl_field in IPv4 sysctls
  sysctl: net: use sysctl_field in IPv6 xfrm sysctls
  sysctl: net: use sysctl_field in IPv6 fragment sysctls
  sysctl: net: use sysctl_field in 6lowpan fragment sysctls
  sysctl: net: use sysctl_field in vsock sysctls
  sysctl: net: use sysctl_field in MPTCP sysctls
  sysctl: net: use sysctl_field in SCTP sysctls
  sysctl: net: use sysctl_field in core IPv6 sysctls
  sysctl: net: use sysctl_field in net core per-net sysctls
  sysctl: net: use sysctl_field in SMC sysctls
  sysctl: net: use sysctl_field in VRF sysctls
  sysctl: net: use sysctl_field in RDS sysctls
  sysctl: netfilter: use sysctl_field for per-net sysctls
  sysctl: ipvs: use sysctl_field for per-net sysctls
  sysctl: bridge: use sysctl_field for br_netfilter sysctls
  sysctl: net: use sysctl_field for MPLS sysctls
  sysctl: net: use sysctl_field in IPv4 devconf sysctls
  sysctl: net: use sysctl_field in IPv6 devconf sysctls
  sysctl: net: use sysctl_field in neighbour sysctls
  sysctl: parport: use sysctl_field for dynamic sysctls

 drivers/net/vrf.c                       |   43 +-
 drivers/parport/procfs.c                |  317 ++---
 fs/proc/inode.c                         |    2 +-
 fs/proc/internal.h                      |    2 +-
 fs/proc/proc_sysctl.c                   |  603 ++++++---
 include/linux/parport.h                 |    6 +-
 include/linux/sysctl.h                  |  283 +++-
 include/net/ip_vs.h                     |    3 -
 include/net/ipv6.h                      |    6 +-
 include/net/neighbour.h                 |    1 +
 ipc/ipc_sysctl.c                        |  256 ++--
 ipc/mq_sysctl.c                         |  100 +-
 kernel/pid.c                            |   41 +-
 kernel/sysctl.c                         |    3 +
 kernel/ucount.c                         |   83 +-
 net/bridge/br_netfilter_hooks.c         |   99 +-
 net/core/neighbour.c                    |  329 +++--
 net/core/sysctl_net_core.c              |  241 ++--
 net/ieee802154/6lowpan/reassembly.c     |   84 +-
 net/ipv4/devinet.c                      |  258 ++--
 net/ipv4/ip_fragment.c                  |   96 +-
 net/ipv4/route.c                        |  102 +-
 net/ipv4/sysctl_net_ipv4.c              | 1622 ++++++++---------------
 net/ipv4/xfrm4_policy.c                 |   52 +-
 net/ipv6/addrconf.c                     |  746 ++++-------
 net/ipv6/icmp.c                         |  127 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c |   77 +-
 net/ipv6/reassembly.c                   |   77 +-
 net/ipv6/route.c                        |  173 +--
 net/ipv6/sysctl_net_ipv6.c              |  322 ++---
 net/ipv6/xfrm6_policy.c                 |   48 +-
 net/mpls/af_mpls.c                      |  154 +--
 net/mptcp/ctrl.c                        |  205 ++-
 net/netfilter/ipvs/ip_vs_ctl.c          |  533 ++++----
 net/netfilter/ipvs/ip_vs_lblc.c         |   49 +-
 net/netfilter/ipvs/ip_vs_lblcr.c        |   50 +-
 net/netfilter/nf_conntrack_standalone.c |  743 +++++------
 net/netfilter/nf_hooks_lwtunnel.c       |   40 +-
 net/netfilter/nf_log.c                  |   90 +-
 net/rds/tcp.c                           |  129 +-
 net/rds/tcp.h                           |    1 -
 net/sctp/sysctl.c                       |  505 +++----
 net/smc/smc_sysctl.c                    |  208 ++-
 net/unix/sysctl_net_unix.c              |   48 +-
 net/vmw_vsock/af_vsock.c                |   91 +-
 net/xfrm/xfrm_sysctl.c                  |   77 +-
 46 files changed, 3964 insertions(+), 5161 deletions(-)

-- 
2.55.0

