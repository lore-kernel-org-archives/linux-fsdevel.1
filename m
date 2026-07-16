Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3C3876DE;
	Thu, 16 Jul 2026 05:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179685; cv=pass; b=cgqvvJuuYVLsvyEIbpVt3v4viXy/I9o4fnbv0cpeR3kOQQse3XqUrM7HAk9Z/dHxhTPT9X7aFkLXz/Jqi43APRIuZJkAvCxmwV/XbWhWgTjIIfI1QfRtyHWttlA6XPGmMBvQxNW5FaTY1rohdqyt/KcFYikVAXonKHQmeaooUcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179685; c=relaxed/simple;
	bh=e0+fR+NPwVaC4H/KOewx9kZPVM8BUDk8Cel6q81uq8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NHzMIHxQphErwHmoGS5MtON0idHsZ9XSS0poyTtNh8Sjn3MBFpfIAnFm6j++sSF5Zu3HfnQkNb+JxB1mNj5j9AXQk5qTB9ySCHBZ3HANv7+XSf/IlJDJJJUlAjN01TGYIH6+sSCYpMWLMCKR9D3WexijsSNrm/Ewz/zI3f71514=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=sf2IorRC; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="sf2IorRC"
ARC-Seal: i=1; a=rsa-sha256; t=1784179666; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fbPqJFaJ+ft6BqVPaMq6wLPL+/GMvbVE4Z7qG+/zfzDZUy3hhxbdsAkW+nabXmWp3yhrHB9NQFdgf92lJQw1vaeJULXskSYKxF6t0XgCh1aLwR2E9N3w5DcuKm9TtFsPRmfaQoDqFp+ie0yT8MP6gc/6SzI/zpyr/sQk+7Heoyk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784179666; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ppnREthApipiY+d6EwEoXxvC9z+jfkcK5oFpaQgQY1Y=; 
	b=fodtc5etp5EfAW87q1tDHd6nFsKKnBWaaS/wOqpodbPFECUSEqszG28r4pCXnyyzVXBs1s7CgA8yh4YCaanESLL5lxoNRKydeCR9ROVDq8GxTp3fGLI/yRyI0jP21QiYqnVpCwGF7SPuXtbhZdyxHo57K16tNnJzJmh25EkWph8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784179665;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ppnREthApipiY+d6EwEoXxvC9z+jfkcK5oFpaQgQY1Y=;
	b=sf2IorRC5fE85diQKpNQGDsbhx0SfN5IQ8loUuVRXMgaFeMZf4sco+StU2Gx3wvm
	KErZjLWWcApM+dLKrzvege7SkIGI/jlMUX0no8/GCpqncTO2Niu6MwDJ/SNC2VLz/I4
	JFc8u981R1zqI6V8pIY82Q7S5uh5IQ1n5cZsDOIw=
Received: by mx.zohomail.com with SMTPS id 1784179662386997.6733672438661;
	Wed, 15 Jul 2026 22:27:42 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Li Chen <me@linux.beauty>
Subject: [PATCH] pidfs: preserve thread pidfds reopened by file handle
Date: Thu, 16 Jul 2026 13:27:22 +0800
Message-ID: <20260716052726.1032092-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

PIDFD_THREAD shares O_EXCL. do_dentry_open() clears O_EXCL after
pidfs_export_open() validates the flags, so open_by_handle_at()
silently turns a thread pidfd into a process pidfd.

Restore PIDFD_THREAD on the opened file, matching pidfs_alloc_file(),
and cover the restored flag with F_GETFL.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/pidfs.c                                             | 8 +++++++-
 tools/testing/selftests/pidfd/pidfd_file_handle_test.c | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index aaa609ddab044..c20ffd747ff51 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -939,12 +939,18 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
 
 static struct file *pidfs_export_open(const struct path *path, unsigned int oflags)
 {
+	struct file *file;
+
 	/*
 	 * Clear O_LARGEFILE as open_by_handle_at() forces it and raise
 	 * O_RDWR as pidfds always are.
 	 */
 	oflags &= ~O_LARGEFILE;
-	return dentry_open(path, oflags | O_RDWR, current_cred());
+	file = dentry_open(path, oflags | O_RDWR, current_cred());
+	/* do_dentry_open() strips O_EXCL, which encodes PIDFD_THREAD. */
+	if (!IS_ERR(file))
+		file->f_flags |= oflags & PIDFD_THREAD;
+	return file;
 }
 
 static const struct export_operations pidfs_export_operations = {
diff --git a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
index 68918734dcf32..1e03ae9575fe6 100644
--- a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
@@ -373,6 +373,7 @@ TEST_F(file_handle, open_by_handle_at_valid_flags)
 				  O_CLOEXEC |
 				  O_EXCL);
 	ASSERT_GE(pidfd, 0);
+	ASSERT_NE(fcntl(pidfd, F_GETFL) & PIDFD_THREAD, 0);
 
 	ASSERT_EQ(fstat(pidfd, &st2), 0);
 	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
-- 
2.52.0

