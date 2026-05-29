Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A3342146
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083498; cv=none; b=VcUu+DgN5hjjTtsS0fF7YC9/Oy5ro/2m9RWDsxuDOMG5rYy7eSwbdvh/OaztmLHuVHBWwrtbwh94Fj0nsdFp49OYYieE/UeUhkPb61dyzQ7arB3lfZfW6cQEB57piSsr8YSxWV8nD3qER0OPwrtO5Xw8sv1GGnyQvJNcg0bohsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083498; c=relaxed/simple;
	bh=HiPTflDBYfZdhMC3WpnasYyN0yb76I5DWqcK57WduJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t/yTRHPEwHAgcASQBTD+A41Da5qiIiBbxYZrI1XwXffXtBB8n8jwMKRea4sUVo43zmDneTC4wNDZQz1FPsjgu8aBCFQeCs/jQxOdJswIubBkYXYE5IABZ2NOTDd504d6ahNQsWrIKxxb4BnEXSKHLWaV44NGFaVxf4R5IYrFuSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jjMoMohF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjMoMohF"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903893a0f3so1195e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780083495; x=1780688295; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3UF5hUbwAsGvEH1GwbZruuURY33jU9OFhOiAhQPF5Y=;
        b=jjMoMohF4e9Y51acMFIHS5thHNih4UuBw+Hbx1ZVLE7MWHW0KTqFq6MCvxSZ/Cll8N
         yO+PIaUCi9eRVoA55DQgn+3gK+nXWLLDPeaxafMv5Aj98fF03QqypGyh5XXBPVX7WO56
         4sBQi6yAREGKXQYg6KZG6Iwc6jNgeCfC2skmV6sI9l69KIDlzXUXt+gN3RmADu2xLxBw
         TD2o3zxhsu3pw0YOXy77G6EbL4iilRTFotkapu2tzgMifUJplWtffTOv1wGZuwRo8Fd5
         3zHOTqHmenpUQj2GAOGcYoVf52nGUsbhnOjPF7LqE0XPRH4Awf3BUMz+EnjOZFUvJL1m
         FlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780083495; x=1780688295;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3UF5hUbwAsGvEH1GwbZruuURY33jU9OFhOiAhQPF5Y=;
        b=Lwqhjf3g5HhDt3AV2D07tgUDvRCEYPsFCAwa3Pb2+SHDD32GNC0cX6dk7UMF2d9uwV
         /BgAnZTotuXXZefD4QK2ireASASyJnx2mE/UoV0cBDofRqcRIJ2U5iBTB9x1AtPAb37O
         tQzbZd/MlJyJBrxPlzFMdl8zyVBOkyBQmyQpzIszBmS7Sx1+n2QVbq7DHQhtJSoRZ5SD
         jlVBCfveu+dx35WOYGGCSErXDeqU28AUzahHuotorIow/m4Ev0nskjcOa8daWDRAhvCd
         c87LG6XqfxZk7BdKIrAxVY1lnBmACkmhOADPbPfgGkK0iR/ebVaBjHlt8e8TOwJQHRQE
         xXcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QlZUirVfYqscdtZXS5O/8inVSqWeNNxIdhXQeE7djj1zeOj+Pdqjc9a+LVTkJMv6XCCYGiWFo+9W/Rcvy@vger.kernel.org
X-Gm-Message-State: AOJu0YwuzOG/NQtejmB621LZVhSA5ZJaHye8Qiu/XCsFBfSh72f30l+k
	quPD/LzXRC5SpUpghcB72KXPqbWpNYhqecEfdgM9dr4Ah7cQFRGtTfAAy2LPiyQqdAiYT3s0O2Q
	OSgpMLd0w
X-Gm-Gg: Acq92OEZ5Iulvhd6i9Jri7r7ERF494cU1UNgEb67fNew5gL9gerczskXRi0UTF4o6BS
	UmxBLQFSMu9LE2835D8mE/5nXd7zUDMwFRiARE29BA73t5Leu6S9pd3ZsFlzXT9rojqm0hXK1S/
	LZmfba8GZpPN9WzR/9ZOtiMv+YzHzFSuKloDdi/Q+qlSHNRMKnssjkDJlp+Ao855yzi9icXn/pn
	VrmxPqSj+ns5xnaDilBlB86vx31TqxQeePjp8Tb6v6kWN5HKAzWd4RK9QGciDMpF3P4BSb1tJNa
	hTRCvZHxPahxjaVUxtBH3HP181bClKfU+mo//VYJO90v/0AH6jMvOHlSCWv5cgjaMlUxEyDPgou
	ABaa8B7GZn0uTf5G/9bwSlX6mZ3t3oW2IrIjMm5uPpB9Nzkjf6H4rvC0cegGaOnG0ib4rTHMKCe
	s9pmNNBrEnXzO8lX67AvGAbQ7nvrPbS0yftOHcNsk/FVaZqDiXf5gs7GzFtY1Vy4vZNCJbE3k=
X-Received: by 2002:a05:600c:3e06:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-490a2cc9959mr181555e9.2.1780083495183;
        Fri, 29 May 2026 12:38:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:d743:bf7b:2a4:a9a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a03f8sm5854809f8f.7.2026.05.29.12.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:38:14 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 29 May 2026 21:38:08 +0200
Subject: [PATCH] vfs: document locking for mnt_notify_add()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-vfs-mnt-notify-comment-v1-1-5becd17a15c3@google.com>
X-B4-Tracking: v=1; b=H4sIACDrGWoC/yXMQQ6CMBBA0auQWTNJLZaAVyEspE5hTNqaTiUYw
 t2punyL/3cQSkwCt2qHRCsLx1BwqSuwyz3MhPwoBq10q4zucXWCPmQMMbP7oI3eU+G1aXtSxnR
 OTVDiVyLH2288jH/Le3qSzd8bHMcJC5XiRXoAAAA=
X-Change-ID: 20260529-vfs-mnt-notify-comment-4369e0558f0b
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780083491; l=3099;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=HiPTflDBYfZdhMC3WpnasYyN0yb76I5DWqcK57WduJ4=;
 b=QVCXfFdDE6rzTGIQ72sIhzHNsRpvX19d3P06T7JwYKd8PImR+qevP54RhYaviLXWgmfLSBmZn
 gMY0Xbp7FJZCnnVau7BuH2IzFWV+yzaUgJW2CsB95JLdWcu4TIalE73
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The locking in mnt_notify_add(), which was introduced in commit
bf630c401641 ("vfs: add notifications for mount attach and detach"), is a
bit gnarly.
notify_list is protected by namespace_lock, but there are cases where
mnt_notify_add() is called without holding namespace_lock, for example:

    __do_sys_fsmount -> mnt_add_to_ns -> mnt_notify_add

Luckily, in cases where the namespace_lock isn't held, the namespace is
always freshly created and can't have any fsnotify marks yet, which means
the notify_list isn't actually accessed.

The existing comment claims that not accessing the notify_list in these
cases is merely an optimization, which is wrong. Fix the comment, and add a
locking assertion.

To allow mnt_notify_add() to reference the namespace_sem, move it into
fs/namespace.c.

Signed-off-by: Jann Horn <jannh@google.com>
---
I'm sending this patch because I spent some time staring at this
trying to figure out if this was buggy or not.

I don't know if this is working as intended or working by accident,
and it might be nice if this was cleaned up to have simpler locking;
but for now, document what's going on for the next person who stares
at this code.
---
 fs/mount.h     | 10 +---------
 fs/namespace.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index e0816c11a198..99016db2f408 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -219,15 +219,7 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 }
 
 #ifdef CONFIG_FSNOTIFY
-static inline void mnt_notify_add(struct mount *m)
-{
-	/* Optimize the case where there are no watches */
-	if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
-	    (m->prev_ns && m->prev_ns->n_fsnotify_marks))
-		list_add_tail(&m->to_notify, &notify_list);
-	else
-		m->prev_ns = m->mnt_ns;
-}
+void mnt_notify_add(struct mount *m);
 #else
 static inline void mnt_notify_add(struct mount *m)
 {
diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..56f130b49e58 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6431,6 +6431,25 @@ bool mnt_may_suid(struct vfsmount *mnt)
 	       current_in_userns(mnt->mnt_sb->s_user_ns);
 }
 
+#ifdef CONFIG_FSNOTIFY
+void mnt_notify_add(struct mount *m)
+{
+	/*
+	 * notify_list is protected by namespace_sem.
+	 * It is possible to call this function without holding namespace_sem,
+	 * but in those cases, the mount is associated with a new mount
+	 * namespace that can't have any fanotify marks yet.
+	 */
+	if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
+	    (m->prev_ns && m->prev_ns->n_fsnotify_marks)) {
+		rwsem_assert_held_write(&namespace_sem);
+		list_add_tail(&m->to_notify, &notify_list);
+	} else {
+		m->prev_ns = m->mnt_ns;
+	}
+}
+#endif
+
 static struct ns_common *mntns_get(struct task_struct *task)
 {
 	struct ns_common *ns = NULL;

---
base-commit: 8fde5d1d47f69db6082dfa34500c27f8485389a5
change-id: 20260529-vfs-mnt-notify-comment-4369e0558f0b

Best regards,
--  
Jann Horn <jannh@google.com>

