Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BC202C29;
	Sun, 24 May 2026 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779633932; cv=none; b=unaWVLDPkBx+dRGZmiWm6f/xvU+xDDyGrACeTisuzLEcAzxBFzSa4eaGwc//wq6aujS5iRCQRzY42B+36csmgiUYa3dc6uF4O79YFZfcNcjG51klU5Hc9CIc8O+7Mi5TlLNDyuO1ZiPro1jO5T3fmAvX6TmKRG/ACFrEKjEVZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779633932; c=relaxed/simple;
	bh=rWONkApBl4iPjaj77ym5rqUvBNEPepefgkjoGT2LKZw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pVhphRI8Yxd7p/of4FGESGVAKZMqRzw7vRO79449Ieg0Ju8c4S/ySKGj3Xgv5vR195xSKGdbYo9psy6cYxpFyUcT7ZUvRuQhAMA7xd+qNi2s0dMdtpHlomkABF2ot21qbJFPRPX8sGGR/HCf539IhzLmpBIh5zgG0daW/DorYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=h4/mEjXl; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="h4/mEjXl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=65dmH9apsrr2qwLbfapde2ikNHFTWEtSfoHpzQV39hs=; b=h4/mEjXlD9mzqOqnviCZbBTIjr
	m22/x3xgImZ+Ecpv+AOkOMglEUjjyupyOMZK9uCoh+vtUw21aEUIysaKPNuN9IXE/RauRAJnh8Kmv
	EsWlBycw3JKf1pdfm6RnXyeazI6rQM6Rm5ivXDI2McNpoawpXaXtj148pFgaK1vOw2E/SQULrea6z
	hbKQuXm6sB55qNBGn/0KeMHk2mqyxcrpGk4LunovlVcSb/WEYrM+lxrG/b4TEKHWE/6l3tpz//vke
	hd/QLd06xU9t8O5wi7m9knSzavETIKCAD3jKZgZ8rBj9EWEnriWC6/XpxRUa++huGxJ988zsZZLV1
	XMCQQQjA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wRA4t-000s6V-09;
	Sun, 24 May 2026 14:45:20 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Date: Sun, 24 May 2026 07:44:57 -0700
Message-Id: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkOE2oC/22NwQ6CMBAFf6XZszVtaWnl5H8YY6AssB6AtEgwh
 H83xQsmHl8yM2+FiIEwQsFWCDhTpKGHgmUnBr4r+xY51VAwUELlwkjDG1oeI43I/UXm1nrpLFo
 4MRgDNrTsqdv9u+OreqKfkp+IjuI0hPf+NcvE/cnOkgteSe2dFt4aY641VlT25yG0kLqzOphKH
 UzFBS9dlZnSOqU1/pjbtn0AK0rUne0AAAA=
X-Change-ID: 20260515-fix_pipe-c91677c187e7
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, 
 oleg@redhat.com, axboe@kernel.dk, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=6749; i=leitao@debian.org;
 h=from:subject:message-id; bh=rWONkApBl4iPjaj77ym5rqUvBNEPepefgkjoGT2LKZw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEw76dzQyC6XIcyT82dwX07MGkI6O6ZCcXVI2h
 /ddQObjJQSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMO+gAKCRA1o5Of/Hh3
 bSseEACjlYMD9gwq55RxUR1RKgm1AXH8PFAwEG67vR3zACnq+t8V8GqPuQYuvz8fvIqqV9BjEOk
 gO/nMmdtBFEg7HPXtyJJVjTbqR2BWQP1NsDwr9arY32ee8fd3HkX6ci9OLi+FJ5QxFveAo6IP7a
 ZT/Bu1SR/TVZPULb77MIEn5DCKzzdnBiCB9JJ8hSIwR9wW/MDOVgZJisza2doyhQVtB3QL30qMt
 eKSw/nRe+qZ1JYa41vgwPt5Lr7QWuZvMGK5p325ZgWYM3ZM9bNYQNt2Evlf+wCDtd50O117Nzrc
 tiUia7wMd/Atns8gYjdz108WUF4xpg6RzA+kltpO0Daz/BRcPlzR5esmBAf8FW6yHqIM9FDzLwq
 xZ3tGKmflTzSA5HxQkyEjAyrRWf7KJRZAOjW4FfqTzsJWtuZZers3av3h4TobkXjnUakwE0id2S
 GzLD1d6T0aFwjU9us6/A7Gqfx5Syui5klNsUqNJxstPRWZroHK+xLVdigwzzhbxNiCe/4x4fEjy
 Hq89lCTTtpGpEPcktRXac5AaiYCr7kqm0urQPYfwpDtTalhOKm1U9KxASPlAD2c14CTtfpLlmtk
 /apbPk0Eh3j33/bcH+w7cuwBMLA8mYaGihTKU402kZSZpyOnDVC2S47kPDPbCTuBft75nkDd7gI
 039map/6xoFsZ1A==
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
Changes in v3:
- Drop the anon_pipe_free_pages() call from the wait branch so
  leftover prealloc pages survive the wait_event sleep. The loop
  resumes once pipe_writable() becomes true and immediately wants
  pages again; freeing them forced the next iteration back into
  alloc_page() under pipe->mutex, defeating the patch for any write
  large enough to block mid-syscall. The out: label still frees any
  remainder on syscall exit, so nothing leaks. (Suggested by Oleg
  Nesterov.)
- Drop the in-loop anon_pipe_refill_tmp_pages() call in the wait
  branch as well: its only purpose was to rescue pages from the
  free_pages() above. With prealloc surviving the sleep,
  anon_pipe_get_page() drains it directly on the next iteration, and
  the out: label still refills tmp_page[] at syscall exit.
- Link to v2: https://patch.msgid.link/20260522-fix_pipe-v2-0-a8b35a78244e@debian.org

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

 fs/pipe.c                                 | 103 ++++-
 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/pipe/.gitignore   |   1 +
 tools/testing/selftests/pipe/Makefile     |   9 +
 tools/testing/selftests/pipe/pipe_bench.c | 616 ++++++++++++++++++++++++++++++
 5 files changed, 727 insertions(+), 3 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260515-fix_pipe-c91677c187e7

Best regards,
--  
Breno Leitao <leitao@debian.org>

