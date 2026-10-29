Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296160;
	b=tW7svNgjgTFaq6k5aSLxyfdk14VCzQJ9Gx2s6YRa6PwNBTxWv5Wj0TNgxiSgUMmqikf3
	 9uTLn560VWgPrzG/6ud/vikve7o0va/rpQnPkbDm2GrpRrTyQH11QG0ZjjSLWgzejIfo4
	 W27lrU4teggwCCE3CQLPDu1arvCrbWJCBpYcvSU4FAJk8BOekZ8Mpd71qcyedYUSewvC5
	 RbI5zz0vAwhn0D/fEq1wmFd3hZzX8Ka/Lp3mn/lhOr5Rd2PZ/EirdK50014sA2mEylxea
	 Ec7j6i1dIR+EQzDxyVZrhe55BLQt2frDLilUlD7bwZ6Rwz149c6HbsyoY7QRbkGEf7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ln9h95COh+dKENlOI1wGS5xr92jymKdKA0g3KaCC54g=;
	b=ZgcVzYZ7PLreezggSVV5kVjXWmHcoYFTBqcamJA/NVwxERU9FAIxKsPCOX3FtQy2elkI
	 XSzPc4urfTmhZv+iO7q89MF2hiiW2R7CVyFOhnn27TWOMN9w+UWi+ax8arW9psRjZ7Nt1
	 V8D1RjeZV7oS9GkmNAKXMtJN9iTVhxoxSAAKHrVhWsW675MWo8h6yDaIo6lnCoLIv4WUB
	 U5ZUe3G3B+RXth8QplchlmjfS+zUi2zutgfR1ThA0eq+B0SgQbkXPaMh6qZyY1CbvB3nU
	 Mrdlm21IrDlTlH8t9sqUIzBFBpgobBUkuC9jfP4YOhs0C19sM/HgvlvnDPeoXpUgSUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2jJXejm;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C51606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 17:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C51606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2jJXejm
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a1e794908so651183eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793296159; x=1793900959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ln9h95COh+dKENlOI1wGS5xr92jymKdKA0g3KaCC54g=;
        b=B2jJXejm3VD5OVe4rCorO2wFgTlPozbA2bCsItXfaNw0SkdYkk06Yzq7xIzWJqv/ND
         IgkQ27cgFbyHpMTax9PFDxZ2lrVuc1YF7Gi759KMk3hR4ZpeI9unnbyD+J2px4ZDvjN4
         ZqmdFUO1VqDQBk46+NsfXl3tTA5d/9kABsknOHRrjVduEAtDwUjng6wh7HkK011UE0Wg
         4ihJAQrCQeHpfMnDYYQmNyBtZeFw0ObD+YTiIzimPc6GMenBMsb2lMZ3C6vTVeQAxf21
         t1TmHRW1U78rUtT2O17MncFwIQS502570CeZ4rxTkCT95DOHjfNNxhgjifYT1bSAIr+J
         LT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793296159; x=1793900959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ln9h95COh+dKENlOI1wGS5xr92jymKdKA0g3KaCC54g=;
        b=imXUvJgAaUsgabyzojZ19BB3md0mLBAvgLfrglkBL63+veEYrJz23FgsSHXBZeZU+p
         81eqgQWB6dWgJLZFQNaFTIHV/yD4kENWd9KSkFoELJP00I9i7E7B5kHtuZH35QzVD9sK
         +rKZQYzpqE6WLXyw3EpaUyMYCbxWtQcRNCXTdqClRGTPLj53bFB6t//fSv/Vp0W8150m
         1NdqAb4DwNGCoRt8ZSDWdstC0mpmSGR4roc73IUmtWkyYcWo3To7p1ovqUjP3yaofiWr
         7NatKKh/mLdozHraK6EK/jjTTiR13ofphkkyWYbPHxdHVQG0dogZy25WU6KqaX4xcK3R
         c5sA==
X-Forwarded-Encrypted: i=1; AKwUvBxgozhQ58n76Z1PpHrp6SsWaMtq/PwpJn0JlUY6W8v2HITuP7fa3/hgY66USc2EPat2P/bmfgZC0cYccTxu@vger.kernel.org
X-Gm-Message-State: AFq9FYKGAHg/BvIKv/WpWjf/l9mhsyXYfuhNN3lk1+uaIpv99jREGksE
	ISQyYF7ZzeSgyBKpDrJtz+R0/rSVgtXc7Aea6YXHeRtybXZl5ftQ0yn9
X-Gm-Gg: AYBFou0T2+I32RKg54wLn2lXPQOYcmBaz0HwpkMIbRmwTyFIHiBY18zoDYm5RZpjkBL
	kKVrSSIZ1rXOXHTlthq4v6403ep8USPWh476TCa6P9K606Wx8rUevE144RJIFAToNE88yyA2c3n
	No3mV8ng9Gcg2K6RY+Ox2RnMQDb2LI/7gJOY8yujyEzv2daPb1H9yxNdE2mjcv4LrFOeK4HvS5g
	hogbK6I8QWSxdhs3adX6F6zWkUUPq8piKsbO0bHMdSqcP0NPPsjhmmPtdaF9lJUtt+mQ6bU2dYg
	p0J9Tm8UhrYRRpF3Sn9IkoIxaY0N7s7/eiDCr36qp9t7hatcwrOAcHmqGGlvQQ7I7PGbIQ6iZvb
	VpKRASrdBr+f8uBwDtIh6N4QjRwEm1xCMYSC4fhnjO3lbE068hygeXrs4LUHDjyfNSgq7uR82YN
	t2k3/zMHCHawIxWkEOg5RsPTCcharlaEgOl6Y8+NJjLxx9R7Ys/GFbLe6WIgJSLBB+JwPvlC86b
	nQziOeq1g+oaPJD1xUSZOJyINUNFTHARqNewBoSHiXIg6je1K9UdiGFHkGkgjGJUUAczGdSTuDf
	W17jjB5E1kM5He5iPoVJdrT+TrXEB5ZhYhwh6bEOfAGZPW9zyryUuhrz3g==
X-Received: by 2002:a05:693c:880c:10b0:35c:cd26:3066 with SMTP id 5a478bee46e88-36a424655bcmr123374eec.41.1793296159346;
        Thu, 29 Oct 2026 10:49:19 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm127504eec.11.2026.10.29.10.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:49:18 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ltp@lists.linux.it
Cc: amir73il@gmail.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v3] inotify13: check rename cookie pairing after adjacent moves
Date: Thu, 29 Oct 2026 17:49:07 +0000
Message-ID: <20261029174907.98721-1-dennylin0707@gmail.com>
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
Changes in v3:
- Check event fields separately, starting with the mask, and report specific
  TFAIL diagnostics with actual and expected values. Log correct events
  with TINFO only.
- Report missing and extra events directly instead of using a generic
  failure flag.
- Use delete_entry() for both cleanup paths, as suggested by Amir.
- Use a file/directory test-case table and derive the test count from it.
- Clarify the operation sequence and affected-kernel history, the truncated
  payload diagnostic, and both cookie relations in the success message.
- Handle an empty nonblocking queue as missing events rather than TBROK.

Built with GCC 13.3.0 and checked with LTP checkpatch and sparse. On ARM64
QEMU, the test reports 0 pass / 2 fail on the baseline kernel and 2 pass /
0 fail with either kernel fix. With -i 20, the results are 0 pass / 40
fail before the fix and 40 pass / 0 fail afterwards.

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify13.c | 217 ++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
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
index 0000000000000000000000000000000000000000..2ea5b5d4aeff9b368e5fa79ec18207035567a34b
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify13.c
@@ -0,0 +1,217 @@
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
+			tst_res(TFAIL, "%s: unexpected extra event %u: got wd=%d mask=%#x cookie=%u len=%u name=\"%.*s\", expected no event after %zu events",
+				type, count, event->wd,
+				event->mask, event->cookie, event->len,
+				(int)event->len, event->name, ARRAY_SIZE(event_set));
+			return;
+		}
+
+		expected = &event_set[count];
+		if (event->mask != expected->mask) {
+			tst_res(TFAIL, "%s: event %u has wrong mask: got wd=%d mask=%#x cookie=%u name=\"%.*s\", expected wd=%d mask=%#x name=\"%s\"",
+				type, count, event->wd, event->mask, event->cookie,
+				(int)event->len, event->name, expected->wd,
+				expected->mask, expected->name);
+			return;
+		}
+
+		if (event->wd != expected->wd) {
+			tst_res(TFAIL, "%s: event %u has wrong wd: got wd=%d mask=%#x cookie=%u name=\"%.*s\", expected wd=%d mask=%#x name=\"%s\"",
+				type, count, event->wd, event->mask, event->cookie,
+				(int)event->len, event->name, expected->wd,
+				expected->mask, expected->name);
+			return;
+		}
+
+		if (event->len < strlen(expected->name) + 1 ||
+		    strncmp(expected->name, event->name, event->len)) {
+			tst_res(TFAIL, "%s: event %u has wrong name: got wd=%d mask=%#x cookie=%u len=%u name=\"%.*s\", expected wd=%d mask=%#x name=\"%s\"",
+				type, count, event->wd, event->mask, event->cookie,
+				event->len, (int)event->len, event->name,
+				expected->wd, expected->mask, expected->name);
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
+		tst_res(TFAIL, "%s: missing event %u: got no event, expected wd=%d mask=%#x name=\"%s\"",
+			type, i, expected->wd, expected->mask, expected->name);
+	}
+
+	if (count < ARRAY_SIZE(event_set))
+		return;
+
+	if (cookies[0] == cookies[1]) {
+		tst_res(TFAIL, "%s: expected different FROM cookies for wd=%d mask=%#x name=\"%s\", got first=%u second=%u",
+			type, event_set[0].wd, event_set[0].mask,
+			event_set[0].name, cookies[0], cookies[1]);
+		return;
+	}
+
+	if (cookies[1] != cookies[2]) {
+		tst_res(TFAIL, "%s: expected matching rename cookies: FROM wd=%d mask=%#x name=\"%s\" cookie=%u, TO wd=%d mask=%#x name=\"%s\" cookie=%u",
+			type, event_set[1].wd, event_set[1].mask,
+			event_set[1].name, cookies[1], event_set[2].wd,
+			event_set[2].mask, event_set[2].name, cookies[2]);
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
