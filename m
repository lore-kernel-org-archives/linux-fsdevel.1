Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2510A5C613
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790486255; cv=none; b=JDLaH5RtSlJGXOBJ+CmkO8DU+WDJdGCljxKRL0iPdWuR8+44M74hF+6/M2hxQSwAXictf5dfrtTPT2FUP1Pt/0aSgBBGtqOqHs5KDFzlWrV21eXChBkPo37F9oFUeIc9IjZHnN98BIlYB/aon/8ckHrniZQaDYOCDQq9+bzkEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790486255; c=relaxed/simple;
	bh=bQMwWM6/AZ89zp7CCDYwtmkkCqgqc1BuIJtcVMvLioA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqE71v3DeDQVkqdvKw08wgWXU0NQSTa6Vs2qvYJ1JNJNYTznpx/eqTQnbzIYqsSwkE+pGPGvewuZu7vQuXSz/H5yeoZYN8iSzLiEmHYISBbXPHHBG40KWRXSxd84egRWU+QXmTyR6bFLaUz1TalqcrFSwGuH6lh5svEJ+otjWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYrZuUBy; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYrZuUBy"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso2521484eec.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 22:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790486253; x=1791091053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j+qmirMlaROvYJ+1n7dY0Ko2fZrBnqEhZBiYJG8nwEk=;
        b=AYrZuUByDcGntwb8H2fqUGlDiWsFSxg/fYoS6nxlZ1DbxlPs1L+mrCO8AMXRcQCS6I
         Y1gxLXkBIWx8dz50343c2ig4XGScL5D3ffY/HA71U3+Z6zKrxBefCyDQy0UssHokcg7D
         P81A6oBOVBhA435mAsIfM+MVdIdKBEge5XOck5Obhu/PRTbTUAiIyTOm/6Ol3FsWqVGP
         ub8DAKtU/eur1U4Kx2b+46jl8eTtWCDVv5Qa2vFnzXfWcskAptZ0oH3SRgEBApGzVerd
         54+K5pL04jMnFuG9YAa1GhQ8564aIcKRpSy7m6Q0JKrwozTMvdVYahUXGBzXGb7kNtM1
         zmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790486253; x=1791091053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j+qmirMlaROvYJ+1n7dY0Ko2fZrBnqEhZBiYJG8nwEk=;
        b=tVrqSPUlKBaXO0D4Acc4P1ngDo0eFRSH6TTuTkA6ke9Z5uW57E1dMXrH61RQBT6CR7
         V2yzemfCX6m5tRK9hG5ybG0vUbgKr9HmZCaGm7486yX1bL1WI9UKDMfSIqxPujyRcXyd
         3ap08LUq5WS72JFf+R6Jgptq+do+JhDHiR+msILSgNial9HgfVYE97olPRTsBSAIktVV
         fOhqzGKEEzPM51+U9JfHpP+EFKFhNLH4Dd3mEbDjn2oc9yj4vrYx/aCfwIYfI7Mm1Jyn
         LvqzJz/rbtdFbEjUK+3IpRrEmsx0xb2+8FDzk8AArFqa2fky6pKr1vPMJoIgSKYq5ODS
         yMTw==
X-Forwarded-Encrypted: i=1; AKwUvBxFSFxYlpyI7DC7AM5yvWX7BpHBgPbX0jCMxzfXdvX5hdH++GwhsSUc03PfucHgj/SN5ObIBKUo+vZFwHVh@vger.kernel.org
X-Gm-Message-State: AFq9FYK3bcLcrv2J1djeUxbVM2XiLGXeVHx98gWNIyhSrxhv3eySYqv/
	zbhltmkhuoeppXzs530jB+DWwedPW861/qsa5wzIHJyDS3USIb1n92u1
X-Gm-Gg: AYBFou1i2vcxFfZ59sMd7/1LEDEk0zeLHTDRAXru7LOehTv8rGgD71XUd9VgX0nkeOF
	sUvy8WNEqMZ67iNey+HCTSWEcdtclJrYzUbQ/M9NbWSbNlaLHQyKQ8rWP1hbBpL2NrJu2cHO3r9
	AMHpULz5VkNU3focqjYAZ8iFGeCgXM6FLjMb1hTbcAXafIB19D3ZW1DZAsYIv1IWGnxq6FX7kmj
	fjuMOTRtCCGCz9r+v3CpPn17llN6Qiwmi5af+CKKtg9T0MzptA4wkWsTa88ftVNcB0hrHBz8nPk
	5ki7idbme1b2QtWsAo9ipwuUvS/LW+iCMkbuARYZ7IgJlQm5Tr7Er7Behnek1EDyfOJ8cyqxYyZ
	Gzbz13nfHfFKT+6iiuQrKZ9SSIw1vDJpN1sLItc1FFl73sNgihULMZluoer+hMPtjzQn4e8DEyB
	5JgUwuOQtQTjbpMMDAwqRCuHiAYLzKt4v8oW8AzQvwWUvWx2t198JSdu1Fywt5U+EBvKsFE1GKo
	kicAeNCp23t2ocfG1Y3K/CmssxRYl1hFWMzgAhAc4sKlp80WlgndkcCUr4ZxyB+M2wIC0eB+Yms
	BwJi8t+6jH8Otd4ta7fzC04mWqp9jgHIcwETB+/RQ3wzcqJsOOsSCV0VadbVxo1E1r/GJ48I1Q=
	=
X-Received: by 2002:a05:7301:db8b:b0:33b:fe7b:460e with SMTP id 5a478bee46e88-3426febc80fmr5822057eec.7.1790486253039;
        Sat, 26 Sep 2026 22:17:33 -0700 (PDT)
Received: from FT6N242TWK ([223.181.116.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144173a2asm20713863eec.6.2026.09.26.22.17.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 22:17:32 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	Thomas Maarseveen <maarseveent@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] errseq: fix lost writeback errors in errseq_check_and_advance()
Date: Sun, 27 Sep 2026 10:47:24 +0530
Message-ID: <20260927051726.71337-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

errseq_check_and_advance() advances the caller's cursor to the value it
tried to store even when its cmpxchg() failed. If errseq_set() stored a
different errno in the meantime, the cursor holds a value that was
never in the errseq_t. errseq_set() does not bump the counter while the
current error is unseen, so recording the first errno again recreates
exactly that value, and once another subscriber has marked it seen, the
cursor's next check returns 0. For fsync() (file->f_wb_err) and
syncfs() (sb->s_wb_err) this means that a writeback error recorded
after the previous call returned is not reported. The race is rare: it
needs two different errnos, an error recorded while the check runs, and
a second subscriber consuming the value. There is no user report; it
was found with a model checker.

Patch 1 retries with the value found when the cmpxchg() fails, so the
cursor is only ever advanced to a value that was stored with
ERRSEQ_SEEN set. Patch 2 adds a KUnit case that races errseq_set()
against errseq_check_and_advance() on two CPUs.

Two behaviour changes are visible to callers, both intended. When a
writer wins the race, the call now returns the newer errno (still "the
latest error", as documented). And when two threads race on the same
unserialised cursor (syncfs() does not lock f_sb_err), the loser may
now return 0 where both used to return the error, so each open file
description gets one report.

Dependencies: patch 1 applies to mainline (fd179f8a05be) on its own and
carries Cc: stable. Patch 2 extends the errseq KUnit suite from commit
b52f5c1605f2 ("lib/tests: add KUnit tests for errseq"), which is only
in mm-nonmm-unstable, so the series is based on mm-nonmm-unstable
(e8d6475e77a7). Patch 1 could go through mm-hotfixes and patch 2
through mm-nonmm-unstable.

The bug was found with a TLA+ model of lib/errseq.c checked with TLC.
The patches were prepared with Claude Code (Anthropic), model Claude
Opus 5.5 (claude-opus-5-5).

Tested:
- KUnit on UML x86_64 (kunitconfig with CONFIG_ERRSEQ_KUNIT_TEST=y,
  CONFIG_SMP=y and CONFIG_NR_CPUS=8, run with --kernel_args seccomp=on
  --kernel_args ncpus=4). Without patch 1 the new case loses the error
  in 21,957 to 116,003 of 2,000,000 rounds (1-6% over 8 runs,
  depending on host load), in 44,886 with ncpus=2, and in 30,353 on
  UML i386 with ncpus=4. With patch 1 it loses none (8 runs with 4
  CPUs, 1 with 2 CPUs, 1 on i386). All other errseq cases pass. On a
  single CPU the new case is skipped.
- A userspace replay of the unmodified lib/errseq.c, with a hook before
  the cmpxchg() standing in for the other CPU, loses the error every
  time.
- TLC: the current code violates "an error recorded after a check
  returned is reported by the next check"; with patch 1 the property
  holds exhaustively for 2 subscribers x 3 checks and either 1 writer
  x 4 errors (1,364,445 distinct states) or 2 writers x 2 errors
  (141,055,253 distinct states).
- W=1 builds of lib/errseq.o and lib/tests/errseq_kunit.o for UML
  x86_64 and i386 without warnings, and checkpatch --strict.

Not tested: fsync() or syncfs() on a real failing device, weakly
ordered hardware (the model is sequentially consistent; the fix adds no
ordering requirement beyond cmpxchg()), and architectures other than
UML x86_64 and i386.

Shashank Mohan Jain (2):
  errseq: don't let errseq_check_and_advance() hide later errors
  lib/tests: errseq: add a concurrent check_and_advance test

 lib/errseq.c             |  29 +++++++----
 lib/tests/errseq_kunit.c | 110 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 123 insertions(+), 16 deletions(-)


base-commit: e8d6475e77a75b7a84e42c9d23e238e002f2758f
-- 
2.43.0

