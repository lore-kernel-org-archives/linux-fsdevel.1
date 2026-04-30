Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC734405B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777527414; cv=none; b=mR16iygZGjKA7vHsRj/QEsuq25I/a+La7VrPLlsrP2KHRKootmNc4Ekq8ns/inyH3tV3mCwpKwjR8Y0UFrRW9LmdEepMc+XThu3AEua1KqvSstz2S3gUdwAgCmLnVrNB/IqBwq9KuTu0EDWsS+6w9JsEgSTmFUFwo4+mTdI4VFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777527414; c=relaxed/simple;
	bh=mdtDdNY2h3DBj2KnBEOFyjFZNYUhiPcjox3rvAtufTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDyZ6+FR4WMAZY8w/RRn2mePj7N61+ZlRlUMtSJ2zPaMhltWnlzFxD1dOFiPty/fLzh/BAR59SAc7WbH3vgH5pCh4Stnhyz0imO2sjYjJNdujoP92Idjx4B5yWOhLe5a+g2nzWirbCAd7aqAcjv4KCKRtBB0vWskTB8yJPzWws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkL2o/qd; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkL2o/qd"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9567aa1a047so193111241.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777527412; x=1778132212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ocQlHHH1wPEO06aL5OauXm+y1fwgshk6cQ3uJMAxoO0=;
        b=BkL2o/qdTUsp/uqx+zLk7ID3+ABFCEcuE0XNvGSb551w5qwENbJm1dCNwhFDWJ7xIE
         PobWRsQLloR8RNZzcvqzHDCVNonEdIaJTBFKKxZFIjcT1+Ourm/ef+985A2CV3zYMP2E
         s8BYH40xrGB0HoAETulpNdsIgjNnLm4aCvWZ4mF4uVprGdzBexKUWpgzdWC9sAU95LbC
         7fYwA3lRJitFQkKQcQdSyQVNiyG8EkcBwJ4ppR4810382XzRi3hbpVjF1E50Ujhxtd2n
         1sYlfhFnR/nyjK9BaRIwj7V5joJk9xoH0VxEsLNWoYLYpe58w4HiTFnlr1t4uqFxpK0d
         OHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777527412; x=1778132212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocQlHHH1wPEO06aL5OauXm+y1fwgshk6cQ3uJMAxoO0=;
        b=io+OgQ1X7Fs7uV1jNvMmLTG6s88VRVQAK+3mpwm3/l8L8PGFRbZH0if83JWL5urvwp
         UMkmH5/qNA1FizM0vKkJKiAbZoeFOYUttxs5klE3QsZ7AFVJaktLp1/MDrvBtgiMBfbP
         AlS/f6WG2DSFvzSSJn/G5bU1nmfCFZiWIMs3ZRADAphlTqrwu30ONXJWjAEq96BYnC48
         Gwj4P25Rw6sDn+srMiVJmbS83tDbk0NWlg9S9EZt/LEG9LLMwtf6FK+ZzrYcMLRdb4H1
         vCkFK9N/f+SomsqQTLMt2Gf6xz05oK/GQ1Po+esGd5Zs+sONriUg3cM0wdD53wHqV6PF
         yWaA==
X-Gm-Message-State: AOJu0Yzd8p18VpwxzVOTI7w4rz6Zig6ewMZUjZAbD7Xq0Y49Y2HBSoGK
	8hsm1Aba9lJk2NELVk9B7s9d6PYteQUZknOH5UdriuK0O64aKL6R51aqdpLsUL0Mqnw=
X-Gm-Gg: AeBDieu55RcqGFPGe+8XzmkTC/+j8NSMEIEuSU21Gi1pCGY9aPuuvBudSRlSgAURFVJ
	cnBu6oJMi7n81p4XqWRahCXPvPBH/JfjehNKBzihbVMOJeQlE6GYVnVht0R0GJmvybYBGaH+TwH
	HCwPS31m0DziuBRgtFcNFJLee07fMf1YuOX03eAB25uHx6JVp0SxsupPnYUut4ureC59KKYUMFo
	4BhKu1qY/UxTy4b+4zEzot+E1TH9l/GwcVMI+5J+m16+/+LNszzYYb7LHA4Ay0qw1aFMWK+vWm5
	AUFfc+aJ/F8oFHw6yhpJhtjT//zaeIT5oyy1ZgvNCyrV8FLU1n0b+7C7xUT3H7KrNfG5jss7ipS
	hIFvLziwTlHUatxCvaWaw70ggT3uGcqcFgrofl/qkAe2lDmd32uFSznr6UkFgQaBUOgpPImE1Gj
	iRmnSWRcOfZ3M2KOadgNpz9K9WAn9goF9PV+O00NzhIU+uWLQe4FWp
X-Received: by 2002:a05:6102:149d:b0:609:5643:e9f2 with SMTP id ada2fe7eead31-62ad1529ba1mr582184137.6.1777527411933;
        Wed, 29 Apr 2026 22:36:51 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62982736ba5sm2411089137.5.2026.04.29.22.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 22:36:50 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against concurrent clears
Date: Thu, 30 Apr 2026 01:36:45 -0400
Message-ID: <20260430053645.1466196-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A WARN_ON_ONCE(!buffer_uptodate(bh)) in mark_buffer_dirty() is
reachable from the buffered write path on a block device when the
underlying device returns I/O errors at high density.  Reproduced
by fuzzing an NVMe controller (FEMU) that returns crafted error
completions for a sustained workload from /dev/nvme0n1.

The contract documented at set_buffer_uptodate() in
include/linux/buffer_head.h reads:

  Any other serialization (with IO errors or whatever that might
  clear the bit) has to come from other state (eg BH_Lock).

In fs/buffer.c, BH_Uptodate can be cleared from four I/O completion
callbacks: __end_buffer_read_notouch, end_buffer_write_sync,
end_buffer_async_read, end_buffer_async_write.

end_buffer_async_read() runs with BH_Lock held throughout, so its
clear is already serialized against any caller that also holds
BH_Lock around set_buffer_uptodate(); the call may in fact be
redundant, but addressing that is independent of this fix.

end_buffer_write_sync() likewise holds BH_Lock while it clears
BH_Uptodate on the write-error path.  Removing that clear would
change long-standing buffer-cache I/O-error semantics and is out
of scope here.

The race is therefore between block_commit_write() and
end_buffer_write_sync():

  CPU A: block_commit_write              CPU B: end_buffer_write_sync
         (folio lock held, BH_Lock NOT)         (BH_Lock held)
    set_buffer_uptodate(bh);
                                           clear_buffer_uptodate(bh);
                                           unlock_buffer(bh);
    mark_buffer_dirty(bh);  /* WARN */

CPU B observes the contract; CPU A does not.  With one side unlocked
the serialization is one-sided and ineffective: CPU A's set can be
immediately followed by CPU B's clear, tripping the WARN_ON_ONCE.
In the fuzzing reproducer, write-error completions are frequent
(visible as repeated "lost async page write" and per-LBA write
failures); buffer I/O completion callbacks on the write-error path
(e.g. end_buffer_write_sync, end_buffer_async_write) clear
BH_Uptodate while holding BH_Lock.

The bug is not benign: a not-uptodate buffer can be marked dirty
and subsequently written back; depending on whether the buffer was
fully or partially covered by the user write, this can leave on-disk
content that does not match the intended buffered write state.

Fix this by taking BH_Lock around set_buffer_uptodate() +
mark_buffer_dirty() in block_commit_write(), so both sides of the
contract use the documented serialization.

Found by FuzzNvme (Syzkaller with FEMU fuzzing framework).

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
Hi Matthew, Hi Jan,

Thanks for the review on v1.  v2 takes the feedback, quick notes below.

To Matthew:

You were right that the v1's timing diagram named the wrong racer.

The actual race is with end_buffer_write_sync() on the write-error
path, as Jan pointed out -- it also clears BH_Uptodate under BH_Lock,
but block_commit_write()'s else branch was reaching set_buffer_uptodate
without BH_Lock, leaving the serialization one-sided.  v2's commit
message and in-code comment now name end_buffer_write_sync() as the
racer.

To Jan:

Thanks for confirming the racer and for the historical context on the
dirty + !uptodate state question.  v2 keeps the fix scoped to taking
BH_Lock in block_commit_write(); the broader semantic question and any
change to end_buffer_write_sync()'s clear is left out of scope here.

The redundant lock_buffer/unlock_buffer that v1 added to the
buffer_new branch of __block_write_begin_int() is also dropped in v2 --
that bh has no in-flight async I/O so no race exists there.

v1 thread for context:
https://lore.kernel.org/all/20260426020137.1221985-1-coshi036@gmail.com/

Thanks,
Chao

Changes in v2:
  - Drop the lock_buffer/unlock_buffer added in v1 to the buffer_new
    branch of __block_write_begin_int(): that bh is freshly BH_New
    and has no in-flight async I/O on it, so no race exists at that
    site.
  - Rewrite the commit message and the in-code comment to identify
    end_buffer_write_sync() as the actual racer, not
    end_buffer_async_read() as v1 claimed; end_buffer_async_read()
    holds BH_Lock across its clear so a caller that also holds
    BH_Lock would already be serialized.
  - Reference the BH_Lock contract at set_buffer_uptodate() in
    include/linux/buffer_head.h explicitly.
  - Drop verbose line-number citations and the WARN stack dump from
    the commit message; tighten wording around reproducer evidence
    and on-disk impact.

v1: https://lore.kernel.org/all/20260426020137.1221985-1-coshi036@gmail.com/

 fs/buffer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4d7f84e77d2..6fddb2f1e7c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2104,8 +2104,22 @@ void block_commit_write(struct folio *folio, size_t from, size_t to)
 			if (!buffer_uptodate(bh))
 				partial = true;
 		} else {
+			/*
+			 * Per the contract documented at set_buffer_uptodate()
+			 * in include/linux/buffer_head.h, callers must hold
+			 * BH_Lock to serialize against concurrent clears of
+			 * BH_Uptodate.  Holding only the folio lock is not
+			 * sufficient: a concurrent end_buffer_write_sync() on
+			 * the write-error path clears BH_Uptodate while
+			 * holding BH_Lock; without BH_Lock here the clear can
+			 * land between set_buffer_uptodate() and
+			 * mark_buffer_dirty(), tripping the WARN_ON_ONCE in
+			 * mark_buffer_dirty().
+			 */
+			lock_buffer(bh);
 			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
+			unlock_buffer(bh);
 		}
 		if (buffer_new(bh))
 			clear_buffer_new(bh);

base-commit: ffe69af1f87fa77da975ad4b0b093d48c3cbe6c3
-- 
2.43.0

