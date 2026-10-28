Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164543;
	b=w+CIiIn6rxip86VzwqkCWPhm1iKq+vYK84gQqPzBVVoV00KntMXsLgDj98PA/le9UqTQ
	 YALniFuU/3Ad2fMwvrwXCOjUo1ZFbwKxb2gwa50uiSxkH69AxpG+H/51gob96kIEGG7M3
	 xIBLcNqkJLha7YY5eHSOqDVqCj70JzABf+VnAE594WcoKzYFetp2wVnXe81fB03izwm1a
	 fBDjHjCVzvRc1S3838Okp2PWzpiwg0ZbHnIOasGpdmgh1nP7l+b01vgXKthb11gh4TEp4
	 VQpklM4E11PTlmYsr/NwyB3Ap2lebiMqexmIyIUORDZhU7JAUABEnJgXFLpaq5pqBqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Yj2icuvOpo7K2PUVpGV+n/piexMtVazEmDnEiQ20ik=;
	b=zmidmA6HQpRE6ba77/GOqJQPjnCV4Ol14YnvIdDoA2R7xEU6hx2Y5HDnSKzjNDGPa1Gt
	 v3pvVK1VC96+nnSi/ccEHL2QL9xbOz82UZ9uEquT6Ne0LHSRhTWZp287badULN63FsG7+
	 BHRssoDMMJtx7xbSwBmKqYQcmi1WNNlaM1HkxG6x3kN6+H1iLAU8UwGjuDswpuETeK/OK
	 ZZ9+8+ZP9912/YgG1t5XqeXNaErYcbkyjihJmt8sQjFkU+QWIcNmahBJpKak5+rfbV4o3
	 iheRHHl5o0OqvORCvP+NL2p8HtV13tqpbc64bDoOZVjmpKyy81e1iTWsksjFudLsYqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cmiHdW9I;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE2B606A31A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 05:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE2B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cmiHdW9I
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso447189eec.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 22:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793164542; x=1793769342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Yj2icuvOpo7K2PUVpGV+n/piexMtVazEmDnEiQ20ik=;
        b=cmiHdW9Ivt5TA6I9WuIU54jo1s5S6aE1Nji2KcPKClAt2L2CAIMcE9q2jbM55U8PhR
         T8kZEfDJxaoQ18XyvMngoHdLTkYTpKVWW+tKYy8SSTQI1SLbWAf7wn/M4VtUIFLHbL8Q
         sJIftJZiRbry/wAl559LSvPq6SFrA0re1ht3Qt4vjV4vKDM/qxUSt60Diih3jLCvjHzK
         BzFb9C/r5LyXYfyaUJRljT/eEUMZqAY0LyDmqNC5CuXAwst3m0jXQK4WswA5QpKMNYKW
         dJ4izpdkltwfZUwBZvEllQF2BxTRVLb38N1zVRo7/Tim+G3ZzmkNUcORLlm4DIsX/tWK
         CSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793164542; x=1793769342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Yj2icuvOpo7K2PUVpGV+n/piexMtVazEmDnEiQ20ik=;
        b=EvWkuuW8KmWXu1SWTq9J1/ul8LXVKVtoGWNXpAuuOTLODSNcvTUxHzI5PLk6qPof0o
         prnNqSvGsNQKOA0RkoeEl+GtdzubFauZW6NpwMUAR5vE99CuYU1TFYp73/2T8vh37ujS
         F7osPrl8PBEQ7/DRxuBiU0hFUxxFCpN5zG2T3h1OImGCKeufbayXZE42/xNQs1UQDgGL
         25vpg+qOxgNyevIo3/BWrKgbAVIoP30V01oNuGgbk5FhEl0GJywPv2EPqUHXj49zttU7
         G+8wTtYCgRVYgU8vNbpXQUK7vMPeY19DkVfL9ZQUvI3qd9jpVi+xv8tXBPfwr9c4xQse
         IYZA==
X-Forwarded-Encrypted: i=1; AKwUvBzh8AUIP51o7/t2I2PAEsxQjRFekSKEblViKjktfHnT058gKmWXYX3OEICJ/MbQTTgHRssVGMES/nXWJ62O@vger.kernel.org
X-Gm-Message-State: AFq9FYIuLI+18/fkAhEYb9SvI0EmtaWPUEaRU2nYbSn7kIGOjRHPNfS5
	bc3aOna/fdh7rxCQ7x7D0ZFrCZJpmu0NIGo0Dkpkhx471m86Qr83DF5T
X-Gm-Gg: AYBFou3dOguh2MhASeu3GmAx4dz3V6CIxweS5YxRpOVRaet5uGW+ot0x5LzQQXHQ1cM
	PfBJRahy91Lmo3qx0Ub+yUTy10sYvJ5MDOOgeGF6xsB65mJ8FN19QU/Hlt+LfrUPZOFlvLH8A7n
	SY5ct4/1iN70yhmYfNClKBniKDL1xKxm/RNxiXMb7TC3j0o3y1c5YQEvJglpY5l2lg9CRCctT2a
	zXt3TyApjdzXgCJznl3h+CT+4Bbdps2pW9mteIplw10ePsFgjVgdVUtWpAt3aYUSDxrgZsxmDy6
	5dj9xfnzOv3olFZefo/tLgPeSkDXgGgIBh7F01dbI7wlo+X04vhk9IARwd34IDV1kykZfB09NwW
	DcMWgV9euIzmXXLgOkV/jOw/SF70MGEe0HNjfE1qsm19QNxOnohUPUyWN/MdfP20ZX7ltEFttyz
	Da2EuN7R9BABtLhURhuz04iYnfA1tpo1WKZSUEFg5hZSlDHqU35/o3yaGTRuzaJB2FuMrTk0SN/
	dfYxRw/I8phhpSLfudxdkvvaFSGxjr3k3hT5+ySCGQpR3ycdgaO/SqHiswCHSYJgkXOmvOY7Llu
	HlCaqZAxbPS+LJ7YWcE5R4cwEvVcOSUdVdnDdWNfNUgRLatpy4Q/L/Tz
X-Received: by 2002:a05:7301:52c8:b0:361:306f:c32a with SMTP id 5a478bee46e88-36a2036d1ffmr2152593eec.11.1793164541601;
        Tue, 27 Oct 2026 22:15:41 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm3579812eec.23.2026.10.27.22.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:15:41 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ltp@lists.linux.it
Cc: amir73il@gmail.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2] inotify13: check rename cookie pairing after adjacent moves
Date: Wed, 28 Oct 2026 05:15:18 +0000
Message-ID: <20261028051518.22982-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue an unpaired IN_MOVED_FROM event, followed by an IN_MOVED_FROM and
IN_MOVED_TO pair with the same source watch descriptor and name as the
first event. Watch only IN_MOVE so creation of the replacement entry
does not separate the two IN_MOVED_FROM events in the queue.

Affected kernels coalesce the second IN_MOVED_FROM into the first,
leaving the IN_MOVED_TO cookie without a matching IN_MOVED_FROM cookie.
Check that all three events are retained, the two moves have distinct
cookies, and the second IN_MOVED_FROM matches the IN_MOVED_TO cookie.
Cover both regular files and directories.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify13.c | 176 ++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 testcases/kernel/syscalls/inotify/inotify13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2bdb4a9..e578bd9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -677,6 +677,7 @@ inotify09 inotify09
 inotify10 inotify10
 inotify11 inotify11
 inotify12 inotify12
+inotify13 inotify13
 
 fanotify01 fanotify01
 fanotify02 fanotify02
diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/kernel/syscalls/inotify/.gitignore
index f6e5c54..b597ea6 100644
--- a/testcases/kernel/syscalls/inotify/.gitignore
+++ b/testcases/kernel/syscalls/inotify/.gitignore
@@ -10,3 +10,4 @@
 /inotify10
 /inotify11
 /inotify12
+/inotify13
diff --git a/testcases/kernel/syscalls/inotify/inotify13.c b/testcases/kernel/syscalls/inotify/inotify13.c
new file mode 100644
index 0000000..5b28e8d
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify13.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Hungyu Lin <dennylin0707@gmail.com>
+ */
+
+/*\
+ * Verify that coalescing does not lose an IN_MOVED_FROM event needed to
+ * match a later IN_MOVED_TO event by its rename cookie.
+ *
+ * Move an entry from a watched directory to an unwatched directory, recreate
+ * it under the same name, then move it to another watched directory. Watch
+ * only move events so the two IN_MOVED_FROM events are adjacent in the queue.
+ * Their cookies must differ, and the second must match the IN_MOVED_TO cookie.
+ * Test both regular files and directories without reading between renames.
+ */
+
+#include "config.h"
+#include <fcntl.h>
+#include <string.h>
+#include "tst_test.h"
+#include "inotify.h"
+
+#ifdef HAVE_SYS_INOTIFY_H
+#include <sys/inotify.h>
+
+#define SOURCE "source/entry"
+#define SAVED "unwatched/entry"
+#define TARGET "target/entry"
+
+struct event_t {
+	const char *name;
+	unsigned int mask;
+	int wd;
+};
+
+static int fd_notify = -1;
+
+static void create_entry(int directory)
+{
+	if (directory)
+		SAFE_MKDIR(SOURCE, 0700);
+	else
+		SAFE_TOUCH(SOURCE, 0600, NULL);
+}
+
+static void verify_inotify(unsigned int directory)
+{
+	const char *type = directory ? "directory" : "file";
+	unsigned int isdir = directory ? IN_ISDIR : 0;
+	struct event_t event_set[] = {
+		{ "entry", IN_MOVED_FROM | isdir, 0 },
+		{ "entry", IN_MOVED_FROM | isdir, 0 },
+		{ "entry", IN_MOVED_TO | isdir, 0 },
+	};
+	union {
+		struct inotify_event align;
+		char data[4096];
+	} buf;
+	struct inotify_event *event;
+	const struct event_t *expected;
+	unsigned int cookies[ARRAY_SIZE(event_set)] = { 0 };
+	unsigned int count = 0, i;
+	size_t pos = 0, len;
+	int wd_source, wd_target, failed = 0;
+
+	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
+	wd_source = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "source", IN_MOVE);
+	wd_target = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "target", IN_MOVE);
+
+	event_set[0].wd = wd_source;
+	event_set[1].wd = wd_source;
+	event_set[2].wd = wd_target;
+
+	create_entry(directory);
+	SAFE_RENAME(SOURCE, SAVED);
+	create_entry(directory);
+	SAFE_RENAME(SOURCE, TARGET);
+
+	len = SAFE_READ(SAFE_READ_ANY, fd_notify, buf.data, sizeof(buf.data));
+	SAFE_CLOSE(fd_notify);
+	fd_notify = -1;
+
+	/* Reuse these paths for the next case and for -i iterations. */
+	if (directory) {
+		SAFE_RMDIR(SAVED);
+		SAFE_RMDIR(TARGET);
+	} else {
+		SAFE_UNLINK(SAVED);
+		SAFE_UNLINK(TARGET);
+	}
+
+	while (pos < len) {
+		if (len - pos < sizeof(*event))
+			tst_brk(TBROK, "Incomplete inotify event at offset %zu", pos);
+
+		event = (struct inotify_event *)(buf.data + pos);
+		if (event->len > len - pos - sizeof(*event))
+			tst_brk(TBROK, "Incomplete inotify event name at offset %zu", pos);
+
+		if (count >= ARRAY_SIZE(event_set)) {
+			tst_res(TINFO, "%s: unexpected event %u: wd=%d mask=%#x cookie=%u len=%u name=\"%.*s\"",
+				type, count, event->wd, event->mask, event->cookie,
+				event->len, (int)event->len, event->name);
+			failed = 1;
+		} else {
+			expected = &event_set[count];
+			cookies[count] = event->cookie;
+			tst_res(TINFO, "%s: event %u: wd=%d (expected %d) mask=%#x (expected %#x) cookie=%u len=%u name=\"%.*s\" (expected \"%s\")",
+				type, count, event->wd, expected->wd,
+				event->mask, expected->mask, event->cookie,
+				event->len, (int)event->len, event->name,
+				expected->name);
+			if (event->wd != expected->wd ||
+			    event->mask != expected->mask ||
+			    event->len < strlen(expected->name) + 1 ||
+			    memcmp(event->name, expected->name,
+				   strlen(expected->name) + 1))
+				failed = 1;
+		}
+		count++;
+		pos += sizeof(*event) + event->len;
+	}
+
+	for (i = count; i < ARRAY_SIZE(event_set); i++) {
+		expected = &event_set[i];
+		tst_res(TINFO, "%s: missing event %u: expected wd=%d mask=%#x name=\"%s\"", type, i, expected->wd,
+			expected->mask, expected->name);
+		failed = 1;
+	}
+
+	if (failed) {
+		tst_res(TFAIL, "%s: unexpected rename event sequence (%u events, expected %zu)",
+			type, count, ARRAY_SIZE(event_set));
+		return;
+	}
+
+	if (cookies[0] == cookies[1]) {
+		tst_res(TFAIL, "%s: both FROM cookies are %u (expected different cookies)",
+			type, cookies[0]);
+		return;
+	}
+
+	if (cookies[1] != cookies[2]) {
+		tst_res(TFAIL, "%s: second FROM cookie=%u, TO cookie=%u (expected equal cookies)",
+			type, cookies[1], cookies[2]);
+		return;
+	}
+
+	tst_res(TPASS, "%s: second FROM cookie=%u matches TO cookie=%u",
+		type, cookies[1], cookies[2]);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR("source", 0700);
+	SAFE_MKDIR("unwatched", 0700);
+	SAFE_MKDIR("target", 0700);
+}
+
+static void cleanup(void)
+{
+	if (fd_notify >= 0)
+		SAFE_CLOSE(fd_notify);
+}
+
+static struct tst_test test = {
+	.test = verify_inotify,
+	.tcnt = 2,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
+
+#else
+TST_TEST_TCONF("system doesn't have required inotify support");
+#endif
-- 
2.43.0

