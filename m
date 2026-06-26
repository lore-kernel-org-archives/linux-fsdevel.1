Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BCC3EDE68;
	Fri, 26 Jun 2026 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469614; cv=none; b=QZLplTrWaDSJYmBq/SGE4obncITJbw9PPU387idiL9RWlNNvAOr/iggvWT1yoYmaOMbTBH5OzIe/F4VhHVg6fy2+kHGHgYTRyzghl2qsBAMZEy0YHP2BQrsST2GvKkirYPV3fcDa6ARtKoNCiR7FPoKYFOOFsLiLM5zIAmFIuaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469614; c=relaxed/simple;
	bh=bOajw6iIgMGainGbnXLTRmpSSsucqM5UsqIcALhUlSs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XNiSS1sSM1alEw/73PBVbeOSA30xeW5brLSz/GEXrGQnWtss6AEIE1UUIc02lZutlaAS56wJNRmnk6vdsOO4knbPZZcKpJxb+fLBAFhdxRH2EBCnvDDC7o+h1Lw6nIPEKH5x2972inrKZ7UO5wKQqCGTKoEZvE3n7ODfbfiiKv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=YJeg4Gp4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="YJeg4Gp4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=eVNFozF8mqAS0n3p3ovWop+lEEA/+9lzXnvwfYxGwWE=; b=YJeg4Gp4GeYh2KgxnelX9+rClP
	iESDrDF0hrvXr/TKwXeme9aNfmVdRqkRoCy0hyS8EhZsxSJsleXpnQqo7AfPVo9coX7kMUdZ+L/ft
	eXyngGq8hWUzPKQMQil25GfZQkIFCkhcjI8lUAR406a6Sh/6UIe+GsQDi2fP/VavugqpEiz/6qqPe
	bGcgUMgocB/pAksUpDayZ6mqcIT4PMq11HAFLph55KaQAPJj3PYpy9TpRA75MttxyioAtPv67C77v
	qwz2eyGvKUkqQfHwOiMYvsPgy+fih2svJ/3ayyLFLL64wV0i4mMOowON1hctLqGtynZR1h2jG+ePW
	MKIBJRnA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd3ld-003u09-1j;
	Fri, 26 Jun 2026 10:26:37 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH RFC 0/4] fs/pipe: unify the page pools into a single
 per-pipe pool
Date: Fri, 26 Jun 2026 03:26:29 -0700
Message-Id: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANVTPmoC/x3MQQrCMBAF0KsMf92BGkwr2QoewK24SNqp/k0aE
 hWh9O6C7wBvQ7NKawiyodqHjWtGkEMnmJ4xP0w5Iwhc74Z+cF7TUQuL6Ttz4RRfXLPGFMd08s7
 PNqITlGoLv//1huvljPu+/wCniZVjagAAAA==
X-Change-ID: 20260625-b4-pipe-unification-aba7b8525de7
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3774; i=leitao@debian.org;
 h=from:subject:message-id; bh=bOajw6iIgMGainGbnXLTRmpSSsucqM5UsqIcALhUlSs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPlPZwBrzlNGRrHoCHG4pBNMS1xZM2tq0Arq7H
 nQCyalrPZqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj5T2QAKCRA1o5Of/Hh3
 beMjEACstl6iGyqeWSwbYadqrt6Ct6ktpbeQ3eZSdMPyc7nr22NWjN/0hVLdZlrVq3H4SU2eEU/
 jO344Xs8lP8TQGQFRFBKzXQPXn+EHMPA7Mel1sT28OyF+r86dIKB1U6pzA/DTwaF1Q8E6hMVPEp
 icRfsu5/RXiApkyzQa1Cop7YpZMT6xiiPl5OdV4EmlxLErbGUycIY3DeG+0a2piWFE422wp5vMC
 WiT3BsUec8p+0mYBjc/mGFnp46n9QpDzkzieF2cYPQEueyLjEMD4qOXXmxIVIvQ9ZDSbQhaMXgu
 TkNR5WH7TP3CuwLx4mJBX/XbfUTn38uAzHDTH0uijj7gadh6XR1bYtAg6PbA4cgpfIZERGtKc5i
 78tV2JELRRADUZlZs/HERnd42P/oD/Dld9WiEsEPa+J6lcl0d0g8RRW26WOFQRAtT/CRZ5OrPir
 DvqS72jn9Y83IGDsPZlsTpiDhBcw6MQSSuTYG5avkE5K8tHO8IRCES90oPi3o9a5+Yrlfk78EaT
 62XHUp7XvSoQoWeQglMd+BujbszIrgOGhUPY73bLL5CLgngNFHcoYEliCvqYykFxTwQyDBX9gU3
 jeO4KK8AHXe2EzEkawRcV6VebmdAauI9BxPHi8Sizk1MMBDHZzOsS2dV7bXs5HeQgC1+1m1kw+B
 q/Lx3XPq9pFfedA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

TL;DR: This simplifies the pipe code, unify the page pools, reduce the
code by 11 lines, and improves the microbenchmark by up to 23% — so it's
probably wrong (!?).

Summary:
=======

I've spent some time converging tmp_page[] and the on-stack
anon_pipe_prealloc pool of pages into a single per-pipe pool, as
discussed previously in a few places, most recently at:

https://lore.kernel.org/all/ajLA_zxsYyKISkwp@redhat.com/

Problem:
========

1) We have two types of page caches in the pipe mechanism today
   * tmp_page[]
   * anon_pipe_prealloc

2) they operate in different ways:
   * tmp_page[] is protected by the pipe lock
    *  per-pipe, persistent, 2 pages
   * anon_pipe_prealloc is an on-stack pool, not lock protected
    *  burst, up to 8 pages

Proposal/Design:
================

1) Keep the same page budget as today
  a) up to two per-pipe persistent pages
  b) burst of up to 8 pages

2) no pages are allocated unless necessary
   * Pages are _ONLY_ allocated based on the length of the write,
     minus the pages already available in the pool.
   * No page is allocated but left unused

3) keep allocation and freeing outside of the lock
   * only the assignment of pages stays lock-protected
   * Currently, tmp_page[] pages are allocated in the lock, so
     this patch will improve it (thus the performance numbers)

How:
====

1) replace tmp_page[] with anon_pipe_prealloc in pipe_inode_info
2) at write (anon_pipe_write), allocate the pages outside the lock in a helper
   called anon_pipe_prefill()
   a) the assignment into the pool must be lock protected
      * anon_pipe_prefill() does it
   b) anon_pipe_prefill() can populate up to PIPE_PREALLOC_MAX pages in the
      pool
3) once anon_pipe_write is done, the pool is trimmed back to at most
   PIPE_PREALLOC_KEEP (2) pages by anon_pipe_trim_pool()

Testing:
========

Tested on a bare-metal Intel(R) Xeon(R) Platinum 8321HC (52 CPUs) using the
pipe_bench selftest (tools/testing/selftests/pipe/pipe_bench).

Two kernels were built from the same configuration (no debug options),
differing only by this series:

  - baseline: on-stack anon_pipe_prealloc pool + tmp_page[]
    Commit 4e5dfb7c84012 ("Add linux-next specific files for 20260623")
  - patched:  this series (unified per-pipe pool)

Each kernel was booted on the same host and benchmarked with 5 writers /
5 readers, 64 KiB messages, 5s per run, with and without memory pressure
(stress-ng --vm 4 --vm-bytes 80%). Comparing writes/s and average write
latency:

  - no memory pressure:    ~+11% throughput, ~-10% avg write latency
  - under memory pressure: ~+23% throughput, ~-18% avg write latency

The improvement comes from the larger persistent cache (up to 8 reusable
pages vs the old 2-page tmp_page cache), which reduces alloc_page()/
free_page() traffic; the effect is largest when reclaim is active.

Future:
=======

If this approach is accepted, we could keep all allocated pages in the pool
and rely on a shrinker to trim it under memory pressure.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (4):
      fs/pipe: make the prealloc pool per-pipe infrastructure
      fs/pipe: add per-pipe pool push, prefill and trim helpers
      fs/pipe: switch the write path to the per-pipe pool
      fs/pipe: remove the old on-stack prealloc helpers and tmp_page[2]

 fs/pipe.c                 | 162 +++++++++++++++++++---------------------------
 include/linux/pipe_fs_i.h |  21 +++++-
 2 files changed, 86 insertions(+), 97 deletions(-)
---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260625-b4-pipe-unification-aba7b8525de7

Best regards,
-- 
Breno Leitao <leitao@debian.org>

