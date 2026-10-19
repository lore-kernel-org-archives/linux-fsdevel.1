Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B183332907
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416267; cv=none; b=KedeRwwZBJYM/UvPRCpsTnIzrrJejwb6CDIyx+IvhvlhBZEntkN7PPwuJBOOIT1Igs8fenkyEKnYcDmk0WC6M2OlP1Ck5Hw2lp51T0eKri0fEmztc54EDnZHzZjWFin6zp0g79sGJRAz7M1TNT0DqMXmKXAZI6NT8h8BXoI6Dz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416267; c=relaxed/simple;
	bh=yoaGZiQ9H2vRb1xLQBCf1fZhJ3mt/eR09MUsi84PMZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NlSYpgDIBRrr/4IqMOzEwtx3V2JkrVmj/Paq/YlW/UaAjP9gckTq9MHzQBcniWk/T4ykrDLyP9U8P32dPIGL3GVqk3OtTftxpzW7S+ZWBCs5JpYnNgCRqOmEh6ADNiQkdMFBl55RduRbHe3Yryj/w+Mu4fEHo9VTJU4QODgFlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgpdvKhq; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgpdvKhq"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-354ba08cfd1so3809298eec.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 06:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416265; x=1793021065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gHkvJRImAGRTzqUxR43Iw2Rk7eqpTmHI2Ma9f9R50ho=;
        b=AgpdvKhqi04YMn77dpglwRqTiOMJgCik0Xrsk19JmSfAy7kQyeFYMOHO5xvcFwN7ic
         wvJiUTG4tNrzPSqM+faQfxRerBA1eqjp/HxLlHkBke0zyD2JyheZdEy1ridSV+8RAQcN
         yCo8xRrnvHbzyJ18Pj7P4vkbBWaWWqp7aJSdRcf6n/YVPjGwsMr7zqbdVbi1jGhEAYUy
         W+nwpwEdMsmUpajs2MEz0RC1GMVblPc8QBXhLVjBIQnVKgEvVTRFjVgZuplY34m4UzAL
         UZhotemi9TrR3dyXE/B9VvhrLANOi2Lt/Jq8B5MMivXpf0DmwYz3nHeeTovHoUzE1AvR
         p1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416265; x=1793021065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gHkvJRImAGRTzqUxR43Iw2Rk7eqpTmHI2Ma9f9R50ho=;
        b=NSTKi4fhb3oJHlO7TZ/yb2rvzWbnBixU0ktddTugIK45XeR0nJHqE8Ui9xAXrljMzK
         6K+IHDXErakXKy5jxiFOMfZWl3eMIL1IheDX7UhrTV30MIqk8E4mg0WJIJglq7UKKhxn
         BmXMNJykDU/DAyK959U3ijY0ixhQFwCXVeFK4ixEtkPotqmu9yvX8kvC6r6B1Kusup4D
         XFi2ZTCQxKAsAZ6X3WWut2A1F32UtvEu/UySNJj+DPkiNdH+Y1ElRxRVhFvc9TyS9SMQ
         iG458culk32HeY2jyXGPgYxcSHilI7NqhHjAKB4uDL9v0K0giLP0lM9xL6mCx3aPS4k3
         Rpgw==
X-Forwarded-Encrypted: i=1; AKwUvBw1r7ngsMeFcyBy1m4xd05KxeGFeKViqd4HHR3xBAvQnKvZhOMe7BeA88Wg8OC6gMjRnKUhAZLWv8bSHTeB@vger.kernel.org
X-Gm-Message-State: AFq9FYJgXzCvzT1o5/YAX6uBCVQ7Setv7jdMKjezm77AXSc1qy+aqiwl
	rr6gazOEFkDmN8boCSXz++kRc9aFJWYMRcIL2j5GDPUHxSFq0EYXtOyB+f50/L5H
X-Gm-Gg: AYBFou3/Byrj2W73YkCE1K7o/zawaO6DMaAXRjkst55i020qn/y6nfzOcTCswq/bkh4
	3E6kvzMKg1Bfw1KpZVodOE7qDs6OMXgx0vJmHGwKXbfGMZLSlAATJCFhfhw/DiEkKFKymgYUPzx
	80djuKsCHBPADK+hRBK2GYzfEthm+2OH4XU3EOICUZNkqONzp74sqYBLFsY+a5xb4p+2aRkz27y
	ULGfSTNpC1NcBdjh6NnjvMY6oVNf+iswzbClKpbf1XOAiphf57MIhp57LDaddeZUmy70QzS26sC
	3p6MzVrwf0NscaBEyz+KTlX5pndneaxDSptrwFQk74Qgu4Vv//vEVNyMq/aUeqCy/O+cpm/1361
	mw9XxqZDn14DMPRqod0aiaHQL8rCQ6Wrxno79vrtfBEICeh+2eq+ryJQwT2s0Ll00DIl9STyGaD
	mY81ZWoHkzMcmgPEuRmmg0RvhUh9+gTmD4EDhErTiKek8I3Nzy7sQb6YGzhzkFMCIy9LWf/w==
X-Received: by 2002:a05:7300:d0ab:b0:35d:2633:ff79 with SMTP id 5a478bee46e88-361a2a3c429mr11431088eec.40.1792416265293;
        Mon, 19 Oct 2026 06:24:25 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7a80:50::3cf:67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm52717230eec.12.2026.10.19.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:24:23 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH] d_path: fall back to init_fs when called after exit_fs()
Date: Mon, 19 Oct 2026 20:24:19 +0700
Message-ID: <20261019132419.62905-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

d_path() dereferences current->fs unconditionally. do_exit() runs
exit_fs() before exit_task_work(), so a deferred __fput() sees
current->fs == NULL. If that fput ends up in d_path(), it crashes:

  ima_file_free() -> ima_update_xattr() -> ima_calc_file_hash()
    -> dentry_open() -> smack_file_open() -> smack_log()
    -> common_lsm_audit() -> audit_log_d_path() -> d_path()
    -> read_seqbegin(&current->fs->seq)

Any LSM or audit path that formats a path on open can hit this. Fall
back to init_fs, whose root is always valid, when the task has no fs.

Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=975ace299d6ba2eb1cea
Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Reproduced in QEMU (x86_64, KASAN, Smack+IMA+audit) with the syzbot C
reproducer: without the patch the first exiting child hits a null-ptr-deref
in d_path(); with it the reproducer runs to completion with no KASAN/Oops.

Alternatives considered: fixing only the IMA->Smack audit path (too narrow,
any open-time LSM/audit hook can hit this), or reordering exit_fs() and
exit_task_work() (too invasive). Happy to rework if you prefer another approach.

 fs/d_path.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index c25309006d5d..24fd56e80631 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -3,6 +3,7 @@
 #include <linux/export.h>
 #include <linux/uaccess.h>
 #include <linux/fs_struct.h>
+#include <linux/init_task.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/prefetch.h>
@@ -284,7 +285,8 @@ char *d_path(const struct path *path, char *buf, int buflen)
 		return path->dentry->d_op->d_dname(path->dentry, buf, buflen);
 
 	rcu_read_lock();
-	get_fs_root_rcu(current->fs, &root);
+	/* exit_fs() already ran if we are called from exit_task_work() */
+	get_fs_root_rcu(current->fs ?: &init_fs, &root);
 	if (unlikely(d_unlinked(path->dentry)))
 		prepend(&b, " (deleted)", 11);
 	else
-- 
2.43.0

