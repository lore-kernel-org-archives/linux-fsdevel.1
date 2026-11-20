Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182153;
	b=3lIWIufdUmuKElgWmDf4EviDsLjhLfrrprQ7RyNPHWP5EJDtW/Q+FCfRN30Z5nMD8jSS
	 3vnJmhAvbCRayaQnK3JekGu53CFtvCvZ1hI+Xo868zwL3W2dR8ywdqhnXI0bd1el5eygv
	 5ox7VumRTjkBkpuW0geeg6Vxd7aUT5qLYglGyRXFDF0+e2KjCo5syZhcLOf8oR8g4g0d7
	 UkMTE/Eee8W7tmsAQBKZ7GKuMDfNvf/8jTVoncg0qHHxNiLoq99g92ndzp48g2wXVj+ba
	 GGeKNcjTO6on9DkfMZamG2j4g8VL+CsAKcrfurEi+iJYHn7MoVxbG/TWkRsc9Vz+LUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182153;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=EyU8IUWPHTCgRPl42Jjqqg6MmBy+29h9LlcoVLoowqM=;
	b=KmcmPC0RmWpwz+Ja8VEAx2XtRGNlkgRkeo6Fdzbdp47RGSR5sZnejWjC4r80Zrb+9K5P
	 P88iz5IVmgiY1mYRW7gQ+OEle60SAYBEEtjmO9pImZ8mbkDlWEZy4dyFEGZYMylNh1opq
	 B4ApMFDm884FBz7/LTF6khffm9lHa7ntIaHU93gkmfbabykyGH5/B7ZZm0onFgE8QPiZa
	 2Y3ZPKe0IahdcKkSCYZR779k6ZJlwwd0iynzcmcLv8HVLFjdWpuezOppGkWEnB6Plqjdd
	 rY458dpu6xtfLLocG4Sx3hdh9xNGBcl/qhlD8YeO8axtYsBf1hy2K2SGG7phXBWYBBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IT3qkdyO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C32606A32C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IT3qkdyO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2761F000C0;
	Fri, 20 Nov 2026 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182152;
	bh=EyU8IUWPHTCgRPl42Jjqqg6MmBy+29h9LlcoVLoowqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IT3qkdyOjenbnZjjh6oTAOqIA0GVob6KTnVxDfvTbarYDp5UUhOuUkmXra19JQJ/P
	 /kv85iUdEbJN4QiYgxz+cP9ydLdt23e5X3+rNAllzBmzFd9ZEqjyP6KIy1XUnSmPqq
	 QFGpIH4tRJREJDwwUBtmgetjZCr8TQ6S7uEdAcCMgjx2Rz/L7m6VldAlhj6T61dgQ2
	 v685od1YzezKiNzg0IQTScBdchZw3su/+VD0+dNqPFLDJ7ZyKDYjYa9Gc1Q97WQrNK
	 7kQD/X3soXV84TyuWiMslwM7pXwWg4uxcDl0xQaKXsPrwr1BhWa9ZobjQD1mKDfBC3
	 wmQNka1HpTShg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 20 Nov 2026 14:42:09 +0100
Subject: [PATCH 1/3] pid: move pid_in_current_pidns() into kernel/pid.c
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
Message-Id: <20261120-work-pidfd-pidns_visible-v1-1-0e82d08469ae@kernel.org>
References: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
In-Reply-To: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jiwoo Kim <arpe1618@gmail.com>, Chen Linxuan <me@black-desk.cn>, 
 linux-mm@kvack.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=3561; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AAqjJa+Lt7I0UGE2nk14kuF0ZHp1hs12+suAI1lRIK0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQz+Nle/FntmX/n5pnm3ezOWaevloRbv7bXdGL0EBcJX
 NP3ZDlXRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQUxBkZVn0uPeyvJ3VXgf3H
 m/MxlQ3FinL7389fU+K3/Hroj39TzzH8FQw49fP3S7fLO/8m/wlJjnq2QETAwIL59klX7pfvhXr
 3sQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The pidfd api checks in various places whether the target is visible in
the caller's active pid namespace. pidfs has pid_in_current_pidns() for
PIDFD_GET_INFO and the ioctls that hand out namespaces and task paths,
the pidfs file handle lookup uses pid_vnr() directly, pidfd_getfd()
uses pid_vnr() as well, and pidfd_send_signal() walks the pid namespace
hierarchy in access_pidfd_pidns(). That's all the same check.

Move pid_in_current_pidns() into kernel/pid.c so it can be used outside
of pidfs and convert the pidfs file handle lookup to it while at it.

pid_vnr() returns pid->numbers[ns->level].nr if ns->level <= pid->level
and pid->numbers[ns->level].ns == ns, and 0 otherwise. That's exactly
the condition pid_in_current_pidns() checks. Pid numbers handed out by
alloc_pid() are always >= 1 and only pids allocated by alloc_pid() end
up in the pidfs inode hashtable. So pid_vnr(pid) == 0 is the same as
!pid_in_current_pidns(pid) in the file handle lookup.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/pidfs.c          | 12 +-----------
 include/linux/pid.h |  1 +
 kernel/pid.c        | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index a2a0691cf1310..85b160923177c 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -327,16 +327,6 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
-static inline bool pid_in_current_pidns(const struct pid *pid)
-{
-	const struct pid_namespace *ns = task_active_pid_ns(current);
-
-	if (ns->level <= pid->level)
-		return pid->numbers[ns->level].ns == ns;
-
-	return false;
-}
-
 static __u32 pidfs_coredump_mask(enum task_dumpable dumpable)
 {
 	switch (dumpable) {
@@ -1028,7 +1018,7 @@ static struct pid *pidfs_ino_get_pid(u64 ino)
 	if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask))
 		return NULL;
 	/* Within our pid namespace hierarchy? */
-	if (pid_vnr(pid) == 0)
+	if (!pid_in_current_pidns(pid))
 		return NULL;
 	return get_pid(pid);
 }
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 185bf0cde2d14..1b463921d2ed0 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -239,6 +239,7 @@ static inline pid_t pid_nr(struct pid *pid)
 
 pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns);
 pid_t pid_vnr(struct pid *pid);
+bool pid_in_current_pidns(const struct pid *pid);
 
 /*
  * Needs tasklist_lock if type > PIDTYPE_TGID. A lockless reader can:
diff --git a/kernel/pid.c b/kernel/pid.c
index 4f9a29eb29de7..aa3ed6b5d4a9d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -559,6 +559,27 @@ pid_t pid_vnr(struct pid *pid)
 }
 EXPORT_SYMBOL_GPL(pid_vnr);
 
+/**
+ * pid_in_current_pidns - check whether a pid is visible to the caller
+ * @pid: the pid to check
+ *
+ * A pid is visible to the caller if it has a number in the caller's active
+ * pid namespace, i.e., if it was allocated in the caller's active pid
+ * namespace or in one of its descendants.
+ *
+ * Return: true if @pid is visible in the caller's active pid namespace,
+ *         false otherwise.
+ */
+bool pid_in_current_pidns(const struct pid *pid)
+{
+	const struct pid_namespace *ns = task_active_pid_ns(current);
+
+	if (ns->level <= pid->level)
+		return pid->numbers[ns->level].ns == ns;
+
+	return false;
+}
+
 pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
 			struct pid_namespace *ns)
 {

-- 
2.53.0

