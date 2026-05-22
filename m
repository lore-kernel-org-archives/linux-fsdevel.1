Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D43AF643;
	Fri, 22 May 2026 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468281; cv=none; b=oOwTdFBTIH+kicD4cKMkweUCdfFal0SxJauLY0Bd4E4Bnz+aIwJT98fbiBn83IqLYx6L0LUXMQ5M27suPUHDVX8MiJNJc9Y3rF1ACXoK1x2tH3Io5Q2WEZeEKAbo+HOfZORWb7+gsoMYJHfybXlT5SA71Xmiw/K6rC6opQ3XG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468281; c=relaxed/simple;
	bh=2MGhO16qcgSYowhdkwytld7oWexxQ3nOy1X62h62Da0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fz6KWDHj4/iCfDuh2F+ky1DGUN1EvvrmMxlO+85ZKDpbzo0KPJtRKOmig1IF2q/fz5u34lInrlYjGyUny3Z3Uz75SSKFizwYSRPOzWUryG0knLLDlI/3P3ezInFe28htJtKHz4gwfmjraQGdMnAQcPEpyj1n35bC9RFTE3cbPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=M/xGGbww; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="M/xGGbww"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=c29kdE19tOEPt5DpIR0KQ3KOlYiiGZGY4Ypk2R7P/ag=; b=M/xGGbwwSxvHXUuJJwZHTqXsfV
	cW0jlPmTajThmEPqZYAJGrkSs8LxDN3Myj/iu5oQG80Tv6WwW08ajpUG8UbuFNFeV1b3eyBxpBg8v
	ETLsFuVVfUbjLiVUz0hi1De/VDxul28+RynHrpjok7ibsWxsIzyvfHpK2qvkX6yQKUvPQrZv+xOwN
	24GDtvQZKRLxEX3HfUoLiU2HQU+ne5kPd30uznp4YLD/etvOxObJ/nUvvi6H8IPa5IprxTblh1sf/
	wjJRm1ygTo9i5Rzpk2tIsWIspD5o8C87o9lPUIpI96Ds3zsl/7sKPi2cA4TuDQlaS1VpaofAioJMV
	p/hNJygw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQSz6-004nmQ-3A;
	Fri, 22 May 2026 16:44:31 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Date: Fri, 22 May 2026 09:44:20 -0700
Message-Id: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOSHEGoC/22NwQ6DIBAFf4XsWRogIpaT/9GYRnDV7UEJWGNj+
 PdGe+3xJfNmDkgYCRNYdkDEjRItM1imCgZ+6uYROfVgGSihKqGl5gPtz0ABub/Lyhgva4MGCgY
 h4kD7pXq0v53e7oV+Pf8nMVFal/i5Wps8uT/aTXLBnSx9XQpvtNZNj466+bbEEdqc8xfix1pes
 wAAAA==
X-Change-ID: 20260515-fix_pipe-c91677c187e7
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, 
 oleg@redhat.com, axboe@kernel.dk, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=5844; i=leitao@debian.org;
 h=from:subject:message-id; bh=2MGhO16qcgSYowhdkwytld7oWexxQ3nOy1X62h62Da0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEIfo8zzfhr7McHv3LZTjikR36X7cx1Dna3zRy
 ZXko4o3zu6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahCH6AAKCRA1o5Of/Hh3
 bSPSD/9Ul9BFfp1Qg6QngDUoc2/386KkuFkN5Pj3tLuuuzx/zsEzRhEehLFW4tC7CrmCBS2Do7z
 Y9cp+6tz4a6TGOPVl6HglhZ831urrc99CnPv4B14MsMkbteo7AjcG3ZYLNJh7PJj5rNawTkQtFR
 jEtG3MEXDC1+RfHboDi0vbW7GNK03n+rRum/vi4UEzDsGGoUUMY5tDnuPFk0GSxAIoL1Ab/eDk+
 U4wXezxp+igQ4SU+Z4D84nEVDlVwb9WaeEXpCT58atx2na22PtLcyzYgoadcMwHwH4qkuiv/IE8
 J24CvVLbNLHfp2lVI8xAErS6chok0auF50rsKhgzsqT5UjQ4Scoi0fSn1P2/pGfp6JTRKTaCxg2
 1+aerPkqxnqn/Th7+eOp3f/co1SvbNA6FED67aYYjV8gcmPRforaaR6tEdBwvia7ZBJwVCTxqbm
 3YqDJaEovkVHX2ritc5EXg4wzxHcFmIBPQz39Mk7/EAnfj6s2iKrsc9pPNcd0142WQLACM73jFW
 NlsKFh6hc6knxzVCqSwwhsiTcUySMUtVH0Cb/piGhtEoOfWKtfeZvu9+C89u6Cw/DDa2wmgwK9r
 h3aWLz8Efc7ve0bA/JZgdsHao29ZHiuP5JaWoxvTPqxiu6w0sNh6O+a0qgJPHG4QJ3XKqvUtoUQ
 6yVwWgaaxuzfgOg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

While profiling Meta's caching code[1], I found pipe->mutex contention
on the hot path. anon_pipe_write() currently calls alloc_page() once
per page while holding pipe->mutex. The allocation can sleep doing
direct reclaim and runs memcg charging, which extends the critical
section and stalls any concurrent reader on the same mutex.

This series pre-allocates pages outside pipe->mutex in
anon_pipe_write(): for writes that span more than one full page, up
to PIPE_PREALLOC_MAX (8) pages are allocated via a per-page
alloc_page() loop before the mutex is taken. anon_pipe_get_page()
then drains the prealloc array first, falls back to the per-pipe
tmp_page[] cache, and only enters the allocator under the mutex for
the leftover pages (writes larger than PIPE_PREALLOC_MAX, single-page
writes that skip prealloc, or shortfalls when the prealloc loop
fails). Leftover prealloc pages are recycled into tmp_page[] before
unlock and any remainder is put_page()'d after unlock, keeping the
allocator out of the critical section on both sides.

alloc_pages_bulk_mempolicy() looked tempting but the bulk allocator
refuses __GFP_ACCOUNT under memcg -- it returns at most one page
when memcg_kmem_online() && (gfp & __GFP_ACCOUNT), see commit
8dcb3060d81d ("memcg: page_alloc: skip bulk allocator for
__GFP_ACCOUNT"). A per-page loop keeps memcg accounting and the
task NUMA mempolicy honoured uniformly without open-coding the
charge.

I also vibe-coded a microbenchmark to validate the change. It sweeps
writers x readers over {1,2,5} x {1,5,10} with 64KB writes against a
1 MB pipe and prints throughput + latency percentiles per config.

Measured on arm64 and also on x86 using virtme-ng (16 vCPUs, 64KB
writes, 1 MB pipe). The numbers below were collected on v1
(alloc_pages_bulk()); v2's per-page loop preserves the dominant
"allocation outside the mutex" win and is expected to land in the same
range.

== No memory pressure (10s per config) ==

  Throughput in MB/s (baseline -> patched, delta):
    writers   readers=1              readers=5               readers=10
          1   1119 -> 1354  (+21%)   1132 -> 1195   (+6%)   1060 -> 1240  (+17%)
          2   1162 -> 1487  (+28%)   1034 -> 1285  (+24%)   1069 -> 1213  (+14%)
          5   1152 -> 1357  (+18%)   1021 -> 1164  (+14%)    997 -> 1239  (+24%)

  Avg write latency in ns (baseline -> patched, delta):
    writers   readers=1                 readers=5                readers=10
          1    55786 ->  46103 (-17%)   55164 ->  52260  (-5%)   58906 ->  50370 (-14%)
          2   107546 ->  84011 (-22%)  120837 ->  97206 (-20%)  116860 -> 103036 (-12%)
          5   271293 -> 230170 (-15%)  306089 -> 268429 (-12%)  313300 -> 252232 (-19%)

Throughput improves +6% to +28% and average write latency drops 5%
to 22% across every configuration.

== Under memory pressure (--memory-pressure, 6s per config) ==

stress-ng --vm 2 --vm-bytes 50% --vm-keep is forked alongside the
sweep so the alloc_page() calls inside anon_pipe_write() routinely
hit direct reclaim -- exactly the regime the patch targets.

  Throughput in MB/s (baseline -> patched, delta):
    writers   readers=1            readers=5            readers=10
          1   1088 -> 1438  (+32%)   996  -> 1477  (+48%)   989  -> 1194  (+21%)
          2   1076 -> 1378  (+28%)   1007 -> 1269  (+26%)   1018 -> 1234  (+21%)
          5   1052 -> 1311  (+25%)   986  -> 1225  (+24%)   972  -> 1249  (+29%)

  Avg write latency in ns (baseline -> patched, delta):
    writers   readers=1              readers=5              readers=10
          1    57397 ->  43406 (-24%)   62690 ->  42272 (-33%)   63136 ->  52272 (-17%)
          2   116121 ->  90700 (-22%)  124098 ->  98481 (-21%)  122754 -> 101217 (-18%)
          5   297122 -> 238322 (-20%)  316836 -> 255095 (-19%)  321496 -> 250189 (-22%)

Throughput improves +21% to +48% and average write latency drops
17% to 33% -- a noticeably bigger win than the no-pressure run.

That tracks: when alloc_page() has to dip into reclaim, the cost
of holding pipe->mutex across it is highest, and pulling the
allocation out of the critical section pays the most.

Link: https://www.usenix.org/system/files/conference/atc13/atc13-bronson.pdf [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Switch the prealloc path from alloc_pages_bulk_mempolicy() to a
  per-page alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT) loop.
- Split the prealloc work out of anon_pipe_write() into dedicated
  helpers (anon_pipe_get_page_prealloc / anon_pipe_prealloc_pop /
  anon_pipe_refill_tmp_pages / anon_pipe_free_pages) gathered in
  struct anon_pipe_prealloc, so the write path stays readable.
- Recycle leftover prealloc pages into pipe->tmp_page[] before
  unlocking
- Link to v1: https://patch.msgid.link/20260515-fix_pipe-v1-0-b14c840c7555@debian.org

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Breno Leitao (2):
      fs/pipe: pre-allocate pages outside pipe->mutex in anon_pipe_write
      selftests/pipe: add pipe_bench microbenchmark

 fs/pipe.c                                 | 105 ++++-
 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/pipe/.gitignore   |   1 +
 tools/testing/selftests/pipe/Makefile     |   9 +
 tools/testing/selftests/pipe/pipe_bench.c | 616 ++++++++++++++++++++++++++++++
 5 files changed, 729 insertions(+), 3 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260515-fix_pipe-c91677c187e7

Best regards,
--  
Breno Leitao <leitao@debian.org>

