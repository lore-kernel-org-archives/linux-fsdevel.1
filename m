Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128820;
	b=i+UVzoYPajOpT7ZAym+LYZOp6QaPoGm9oV81ypQXEwvcyxyGKITwtefIAw/agMYAp54V
	 1Fe+Tl8wB4aLBljVOx8s7e3U7ZMq9ewb5W6SabyVQUaQW9P9bVMI08ooiC7pbHDFsbfDs
	 IxyNioykKOVdCfOSqT7qPyXIFvCu7AG0/CGEqmRVxAoxNURGRdNf0+ggWZFdvyBWEt0is
	 GQamsxqHxIYpUBDJs5Wte7MVCFrH0UB7LXMLR7mVt8ctfka8LAmMxxoFHC5E9yHds7IYv
	 Es3YjmChMABjpfBaIH1KmKGh/pb0xNSWRXdtngls2zbCVykm2LPUTUldbzJFyV+8+OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HEI1beLFEji6JPrC/ny5Nsu6fz42d2/T2/6Fj2LaCcY=;
	b=Nf3ck7RAfYgQanJNbJlNzY4NqZkWIUwURwPwo1x5Vjqnt4cWV2o9tTDlPy9vc3yKSGiM
	 xRSb3s6+yUV2HJpaBuFuf48Bf781KNQhoTRnx6BQkLfjT8SKK39SNoaNcxeshVuQNS3Re
	 Uj4QGLSb8YaD7gCjbQWJ542S/CXmyKNt6f56gGg5LD/swt5DAiZuEyihRek0EEjIq1KIM
	 y/Y5inqIXoSqZOMwjWRt03jLBhM29PzD68rtS42cIOOD1J/VUJ3JJ3uKjc9kAlBcDxE88
	 4S9CiD7qqfucDkE5kYXRvw5u+2xl28P6WIB6uYenWXdtq/r0i7gAXDJX77Z8JJlppRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I0q/ZPoP";
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6695606A324
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 19:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6695606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I0q/ZPoP
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-13985f8229aso110657c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793128819; x=1793733619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HEI1beLFEji6JPrC/ny5Nsu6fz42d2/T2/6Fj2LaCcY=;
        b=I0q/ZPoPh7z2J/HgiqS6Vkd/rH0ryiZNzAPtI23gYwZaexHHrDAKpjAGKuOVJYi6YS
         l5h/hRftMU1Ny7uc/UaQgv6QyJ0hrxozjSgYfVTH2bykPfSh8AFoZhFYrX9TYyMvz+/X
         mNF8ifCbVshXP+yTor8wbAcPrQmBgrax4P4ttz1qrTspxxlb/737Nc2qll8/vstWwn2o
         3ccbYEk6ZpYTDqe0SYKNilwkZAgQOcHqFLx0TQJY1ihMHBa2YwaLr2y1p1h5xyiFSSBD
         es1+GglczN8aD1ZS/XQuc+7+ccvMJiCrAYAY8DJN9KwczgfwLwWl7KaqlVhlHb+JjzjM
         zDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793128819; x=1793733619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEI1beLFEji6JPrC/ny5Nsu6fz42d2/T2/6Fj2LaCcY=;
        b=fimUB5GOSbZwjZcuJvG74wfEYvDsZINLw2BgOfJKrx5ZHX4JUldnNABVgQy2SjcQGD
         vJoQwKniI/tzbiFyUvW8NbKQaoGnGN23epyxaSdAYpU32M/quiFyDrMLT3ldFR51yZ5w
         4vtVe4Q/PEPX8DccNIEV1E8BVnw1WjKJGjaBHw0xCSifZv4LxziY+iHS83+OAeY96Peq
         ElCdtTm4AsT+leLyo0JNmOyix5NDtPbdF9In6SxDK0k1VeN+J5vpTPC80patQK64VLzS
         qr08UJLTuv+UQtfSMxze7b+upXN8IkEp6jeaziWD/pfMy19uUGrszHPdV1mAiVnOwKjW
         Kzjw==
X-Forwarded-Encrypted: i=1; AKwUvBwX68gbzks37M0gQWIvrAZmHh/nvCSvSL4XBb4hCTLd3zs3OUCGC4p6TTkmn5ZF/A1ozoNlBXNuPURsyycS@vger.kernel.org
X-Gm-Message-State: AFq9FYL0Wo/ye3qkgEJuNHtvaNZKyvYiSq6aCJMeXp3mK0DPWSPM2/CL
	VoUBfiQQQUH4R0DRoWPOgwsTA4L5ipXLy/hI+W9AcE2QpbV8mloGS06b
X-Gm-Gg: AYBFou0C6zl9IYZbe8quCFCGP/As2Uh8mG4IsrqEO9Xa6OwgiqdmX8F9DoSkJoSfVF7
	cP2co2VaW1KSdaSWtH6rF/Ku2LNROXYuNt67B+B9X8ZICZrmXcy3s4Ag9qt9e9ZsuegUe0JwoSn
	36kdHScSrHMAnSx8HNkV8Q2ypUajFCpEqmoS8UjfXVxLQ3sjiXDFIeBZvJiOPqTuRjGQD5bhTPe
	+r+YJguY6tlzkJNeRAjpMrabMGM1Fw9AXIJMa+/L6hStcRrRwDrutUpyr2Hi0xuMJN8Vhk1wr+6
	wpsWkDOjY7TzCrNS/vJpGTfCvurUcPXqiMK4GTQeFg0fuWlEdaTQ4PL6w59L78Ono5Ml7TFz6HH
	7K9LNtddheTsomFVnW9WwMfY1k8Y6Aopz4meVG3j4Pr4CdisH72JESxJa0c+DDhwQ8Y5IHxt3ng
	UtsoJnnTBmDmNCXnMqJgq3dC1TeKBu1UhR4L3rN8zNwQgYGjVCPC6gyo7fqLH+mTz9mbKGNNu2+
	xR1hEDH/xz9KlIjKeYZOAsbcNbyZ7WZmbCuxKIUFK23ig9An+5LXo9CRrkRfifu56kp0QG6gi7G
	EMlQTdo=
X-Received: by 2002:a05:701b:4309:b0:145:287:ce91 with SMTP id a92af1059eb24-1a6cc90e851mr255380c88.14.1793128818705;
        Tue, 27 Oct 2026 12:20:18 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6da729ec9sm203115c88.20.2026.10.27.12.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:20:18 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ltp@lists.linux.it
Cc: amir73il@gmail.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] inotify13: check rename cookie pairing after adjacent moves
Date: Tue, 27 Oct 2026 19:19:55 +0000
Message-ID: <20261027191956.5015-1-dennylin0707@gmail.com>
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
 testcases/kernel/syscalls/inotify/inotify13.c | 147 ++++++++++++++++++
 3 files changed, 149 insertions(+)
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
index 0000000..4b172ba
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify13.c
@@ -0,0 +1,147 @@
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
+	union {
+		struct inotify_event align;
+		char data[4096];
+	} buf;
+	struct inotify_event *event, *events[3];
+	unsigned int count = 0;
+	size_t pos = 0, len;
+	unsigned int from = IN_MOVED_FROM, to = IN_MOVED_TO;
+	int wd_source, wd_target;
+	const char *type = directory ? "directory" : "file";
+
+	if (directory) {
+		from |= IN_ISDIR;
+		to |= IN_ISDIR;
+	}
+
+	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
+	wd_source = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "source", IN_MOVE);
+	wd_target = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "target", IN_MOVE);
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
+			tst_brk(TBROK, "Incomplete inotify event");
+
+		event = (struct inotify_event *)(buf.data + pos);
+		if (event->len > len - pos - sizeof(*event))
+			tst_brk(TBROK, "Incomplete inotify event name");
+
+		tst_res(TINFO, "%s: wd=%d mask=%#x cookie=%u name=%.*s",
+			type, event->wd, event->mask, event->cookie,
+			(int)event->len, event->name);
+		if (event->len < sizeof("entry") ||
+		    memcmp(event->name, "entry", sizeof("entry"))) {
+			tst_res(TFAIL, "%s: unexpected rename event name", type);
+			return;
+		}
+		if (count < ARRAY_SIZE(events))
+			events[count] = event;
+		count++;
+		pos += sizeof(*event) + event->len;
+	}
+
+	if (count != ARRAY_SIZE(events)) {
+		tst_res(TFAIL, "%s: expected two FROM events and one TO, got %u",
+			type, count);
+		return;
+	}
+
+	if (events[0]->wd != wd_source || events[0]->mask != from ||
+	    events[1]->wd != wd_source || events[1]->mask != from ||
+	    events[2]->wd != wd_target || events[2]->mask != to) {
+		tst_res(TFAIL, "%s: unexpected rename event sequence", type);
+		return;
+	}
+
+	if (events[0]->cookie == events[1]->cookie ||
+	    events[1]->cookie != events[2]->cookie) {
+		tst_res(TFAIL, "%s: rename cookies do not identify the later pair",
+			type);
+		return;
+	}
+
+	tst_res(TPASS, "%s: second FROM cookie matches the TO cookie", type);
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

