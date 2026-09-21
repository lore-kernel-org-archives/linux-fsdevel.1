Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F3C4AAC4C
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000170; cv=none; b=gx9WB+092s8KHiA/Ukj7urjVhqXaYYT/a9BtUaTcKVFLJSyQjhRxdKgT9Thgdtg4NabqPRkb3/EailNFwHh1tVFQKQN0NxBS1yD9gRFP0Zwa7soHXgt6fJC+GzMoxUxBGmYm5snHyLTT9LFILuUK46W7PnM5MAL6E5OnSICtsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000170; c=relaxed/simple;
	bh=a/xpl/Ta7AOr4QRFOQtZ4jaF44Kf3E0y4H6XcxGZkT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bdO5cYJU3hrXj32WsHZcWuPfYK5BRDXy/Wf7e/wdw5CTzGjt/oRzpXzD604JqCy8o/Ir3+U50UnfLPX+xLm2keHkY+UJlHLGrXFZAD54bOPCI9Z8J+6Zv6knl5DIU4PkwHnPBmo3CFAjls2M9OO9f/bc39IWsup2ZnYAQ6pontM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJkOOBXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJkOOBXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE2E1F00899;
	Mon, 21 Sep 2026 14:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000166;
	bh=c0Kua6sqiXGLtDzHFPh3TNHun44BAU4np/PHk7YmaCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DJkOOBXDtD/DyNBuGUnBAgOBFBuLkBLsjqD0mTNPVezvyAD7oBlziiUdtGlMon2fu
	 xx1fC//R+JhAvrVT5DMFq3lX7mSRFvbMhbenfO2UgG8+jC4DxWTshHNSVFfou3AINn
	 lWGoSRgX7FauOXg/LMpxyJpc2PTOuQ6rQ9fCIxAzQjmQU5e6rU4QpHH1Dwx4TgXJ74
	 0WYRMH4//zQOlLFOZU8QQQzBNRPdDQmMRix1KOugiKvwkJgSeoM+wQOQMSXIjLLS7Z
	 M9HRnHXHQhqX2w5QhvYm1laV4zINP7B3ZvBtAQ5y0uas0INHftDk05M+DkW+OPgiib
	 Q8DymXQS1iAaw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 16:15:36 +0200
Subject: [PATCH 08/10] file: let dup_fd() drop only close-on-exec
 descriptors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-file-close_range_except-v1-8-c20d0b49270d@kernel.org>
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Neil Brown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=brauner@kernel.org;
 h=from:subject:message-id; bh=a/xpl/Ta7AOr4QRFOQtZ4jaF44Kf3E0y4H6XcxGZkT0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRttOF5bqq9Zq+zYcwP+9LPv9e+Lwyr+uLw/dbvLU9vf
 yjwfeB8paOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi4ZMY/ieIaH40N7xqOTGo
 /6fcdw6TktATa2v+yBgkcMxtOS3yQYSR4dYOxuMG078nHY75VjsxSPcQT6qVl3VgeEqe4ZwrrwP
 3cgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add FD_RANGE_CLOEXEC_ONLY. When set dup_fd() leaves everything behind
except for fds that are close-on-exec. Without FD_RANGE_EXCEPT the
clone loses the close-on-exec descriptors in the range. With it the
clone keeps the range and loses the close-on-exec descriptors everywhere
else. Descriptors without the flag are carried over either way.

Nothing passes the flag yet.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c               | 43 ++++++++++++++++++++++++++++++++++---------
 include/linux/fdtable.h |  3 +++
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 39651c7a992e..8952efd2cf3a 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -365,7 +365,8 @@ static unsigned long fd_range_word(struct fd_range *range, unsigned int i)
 }
 
 /* Bits of word @i that dup_fd() leaves behind. */
-static unsigned long dup_fd_dropped_word(unsigned int i, struct fd_range *range)
+static unsigned long dup_fd_dropped_word(struct fdtable *fdt, unsigned int i,
+					 struct fd_range *range)
 {
 	unsigned long dropped;
 
@@ -374,6 +375,8 @@ static unsigned long dup_fd_dropped_word(unsigned int i, struct fd_range *range)
 	dropped = fd_range_word(range, i);
 	if (range->flags & FD_RANGE_EXCEPT)
 		dropped = ~dropped;
+	if (range->flags & FD_RANGE_CLOEXEC_ONLY)
+		dropped &= fdt->close_on_exec[i];
 	return dropped;
 }
 
@@ -393,15 +396,37 @@ static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *rang
 
 	if (last == fdt->max_fds)
 		return NR_OPEN_DEFAULT;
-	/* Only words up to the last open descriptor can hold a kept one. */
-	i = last / BITS_PER_LONG + 1;
-	while (i--) {
-		unsigned long dropped = dup_fd_dropped_word(i, range);
+	if (!range)
+		return ALIGN(last + 1, BITS_PER_LONG);
+
+	if (range->flags & FD_RANGE_CLOEXEC_ONLY) {
+		/* The close-on-exec bits decide what is dropped, walk the words. */
+		i = last / BITS_PER_LONG + 1;
+		while (i--) {
+			unsigned long dropped = dup_fd_dropped_word(fdt, i, range);
+
+			if (fdt->open_fds[i] & ~dropped)
+				return (i + 1) * BITS_PER_LONG;
+		}
+		return NR_OPEN_DEFAULT;
+	}
 
-		if (fdt->open_fds[i] & ~dropped)
-			return (i + 1) * BITS_PER_LONG;
+	if (range->flags & FD_RANGE_EXCEPT) {
+		/* Only the range is carried over. */
+		if (last > range->to) {
+			last = find_last_bit(fdt->open_fds, range->to + 1);
+			if (last > range->to)
+				return NR_OPEN_DEFAULT;
+		}
+		if (last < range->from)
+			return NR_OPEN_DEFAULT;
+	} else if (last >= range->from && last <= range->to) {
+		/* The last open descriptor goes, the kept ones sit below the range. */
+		last = find_last_bit(fdt->open_fds, range->from);
+		if (last == range->from)
+			return NR_OPEN_DEFAULT;
 	}
-	return NR_OPEN_DEFAULT;
+	return ALIGN(last + 1, BITS_PER_LONG);
 }
 
 /*
@@ -487,7 +512,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *range)
 		struct file *f = rcu_dereference_raw(*old_fds++);
 
 		if (!(fd % BITS_PER_LONG))
-			dropped = dup_fd_dropped_word(fd / BITS_PER_LONG, range);
+			dropped = dup_fd_dropped_word(old_fdt, fd / BITS_PER_LONG, range);
 		if (f && !(dropped & BIT_MASK(fd))) {
 			get_file(f);
 		} else {
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index d6c6c7a3400d..afdfaad381df 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -104,6 +104,9 @@ int unshare_files(void);
 enum fd_range_flags {
 	/* Leave behind all descriptors outside of the specified range. */
 	FD_RANGE_EXCEPT		= (1U << 0),
+
+	/* Only select descriptors that have close-on-exec set. */
+	FD_RANGE_CLOEXEC_ONLY	= (1U << 1),
 };
 
 struct fd_range {

-- 
2.53.0

