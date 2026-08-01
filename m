Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5213D3318
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621700; cv=none; b=JM3F/uR5UX7RCuVmijoKDHvq+8CVtNFyAS9udLdUMaAotoanl57iTIMlfbP9Ycvw5u4IQms+FD0QK7xsyrVhfEA/VgoYX5gZvS8jATv4Y/K0TZw8AKf9uLPezsL9n8a9okH6apy8FqPIsivZOeYxWHguHi11ODBQpiwcPOtwNnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621700; c=relaxed/simple;
	bh=/v7VBJbAb9aO5qRUONItTpWH4owbSyqDIsLqUgwMCt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epLhpg/YvTOWrUdWtk7iQoFY6NxOdnIL38cdAXzFYGAZ6srStyWV1pJcb8jQrtAiMVxpGFnD5cj2IjsXqCtXsS84XfbXlwdUoBp6sAGIxCj/4U/6okDnzfjgZEuBsSWeY7wzDMOMAGEN4anQ05hNKthsWqzjrbdgepgvzhWEaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cONoK9DE; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cONoK9DE"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81ee41aaec1so29634257b3.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621696; x=1786226496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XvLI01z2FUEK9ccgzSRudNIsKkvOOlfj4ulYih3+qTw=;
        b=cONoK9DEybQyse0MMTQ578SeX73NzsGajXVpScsaVCJ+Q1kArj6DfxOs2OefFKR2K5
         uJMfUUjnbC/vVh4s+ij14YZW41ohWsko3lGk8C16Q6ICvWjdXbC/fZZupzXFfsJA+c6Z
         o7tCP54FlCsxzO1DWuiLIvDAhEKlnlsPKfJBYkbbvC9JeNHC/7QqAAYrMPtNJXY6GrMj
         CZOPk6hpy/Ujf3U+k72bjN9mHQ7hXN7Mjk1+9ky5SfnQ0dBAKQ+RAayPm09T6WRAoa6i
         TqqKi1B1w1iG8gWtbWmvBZcvS+rv5GfHCb92w0oSCPudhnQS3MGXHCr//Ng5XGCVnuhQ
         oBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621696; x=1786226496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XvLI01z2FUEK9ccgzSRudNIsKkvOOlfj4ulYih3+qTw=;
        b=s2LLcPaI7gRqBd2hyMDnlVqSe8wtKXumvcHgE4P33W9eePgQkyZx3uBGUIlll7h5+R
         hfqV0uuxRRqLlu/7teKo0qBNll0gdOdHHPodo85uzaOA6j4wCqm0X5YZK/5pTcBonOec
         O731zXUO9N+IrAt1P+izxznP7yysDdxysuNjK7dQ11mSgYnkObFkTeXZktoweowapqCo
         2t65OSM5thaKCwM9tb2fK+ah5I0qgSRJFG2T9ZLZ+/f6iC81PWZjpB2qG4h7B9Gepqd/
         Pp/kn1JS4pEiBC0wkho/gVE15nifnPusKHQ6iCXINr3MopEMxpBt3phbutoyKzDhMDfV
         Lt1Q==
X-Forwarded-Encrypted: i=1; AHgh+RpChcsM9Vo+rrG1K8k0vFIzdaPETqTmX6VyRLQSR/uMaUQzAV75al9o+G2+J+DrynoN+ud0ldNETZoEgRcS@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfEBVaSVdQjD5DJk1khvvjxEaPKiYkGAA8agZxt4+h8a5rOOS
	YOM28uKRFI9EUXBofaIRDgAs7z890L0amZDyx/ctjyDDpVxcEkS/lrdb
X-Gm-Gg: AR+sD10Lv/kGFBmk1ebJUfSglv6DtCEqCe84aLqTq8XOYOpBcx/LaLdV9r5JzZw+bZ+
	KiEGiwkXfLSdG81UQIdUASVkgUa8e/cwSzqQw2ywzJgjjQRKOpGW3/6cs7YSRVOrEcYKFOkpfk2
	v/xo6ilnOrrM5wYK/XH3EAKWqgHpMs/nuoEh4JuqROuFmgnI06H76JK32g81dXGOxvVdWVpk3gt
	ZQouF33T4bRJkvdRh/MS/9PsEv7fjR7afZ7m9zd4ydpkKSKW9vUiDgcSMRkJz98bhM0fRqOMgec
	oqKwntRha2TBJEtuqZxEMF8h1UXwPDSxPaJ9iqA8qRe84h+PGec6rlcsnAZewZiwyZpIvte3HSS
	tEi4tgHwFD3VgS2rRfa3pRk+cAx2f9U4pauem959HUp+uBJzAOYOUsidB8tTOCXIXqTAiXQdiwk
	S4f7FE0hOQcNQDKGdxwpdvm+JyEvwvq3M7pWo9yrjQzJkbhV8yoaQYBvKinpeA8B/JuRXwP3C2q
	T6TsPudVfh2UuN9aeY=
X-Received: by 2002:a05:690c:eca:b0:7ff:87e1:34d1 with SMTP id 00721157ae682-81fd4a5a892mr78630197b3.11.1785621696163;
        Sat, 01 Aug 2026 15:01:36 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:35 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH 18/19] ext4, jbd2: report fast commit write errors with BH_Write_EIO
Date: Sat,  1 Aug 2026 18:01:02 -0400
Message-ID: <7f988ec74b5d1135d5d67771240639e57ba9e0f4.1785621505.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785621505.git.coshi036@gmail.com>
References: <cover.1785621505.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext4_end_buffer_io_sync() is the third completion handler in this
series that reports a failed write by clearing BH_Uptodate, and
jbd2_fc_wait_bufs() is the only thing that looks at the result.
Convert both.

They have to move in the same patch.  The handler lives in ext4 and
the wait in jbd2, but neither is used by anything else: the buffers
are ext4's fast commit blocks, submitted by ext4_fc_submit_bh() and
waited for by jbd2_fc_wait_bufs().  Converting one without the other
silently disables fast commit write error reporting.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/ext4/fast_commit.c | 2 +-
 fs/jbd2/journal.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 8e2259799614..8cd60c9f2272 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -213,7 +213,7 @@ static void ext4_end_buffer_io_sync(struct bio *bio)
 	} else {
 		ext4_debug("%s: Block %lld not up-to-date",
 			   __func__, bh->b_blocknr);
-		clear_buffer_uptodate(bh);
+		mark_buffer_write_io_error(bh);
 	}
 
 	unlock_buffer(bh);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 9e4cb04587b4..ffe7a22e6699 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -890,7 +890,7 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
 		 * Update j_fc_off so jbd2_fc_release_bufs can release remain
 		 * buffer head.
 		 */
-		if (unlikely(!buffer_uptodate(bh))) {
+		if (unlikely(buffer_write_io_error(bh))) {
 			journal->j_fc_off = i + 1;
 			return -EIO;
 		}
-- 
2.43.0

