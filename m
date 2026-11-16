Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.160
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845275;
	b=V39BUpXn5ETjaycdteBLclFUAIonevyzGNThzhpZwjbE1yahNONZA+FoEhOMZa758Zul
	 EJauxjucTGOXMK1lqPvxxPiMfVMnGPzT70x6IKFeiVSWDadHwdVDg/DXeITFzeeg0wXYa
	 TcTg3rXQM+RSQE4v1e/w5GXJ5s+H6mUrav6J1UAouyR7xIG5psHqLMAPHZf+UGXyf4uX3
	 i7z1VjqfC/hL+nZ6RZ/+Ae6LTsl9hPNdH41Jldg8WGoHvBxo2Ib50gpN964K9ytC3eHTh
	 w2nfRGXTePsVTlxc+KRMFLGgsl6E9Z2nY9eL5duYZjM0mwYWagrn5knJ2EUjiwBsiHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845275;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=g3MIhzss8mzt7vvaQx34eU1QQkekVy7XwM3ImLiIdHU=;
	b=sg8XQhndZ0CM/lzYFQL4ii5KV4lXhueJyXvHHAo8dcGjEAIuaFXopRztzHeMEwWnCtqK
	 IQSlrKgEb/1YWX3ITajdHVcL541im2aOL0lRfBiw0UrUWrLRRHK5gmr3/GEo9yvvT61x6
	 4PLMVB9lsMxGtNI3uFdo812jR2GMJHztsHG0DvZwNgboxhoNAa0CdmmWLIoeyPmzKJBvV
	 RXVvsCLwp2klO2P1KQJruzNCAhTVDG16nAf8DIuMv12DPgI4Dr7cMghhPv4aKhLn62HHr
	 ZwlSgBbOkC46hfdgckpVUb2D6DRCVdQS6l6JyfZqvUhmZQ+WIqKx7Jsi94+wxBfTYsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XAB5N40f;
	arc=none smtp.remote-ip=95.215.58.160
Received: from mta1.migadu.com (out-160.mta1.migadu.com [95.215.58.160])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC754606A329
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 16:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC754606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XAB5N40f
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=M2zGI//Yg1vNKx0It6vDuy2OUuLLXC9VnhJk9KFe5C4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794845271; v=1; x=1795450071;
 b=XAB5N40fqj63DLyDo1NAsXTdskdS6J6L3qJr5LqZgwg/lpI1HRqy7MKB+/Fdx2Gx6McCQ8oP
 uy7ikxYV24MUknjr5ky7n8HZk8rOSMFKPl/XX3NH4r+51O6GCIGBcBh8/1qyJoNE5AtmiHtjpND
 TljfhWMxpare357FuZU/YuW0=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id a9b2173988e0f0ab;
	Mon, 16 Nov 2026 16:07:51 +0000
X-Mizu-Trace-ID: a9b2173988e0f0ab
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/6] sysctl: replace overloaded extra pointers with typed bounds and core stride
Date: Tue, 17 Nov 2026 00:07:32 +0800
Message-Id: <cover.1794844686.git.wen.yang@linux.dev>
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

struct ctl_table has long relied on extra1 and extra2 pointers to serve
multiple unrelated duties, including range limits and caller-specific
context.  This series addresses both:

1. Replace bound pointers with plain unsigned long min and max fields
   directly in struct ctl_table.

2. Replace per-entry context pointers with a core stride mechanism,
   allowing callers to register arrays of structures embedding struct
   ctl_table and recover enclosing context via standard container_of().

This RFC focuses on the core stride infrastructure and two representative
complex users (netfilter nf_log and IPv4 devinet), as suggested by Joel
Granados.  The remaining treewide callers are converted in a single
squashed commit to ensure the tree builds and tests pass cleanly.

Changes from v1:
=================
v1: https://lore.kernel.org/all/cover.1793204511.git.wen.yang@linux.dev/

1. Abandoned per-entry 'void *priv' (David Laight):
   - v1 added 'priv' to struct ctl_table, incurring 8 bytes on 64-bit and
     4 bytes on 32-bit for all ~1,000 entries across thousands of dynamic
     instances, even though <7% of entries need context.
   - Refactor: context lives outside struct ctl_table via core stride;
     callers embed ctl_table at offset 0 of their own record and recover
     context with standard container_of().
   - Cost: zero growth in struct ctl_table (56/32 bytes) and zero growth
     in struct ctl_table_header (88/52 bytes, packing u16 stride and type).

2. Eliminated slot wrappers & index coupling (Joel Granados, David Laight):
   - An intermediate prototype discussed on the list used slot-indexed
     container recovery, requiring 32 wrapper functions in devinet and 11
     in nf_log.
   - Refactor: with core stride, the core passes the exact registered
     entry pointer to the handler, so handlers use container_of() directly
     and all 43 wrappers disappear without touching proc_handler
     signatures.

3. KUnit purity & dependency fix (0-day robot):
   - Removed register_sysctl() calls from KUnit; tests invoke
     proc_handler directly so no live /proc/sys nodes are modified.
   - Added 'depends on SYSCTL' to SYSCTL_KUNIT_TEST in lib/Kconfig.debug,
     fixing undefined symbols when built as a module with SYSCTL=n.

4. Baseline rebase & conflict resolution:
   - Rebased onto next-20261111 (aaa2f954c21b).
   - Added proc_dointvec_jiffies_minmax and proc_dointvec_ms_jiffies_minmax
     to sysctl_check_table().

5. Added Coccinelle verification script (Joel Granados):
   - A 17-rule script (patch and context modes) maps all 15 SYSCTL_*
     constants through one lookup table instead of repeating two rules
     per constant.
   - Bounds that point at a variable (&foo_min, &foo_max) are left
     untouched and reported: in several callers (power/main.c, i915_perf,
     ipc_sysctl, pid, sched/rt, rds, xprtsock) that variable is updated
     at boot or at run time, so inlining its initial value would silently
     freeze a live bound.  The script also flags .min/.max fields holding
     a pointer or a legacy macro.

6. Streamlined RFC series layout (Joel Granados):
   - Reduced from 39 patches in v1 to 6 focused patches (core
     infrastructure, unit test, two complex stride consumers, coccinelle
     script.

Key Design Points:
==================

1. Zero Memory Growth:
   - struct ctl_table keeps its exact size (56 bytes on 64-bit, 32 bytes on
     32-bit). No 'priv' field is added.
   - u16 ctl_table_stride is introduced into struct ctl_table_header.
     Together with u16 type, it occupies the existing alignment padding
     hole on 64-bit (88 bytes unchanged) and keeps 52 bytes on 32-bit.
     Registration rejects stride values that exceed U16_MAX.
   - Headers are allocated once per table registration (~240 sites
     in-tree), not per entry (thousands in-tree).

2. Eliminates some Wrapper Functions:
   - net/ipv4 devinet: registers strided struct devinet_sysctl_entry,
     eliminating 32 per-attribute wrapper functions.
   - Handlers recover their context using standard container_of() without
     changing any proc_handler signatures.

3. Standalone Stride API vs. Existing _sz:
   register_sysctl_stride() and register_net_sysctl_stride() are added
   alongside register_*_sz() so existing callers remain untouched.  If
   preferred, stride can instead be folded into register_*_sz() as an
   element-size parameter (similar to bsearch()).

4. Fixes & Cleanups:
   - Fixes net.core sysctl write permissions in init_net (mode 0222 is
     now cleared only for non-init network namespaces).
   - Cleans up redundant '.min = 0' initializers treewide.
   - Provides a Coccinelle script (scripts/coccinelle/api/sysctl/) for
     automated conversion and proof of no leftover extra1/extra2 uses.

Series Structure:
=================
- Patch 1: Core stride infrastructure and numeric bounds.
- Patch 2: KUnit unit test coverage (21 tests, pure handler execution).
- Patch 3: netfilter nf_log stride migration (11 wrappers removed).
- Patch 4: net/ipv4 devinet stride migration (32 wrappers removed).
- Patch 5: Coccinelle script for detection and conversion.

Testing:
========
- KUnit sysctl_test: pass:21 fail:0 (UML).
- x86_64 defconfig build of kernel/, fs/proc/, net/ passed.
- Coccinelle: full-tree MODE=context finds 0 leftovers after conversion
  and 822 before it; MODE=patch converts the legacy net/unix table.


Wen Yang (5):
  sysctl: add numeric bounds and core stride infrastructure
  sysctl: cover numeric bounds and table containers in KUnit
  netfilter: embed logger sysctl context using stride
  net/ipv4: embed device sysctl context using stride
  scripts/coccinelle: add script to detect and convert sysctl bounds

 fs/proc/proc_sysctl.c                         |  82 +-
 include/linux/sysctl.h                        |  43 +-
 include/net/net_namespace.h                   |  10 +
 kernel/sysctl-test.c                          | 776 +++++++++++++++++-
 kernel/sysctl.c                               |  38 +-
 lib/Kconfig.debug                             |   1 +
 net/ipv4/devinet.c                            | 190 +++--
 net/netfilter/nf_log.c                        |  84 +-
 net/sysctl_net.c                              |  31 +-
 .../api/sysctl/sysctl_numeric_bounds.cocci    | 276 +++++++
 10 files changed, 1339 insertions(+), 192 deletions(-)
 create mode 100644 scripts/coccinelle/api/sysctl/sysctl_numeric_bounds.cocci

base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
-- 
2.25.1

