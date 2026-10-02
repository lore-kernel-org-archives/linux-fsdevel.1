Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DAB4BB5DE;
	Fri,  2 Oct 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949247; cv=none; b=WuURzPoXtTt5I+uRXc7eAfVYguxOTY2PxNv8pE7D9osXqva24QfnqPHJeoyNM2YXwbfqF5ascPgc7l0Egm7zxCqH3HASvgB/qkL+Nl2ixMJ/u79SWp1+uc5XPheEJhthcxFapCoz7OcHKVPGzhi/Kwm273QIlAi659X0OGDSvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949247; c=relaxed/simple;
	bh=IoNfPAJCstFFmjylj9ccqtenSjICQVDGo1zt1drMIHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvacYGK5b6/GTyJxzw55Z+6Az06kXivYly1dqJrcAQCKbZmG5bHVowSkvHp/+YCkx/NFTU/0sCai3QV3JMMurKhqwrIhI+MLPYlbY/qABVr3MocRSmfclbcWZInzkaHyiPwmSyzZwGVtgs7KdFxMeP024JSDfglAJ9Ewi/E3jDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oigTOZtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oigTOZtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C781F000FF;
	Fri,  2 Oct 2026 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949245;
	bh=vd18R7hktmmmVvZRwsV0vT6Er0pxSOqADxdsRmONpkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oigTOZtJFDGiWZeGH0Q7kBzEQ7N2AXFnv5mfQ45A+Y23BI1Rwo6QvAexYfuTTf6nX
	 wGNLz9FxRVn1PEW9dy0EU9VTxQcnCK5SMxC2VH3ZP3bX9VZxLJxVI9nGVBW7lSq71j
	 Hvt0xJuIub2wljzbyNeVW1EvlR4WVJt0vl4gZs/wC425aDkypFR6TWVxGjs6ZrvRTt
	 fEmKf0vok1CczFgzAeXkMtaRl8dCHmy4r0DDfEjZ3ZVMMOcQDauVLXi554BrC4iYOG
	 TdbG1PtbI2LRD7t4vYHIvOIDssQNSIfKEtSGJ8QbWS3fu0DtgvVVWYxmFnXFdruF1Q
	 sQdmxuqouOKRQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:43 +0200
Subject: [PATCH 12/21] selftests/filesystems: check that an automount below
 an overlay layer is refused
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-12-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=6399; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IoNfPAJCstFFmjylj9ccqtenSjICQVDGo1zt1drMIHc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x7ZKvvmU4Kk2ZpaniqLm1tuzOebIXq8YquG04sff
 y+fenX8aUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEOF4wMrz8HMd+S+u0TGb/
 iq5rliZT5nqeeZvD9PijPNOlr4dWX/VgZGh8+W1xhKjkadNZM3rlL7S4V3Ct0ftWx/j+rvcHzTC
 Op8wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make sure that we don't automount on top of internal things.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/overlayfs/.gitignore     |   1 +
 .../selftests/filesystems/overlayfs/Makefile       |   1 +
 .../filesystems/overlayfs/automount_in_layer.c     | 174 +++++++++++++++++++++
 3 files changed, 176 insertions(+)

diff --git a/tools/testing/selftests/filesystems/overlayfs/.gitignore b/tools/testing/selftests/filesystems/overlayfs/.gitignore
index 077f7a128168..b343cc430051 100644
--- a/tools/testing/selftests/filesystems/overlayfs/.gitignore
+++ b/tools/testing/selftests/filesystems/overlayfs/.gitignore
@@ -2,3 +2,4 @@
 dev_in_maps
 set_layers_via_fds
 idmapped_mounts
+automount_in_layer
diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
index b3185f684add..382a59bda5e7 100644
--- a/tools/testing/selftests/filesystems/overlayfs/Makefile
+++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
@@ -9,6 +9,7 @@ LOCAL_HDRS += ../wrappers.h log.h
 TEST_GEN_PROGS := dev_in_maps
 TEST_GEN_PROGS += set_layers_via_fds
 TEST_GEN_PROGS += idmapped_mounts
+TEST_GEN_PROGS += automount_in_layer
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/filesystems/overlayfs/automount_in_layer.c b/tools/testing/selftests/filesystems/overlayfs/automount_in_layer.c
new file mode 100644
index 000000000000..0476c4582bdf
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/automount_in_layer.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A layer of an overlay is a private clone of the mount it was given and
+ * belongs to no mount namespace. fanotify hands out descriptors on it. An
+ * automount triggered through one has no namespace to go into: the open has
+ * to fail, not oops with namespace_sem held.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/magic.h>
+#include <sys/fanotify.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/vfs.h>
+
+#include "../../kselftest_harness.h"
+
+#define DIR_LEN		64
+#define PATH_LEN	192
+
+static bool have_fs(const char *name)
+{
+	char line[128];
+	bool found = false;
+	FILE *f;
+
+	f = fopen("/proc/filesystems", "re");
+	if (!f)
+		return false;
+	while (fgets(line, sizeof(line), f)) {
+		char *nl = strchr(line, '\n');
+		char *tab = strchr(line, '\t');
+
+		if (nl)
+			*nl = 0;
+		if (tab && !strcmp(tab + 1, name))
+			found = true;
+	}
+	fclose(f);
+	return found;
+}
+
+static int mnt_id_of(int fd)
+{
+	char path[64], buf[4096], *p;
+	ssize_t n;
+	int info;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", fd);
+	info = open(path, O_RDONLY | O_CLOEXEC);
+	if (info < 0)
+		return -1;
+	n = read(info, buf, sizeof(buf) - 1);
+	close(info);
+	if (n <= 0)
+		return -1;
+	buf[n] = 0;
+	p = strstr(buf, "mnt_id:");
+	return p ? atoi(p + strlen("mnt_id:")) : -1;
+}
+
+static bool on_debugfs(int fd)
+{
+	struct statfs sf;
+
+	return !fstatfs(fd, &sf) && sf.f_type == DEBUGFS_MAGIC;
+}
+
+FIXTURE(layer) {
+	char base[DIR_LEN];
+	int fan;
+	int evfd;	/* on the layer clone of the lower debugfs */
+};
+
+FIXTURE_SETUP(layer)
+{
+	char lower[PATH_LEN], other[PATH_LEN], ovl[PATH_LEN], opts[2 * PATH_LEN + 16];
+	struct fanotify_event_metadata *ev;
+	struct pollfd pfd;
+	char buf[4096];
+	int lfd, lower_id;
+	ssize_t n;
+	DIR *d;
+
+	self->fan = -1;
+	self->evfd = -1;
+	if (geteuid())
+		SKIP(return, "test requires root");
+	if (!have_fs("debugfs") || !have_fs("tracefs"))
+		SKIP(return, "test requires debugfs with the tracefs automount");
+	if (!have_fs("overlay"))
+		SKIP(return, "test requires overlayfs");
+
+	snprintf(self->base, sizeof(self->base), "/tmp/layer.XXXXXX");
+	ASSERT_NE(mkdtemp(self->base), NULL);
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+	ASSERT_EQ(mount("tmpfs", self->base, "tmpfs", 0, "mode=0755"), 0);
+	snprintf(lower, sizeof(lower), "%s/lower", self->base);
+	snprintf(other, sizeof(other), "%s/other", self->base);
+	snprintf(ovl, sizeof(ovl), "%s/ovl", self->base);
+	ASSERT_EQ(mkdir(lower, 0755), 0);
+	ASSERT_EQ(mkdir(other, 0755), 0);
+	ASSERT_EQ(mkdir(ovl, 0755), 0);
+	ASSERT_EQ(mount("debugfs", lower, "debugfs", 0, NULL), 0);
+	snprintf(opts, sizeof(opts), "lowerdir=%s:%s", lower, other);
+	ASSERT_EQ(mount("overlay", ovl, "overlay", MS_RDONLY, opts), 0);
+
+	self->fan = fanotify_init(FAN_CLASS_NOTIF | FAN_NONBLOCK | FAN_CLOEXEC,
+				  O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(self->fan, 0);
+	ASSERT_EQ(fanotify_mark(self->fan, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+				FAN_OPEN | FAN_ONDIR, AT_FDCWD, lower), 0);
+	lfd = open(lower, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(lfd, 0);
+	lower_id = mnt_id_of(lfd);
+	close(lfd);
+
+	/* the overlay opens its lower directory through the layer clone */
+	d = opendir(ovl);
+	ASSERT_NE(d, NULL);
+	closedir(d);
+	pfd.fd = self->fan;
+	pfd.events = POLLIN;
+	ASSERT_EQ(poll(&pfd, 1, 5000), 1);
+	n = read(self->fan, buf, sizeof(buf));
+	ASSERT_GT(n, 0);
+	for (ev = (void *)buf; FAN_EVENT_OK(ev, n); ev = FAN_EVENT_NEXT(ev, n)) {
+		if (ev->fd < 0)
+			continue;
+		if (self->evfd < 0 && on_debugfs(ev->fd) &&
+		    mnt_id_of(ev->fd) != lower_id)
+			self->evfd = ev->fd;
+		else
+			close(ev->fd);
+	}
+	ASSERT_GE(self->evfd, 0)
+		TH_LOG("no event on the layer clone");
+}
+
+FIXTURE_TEARDOWN(layer)
+{
+	if (self->evfd >= 0)
+		close(self->evfd);
+	if (self->fan >= 0)
+		close(self->fan);
+	umount2(self->base, MNT_DETACH);
+	rmdir(self->base);
+}
+
+TEST_F(layer, automount_below_the_clone_is_refused)
+{
+	struct stat st;
+	int fd;
+
+	/* the automount point is there */
+	ASSERT_EQ(fstatat(self->evfd, "tracing", &st, AT_NO_AUTOMOUNT), 0);
+	/* the clone is in no namespace, so the automount has nowhere to go */
+	fd = openat(self->evfd, "tracing", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	EXPECT_LT(fd, 0);
+	EXPECT_EQ(errno, EINVAL);
+	if (fd >= 0)
+		close(fd);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

