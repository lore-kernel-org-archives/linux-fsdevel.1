Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF24A3879;
	Mon, 21 Sep 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998319; cv=none; b=XDXVuE+Lh7dwRT2p/HCtKv407Qz9DMLK1Gj2HImDVU4e2jz81U8dIxTJ7INhzkTHGZAgtKJTfXECouR0rGmvQc+moD/Q5vnsgsZzoLiKiIfs1xm0csNNgz7n6N1p2YpC7rOT+wy24hs4Bgo0kbO1GDw+fKjMRJbs+pvf4FKW4y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998319; c=relaxed/simple;
	bh=Haa/wVyspvaLZ+kfdekU+bfXGoKBsPMcmx94/xgcUP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SjYTpjEjaf3Zf9ttOv9BCB8xRz3ELt70ATzBeF4R4zh2K8dawtmbuEBLiyuC93wxLYyWryvQX8zWb/K8cmmWbtoF4IFPZDcY+wJUnCKrUP/wJ9jhrEJoUbMSNHatiw5gf261wyQeWfLCWyPZvPlSLDucCDRr3v3hqFI4cdYGCJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrGSwNJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrGSwNJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160871F00893;
	Mon, 21 Sep 2026 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998318;
	bh=RMdX6MHSOqe32C0/+/LiVkpOkjZr/CxbphyJOfe1CoY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JrGSwNJUfaYorWbdHx9MJYNKq8svon8b7c/hDVt/10yuh95LAe8aShc9uuPEgx5p5
	 j7vdEIjzOHK0bW+sK0/dBaixMeUaddgbjrQpXZlz2Is7yWqAHO++pyYQlu9okcXbm8
	 jrzRsIny+dLdhgpxXepR0SQVloeRm4AjCx7I23YecZ+5WVVYe9gBuGeSwGtRFNgR9y
	 3wLaBnDAWb7G+OpuW0dWx2NNX7PZsVhDOypbNt076EjmOc4eBS61cYLUdnAPe4PCI9
	 VNIjtigIpYAu+ajPw5FWEnU6wmv+YyDREzoVUeiS3873to5mmMb7yxExKs7qPmW5Zs
	 6utJEIEbkemFA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:44:52 +0200
Subject: [PATCH v3 03/17] coredump: parse a snapshot of core_pattern
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-3-8e4adb1619e6@kernel.org>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
In-Reply-To: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Chris Mason <mason@kernel.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-mm@kvack.org, io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=5307; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Haa/wVyspvaLZ+kfdekU+bfXGoKBsPMcmx94/xgcUP8=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGqxNNyi2QcsZwZptVnS+SHxd0aR6NrZ2bcBRHvqEraPesAch
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmqxNNwACgkQkcYbwGV43KLL2AEAsljD
 MwGHkO+fvYYw7mjQP8R3jVwtHBXUtAZXQoiB3QcBAPscjTkLH3Iv1c2qiGKhZRn/9W+CMgQVSQK
 8SAQ0GygP
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This is a long-standing problem that I discussed a while back with Jann.
I didn't care enough about it to really fix it and it's from the
before-fore-times.

coredump_parse() reads core_pattern directly while it can concurrently
be modified. So it reads the first byte, figures out what mode is
wanted, then allocates the number buffer and then consumes the rest of
the core_pattern string.

Say the sysctl handler updates the core_pattern array byte by byte
(idiotic but supported). So that can lead to all kinds of insane mixups.
Say you could transform the old "|/usr/bin/helper" and the new
"/tmp/core.%p" into a usermodehelper started as "tmp/core.<pid>".

So copy what proc_do_uts_string() does and let the handler run
proc_dostring() on a copy, validate the copy and make it visible beneath
a spinlock. Then coredump_parse() can take a snapshot under the same
spinlock and parse a stable copy.

From now on, rejected patterns are never visible and we can drop the
whole rollback logic. It has the same minor defect that utsname has,
namely that two writers can race on a non-zero offset. Irrelevant imho.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 59 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 40eca2b85b81..d5d76704df81 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -85,6 +85,8 @@ static int core_uses_pid;
 static unsigned int core_pipe_limit;
 static unsigned int core_sort_vma;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
+/* Taken around every copy in and out of core_pattern. */
+static DEFINE_SPINLOCK(core_pattern_lock);
 static int core_name_size = CORENAME_MAX_SIZE;
 unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
 static atomic_t core_pipe_count = ATOMIC_INIT(0);
@@ -240,11 +242,16 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 			   size_t **argv, int *argc)
 {
 	const struct cred *cred = current_cred();
-	const char *pat_ptr = core_pattern;
+	char pattern[CORENAME_MAX_SIZE];
+	const char *pat_ptr = pattern;
 	bool was_space = false;
 	int pid_in_pattern = 0;
 	int err = 0;
 
+	/* The sysctl handler may be publishing a new pattern. */
+	scoped_guard(spinlock, &core_pattern_lock)
+		strscpy(pattern, core_pattern);
+
 	cprm->mask = COREDUMP_KERNEL;
 	if (core_pipe_limit)
 		cprm->mask |= COREDUMP_WAIT;
@@ -1640,11 +1647,11 @@ void validate_coredump_safety(void)
 	}
 }
 
-static inline bool check_coredump_socket(void)
+static inline bool check_coredump_socket(const char *pattern)
 {
 	const char *p;
 
-	if (core_pattern[0] != '@')
+	if (pattern[0] != '@')
 		return true;
 
 	/*
@@ -1656,16 +1663,16 @@ static inline bool check_coredump_socket(void)
 		return false;
 
 	/* Must be an absolute path... */
-	if (core_pattern[1] != '/') {
+	if (pattern[1] != '/') {
 		/* ... or the socket request protocol... */
-		if (core_pattern[1] != '@')
+		if (pattern[1] != '@')
 			return false;
 		/* ... and if so must be an absolute path. */
-		if (core_pattern[2] != '/')
+		if (pattern[2] != '/')
 			return false;
-		p = &core_pattern[2];
+		p = &pattern[2];
 	} else {
-		p = &core_pattern[1];
+		p = &pattern[1];
 	}
 
 	/* The path obviously cannot exceed UNIX_PATH_MAX. */
@@ -1673,7 +1680,7 @@ static inline bool check_coredump_socket(void)
 		return false;
 
 	/* Must not contain ".." in the path. */
-	if (name_contains_dotdot(core_pattern))
+	if (name_contains_dotdot(pattern))
 		return false;
 
 	return true;
@@ -1682,27 +1689,35 @@ static inline bool check_coredump_socket(void)
 static int proc_dostring_coredump(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
+	char pattern[CORENAME_MAX_SIZE];
+	const struct ctl_table tmp = {
+		.procname	= table->procname,
+		.data		= pattern,
+		.maxlen		= sizeof(pattern),
+	};
+	bool changed = false;
 	int error;
-	ssize_t retval;
-	char old_core_pattern[CORENAME_MAX_SIZE];
-
-	if (!write)
-		return proc_dostring(table, write, buffer, lenp, ppos);
 
-	retval = strscpy(old_core_pattern, core_pattern, CORENAME_MAX_SIZE);
+	/* Work on a copy, proc_dostring() appends at *ppos. */
+	scoped_guard(spinlock, &core_pattern_lock)
+		strscpy(pattern, core_pattern);
 
-	error = proc_dostring(table, write, buffer, lenp, ppos);
-	if (error)
+	error = proc_dostring(&tmp, write, buffer, lenp, ppos);
+	if (error || !write)
 		return error;
 
-	if (!check_coredump_socket()) {
-		strscpy(core_pattern, old_core_pattern, retval + 1);
+	if (!check_coredump_socket(pattern))
 		return -EINVAL;
-	}
 
-	if (strncmp(old_core_pattern, core_pattern, CORENAME_MAX_SIZE))
+	/* Publish the validated pattern whole. */
+	scoped_guard(spinlock, &core_pattern_lock) {
+		changed = strncmp(pattern, core_pattern, CORENAME_MAX_SIZE);
+		if (changed)
+			strscpy(core_pattern, pattern);
+	}
+	if (changed)
 		validate_coredump_safety();
-	return error;
+	return 0;
 }
 
 static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;

-- 
2.53.0

