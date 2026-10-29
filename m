Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308035;
	b=BbThgSA9guLTHLkwCSmumz7F+cqmxSbOyboyucA92O3A8ttvEOW1ZquLGcPa5KCCaurF
	 0GQ3AySOBhJ0Xva3Ad5g6bQr5gRmzF5QTIJjTnbgdMQq5EPKsG8UrPUkJ3s0z5Tlzf+yA
	 BRzWVY51hEs4tFPxAsHWZWXQBnlmU1auoEI78IzqnXmRSCbGyEqMQD9sIIbkVE+t+FekC
	 eim7NxjELxwt0jhQN4Bl4GY5vPFymQr+V0WQXVK8HALEYaAhcnfrCoZfYtiSOUyavOUgb
	 BPZPyP92Wz/dcbqB7wYu24MjANVJEHyLdGktVArKbQ9qiWmawckdAny5E8BkIoyxcyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0tz6UJO2BZhACEYM6ZFE2ekJAZW1YAXReqMb1KC2X0Y=;
	b=FpROlov12pqPpXzKBLm6oVofDp2wTchYEmQDFw8O5FOWqkVG0n8ooNTP0RcVh1jssFXj
	 z7c3bCdZHUUTsFbcrOnpfhIoMfv2hZ2tkmGtjEgYulaa5pI2n7LHBVaYPeIoz8LKYlg2l
	 pKHdjmiScVpvcmNSFRQUGPWbW0O67Mzh6bqFsmuysCtYvUBEtYNdzAV3K7Rqqh0JwigN9
	 3E4r4Jqg5waN2ghDkCc4BHmqsXIcQfoGrhPh+Jg41ocNbgaVkuP0RNpDxNTAiDhmHCGLJ
	 bVUZr+TMFaX+zC7cSTTULd4DU3gZcvIzTptvxi+OvtLQapJkvvg83on0WdkwkyTuRJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=feLgwf1y;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F693606A320
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 21:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F693606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=feLgwf1y
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-369fd8abd71so76647eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793308034; x=1793912834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0tz6UJO2BZhACEYM6ZFE2ekJAZW1YAXReqMb1KC2X0Y=;
        b=feLgwf1yiKMf902E5IeSxB8S6E4JJNXcHz9Papz1aTb9bO0Q/MmV08rwWurPv7qGnW
         eTceSH+f5istBgVYIaO/JuPQYIXjt52qj7SBNPOQvmIvLDBaUNI3IG8GjrVTooMFMZYe
         FC8RQdYbhTJiyPhtZ5ci25mpAZvAevR/16o9yvHgzZbjR6TqUip87nPTmBG1okLjoFTc
         XcHaA+OjK8Q1nHneuzjGdYqRlCSKDQRtY06FWsqbRxUsDlvit84lbsTxwOU537DBQDVz
         TDCkwRBHnASKXUOKo+uQBDyZfWq0eXsRSeaYBxyvA/YbtlVc5gIa42MmA5GDYW6OaU0X
         01CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308034; x=1793912834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tz6UJO2BZhACEYM6ZFE2ekJAZW1YAXReqMb1KC2X0Y=;
        b=25bYhmz0Bu1DQwG8G67Qyhn62/TUn8Jvjxo8IQWHJLaBFAleAwTkXAFPNvYYc9OmW7
         SrPlZIQw3mG/jhhMuecjWDFohzCim87FP4PqiFE4pddsmjDmSJ4QEfo09rLrS0HoOWAn
         5Rv/Rm3nVP9y+asqMFjX5sToXmej9YLGyNppkWJOUPe5bRVHrZZtQEpP7ZkjDbuoxp//
         Wp0h5G3lkuEBFC3CwdKs34P3ewYzdtNFJmkxe48gLk5BKjeOcZru5Ouh9wi53qz+f3Wl
         3KN70kazDxvfzSXP9pYhXPdWf516hfoTzjfvRBe0nmt/LdFqOBAwwzzYuO6w9+muE1sc
         mM/A==
X-Forwarded-Encrypted: i=1; AKwUvBy5WGJLq/NvIuqtVogOj+v00QgVaCV9aL8EP6LGIDcq+y7ww7Ikun9Ddig3cO0+6YESOmzGt2p4MwoSUwWk@vger.kernel.org
X-Gm-Message-State: AFq9FYLCGRLB+co7siiH4GLDOtWTATEfnWftu6RClfU4yCTK1N+icFKq
	YALdJhUZnhmP5ydd8aDREbqxlS8Uzem6I5OlYJUkpTDLILyhhI2devhr
X-Gm-Gg: AYBFou2EsXYjU4ryZLAYxXV5bsuE7S5LPCVzzAhDPNGJvtJ40Tpefb+itCqNWSZawkm
	DJb1vdQCruCIywpcyQqDFNzMSwCcsGENzne0zqi7B+I7QvmRPepnokord+R7F3VfXXjWBkKOvps
	r2aGL+rIwm6Sh1IFCy03pJx6ICdW0bC23roX0Bj8QvKyXcLPRog9HkC1JAS3FXilrjReFUza173
	BLaxCymsg8yRg7RZT4nEuOPlZl4eZ32D+56KqO4OX+QFQmlv1JaEFdZWbQfxBlDXNrKYuwzj3de
	zU4bJz61Mb4nm5sMM98LFZZetjAa4We/ad/u7c5CCUvsSyW2Z4i/bw4qNo4XM7uaUVbBAPcm6Y0
	LDOqsc4jLUNcrvewYrSMc4zCHI6UxlZh5hOYfChAqB2JXEn0b079Bk0VjX3a4wE4RGismkgCjWl
	HZ/12xZNikQZUms3pC2o3nkGpe3GJZ5dIQkAQL6JrwJIfjRhnMWOr9fgFn/NpA4g0Pse1487jk+
	Q266r6NWGPYVOgW76116dDp4TTUZumhxphZS0AIP6b8iUerjbgUtFRF2j0LNEYY0fm4Y0Wwjl99
	vZjZkGmsV4HtJvUESN93/1Y+V6UBfS6//DTeKzkLIMNIJuoWUbqaGAui
X-Received: by 2002:a05:7022:3c04:b0:1a9:c52f:655c with SMTP id a92af1059eb24-1ac5c555f7cmr258090c88.36.1793308034303;
        Thu, 29 Oct 2026 14:07:14 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm1089981c88.20.2026.10.29.14.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:07:13 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ltp@lists.linux.it
Cc: amir73il@gmail.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v4] inotify13: check rename cookie pairing after adjacent moves
Date: Thu, 29 Oct 2026 21:07:01 +0000
Message-ID: <20261029210701.80050-1-dennylin0707@gmail.com>
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
Changes in v4:
- Put expected values immediately after the mismatched fields, following
  the existing per-field diagnostic format.
- Use the existing "got unnecessary event" and "didn't get event" wording.
- Keep event context for extra events and mask, watch descriptor and
  filename mismatches. Omit it from the two cookie-failure messages,
  since it is already present in TINFO, as confirmed by Amir.

Built with GCC 13.3.0 and checked with LTP checkpatch and sparse. On ARM64
QEMU, the test reports 0 pass / 2 fail on the baseline kernel and 2 pass /
0 fail with the kernel fix. Local diagnostic controls also exercise both
cookie failures and verify the preceding TINFO and concise TFAIL output.
The controls are kept outside this patch.

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify13.c | 211 ++++++++++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 testcases/kernel/syscalls/inotify/inotify13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2bdb4a9a2b4801d03d93efea686124530f5ce2d5..e578bd92d7e7ded5c0ca2f95dc87fce814d733cc 100644
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
index f6e5c546ac4032766cee9f16b3689be5d0302d37..b597ea63f493b2da2a58017d3eb7b16a7b033fc5 100644
--- a/testcases/kernel/syscalls/inotify/.gitignore
+++ b/testcases/kernel/syscalls/inotify/.gitignore
@@ -10,3 +10,4 @@
 /inotify10
 /inotify11
 /inotify12
+/inotify13
diff --git a/testcases/kernel/syscalls/inotify/inotify13.c b/testcases/kernel/syscalls/inotify/inotify13.c
new file mode 100644
index 0000000000000000000000000000000000000000..9ee660e041435d16b63097ba8e2f86515d6bac57
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify13.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Hungyu Lin <dennylin0707@gmail.com>
+ */
+
+/*\
+ * Verify that two IN_MOVED_FROM events that differ only in their rename
+ * cookie are not coalesced.
+ *
+ * inotify(7) allows coalescing only of events with identical wd, mask,
+ * cookie and name. A regression introduced in v2.6.31 dropped the cookie
+ * comparison. On affected kernels, the second IN_MOVED_FROM is coalesced
+ * into the first, leaving the following IN_MOVED_TO without a matching
+ * IN_MOVED_FROM cookie.
+ *
+ * With source/ and target/ watched for IN_MOVE, and without reading the queue:
+ *
+ * 1. Move source/entry to unwatched/ (IN_MOVED_FROM, cookie A).
+ * 2. Recreate source/entry.
+ * 3. Move source/entry to target/ (IN_MOVED_FROM and IN_MOVED_TO, cookie B).
+ *
+ * All three events must be queued, with A != B. IN_CREATE is not watched, so
+ * the two IN_MOVED_FROM events are adjacent; the queue is not read in between,
+ * because only the last unread event can be merged with a new one. Both a
+ * regular file and a directory are tested.
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
+#define UNWATCHED "unwatched/entry"
+#define TARGET "target/entry"
+
+struct event_t {
+	const char *name;
+	unsigned int mask;
+	int wd;
+};
+
+static struct tcase {
+	const char *type;
+	unsigned int isdir;
+} tcases[] = {
+	{ "file", 0 },
+	{ "directory", IN_ISDIR },
+};
+
+static int fd_notify = -1;
+
+static void create_entry(unsigned int isdir, const char *path)
+{
+	if (isdir)
+		SAFE_MKDIR(path, 0700);
+	else
+		SAFE_TOUCH(path, 0600, NULL);
+}
+
+static void delete_entry(unsigned int isdir, const char *path)
+{
+	if (isdir)
+		SAFE_RMDIR(path);
+	else
+		SAFE_UNLINK(path);
+}
+
+static void verify_inotify(unsigned int n)
+{
+	const char *type = tcases[n].type;
+	unsigned int isdir = tcases[n].isdir;
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
+	int wd_source, wd_target;
+
+	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
+	wd_source = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "source", IN_MOVE);
+	wd_target = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "target", IN_MOVE);
+
+	event_set[0].wd = wd_source;
+	event_set[1].wd = wd_source;
+	event_set[2].wd = wd_target;
+
+	create_entry(isdir, SOURCE);
+	SAFE_RENAME(SOURCE, UNWATCHED);
+	create_entry(isdir, SOURCE);
+	SAFE_RENAME(SOURCE, TARGET);
+
+	len = SAFE_READ(SAFE_READ_ANY_EAGAIN, fd_notify, buf.data, sizeof(buf.data));
+	SAFE_CLOSE(fd_notify);
+
+	/* Reuse these paths for the next case and for -i iterations. */
+	delete_entry(isdir, UNWATCHED);
+	delete_entry(isdir, TARGET);
+
+	while (pos < len) {
+		if (len - pos < sizeof(*event))
+			tst_brk(TBROK, "%s: event %u has %zu header bytes (expected at least %zu)",
+				type, count, len - pos, sizeof(*event));
+
+		event = (struct inotify_event *)(buf.data + pos);
+		if (event->len > len - pos - sizeof(*event))
+			tst_brk(TBROK, "%s: event %u claims %u name bytes but only %zu are left in the buffer, wd=%d mask=%#x cookie=%u",
+				type, count, event->len, len - pos - sizeof(*event),
+				event->wd, event->mask, event->cookie);
+
+		if (count >= ARRAY_SIZE(event_set)) {
+			tst_res(TFAIL, "%s: got unnecessary event %u: mask=%#x wd=%d cookie=%u len=%u name=\"%.*s\"",
+				type, count, event->mask, event->wd, event->cookie,
+				event->len, (int)event->len, event->name);
+			return;
+		}
+
+		expected = &event_set[count];
+		if (event->mask != expected->mask) {
+			tst_res(TFAIL, "%s: got event %u: mask=%#x (expected %#x) wd=%d cookie=%u name=\"%.*s\"",
+				type, count, event->mask, expected->mask, event->wd,
+				event->cookie, (int)event->len, event->name);
+			return;
+		}
+
+		if (event->wd != expected->wd) {
+			tst_res(TFAIL, "%s: got event %u: mask=%#x wd=%d (expected %d) cookie=%u name=\"%.*s\"",
+				type, count, event->mask, event->wd, expected->wd,
+				event->cookie, (int)event->len, event->name);
+			return;
+		}
+
+		if (event->len < strlen(expected->name) + 1 ||
+		    strncmp(expected->name, event->name, event->len)) {
+			tst_res(TFAIL, "%s: got event %u: mask=%#x wd=%d cookie=%u len=%u name=\"%.*s\" (expected \"%s\")",
+				type, count, event->mask, event->wd, event->cookie,
+				event->len, (int)event->len, event->name,
+				expected->name);
+			return;
+		}
+
+		cookies[count] = event->cookie;
+		tst_res(TINFO, "%s: event %u: wd=%d mask=%#x cookie=%u len=%u name=\"%.*s\"",
+			type, count, event->wd, event->mask, event->cookie,
+			event->len, (int)event->len, event->name);
+		count++;
+		pos += sizeof(*event) + event->len;
+	}
+
+	for (i = count; i < ARRAY_SIZE(event_set); i++) {
+		expected = &event_set[i];
+		tst_res(TFAIL, "%s: didn't get event %u: mask=%#x wd=%d name=\"%s\"",
+			type, i, expected->mask, expected->wd, expected->name);
+	}
+
+	if (count < ARRAY_SIZE(event_set))
+		return;
+
+	if (cookies[0] == cookies[1]) {
+		tst_res(TFAIL, "%s: got second FROM cookie=%u (expected != %u)",
+			type, cookies[1], cookies[0]);
+		return;
+	}
+
+	if (cookies[1] != cookies[2]) {
+		tst_res(TFAIL, "%s: got TO cookie=%u (expected %u from second FROM)",
+			type, cookies[2], cookies[1]);
+		return;
+	}
+
+	tst_res(TPASS, "%s: FROM cookies %u and %u differ, TO cookie %u matches the second",
+		type, cookies[0], cookies[1], cookies[2]);
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
+	.tcnt = ARRAY_SIZE(tcases),
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
