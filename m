Received: from mail-wr2-f32.google.com (mail-wr2-f32.google.com [74.125.225.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1744780F
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241181; cv=none; b=Zz8FtWbz3tqLTUbbZSECwCgbf1pHG6E0QnZ47BF7A7bM3+hyXb7JeLeuQn5rGz6GKTkdN9Xy1eX3826h+Juc1riZ12sLn4M5wDQn8OmaNYnI4g2VeVn8eMbX1zJuHuRkfBZiPkA5OVb1uoEz2wxHi8CFnlSdI6MO9/En2Cr7GyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241181; c=relaxed/simple;
	bh=+hOZACThI9fTymMJZFcS53sfhvVmabkJCCIZDLXeVX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9xIk0D6uUQeB3MDtI1NETEknguXJzP2vtuTWjM0eOd/6EuruRqz/PGcl6FEQT6wtGqTa6rkKc2gaqWPAyQ0KG29YZQK3G3qc9WvRAQWP27H44njgm9HgKKSfUWerk/zlZOSv1pb70WaojfJ/dHe+XjmhFwKBXIupFnd9hZXaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRTt7MeS; arc=none smtp.client-ip=74.125.225.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRTt7MeS"
Received: by mail-wr2-f32.google.com with SMTP id ffacd0b85a97d-482f6350f91so1141552f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790241178; x=1790845978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULqy3851A4B8rk2HooNfYhmLdLyD4QbbwevT0D7ixEg=;
        b=MRTt7MeSaAaW6U7mujoM4gBZPX69ndIkCJOjsuWSbBg7SgTg5l2pQX4NLTvN18UNGV
         YGoc2YBLkUcf5uvxwxcsBGtNj6N2RRDX0wfX39pjf8UfeA+2j4KGNagUHCgQ0+EvPKbE
         xI+AkjHC4IyQl+HylGQJqK1Z/boQPiYM/9h/cqSnLNcAtSJ2198fVQE8ekSjucUvw0pb
         RiFUTO7cXLH/yTwlrOzVP8TYwIvHjQUbhntQz1Snd+bJUy01DRRh/qPxXOVaGuzDFR/a
         ELKoFmdAYHUGrEARMOIiUfViIrPUiy5IcsTPixoIv9WbqGOb/3e/o+vRhAaHHxDH0I1X
         hlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790241178; x=1790845978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ULqy3851A4B8rk2HooNfYhmLdLyD4QbbwevT0D7ixEg=;
        b=QF/Ah510+9xW96DKTCVZlpFxsobIWBdKkFBycaBQvjR+7ScePmxKQ4eTBMiwSXXPBP
         C6XMyx18WMBFnKZo4VHIrMZzX5KFQnMplMLEFdIvgWdkOM35dl2QlGUjcMqR4ZZugaOW
         XZfsKZmOADUMkgNL6b7MMEA6blw/Ugu9bZqq8eJdMEbvPwyvh8TKs2VgoqEeHGVAx/5h
         KbghN1ucHTgWmuUVJLFhf1rGWUVUTFwR0oXIoYDIUUNnh0HurmX1WKCoXtVC5d5HY5ds
         sDc1t0oVoVeBCGSkP0etcFWh/5Jl7wIHzxgkvPOLws/n50hoGUmSV0vcitmkB5OfsQVf
         jSAA==
X-Forwarded-Encrypted: i=1; AKwUvBwqRkY1cMWY8ju2kVGnk+c7HNf9d8PBfSpu124vp9cddOZBfpQ72G70Htmjs2a27OWzKt8yiq3VXWbTVJk0@vger.kernel.org
X-Gm-Message-State: AFuF++kjFZ9FQMPp0MpTZMyURR0I73Em2UQSLgYoS+UDnw1cFE4L3eOB
	GkawLTJuPFWOjLw8bjmddOpV149WfEhTircLk/IS76UI4a4fzSkn56/N
X-Gm-Gg: AYBFou3ftEB98Kj/ULC9D5d17xdqE4UOF4DymuRG0z0Bxru7bb8A/0RZYS1MNCp8wK6
	wuoy/4yx/Bjwt5eswfp/tBvEvGP75nzdS9OW+XsS/oRzLgVXkKsvKMzO9TsYG5b9daBeK/Wqbxn
	XL39iDS1EOoNuQMCRJiLrPLQT+h/hVY59j4jKI/hKPf5KBnPaE7MddCQdKMQF1IgRWBX3tFxos+
	DtLNL6NjRJev54kuFQ+cAd29XGzj4iV3kKxjoFoRYrwuQfXm/c34eEFkgJxa693iIpcO+REkL+Z
	fR0Sn8KaDAsN2NNcDVS+QiD2PkCgHKoMHUJDPSmhAIP2aySEpKbJJNepinnsmUg1fUeou+Ug/aE
	UraOHRjBhau15vQqcghqcPxH1mPizT3HSbX08qcwis/vibbz/H3qak94KuiylO7URx1RaUCtxyb
	AzENyEG/tIxhqtSVFd/AU92twC6y302VmFVgfizPI5VLwJ9TKXGTrdWUdUnl6yIzHGKsFkooOro
	WR1FXuKbCxOo9aX+iHcXx5vGW2PA7LcyY29R4OpjGf/OgnxHYsxczSz/2m0Nx885C6a6EDbjlpp
	KxiH
X-Received: by 2002:a05:6000:4012:b0:487:40d:af33 with SMTP id ffacd0b85a97d-4887171633bmr3055061f8f.13.1790241178110;
        Thu, 24 Sep 2026 02:12:58 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm12756677f8f.6.2026.09.24.02.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:12:57 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] xfs: add an error tag to inject a ->writeback_submit() failure
Date: Thu, 24 Sep 2026 11:11:52 +0200
Message-ID: <20260924091203.198225-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924091203.198225-1-parri.andrea@gmail.com>
References: <20260924091203.198225-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only in-tree way for xfs_writeback_submit() to fail is a failing
xfs_reflink_convert_cow(), which requires a shared (reflinked) CoW
extent.  There was previously no way to exercise that failure path
from userspace, which made it hard to write an xfstest for it, e.g.
for "iomap: don't resubmit an ioend after ->writeback_submit()
failed".

Add XFS_ERRTAG_WB_COW_CONVERT_ERROR to force xfs_reflink_convert_cow()
to fail with -EIO, so that ->writeback_submit() failure and its
callers' error handling can be exercised with error injection alone,
without needing a corrupted or racy COW fork.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/xfs/libxfs/xfs_errortag.h | 6 ++++--
 fs/xfs/xfs_reflink.c         | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index 6de207fed2d89..e6b0864051b0a 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -75,7 +75,8 @@
 #define XFS_ERRTAG_METAFILE_RESV_CRITICAL		45
 #define XFS_ERRTAG_FORCE_ZERO_RANGE			46
 #define XFS_ERRTAG_ZONE_RESET				47
-#define XFS_ERRTAG_MAX					48
+#define XFS_ERRTAG_WB_COW_CONVERT_ERROR		48
+#define XFS_ERRTAG_MAX					49
 
 /*
  * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
@@ -137,7 +138,8 @@ XFS_ERRTAG(WRITE_DELAY_MS,	write_delay_ms,		3000) \
 XFS_ERRTAG(EXCHMAPS_FINISH_ONE,	exchmaps_finish_one,	1) \
 XFS_ERRTAG(METAFILE_RESV_CRITICAL, metafile_resv_crit,	4) \
 XFS_ERRTAG(FORCE_ZERO_RANGE,	force_zero_range,	4) \
-XFS_ERRTAG(ZONE_RESET,		zone_reset,		1)
+XFS_ERRTAG(ZONE_RESET,		zone_reset,		1) \
+XFS_ERRTAG(WB_COW_CONVERT_ERROR, wb_cow_convert_error,	1)
 #endif /* XFS_ERRTAG */
 
 #endif /* __XFS_ERRORTAG_H_ */
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 4801361366359..104542b10d9e0 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -34,6 +34,8 @@
 #include "xfs_rtalloc.h"
 #include "xfs_rtgroup.h"
 #include "xfs_metafile.h"
+#include "xfs_errortag.h"
+#include "xfs_error.h"
 
 /*
  * Copy on Write of Shared Blocks
@@ -346,6 +348,9 @@ xfs_reflink_convert_cow(
 
 	ASSERT(count != 0);
 
+	if (XFS_TEST_ERROR(mp, XFS_ERRTAG_WB_COW_CONVERT_ERROR))
+		return -EIO;
+
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	error = xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-- 
2.53.0

