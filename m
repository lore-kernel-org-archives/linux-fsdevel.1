Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB462931E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585309; cv=none; b=Y2qAD4RXjLHfdf52wGmjUWyJEZ4P0Ilj4s3bpwUFIwtEnfExxF9J1V7pVB7HbYK2d/dXfz6NdbwqrK7EALKoonKHNh4TjoRnti/8FINArtrYfawfx37pn2EYUmJLlQCbv5MEzSWdlUiubthn/3aP6CopV7/9BnoyuETQfD3Q7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585309; c=relaxed/simple;
	bh=s1sH/1IcCUCWkTuphEUbN/Is/vUMXm3bT7doJt8rKZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcALLlvEx9nW3k0ZwK8wNKezZFAtLT0mXCITnqCbPxDIqXDXkdGCjiHtsWIOlHbHSDorZXWAu/aWW2EbjnhLZq3+RO46Kw152Qs2m731RzaBNgXoGA8qfYp1Tv743rP2UC6j6oVO5bYYx3BxAPzaUECZLKIpyE/Q+P48l2vHy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmSUHuyO; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmSUHuyO"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so16684175e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 01:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790585304; x=1791190104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DW1aw9XilMAGHwwMkE5gUpMp3JZrQpWAH61R3Ws3XHs=;
        b=dmSUHuyO7LYFvNU6p60O9dadqqst5WT2+e8G68CWxSDA1NnzcP9OssEU9gkRR6jbh6
         rjifG3zE8DY+g+A6qJL3gHZTAdWXoZokb79xdkYUVpfEiv2YKZ2NwE0Cqhz/MBTpDFXq
         69+aNfL/Es00juBasCQ/H3Xki9y6/fGOPUYoX0UH9MBOah6NREFSPZ9ndEeQEkRyWcqs
         Qy5gT4QPJnaj+uby1BskFbCz639B2FgZ5e0AMibD04J4iw63e1GP/SUA9jzhZGFbTFF6
         WIzOWwODvRxV/aN9MnfbhBlU8GhfoTQhg88AXq4sSJ/ONUC6feXOLuoSSQgpOgkeGOto
         KXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790585304; x=1791190104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DW1aw9XilMAGHwwMkE5gUpMp3JZrQpWAH61R3Ws3XHs=;
        b=YV8cIzueC5qzMMUFhdS1XAWOGxxrpR9SJeu3BwkizUbAJAGhKO9F2DW/S46dMxGrjT
         RYfS94N0dGG7Cofs+BoB1nc9Vnz0cBvl4iDvKmedYARGBuUnqhzLfY/sCZKqlQ7qvvXn
         ZiNm5IZsShuk/oqL2srjrM8WykL1V0gUEtRU8GHJpNI1L7JIbAsmZMeDfv8FOna+qG0z
         aHKbcXu1lvr36zN8zSMVyvWcRvGQKk8O9B9+fsCWGgwdYcxKacGiGFZrYqwPf6lehfwP
         tUKFrmey1WWgIuUa4CFVoLbB1+jcOiAKMlFAhxSEbzt/3zn51pxYPf9KbE+rknhSc98K
         F27w==
X-Forwarded-Encrypted: i=1; AKwUvBynpRQ2k4ijkfBuuknLSQ24BHPpU0O9RXoNy4hgSGry7Od+PzqWi8N33RLXVbWfZvowAE+pH6V8yLjCDkDK@vger.kernel.org
X-Gm-Message-State: AFuF++nD+sXrrzfF0hARl/V/5FzZz49kcGjVV9vtYJQ76vpnQrIlbmaM
	lCWCgtZ9tcR1HDQqUnQnIH52NVLl5rP/LFYe2+GZkwI5vXdw0TWx7Dc7
X-Gm-Gg: AYBFou3iYY6aJvAUOSfLXLL5yxU/cMkod1yKK/remU9t7P8lqpSL2dssviej87dR3qH
	YV09oJqIcrZ8iWjGlZnPtAU0Nyn39L+ZHnAcFNQTXVwjLL6m6/mWp5mNKYZmhklU4eMrQPaZN/p
	gJ/T6gqcnjkABpTHXvACGnw2mabezI1RIuf3+G9jbgX82WLbB0dmIc3IO3Fot84dPeQFSHWip1e
	7SuPK57L2N3eRfUpnh8RrXjDE50KqUfFNtqkJTPVFohaNAhmXFgIQfw7756iSJgN2OLgOtSpszN
	YO8LaDPzUJ0viq4DKNXr+A6EW9ZPFzL3cE5LSHdYc3OTCodxTWA1rVGBbUOgTkfgkb4oEs7Irfk
	XT72uYZdKuX2pQSMgu28kQ/suXHECcxaSdw/PAErgP8SV1lDIF/vBt7IeMcZz3ZK2vKCXohDU+S
	zeREDztN+gkreqSeiXKzWNe7HeZ09TXpWyA1/oStHxUn76m0D7n/63Ltbrg29FyE9P8ZQH1HEkI
	v4DwCHQShxHaGmtkhswNryP4dimUiy89/Rbc7LRARzD2LW17doyHBb2qWqcw7q0iKHI+7PYBAZ9
	bLxR
X-Received: by 2002:a05:600c:3494:b0:49f:ff73:9971 with SMTP id 5b1f17b1804b1-49fff7399f4mr69817225e9.18.1790585303613;
        Mon, 28 Sep 2026 01:48:23 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017652d1sm182584705e9.5.2026.09.28.01.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:48:23 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/4] iomap: don't resubmit an ioend after ->writeback_submit() failed
Date: Mon, 28 Sep 2026 10:48:06 +0200
Message-ID: <90fbd42df4f51306e57a95830d2d53873f630eb9.1790342457.git.parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790342457.git.parri.andrea@gmail.com>
References: <cover.1790342457.git.parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap_add_to_ioend() submits the pending ioend through
->writeback_submit() before allocating a new one for the current range.
When the submission fails the helper completes the ioend with an error,
but iomap_add_to_ioend() returns the error without clearing
wpc->wb_ctx.  iomap_writepages() then submits whatever wpc->wb_ctx
points to, so the already completed ioend is submitted a second time.

For XFS the second bio_endio() lands in xfs_end_bio(), which
list_add_tail()s the already linked ioend into ip->i_ioend_list.  This
corrupts the list and leaves a use-after-free/double-free window against
the ioend completion worker.  Reproduced with a fault-injected
->writeback_submit() failure on a reflinked XFS file with several
CoW writeback ranges in flight: the unfixed kernel hits repeated
"list_add double add" warnings from __list_add_valid_or_report(),
the fixed kernel fails writeback cleanly.

Clear wpc->wb_ctx when ->writeback_submit() fails.  The old
iomap_submit_ioend() cleared the context unconditionally; that clear was
lost when submission moved to iomap_ioend_writeback_submit().  The final
->writeback_submit() call in iomap_writepages() needs no equivalent fix:
it is the last thing the function does before returning, and every
caller allocates its iomap_writepage_ctx on the stack for a single call,
so wpc->wb_ctx is never read again afterwards.

Fixes: f4fa7981fa26 ("iomap: hide ioends from the generic writeback code")
Cc: <stable@vger.kernel.org> # v6.17
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/iomap/ioend.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 7bbbb417f9152..32ae292a84cbe 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -246,8 +246,16 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 new_ioend:
 		if (ioend) {
 			error = wpc->ops->writeback_submit(wpc, 0);
-			if (error)
+			if (error) {
+				/*
+				 * ->writeback_submit() completed the ioend
+				 * with an error, so drop the stale context;
+				 * iomap_writepages() would otherwise submit
+				 * it a second time.
+				 */
+				wpc->wb_ctx = NULL;
 				return error;
+			}
 		}
 		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
 	}
-- 
2.53.0

