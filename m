Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA54F55DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625878; cv=none; b=AePYfe0DlWcgJojQ0lirFaV4lM+33uolEiiexfWyAcHgUXjImQUI6bIcVfoad9wgfoFwmrzWJRspBbMWxmbwa2VpzC3zoJh936nHoO3EDATrCQu5745Viju9nkv4tWtao0pIXsq6B9Z7g1twGH1F5U4MKwzjqnfpFbnMZN6CeBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625878; c=relaxed/simple;
	bh=mGWrvxsX8lrPlLCLyf7nQzJOfcRfXFgTzw68i6z7WBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gcpUvB7PXqDcIC+ZBwEF0XePNOZQTp+OOwn0qX5942tfddPDQGXaB962tkbEwRxdP7gmgC1GJyNsQaVcPDIqeQgA2/RqXNghOe0KBCgESuAsuZBh0ctJjVLDmNZSoWtowc7qW5Ih8Yrzivg34+iH51wH0lr+lsWxEep+hAV3Bmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfVF7kpm; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfVF7kpm"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bcdf41a3so1839945a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 13:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625876; x=1791230676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JKicZ5bi43c1yeiD8nNabIN5IXqdf1SL8KmkbB+hKXg=;
        b=hfVF7kpmu/Tm+VZaBjXyPaAg5NN1We8NItq+q/oxEFH3gr6IXc3B1r6Bcs4QZ+HSvC
         oMUCJteKfG+/SJYjeDQhaq86JM5vYkQYzqPSLtgXbt0vi5w4dqQCmhqEn4Gfqb+B8TSN
         U3M5yuK/zAw97zLZzHXRCllaBP/xuztFoMKMTa/TrNdlQZpwgWPyr4a+7mVn7O5PrpMe
         qqabcqWdJa6ks2Y0it8m05Ylajqz+O6b7vjcp41SY9hCxsCaPOZkl//4KO5uM3KhwwGd
         KkoZ0WE4p0cJNlMGfBMgZGVnmAIH1bXqh5GfXXdWimr0np7OXnM61oKDUJ3jWTUdg8CJ
         KpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625876; x=1791230676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JKicZ5bi43c1yeiD8nNabIN5IXqdf1SL8KmkbB+hKXg=;
        b=ChSjbNDK4i2POs7FOOTwMOoIq/O4+5NE0/miFBR81NYQGnCoxph+eKsINZRb87hvrv
         esdlRtdLSsBqBabZ2wyK+T4lQPQKD2EdogmjSxwuOfA79TiSdAe2Azj+vEMk0zNHnrlQ
         ZE32edbPoD1hV5cjqqUNlXK1mKjo81NHlVaB0YAfZ4Bal7H3HYkNUcBDg/5y//pSOoxt
         X2JZyK6n+rr+BVpy1w5AY/5uE4EBTBYgFN46gs6sa5jJl6v3cPdLuSjV9jBu6tQKAMZ1
         kbqHQ6foI26oZG//dC6NEjYIFDj4weFdH8F+zYOsgPlWUAAQllE2UkfkcODX20iUNG+r
         IyoA==
X-Gm-Message-State: AFq9FYITAv351mird/dpX7YzzH6xgyVNW8Z9dV+aMXp6LBdLJ3F3XXUe
	WLnAalToPj27OYUdNJ/37wRIS62suaiEwG5IZSsbgZIo484Y8sPtwrEVfQ003X0K
X-Gm-Gg: AYBFou0u/yttTAZZygCfWbXezZ1x15uFSwYboRBPNotXc1+ymME+1lyAEqPwHJ5H9MY
	i66AHkbZACHa1eSS6bX5z9+F4I4NBQvhOkzOaiIe1HlPLJ63sEau0j0vwF9BZvYYzomJoyujNdi
	0FPoTWAra403IZNRWp/cyXLh6vywXtqZPj3dfq1Z82Bd+4pr0BW9PNvPYGCMx995JtsziMyBjkP
	on2bBcTuRHHHX1m74sqByex95ziJ0Pyb/SqfAfKhdqJKTcg46v8YDkASrYXwJZxxXdKsaUBtGK9
	ZQ0OuSyyg704uaksCM8vD8fdoXoRo8yRZXzQGSXuJgiSSjdWEwkDq0NN2549ynWmbHzvaD1l7OG
	APiHLL4QtNjTtLrwcPgNgpidE2WN3vaU0dpUX8QAGBbodO3sEyqDioY1gYA2UpKepGPOKkJ2OSo
	U/55Yot0uUMDQcKaUvLqshjj16KIL6SL18e6XJO4WkdzAefpvB5xTOaTdiZa6x3srEXENxmxB0B
	93YAHO6Aed6m4POO2Kl9YRkF2CTvJFKGBE=
X-Received: by 2002:a17:90b:35c6:b0:3a4:96f7:583e with SMTP id 98e67ed59e1d1-3a496f769b1mr739588a91.60.1790625875522;
        Mon, 28 Sep 2026 13:04:35 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498057a62sm1049038a91.13.2026.09.28.13.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:04:34 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	hch@infradead.org,
	viro@zeniv.linux.org.uk,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v1 0/1] minix: unify the v1 and v2/v3 itree code paths
Date: Mon, 28 Sep 2026 13:04:25 -0700
Message-ID: <cover.1790359547.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For as far back as the git history goes and then some, minix's itree
functions have been split across three files: itree_v1.c, itree_v2.c,
and itree_common.c. The first two of these files had defines, types, static
helper functions, and some wrapper functions tailored for version 1 and
versions 2 and 3 of the Minix file systems respectively. Each of these
files then included itree_common.c.

The reason for this odd arrangement is that there are some stark
differences between version 1 and versions 2 and 3 of the Minix fs.
Version 1 has doubly indirect blocks and 16 bit block pointers, while
versions 2 and 3 have trebly indirect blocks and 32 bit block pointers.
By having the separate itree_v1.c and itree_v2.c files that then
included itree_common.c, DIRECT, DEPTH, block_t, and Indirect could be
defined differently for the two broad types of Minix filesystems while
sharing the bulk of their code because the same code in itree_common.c
would be treated differently by the preprocessor and compiler depending
on which file included it. In other words, DEPTH could mean 3 or 4
depending on if it had been included from itree_v1.c or itree_v2.c.

Christoph Hellwig theorized that minix has this unusual arrangement
because this code was written at a time when the branch predictors were
much worse than today. This makes sense to me, at least as much sense as
can be expected, and I agree with him that modern CPUs should be able to
handle a branch for the two cases lower down in the code. At this point,
the possible performance boost for a historic filesystem that is at best
unlikely to be being used in production anywhere should not outweigh the
benefits for readability and maintainability that unifying the itree
code paths would bring.

This patch was verified against the minix xfstests-dev branch[1] used
for verifying the minix iomap patches. After applying this patch, the
minix tests have the same results as the baseline: v1 and v3 outright
fail generic/472 (a swapfile test), while v2 passes. This does not
include the collection of tests skipped by xfstests because minix will
never, ever be able to pass them because of limitations inherent to the
filesystems. Functionally, the minix module is identical before and
after the patch is applied.

This file unavoidably lands as one relatively large patch, but it ended
up not breaking down well into smaller chunks that would still build a
working kernel.

[1]: https://github.com/ctdk/xfstests-dev/tree/minix

Jeremy Bingham (1):
  minix: consolidate itree* files into one itree.c file

 fs/minix/Makefile       |   2 +-
 fs/minix/inode.c        |  38 +--
 fs/minix/itree.c        | 672 ++++++++++++++++++++++++++++++++++++++++
 fs/minix/itree_common.c | 374 ----------------------
 fs/minix/itree_v1.c     |  67 ----
 fs/minix/itree_v2.c     |  75 -----
 fs/minix/minix.h        |  26 +-
 7 files changed, 702 insertions(+), 552 deletions(-)
 create mode 100644 fs/minix/itree.c
 delete mode 100644 fs/minix/itree_common.c
 delete mode 100644 fs/minix/itree_v1.c
 delete mode 100644 fs/minix/itree_v2.c

-- 
2.47.3

