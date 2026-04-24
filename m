Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230E23C8AE;
	Fri, 24 Apr 2026 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041964; cv=none; b=Tp9ip24m+yh937e/+xNXlFIW35vKAnMN+pWW1958JwJYA+RChkNWhnBGVJYOFlaeJ8AXKIN4fogDXDJ6b4BQq+TNc2udZO3aQkbsQOXwjgRxbBnfK6YmGxXFjtbJNUJYGC8LS+jHzWds434ezkdUA2gvnedmMswB6EIVOS4MoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041964; c=relaxed/simple;
	bh=2nxeSb3OCxyfBIQRPsqYc3RpX1XY3TjU9u3r5uvzTZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4H3o+QiffskkeMnT3ial/rlGvcqIGWOSmCcG4/50+0wpcIjZBsmnd4lXFL9KaV7poH0mg3vUtQcsE1/dKOGfnXQgYJ0rQHaRPN2GtsIee0jYadUy/Pov9EmTWk7/fhjynAjQljOAUc/qjlwe09c6MifEC2GsfcHQcLlmAbNv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matanco.space; spf=pass smtp.mailfrom=matanco.space; dkim=pass (2048-bit key) header.d=matanco.space header.i=@matanco.space header.b=rrN8Mc7Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9HsEAmI; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matanco.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matanco.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matanco.space header.i=@matanco.space header.b="rrN8Mc7Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9HsEAmI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 5E8451380395;
	Fri, 24 Apr 2026 10:46:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 24 Apr 2026 10:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matanco.space;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1777041961; x=1777045561; bh=29EkYimwtX
	Ere1CG5lJ/LdbfXuiXRyivV+3cw26x69M=; b=rrN8Mc7YctQs8WqozcdfHLdFY3
	9nwFTb/0CHE3qkvHp3Z9HXYyHeaOREapyUF4y3IxEsrbJU4AEKWDbWyWbh44VKvq
	T7EA+Nn3RdogMWeYaYoBLBkgQZs1IDjVPsh50cSJV8Rd713nPOeap2hdvhlgtf/9
	siRRM51TV+IA72I5YxH4auljzZr/3gdyQ9ddPMEp40Ovh9GJh+ItIRFtn1TjjAEN
	3gLZ9suzFQ2g/d1sBoMcpbRAYCG0M7+ViqLr5f47urT8+CeQW1wCyMemxmIkBYL/
	qHkJQhjKxWXtML7A+wc25YHfgopa8MjFSz+zLXtnEm8TkMVgb8FvYXQPMCaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777041961; x=1777045561; bh=29EkYimwtXEre1CG5lJ/LdbfXuiXRyivV+3
	cw26x69M=; b=A9HsEAmIhVKyxMvMPMYfTwQOs66USCAP1EuW21IEWzPrDyLW1VU
	SDidU+49v1aEfcLVq3WxdofqdJPEammGlxE4fwG45wWykumy/L4yqHjCgoG7AqDM
	c+tBqdtMr0hAKGgSAMypiyHL90rx2t+a682LLonSEc00lgppske2Q34r4qQeZoyo
	+ipy57uYBtLqAEwx6vNBPcnL4alQfj+53N6iOISl101borudpjc3GTUOx4EUzAyk
	w87CpIUSBwrmKRWJsY1DOey2QME2r8AlijDY2yAym0QYo+IYfrjer+gSoIWg2yz1
	EZ7wUIQOAPsDv1KGwgqf/wjcw5kzUCTJmrw==
X-ME-Sender: <xms:KILrafhWa-mmct2w64neZrB5Uz0FkGyUpojlLP4-HzhfF-VNc4yGcg>
    <xme:KILraW_2pp618o6Ss-LEKy-8LfoPiAo3tv4YHG-jJw3t6BU1UsU2F9g6rPjUM99Sc
    xcAhAvdGFhFL3Qi5T-Ue0gRHafnGhF4Pk_z3OpEjUQRCi1pEwzalTAN>
X-ME-Received: <xmr:KILraeEd2wwIc6XspGXFiI4OZP13bxZABlTksfQZoPHbrhsJIIiN4JdiO1oC-KYeuNpcFOWbUhAu8njQ8lVk-xcce02SW2TGcjMFBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtdefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforghtrghnucevohhh
    vghnuceomhgrthgrnhesmhgrthgrnhgtohdrshhprggtvgeqnecuggftrfgrthhtvghrnh
    epfeekhfehheegvdeugfdvuefhgfeuvddvheekueegfeehgfdugeeiffetgeejjeetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrthgrnh
    esmhgrthgrnhgtohdrshhprggtvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtth
    hopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshgu
    vghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    hsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrg
    htrghnsehmrghtrghntghordhsphgrtggv
X-ME-Proxy: <xmx:KILraRnjXf47PrTHaKWuAfCmAKPsxAqkN5nWoval3NxW2fA70fwbPA>
    <xmx:KILraaYDUpwFLurL7hO30zeqfKiQgl3vALXTo86OQqbqHctrQHYqJg>
    <xmx:KILraeEf6h2nUQH4QjD15uiGvei3JAffHXxT5yvJX470JiS_7MzJ5A>
    <xmx:KILraTKNdN4bCynTFuqSAU4Z-pZivZSd8TaPAdeJ6iN_uWcXUWTlIQ>
    <xmx:KILraU4JPtyBdFl467mN_xDdRmGfnKQ3j-AGQJy0yziMAK9IbceK-bal>
Feedback-ID: i07264b6d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 10:45:58 -0400 (EDT)
From: Matan Cohen <matan@matanco.space>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matan Cohen <matan@matanco.space>
Subject: [PATCH] fuse: expose backing files in the daemon's fd table
Date: Fri, 24 Apr 2026 14:45:53 +0000
Message-ID: <20260424144553.6241-1-matan@matanco.space>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUSE passthrough backing files are currently not installed in the
daemon's fd table, making them invisible to lsof(8) and /proc/<pid>/fd.
This complicates debugging and is the reason passthrough currently
requires CAP_SYS_ADMIN.

Install each backing file into the daemon's fd table on BACKING_OPEN
and close it on BACKING_CLOSE.  Add an fd field to struct fuse_backing
to carry the installed fd number.

BACKING_CLOSE always runs in the daemon's ioctl context, so close_fd()
targets the correct fd table directly.

To handle fds that remain open at connection teardown (e.g. on umount
or connection abort without an explicit BACKING_CLOSE), store a
reference to the daemon's task_struct in fc->daemon_task on the first
BACKING_OPEN.  During teardown, fuse_backing_files_free() schedules a
task_work callback on the daemon task that calls close_fd() from the
daemon's own context.  If the daemon has already exited (task_work_add
returns -ESRCH), its fd table was already cleaned up on exit.

This is a prerequisite for relaxing the CAP_SYS_ADMIN requirement on
FUSE passthrough; a follow-up patch will drop the capability check now
that backing fds are accountable via /proc/<pid>/fd.

Signed-off-by: Matan Cohen <matan@matanco.space>
---
 fs/fuse/backing.c                             |  97 +++++-
 fs/fuse/fuse_i.h                              |  15 +
 .../selftests/filesystems/fuse/.gitignore     |   1 +
 .../selftests/filesystems/fuse/Makefile       |   2 +-
 .../filesystems/fuse/fuse_passthrough_test.c  | 297 ++++++++++++++++++
 5 files changed, 405 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_passthrough_test.c

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index d95dfa48483f0..9c4ac0388491c 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -8,6 +8,8 @@
 #include "fuse_i.h"
 
 #include <linux/file.h>
+#include <linux/fdtable.h>
+#include <linux/task_work.h>
 
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 {
@@ -20,6 +22,7 @@ static void fuse_backing_free(struct fuse_backing *fb)
 {
 	pr_debug("%s: fb=0x%p\n", __func__, fb);
 
+	WARN_ON_ONCE(fb->fd >= 0);
 	if (fb->file)
 		fput(fb->file);
 	put_cred(fb->cred);
@@ -64,19 +67,63 @@ static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
 	return fb;
 }
 
+struct fuse_backing_close_work {
+	struct callback_head cb;
+	int fd;
+};
+
+static void fuse_backing_close_fd(struct callback_head *cb)
+{
+	struct fuse_backing_close_work *w =
+		container_of(cb, struct fuse_backing_close_work, cb);
+	close_fd(w->fd);
+	kfree(w);
+}
+
 static int fuse_backing_id_free(int id, void *p, void *data)
 {
+	struct fuse_conn *fc = data;
 	struct fuse_backing *fb = p;
 
 	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
+
+	if (fb->fd >= 0 && fc->daemon_task) {
+		struct fuse_backing_close_work *w;
+
+		w = kmalloc_obj(*w, GFP_ATOMIC);
+		if (w) {
+			init_task_work(&w->cb, fuse_backing_close_fd);
+			w->fd = fb->fd;
+			/*
+			 * Schedule close_fd() to run in the daemon's context.
+			 * TWA_RESUME fires on the daemon's next return to
+			 * userspace -- in practice immediately after its
+			 * blocked read() unblocks with an error at teardown.
+			 * -ESRCH means the daemon already exited and closed
+			 * all its fds; nothing to do.
+			 */
+			if (task_work_add(fc->daemon_task, &w->cb, TWA_RESUME))
+				kfree(w);
+		} else {
+			pr_warn_ratelimited("fuse: failed to close backing fd %d on teardown\n",
+					    fb->fd);
+		}
+		fb->fd = -1;
+	}
+
 	fuse_backing_free(fb);
 	return 0;
 }
 
 void fuse_backing_files_free(struct fuse_conn *fc)
 {
-	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
+	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, fc);
 	idr_destroy(&fc->backing_files_map);
+
+	if (fc->daemon_task) {
+		put_task_struct(fc->daemon_task);
+		fc->daemon_task = NULL;
+	}
 }
 
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
@@ -117,21 +164,50 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	if (!fb)
 		goto out_fput;
 
-	fb->file = file;
+	/*
+	 * Capture the daemon's task on the first BACKING_OPEN so that
+	 * fuse_backing_files_free() can schedule fd closes via task_work
+	 * during teardown, even when teardown runs outside daemon context.
+	 */
+	if (!fc->daemon_task) {
+		spin_lock(&fc->lock);
+		if (!fc->daemon_task)
+			fc->daemon_task = get_task_struct(current);
+		spin_unlock(&fc->lock);
+	}
+
+	fb->file = file;	/* fget_raw ref transferred */
+	fb->fd = -1;
 	fb->cred = prepare_creds();
+	if (!fb->cred) {
+		res = -ENOMEM;
+		goto out_free;
+	}
 	refcount_set(&fb->count, 1);
+	fb->fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fb->fd < 0) {
+		res = fb->fd;
+		goto out_free;
+	}
+	get_file(file);
+	fd_install(fb->fd, file);
 
 	res = fuse_backing_id_alloc(fc, fb);
-	if (res < 0) {
-		fuse_backing_free(fb);
-		fb = NULL;
-	}
+	if (res < 0)
+		goto out_close_fd;
 
 out:
 	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
 
 	return res;
 
+out_close_fd:
+	close_fd(fb->fd);
+	fb->fd = -1;
+out_free:
+	fuse_backing_free(fb);
+	fb = NULL;
+	goto out;
 out_fput:
 	fput(file);
 	goto out;
@@ -158,6 +234,15 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 	if (!fb)
 		goto out;
 
+	/*
+	 * Close the fd installed in the daemon's fd table on BACKING_OPEN.
+	 * BACKING_CLOSE always runs in the daemon's ioctl context, so
+	 * close_fd() targets the correct fd table.
+	 */
+	if (fb->fd >= 0) {
+		close_fd(fb->fd);
+		fb->fd = -1;
+	}
 	fuse_backing_put(fb);
 	err = 0;
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 17423d4e3cfa6..0edda751747a2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -107,6 +107,14 @@ struct fuse_submount_lookup {
 struct fuse_backing {
 	struct file *file;
 	struct cred *cred;
+	/**
+	 * fd: fd installed in the daemon's fd table on BACKING_OPEN, or -1.
+	 * Valid only while this entry is in fc->backing_files_map.
+	 * Closed by BACKING_CLOSE (daemon ioctl context) or by a task_work
+	 * callback scheduled on fc->daemon_task during connection teardown.
+	 * Must be -1 before fuse_backing_free() is called.
+	 */
+	int fd;
 
 	/** refcount */
 	refcount_t count;
@@ -979,6 +987,13 @@ struct fuse_conn {
 #ifdef CONFIG_FUSE_PASSTHROUGH
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
+	/**
+	 * daemon_task: task_struct of the daemon, held with a reference.
+	 * Used during connection teardown to schedule task_work that closes
+	 * any remaining backing fds in the daemon's fd table.  Set on the
+	 * first BACKING_OPEN ioctl; NULL if no backing files were registered.
+	 */
+	struct task_struct *daemon_task;
 #endif
 
 #ifdef CONFIG_FUSE_IO_URING
diff --git a/tools/testing/selftests/filesystems/fuse/.gitignore b/tools/testing/selftests/filesystems/fuse/.gitignore
index 3e72e742d08e8..ef1ff428aa7a6 100644
--- a/tools/testing/selftests/filesystems/fuse/.gitignore
+++ b/tools/testing/selftests/filesystems/fuse/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 fuse_mnt
 fusectl_test
+fuse_passthrough_test
diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/testing/selftests/filesystems/fuse/Makefile
index 612aad69a93aa..494042ebc4f2c 100644
--- a/tools/testing/selftests/filesystems/fuse/Makefile
+++ b/tools/testing/selftests/filesystems/fuse/Makefile
@@ -2,7 +2,7 @@
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := fusectl_test
+TEST_GEN_PROGS := fusectl_test fuse_passthrough_test
 TEST_GEN_FILES := fuse_mnt
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/fuse/fuse_passthrough_test.c b/tools/testing/selftests/filesystems/fuse/fuse_passthrough_test.c
new file mode 100644
index 0000000000000..31cfced89ca8e
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fuse_passthrough_test.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that FUSE backing files are visible in /proc/self/fd
+ *
+ * When FUSE passthrough mode registers a backing file via
+ * FUSE_DEV_IOC_BACKING_OPEN, that file should remain visible in
+ * /proc/self/fd of the daemon process so that tools like lsof can
+ * observe it. This test verifies that behavior.
+ *
+ * Requires: root (CAP_SYS_ADMIN), CONFIG_FUSE_PASSTHROUGH=y
+ */
+
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/fuse.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../../kselftest.h"
+
+#define FUSE_DEV	"/dev/fuse"
+#define BUF_SIZE	131072
+
+/*
+ * FUSE_PASSTHROUGH is bit 37.  The protocol splits flags across two
+ * 32-bit fields: flags holds bits 0-31, flags2 holds bits 32-63
+ * shifted right by 32.
+ */
+#define FUSE_PASSTHROUGH_FLAGS2	((uint32_t)(FUSE_PASSTHROUGH >> 32))
+
+/* Count /proc/self/fd symlinks that resolve to @path. */
+static int count_proc_fd_refs(const char *path)
+{
+	DIR *dir;
+	struct dirent *de;
+	char link_target[PATH_MAX];
+	char proc_entry[PATH_MAX];
+	int count = 0;
+
+	dir = opendir("/proc/self/fd");
+	if (!dir)
+		return -1;
+
+	while ((de = readdir(dir)) != NULL) {
+		ssize_t len;
+
+		if (de->d_name[0] == '.')
+			continue;
+
+		snprintf(proc_entry, sizeof(proc_entry),
+			 "/proc/self/fd/%s", de->d_name);
+		len = readlink(proc_entry, link_target, sizeof(link_target) - 1);
+		if (len < 0)
+			continue;
+		link_target[len] = '\0';
+
+		if (strcmp(link_target, path) == 0)
+			count++;
+	}
+
+	closedir(dir);
+	return count;
+}
+
+/*
+ * Minimal FUSE daemon: performs the INIT handshake with FUSE_PASSTHROUGH
+ * enabled, registers @backing_path as a backing file, writes the
+ * /proc/self/fd ref counts before and after BACKING_CLOSE into
+ * @result_pipe, then drains requests until the mount is torn down.
+ */
+static void run_daemon(int fuse_fd, const char *backing_path, int result_pipe)
+{
+	char buf[BUF_SIZE];
+	struct fuse_in_header *in_hdr;
+	struct {
+		struct fuse_out_header	hdr;
+		struct fuse_init_out	init;
+	} init_reply;
+	struct {
+		struct fuse_out_header	hdr;
+	} err_reply;
+	struct fuse_backing_map map = {};
+	ssize_t len;
+	int backing_fd;
+	int backing_id;
+	uint32_t close_id;
+	int fd_count_open = -1;
+	int fd_count_close = -1;
+
+	len = read(fuse_fd, buf, sizeof(buf));
+	if (len < 0) {
+		ksft_print_msg("daemon: read INIT: %s\n", strerror(errno));
+		goto out;
+	}
+
+	in_hdr = (struct fuse_in_header *)buf;
+	if (in_hdr->opcode != FUSE_INIT) {
+		ksft_print_msg("daemon: expected FUSE_INIT, got %u\n",
+			       in_hdr->opcode);
+		goto out;
+	}
+
+	memset(&init_reply, 0, sizeof(init_reply));
+	init_reply.hdr.len	= sizeof(init_reply);
+	init_reply.hdr.unique	= in_hdr->unique;
+	init_reply.init.major		= FUSE_KERNEL_VERSION;
+	init_reply.init.minor		= FUSE_KERNEL_MINOR_VERSION;
+	init_reply.init.max_readahead	= 65536;
+	init_reply.init.flags		= FUSE_INIT_EXT;
+	init_reply.init.max_write	= 65536;
+	init_reply.init.max_pages	= 256;
+	init_reply.init.flags2		= FUSE_PASSTHROUGH_FLAGS2;
+	init_reply.init.max_stack_depth	= 1;
+
+	if (write(fuse_fd, &init_reply, sizeof(init_reply)) < 0) {
+		ksft_print_msg("daemon: write INIT reply: %s\n", strerror(errno));
+		goto out;
+	}
+
+	backing_fd = open(backing_path, O_RDWR);
+	if (backing_fd < 0) {
+		ksft_print_msg("daemon: open backing file: %s\n", strerror(errno));
+		goto out;
+	}
+
+	map.fd = backing_fd;
+	backing_id = ioctl(fuse_fd, FUSE_DEV_IOC_BACKING_OPEN, &map);
+	if (backing_id < 0) {
+		ksft_print_msg("daemon: FUSE_DEV_IOC_BACKING_OPEN: %s\n",
+			       strerror(errno));
+		close(backing_fd);
+		goto out;
+	}
+
+	/*
+	 * Close our own fd.  The kernel now holds the only reference via
+	 * its backing_files_map.  Check whether the file is still visible
+	 * in /proc/self/fd -- it should be, via the fd installed by the kernel.
+	 */
+	close(backing_fd);
+	fd_count_open = count_proc_fd_refs(backing_path);
+
+	close_id = (uint32_t)backing_id;
+	ioctl(fuse_fd, FUSE_DEV_IOC_BACKING_CLOSE, &close_id);
+	fd_count_close = count_proc_fd_refs(backing_path);
+
+out:
+	/* Signal results before draining so the parent can proceed to unmount. */
+	if (write(result_pipe, &fd_count_open, sizeof(fd_count_open)) < 0 ||
+	    write(result_pipe, &fd_count_close, sizeof(fd_count_close)) < 0)
+		ksft_print_msg("daemon: write result pipe: %s\n", strerror(errno));
+
+	while (1) {
+		len = read(fuse_fd, buf, sizeof(buf));
+		if (len <= 0)
+			break;
+
+		in_hdr = (struct fuse_in_header *)buf;
+		memset(&err_reply, 0, sizeof(err_reply));
+		err_reply.hdr.len    = sizeof(err_reply);
+		err_reply.hdr.error  = -ENOSYS;
+		err_reply.hdr.unique = in_hdr->unique;
+		if (write(fuse_fd, &err_reply, sizeof(err_reply)) < 0)
+			break;
+	}
+}
+
+int main(void)
+{
+	char tmpdir[] = "/tmp/fuse_backing_test_XXXXXX";
+	char mntpoint[PATH_MAX];
+	char backing_path[PATH_MAX];
+	char mount_opts[64];
+	int fuse_fd = -1;
+	int pipe_fds[2] = {-1, -1};
+	int tmp_fd;
+	pid_t daemon_pid;
+	int fd_count_open = -1;
+	int fd_count_close = -1;
+	int status;
+
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	if (geteuid() != 0)
+		ksft_exit_skip("requires root (CAP_SYS_ADMIN)\n");
+
+	if (!mkdtemp(tmpdir))
+		ksft_exit_fail_msg("mkdtemp: %s\n", strerror(errno));
+
+	snprintf(mntpoint, sizeof(mntpoint), "%s/mnt", tmpdir);
+	snprintf(backing_path, sizeof(backing_path), "%s/backing_file", tmpdir);
+
+	if (mkdir(mntpoint, 0700) < 0) {
+		ksft_print_msg("mkdir mntpoint: %s\n", strerror(errno));
+		goto cleanup_tmpdir;
+	}
+
+	tmp_fd = open(backing_path, O_CREAT | O_RDWR, 0600);
+	if (tmp_fd < 0) {
+		ksft_print_msg("create backing file: %s\n", strerror(errno));
+		goto cleanup_dirs;
+	}
+	close(tmp_fd);
+
+	fuse_fd = open(FUSE_DEV, O_RDWR);
+	if (fuse_fd < 0) {
+		ksft_print_msg("open %s: %s\n", FUSE_DEV, strerror(errno));
+		goto cleanup_files;
+	}
+
+	if (pipe(pipe_fds) < 0) {
+		ksft_print_msg("pipe: %s\n", strerror(errno));
+		goto cleanup_fuse;
+	}
+
+	daemon_pid = fork();
+	if (daemon_pid < 0) {
+		ksft_print_msg("fork: %s\n", strerror(errno));
+		goto cleanup_pipe;
+	}
+
+	if (daemon_pid == 0) {
+		close(pipe_fds[0]);
+		run_daemon(fuse_fd, backing_path, pipe_fds[1]);
+		close(pipe_fds[1]);
+		exit(0);
+	}
+
+	close(pipe_fds[1]);
+	pipe_fds[1] = -1;
+
+	snprintf(mount_opts, sizeof(mount_opts),
+		 "fd=%d,rootmode=040000,user_id=0,group_id=0", fuse_fd);
+
+	if (mount("fuse.test", mntpoint, "fuse", MS_NOSUID | MS_NODEV,
+		  mount_opts) < 0) {
+		ksft_print_msg("mount: %s\n", strerror(errno));
+		kill(daemon_pid, SIGTERM);
+		waitpid(daemon_pid, &status, 0);
+		goto cleanup_pipe;
+	}
+
+	if (read(pipe_fds[0], &fd_count_open, sizeof(fd_count_open)) != sizeof(fd_count_open) ||
+	    read(pipe_fds[0], &fd_count_close, sizeof(fd_count_close)) != sizeof(fd_count_close))
+		ksft_print_msg("read result pipe: %s\n", strerror(errno));
+
+	umount2(mntpoint, MNT_DETACH);
+	waitpid(daemon_pid, &status, 0);
+
+	if (fd_count_open == 1)
+		ksft_test_result_pass(
+			"backing file visible in /proc/self/fd after BACKING_OPEN\n");
+	else if (fd_count_open == 0)
+		ksft_test_result_fail(
+			"backing file NOT visible in /proc/self/fd after BACKING_OPEN\n");
+	else
+		ksft_test_result_fail(
+			"BACKING_OPEN: unexpected fd_count=%d\n", fd_count_open);
+
+	if (fd_count_close == 0)
+		ksft_test_result_pass(
+			"backing file removed from /proc/self/fd after BACKING_CLOSE\n");
+	else if (fd_count_close == 1)
+		ksft_test_result_fail(
+			"backing file still visible in /proc/self/fd after BACKING_CLOSE\n");
+	else
+		ksft_test_result_fail(
+			"BACKING_CLOSE: unexpected fd_count=%d\n", fd_count_close);
+
+cleanup_pipe:
+	if (pipe_fds[0] >= 0)
+		close(pipe_fds[0]);
+	if (pipe_fds[1] >= 0)
+		close(pipe_fds[1]);
+cleanup_fuse:
+	if (fuse_fd >= 0)
+		close(fuse_fd);
+cleanup_files:
+	unlink(backing_path);
+cleanup_dirs:
+	rmdir(mntpoint);
+cleanup_tmpdir:
+	rmdir(tmpdir);
+
+	ksft_finished();
+}
-- 
2.43.0

