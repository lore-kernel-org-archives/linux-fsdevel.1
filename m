Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693684;
	b=CBC7Bx/KN/21z48PM3anNo9rYZ1cwyenPZt+FRWxdC7cftmwzo+vH8m29ccmfvOezQuB
	 W0fz3vb3i3u5h56WEzhtwxg2L+zubnb5A9gvoaV1viqudbHnqjUZ7fD3tgl7JinEtfwqJ
	 vz918Ovw9IYQ+KKcHFpGhZQxbGoB9di4LOK0rEceKpZkuWSdmOtc98FfOmYrkxjHjYdsX
	 VT4LY2+kaUOBUDVJsVb0g+MXNdZtcRT++uHeU2yGtioRutaOeO821wtOBxJmQYRRD3g8E
	 rNXjAiafBYRdoM4SrJEwDB/LyEWW3AZj38bPUn6msDMqGdvQ25ehb9USIRTyIEllKKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693684;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=NCFWquB3oe28SyWKZ8/NdjliT0erKh0Fas52jbJwLlY=;
	b=GNYErj4meFoPHev6alHkifM4C0m7/8ft2IVFtS4bJ08vQWTn8gGBQ/2Q7mYB0PovvxP5
	 dyW6z8LJjX9ki0zJfkKrq3ObaqRI7j6l96YB4bVI2xxXrWxYj2hReeSlfgoqMDSSruoXB
	 ix3wbYVBGe3xlaBS5caC1sT7fmR1jpxbYgVOqDK5/cmiTH6QsntnwLw5+sJ6sKoWk4HMF
	 g7gDHETZbYdcSutcAIAkRRAvSIFwsaJvT4pLdWK/L9UwE647SOjXyHGwFewtztdVtqp3E
	 W7fTKQ4VVhLk3R3BL8nqYrChz5n5zabbS5CW31UHP8ewNAKyCfBhCGCdG4DrVLNHlPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEBrxnQK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC22A606A33F;
	Thu, 26 Nov 2026 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEBrxnQK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795693684;
	b=F6DsejplA/5DwSVk2L6JAYbgOBdcoIIPue9dtzmcB9t2FGRjSR5GRZhukfSkPpzUa+SM
	 vhCEk5TNNLa2x3xsq5PN5NgbX7sN7lNHKUloEAq3Z8OI8+JKbg4rbOi04L6ImO/eBA7Y5
	 xC/W6EEpMPl8cUbvB5LIMSqk4fs6C28S4xPZWu7Pgj3gFjMLhB0Cfuba/g5BfOW5CO62E
	 Gv6nT3IW+dHYY09mb4dlvUbxyD7DfpuuUKRG9H3S5zSsrutA0f9ZmBB1W5T8yQIGjbhU1
	 9KtNFem+I8gFqivQlca7NnkWmabXvtucOMVWz5PxmWLKefaeBjRWFR8qy4C2QFyHM2Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795693684;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=NCFWquB3oe28SyWKZ8/NdjliT0erKh0Fas52jbJwLlY=;
	b=NItHbANAKy9P/3nLQrz4hUvVxk1jovkDH4cuSpW6Fyl2AypqLEMla6QXwZ1e/vG3oQVX
	 GcHL8mZ781l57V5Xs25plaoRcEWMyDyQbTL9qMsP/U0Qz7mlLUtqX0Clo60sSBfSHKgV0
	 Qi9SdOOrzUtILDnZ4dvjb5cPvSMG0nSOHu3u10tMfHuGe4KEHb33hF5S0+Wwkbr4ciUjC
	 ncrkbZt6eLDVWS6lLMZPFdBoZmAnMkSYIaqpH5yYMuXj/8KaxD4pqy8OSMBbXGDMzFy8C
	 B18ZjWrr6btlmkHWYaviHOO5BPW+4zbXLGJrIf9w5WCEd+HLFCyozGlZ0vm4F1dd08g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 448EB1F000CA;
	Thu, 26 Nov 2026 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693684;
	bh=NCFWquB3oe28SyWKZ8/NdjliT0erKh0Fas52jbJwLlY=;
	h=From:Subject:Date:To:Cc;
	b=YEBrxnQKGw/NY/C3imLhcoBS9MTlvODdI5nNSLc9hkHHj181F2CcsskSexD/h6yTs
	 Ywu8uqzI15RoiOnixY3+L5WC5PvR0vJVSOcwQSPaZtth5qEy9VzRe5GLJtAwCgnWie
	 VMzGVrKNNbOkpGyKdS+aobftSatMWjWDNTUlfD2G2sdspxWIuGirxkpFu1prZUQ1aH
	 A2xdYdhqtuktZZzMfVlgVXi+659GmYB85ImW98pEKyWEPEbxnLNtrvipqhwwpHfDkv
	 8SDN5DfoDY7Ci5uL0L0S05OqcAVS7jAO10gjfeNxmXPgc57RPSUals8G429Lyao6Ut
	 kjIDvDMEFofSw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 96B884D445;
	Thu, 26 Nov 2026 11:47:52 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH RFC 0/9] sysctl: Replace ARRAY kmemdup with overlay
 mechanism for NS registration
Date: Thu, 26 Nov 2026 12:47:40 +0100
Message-Id: <20261126-lklm-sysctl-ctx-flatarray-v1-0-d7fc9cc9b03e@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFwcCGsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNj3ZzsnFzd4sri5JIc3eSSCt20nMSSxKKixErdZJMkk9REQwPDFEt
 jJaD+gqLUtMwKsNnRSkFuzkqxtbUAwslstXAAAAA=
X-Change-ID: 20261123-lklm-sysctl-ctx-flatarray-c4b4ea101d93
To: Kees Cook <kees@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, Wen Yang <wen.yang@linux.dev>
Cc: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4810;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=mlvLsVvr0QRLxxbIuMbsgLJ4Mle2Giu4L61BJM4CqCA=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGsIHGEmaQha3UXAh2NNj5bfqquUZkpFgUQba
 m83hmkTRWoB4YkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJrCBxhAAoJELqXzVK3
 lkFPz+QL/2ckQwSLe5QM0rIhD7IFmw6aOc37PQNbPQmez2tzYXRNARNFp9vxXTTNdXIyt8g1WE9
 tG4OhSp950k5JK4twRXeqYAv/MoIaA+y52ERpyAWf6s8m2UlcI6Go2pVfWYEQ35aZ4eubYMubyI
 itYXaN/PipqIS5pAGznYaNt3lOJjm4U52rM32yCgjAUYjkk/YCphjMebs67LfzXUYLipTemPHDL
 t2xKF6WvqrXjadp39tIIdPYr5wyEc1UBZAPjbFVic9nKyfNsaZZd/yvbvtGmVDkT/oTM94q+9b9
 LUc/UU/iA4FA7YD9ZnUvfH8WcmFz3A2Gqn5mk7DVZoWb+hYI5g5SKdZKxvehlkp3U1BavI2Gs5w
 vsJ/h4pZ36kYZaRmXX6GfEmPzwLavSYWoH1eYr3BzKEXfaEButg5LqjBPFlaQftCh6COikKR4M2
 nIb0K5NaHPvhl2rKfjjAl787HjNtEgCMuWvs3wKORuCQDY0ZOgsP1mKcMDZ1q3dWTqCJ4W4HXS5
 /Q=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

This is meant to replace the sysctl array duplication mechanism used by
callers that register sysctls for individual namespaces.

Instead of duplicating a sysctl array and keeping it in memory for the
life of a namespace, use it (the array) as a template and keep only the
necessary delta in a sysctl_context struct inside ctl_table_header. The
sysctl_context can then be used to overlay the ctl_table just before
calling its proc_handler.

The last 5 commits are just examples of how the conversions at the call
sites would look. The idea is to upstream the core first and then merge
each individual calling site through its own subsystem tree.

Motivation
==========

* Reducing memory footprint for namespace registrations
  On a 64 bit ARCH, memory consumption is reduced by at least 53% (this
  is a back-of-envelope approximation): from (56 * ARRAY_SIZE *
  count(namespaces)) bytes to (26 * ARRAY_SIZE * count(namespaces))
  bytes [2]; we save more, if a subset of the context is used.

* ctl_table const qualification
  Namespace ctl_table arrays that are currently modified during
  registration can be const qualified (moved to .rodata) as they no
  longer require pre-registration changes.

What was done
=============

* struct sysctl_context:
  Embedded in struct ctl_table_header, holds flat arrays indexed by
  entry position: void **data, **extra1, **extra2; umode_t
  *mode. They point to what should be overlaid.

* overlay flags:
  struct ctl_table gets a u8 flags member in an existing hole (no size
  change) with SYSCTL_OVERLAY_{DATA,EXTRA1,EXTRA2,MODE}. They control
  what gets overlaid

* sysctl template overlay:
  Add a template registration function to initialize the sysctl
  context. Overlay data from context before calling any proc_handler.
  Template registration can only be done with a ctl_table_tmpl type.

Comment on void*
================
The sysctl_context uses 3 void** because it reflects struct ctl_table.
Yes, we should get rid of these untyped pointers. No, this is not the
series that will remove them. Yes, there are already proposals out there
that are working towards this [1]. Yes, the plan is for sysctl_context's
void pointers to change once struct ctl_table's do. I thought that
resolving the pointers had to go first, but I think these two efforts
can coexist if handled separately.

Recent approaches
=================
* Alexey Gladkov's "sysctl_field" descriptors:
  cover.1787770053.git.legion@kernel.org, cover.1790439358.git.legion@kernel.org
  Which build a temp ctl_table from typed accessors before calling the
  proc_handler

* My own header-context RFC:
  20260924-lklm-sysctl-headerctx-template-v1-0-b25e51c66ba7@kernel.org
  computed .data as base + delta in the core.

This series takes the idea of building a temp ctl_table entry before
calling proc_handler, which is a commonality in these two, and drops
everything else: no network types in sysctl core, no namespace specific
enum in sysctl core, no delta arithmetic.

To and Cc
=========
I always find it challenging to know who wants to receive these e-mails.
I added you here because you have recently commented on the issue or
are in the maintainer path. Let me know if you don't want to be included
in the future.

Any comments are greatly appreciated

Best

Based on v7.4-rc2

[1] https://lore.kernel.org/all/cover.1794844686.git.wen.yang@linux.dev
    https://lore.kernel.org/all/cover.1793204511.git.wen.yang@linux.dev
[2] sizeof(struct ctl_table) -> 56 bytes
    3*sizeof(void*) + sizeof(umode_t) -> 26 bytes

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (9):
      sysctl: Add struct ctl_table_tmpl as a distinct template type
      sysctl: Add flags to struct ctl_table
      sysctl: Add overlay mechanism for flagged ctl_table members
      sysctl: Add sysctl template registration
      net: sysctl: Add sysctl registration to networking
      ipv4: Register ipv4_net_table as a template
      ipc: Register ipc_sysctls as a template
      ipc: Register mq_sysctls as a template
      ucount: Register user_table as a template

 fs/proc/proc_sysctl.c       | 362 ++++++++++++++++++++++++++++++++++++++------
 include/linux/sysctl.h      |  66 ++++++++
 include/net/net_namespace.h |  14 ++
 ipc/ipc_sysctl.c            |  24 ++-
 ipc/mq_sysctl.c             |  20 +--
 kernel/ucount.c             |  14 +-
 net/ipv4/sysctl_net_ipv4.c  | 163 +++++++++++++++++---
 net/sysctl_net.c            |  25 +++
 8 files changed, 594 insertions(+), 94 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261123-lklm-sysctl-ctx-flatarray-c4b4ea101d93

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>


