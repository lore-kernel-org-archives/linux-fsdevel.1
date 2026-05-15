Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A563D1A9A;
	Fri, 15 May 2026 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840943; cv=none; b=GyUohQNJeHWoVIsY+ZUBs7o/cbjGhv2djhlO72aP/eEVFblUfPg+RaWHAtuAtoLZuDVBw7iQtkqfa4sTwZoLXtCvrSHjZstKbS/k4chvmc4O+63BkSQLnpb5RqNqtvd/ZYPpBN9W5HTlft0RMk6Lg/U3Yva5DeSWTcqqKCzrvYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840943; c=relaxed/simple;
	bh=q2o9jgSNyuYPzly0nCT/XLRu8nBus4GRiO8EciABiP8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AfKrEU2WFmYuYO9fJRiwEoSTDYuMeaTEx9rQerL5rLCeKXj8C0d1RzlH8ww7vNyiOfKDp4ZvQNEBstd+nWlEvA6+mwxrN3IsHFm7q9q4EFtpxgeD+B5WNZ7497w9p3FNGHUQfM7Ol1dIRC/eFedIDz069TvTad9yvrCo0UFnthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=iRnpxd+T; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="iRnpxd+T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=L/nYxV95FX7ES4SL/Qq7xlGA3XClDJwVpRV4zHEUrE0=; b=iRnpxd+TdBoKW3vZBf9UU1Rctg
	AvA6UVzdBPvMOP99c+peTc/by3iSheTQfcV9H8pgIDtTOXTQT34UEbRUv1qt1a3mtfECrmGNeXZ3O
	g+IdL5/xhHRsctpV6H+nixGv3oohy+2Ks0xysOI+D0GvdCRV0qQtWNcOu0o+pbW84C9GWZxclxzTX
	sUGrWzqu+YHTSoD+a7B768bcHGrr2C+gDdjmOBvXaewxULzCih8u9fj1IpDJztEL7LzPEVEungy+a
	CxUG60KLMNYxZJih5OIMX8OXze1dzbhGG6FFRoEP8C1R+RtNU2owl54Kf4ExVS7u+hTJCywMLaO8K
	N3LDnJNA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNpmp-004fTS-13;
	Fri, 15 May 2026 10:28:56 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/2] fs/pipe: reduce pipe->mutex contention by
 bulk-allocating outside the lock
Date: Fri, 15 May 2026 03:28:43 -0700
Message-Id: <20260515-fix_pipe-v1-0-b14c840c7555@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFz1BmoC/yXMQQqDMBBG4asM/9pAImhqriIibTq240JDoiUQc
 vdSu3yL7xUkjsIJjgoifyTJvsGRaQj+fd9erOQJR2h12+vOdGqRPAcJrPxgemu9uVm2aAgh8iL
 5Wo3Tv9P5WNkfP49av4XLYolsAAAA
X-Change-ID: 20260515-fix_pipe-c91677c187e7
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 usama.arif@linux.dev, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4165; i=leitao@debian.org;
 h=from:subject:message-id; bh=q2o9jgSNyuYPzly0nCT/XLRu8nBus4GRiO8EciABiP8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBvVixZflaGpM36w7fVPS2wgS53pKnlLbstfSZ
 nIUfeYc512JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagb1YgAKCRA1o5Of/Hh3
 bWVdD/9U7suOdLRHi2NK2+jhadxzdjKCc2V3e5NHz/VUQxbQcIpoD9Us4l+gQtiqRYSJpVQ6hRR
 hy/niqZ3TFYUAz89IXIVZ2R3np8QtlZ1Y8TPQy2dosyB9ABBDfTPWHT7t+kzcUR9ZMUASR80aj2
 CggD2968vouqJyxl1kgJURC0wFGXFJp9lFi1PVbeLHQDBdw69QRvIf/haFs2Esu6MQ5LHpI0gLW
 OBPU4LIBicvq+fKYjB9AvPQFHqsiUl35uAvXD6UkxjxD1TrICTOlvv3iKN6oia8ZTj9C0pyrKyq
 yaqmIepHkzh/3w1IlQw+fxjE+U4EW5UdSPpQTQE6bT/lTBQxPPNhPQ95mWWp6tf0IR4xl+gS/X/
 ffHXtizjTEHUUc916JqhQhjxChFQNI7EzYTcavB+SVegIxMG7tzVMLPgFpc3/I+513iIYwt7Gc9
 QP2S2z3hAe7qRYhrMvjKspNMU9Vy0rXZeQoNhaoH3zRgtbnRrrihIX3a4LnLAgx6VULmAFx59sr
 xhIzFQJVjFGpUqR+m97KN9C/qDCPEgnuOE/4e9Ao7bQPBNLmZaQa9ToJruVnoH0smgDnmtETvWD
 p7PmLM7cWtWuJYHwuh20FZ0e37yPuMxe5jeePJyy792CLNWhyiDJVNn3624/OAtbYo+dF9MWssa
 0APOGcRpT2LXLfA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

While profiling kernel code on Meta's caching code[1], I found some lock
contention on pipe hot path, and I decide to investigate, and found that
anon_pipe_write() currently calls alloc_page() once per page while
holding pipe->mutex. The allocation can sleep doing direct reclaim and
runs memcg charging, which extends the critical section and stalls any
concurrent reader on the same mutex.

I would like to propose that we bulk pre-allocate pages outside
pipe->mutex in anon_pipe_write -- pre-allocates up to PIPE_PREALLOC_MAX
(8) pages with alloc_pages_bulk() before taking the lock

 * the get-page helper then consumes from tmp_page[] / the prealloc
   array first and only falls back to in-lock alloc_page() for writes
   larger than PIPE_PREALLOC_MAX (8) pages, which is rare.

I also vibe coded a microbenchmark to test the pipe benchmark. Basically
it wweeps writers x readers over {1,2,5} x {1,5,10} with 64KB writes
against a 1 MB pipe and prints throughput + latency percentiles per
config.

Measured on arm64 in virtme-ng (16 vCPUs, 64KB writes, 1 MB pipe).

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
Breno Leitao (2):
      fs/pipe: bulk pre-allocate pages outside pipe->mutex in anon_pipe_write
      selftests/pipe: add pipe_bench microbenchmark

 fs/pipe.c                                 |  40 +++-
 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/pipe/.gitignore   |   1 +
 tools/testing/selftests/pipe/Makefile     |   9 +
 tools/testing/selftests/pipe/pipe_bench.c | 351 ++++++++++++++++++++++++++++++
 5 files changed, 400 insertions(+), 2 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260515-fix_pipe-c91677c187e7

Best regards,
--  
Breno Leitao <leitao@debian.org>

