Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748547;
	b=k3WF/Nz2lTuQbhORAO7uMgHdpGvU0ly35eJ4oBbLgvr3MiAL95NM0yRHJ8tuTui4QfWq
	 gu7W0ZBBLCmK9sMT25Usm5chxf7ywNdPZeZ2e4Oe2gJmkJysP9IZ7YfvCoPe78CZtL2q4
	 S9S9OYjH91xPNxJwUmC1cWbAxjFSOGSZvv6Sqh4lOoTxpAlw+tNqMxH9AwTfMq0J1bM8r
	 na2OqNf6+Cv3q6YMVauDfv0nc5LTyv29jJZgSE8CN3+6JnwZ/P7GhTmDP/BkF7pA8bav5
	 QN6gf/8fAQ8SPRUXGf+WlyRrP17ToQWvubffFrQ8hYM5HN7UOcnRaJqzO2HFF+DscFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748547;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NCDnRZqW9T+VIMkq+Wi+hg8jcCBC/wNAJRCUfh3mrvI=;
	b=ZL2jSMCzbP+p2WEwJdPY6bm+oot8kqQDuBVEDbzJ0lXw3I3JqhfC6eYYT4d2U5qqUu2b
	 Wv9PMzuChuoMkImj5Rbt7xJmvGaTLeg//tWiH4R3hI+WejF9ZmPShDhW6OjKWN7lIJDkI
	 WeGyYlzmDWEaW6hXIpW+zmbcXTdrp7BzTwFO544KB7XPZp5opQ4nWrKH3WrCQe0O+EyO4
	 uitIBEB4mpd/rqWWda0oVtUzyJy6d2d1PnyHG1YWuC22hlQPzgTnuB9Qcdt/PS5VmpqNV
	 34sa86riVO5A1SAHDPdDCWs9X/1Q+EAryZ1d7U6bBvr+KmkiP2GeGxwd8o8iM+Jeg+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDCaLLRq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C2606A323;
	Fri, 23 Oct 2026 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDCaLLRq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15FA1F01828;
	Fri, 23 Oct 2026 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748547;
	bh=NCDnRZqW9T+VIMkq+Wi+hg8jcCBC/wNAJRCUfh3mrvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NDCaLLRqEjNXxJummr9wE9aP/S3IFeCpizh9eYHg9b5lhN7cR1kuydn6132jfCu9j
	 3xIeazZbuZUn/YPlkAx74KQDHrrWYDD7ycY5qVuZHDCho9s2WRcZb7N4Wvs7qmGLDS
	 U5rjDT1EqVM4NkdB7/Dw2mJozC2BHL+5buUbGgIAmxxMgx8WqzMTzCrLqfFS1FJ/1o
	 dv115JqaiDgBG52W9j2DAmyx6H22Tf3LuvdBMDyuOCdjZaB5S02RJGp0FHFqvTfWSV
	 aHGkYyeNbrrLLQepZOS7wzmRZEZzy/ZSEuWYCGU8AfVhFLeiFvODrU73FRwdIS1Lgr
	 rE7YoqfBEAw/Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 23 Oct 2026 11:41:01 +0200
Subject: [PATCH 1/5] super: add super_wait()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-work-super-lock_helpers-v1-1-d0fcb3f2f275@kernel.org>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
In-Reply-To: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ya7SdoaaFsa6wkCOTuL60qvNw+v6qCP+I8Z3SQBAtpQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd1v7rn3Wz66X26cYLx508zu+ZMtPrZ4jYh/PdMnMmX
 n9/b9GROR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATeX6E4a9U0Uu76pCobeeS
 78w2z5FirXBpW26cd3jTotu9/S8fWR9kZDhTNf/d6g6v2JLArnoH1c2Ms1YYihUVnQt4csauS07
 7JwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We wait for SB_BORN, SB_DYING and SB_DEAD in five places now, each with
an open-coded wait_var_event(), wait_var_event_killable() or
wait_var_event_state() on sb->s_flags and super_lock_common() picking
between the first two depending on @killable. Add super_wait() which
takes the flags to wait for and the task state to sleep in and use it
everywhere.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 63e85794ea4d..16b9d7ac381c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -102,6 +102,17 @@ static bool super_flags(const struct super_block *sb, unsigned int flags)
 	return smp_load_acquire(&sb->s_flags) & flags;
 }
 
+/*
+ * Wait for one of @sb_flags to be set on @sb, sleeping in @state.  Returns 0
+ * or -ERESTARTSYS if @state allowed the wait to be cut short.
+ */
+static int super_wait(struct super_block *sb, unsigned int sb_flags,
+		      unsigned int state)
+{
+	return wait_var_event_state(&sb->s_flags, super_flags(sb, sb_flags),
+				    state);
+}
+
 /*
  * Returns 0 with s_umount held, -ENOENT if the superblock is going away, or,
  * if @killable, the error from a wait which was cut short.
@@ -122,12 +133,8 @@ static int super_lock_common(struct super_block *sb, bool excl, bool killable)
 		return -ENOENT;
 
 	/* wait until the superblock is ready or dying */
-	if (killable)
-		ret = wait_var_event_killable(&sb->s_flags,
-					      super_flags(sb, SB_BORN | SB_DYING));
-	else
-		wait_var_event(&sb->s_flags,
-			       super_flags(sb, SB_BORN | SB_DYING));
+	ret = super_wait(sb, SB_BORN | SB_DYING,
+			 killable ? TASK_KILLABLE : TASK_UNINTERRUPTIBLE);
 	if (ret)
 		return ret;
 
@@ -216,7 +223,7 @@ static __must_check int super_lock_killable(struct super_block *sb, bool excl)
  */
 static int super_wait_shutdown_killable(struct super_block *sb)
 {
-	return wait_var_event_killable(&sb->s_flags, super_flags(sb, SB_DYING));
+	return super_wait(sb, SB_DYING, TASK_KILLABLE);
 }
 
 /**
@@ -230,7 +237,7 @@ static int super_wait_shutdown_killable(struct super_block *sb)
  */
 static void super_wait_shutdown(struct super_block *sb)
 {
-	wait_var_event(&sb->s_flags, super_flags(sb, SB_DYING));
+	super_wait(sb, SB_DYING, TASK_UNINTERRUPTIBLE);
 }
 
 /* wait and try to acquire read-side of @sb->s_umount */
@@ -606,9 +613,7 @@ static struct super_block *super_dev_next(struct super_dev *cursor,
 				return sb;
 			}
 		}
-		ret = wait_var_event_state(&sb->s_flags,
-					   super_flags(sb, SB_BORN | SB_DYING),
-					   state);
+		ret = super_wait(sb, SB_BORN | SB_DYING, state);
 		put_super(sb);
 		if (ret) {
 			super_dev_walk_end(cursor);
@@ -731,8 +736,7 @@ static int grab_super(struct super_block *sb)
 		ret = -ENOENT;
 	}
 	if (ret == -ENOENT)
-		ret = wait_var_event_killable(&sb->s_flags,
-					      super_flags(sb, SB_DEAD));
+		ret = super_wait(sb, SB_DEAD, TASK_KILLABLE);
 	put_super(sb);
 	return ret ? ret : -EAGAIN;
 }

-- 
2.53.0

