Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891381;
	b=rtCKXGhBiQR+dngPuPbFDA0w3aLRDRZMcbsfPQSM3bOj6VlE8FMT/ZOqn3UR2EDdrFpg
	 /zy7du6mJEkTRMAyP6n/+M83FODePwnOqc0qB1Js0f/mtAU7cqpooO8CbBIlRzgXHGhl9
	 dtin6kuqz2msbVtHIqJFq8g1vLHqmK1SAbPahtfTkCcz7HYj6veJzDVaviTwcLwknCxME
	 9uDEYVp9Oo4+oHY0qZxk9jhRzVMQJ2FDTUyDfNtZbxUnWtjkHxHYxjOLETtRCkdyq3GA+
	 l+zrOYHOnoaCbL4IvimkQWoTIapkBT0HSeLQy+ofzIOWTocMXX+ZahMkciKt/OUYC1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=WFfIYKlEcfzlG/dWEIHjKozgVZ74AbCqPxapNXqYqH4=;
	b=A8ECh9tfqbtD4XrzwOlcex9Rfyyyvr1xSdxsWdCPtDT+Pb8BSTZTFec7Kb99Fx6liQbm
	 Bo1AK/4OpTPVWJJqzlnRK62LUnXA32Y9r+QFTfRzsG8pVGNdKo62t6i6ljwmHMjN2+XtO
	 4lFgEP7xPGLsrdyq3i+C1lmL3CuqvERZAKqIq5ftQjM65pNarOPJl2UjgWv4zVy6ffep0
	 aE9JHt6mUaWmLOYYn5dsFQxvmPyTcG71W/scivYXWzHvXDfPzZ7htYGY/vXV/QOC5bRdW
	 /Q5+qpwBH8OL0sXluLWDGWQ814In8GNHuKuPML8/hmrtUFpX318ROr7NF4CJXSuU8dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mlTeXDfm;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9B606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7D9B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mlTeXDfm
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b305e10ac7so20000247b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891380; x=1794496180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFfIYKlEcfzlG/dWEIHjKozgVZ74AbCqPxapNXqYqH4=;
        b=mlTeXDfmxXMDjL4Lb6C2bOLeeONksppw9Bsab+fkg9io+99V1DUrBKsgA+1GcXqjVz
         rl1Mgdv2wVEzsEA0SMzHw/M/FU2hNhXYoCjh6A3Tc8qkl7H2Gf0QL5f9gfiOghW8nns+
         ItDhFmCHlgdfoMBZuDyuF0GYfeKgwJUtZGkBnFvloFBF19P9hnGzkmvf5aNjUSamEYLq
         KiJbZ9N60tlX+izYB0kfnhR01IsDYknDzsLzi19P7/e+/XfevQqtRKZiSLfcm2ISBMxr
         qC6FnlQu269Abddef6NLtEX6YK6Mhq6ODP11Vu46NDFZkL4UW9ECrpWgq2C4SR2gwjFB
         0s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891380; x=1794496180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFfIYKlEcfzlG/dWEIHjKozgVZ74AbCqPxapNXqYqH4=;
        b=s+jXAO65wTj2g69dy69APSuQyBPckX2jizvyin0B68ilU/lzMRlsTXqFjyWWZsNO/O
         WDRGSdCvJ1JDs42RnOw2qcxLWv97PD8p+9n4laZMEMXuvwdPIyXeKYqsj1aAx1J/N8Jm
         99p2eAshEbCWhNBQa0QuDxAl6y3v/mJe8d7bY+1ag436gGtnn0CevS4a1llKI25lLhAi
         v8/ZiQB+qXhH2pi4rfSMdFClKN7b0Mz2sNDuZsBH+uNTEctAgHhMZbXbomqhKwOiYZXv
         k1imjmXkzQr9sBQsp8yBoNtlW+llgsfF/sa/1k2agPGfHfW6yzaDdk7aJLLR47mHHYLu
         MIKg==
X-Gm-Message-State: APuU4Z8JgoHbyHxSRrYudFsApHVpSw8akE2finldMaIPsSF6kpqTENab
	jiSPbtNc8R7ZKdWpfvMIGPTQ/wQ6roK8gd6QMsoIcYivrqEmAzic+YijSU+jEQjA5Lg=
X-Gm-Gg: AYBFou3yoEuYIWAV4I8Ao9nUFj75ViC4XdCssZNrJlbid1A9BPxL/58vFXpJp7UoGNp
	WD+w4c0J57VKUACMttwWsjOvd/HbI0td61eXlGjHiIJ6UMsBuMQsfRJBuCmXUBowEbcqXLNID/s
	zRvEtPh6lTZsC7AdPb10gA+8eva5lU03K464XTxRIbRnx6JIKxlVIwjhTz2XWLmYieiy/f6KV9B
	/mhZnfkDZCsFVUr3AtkO7bK7BETN6l/+PWYJi2tyJk9RF+t4br/Spq4eddYdKxqniIe62W4qSXs
	Q9wj4Nrwx+8aPFhzweQcZduZj/I3XPcvmcbCp8qTA9hPyqanRJKXjZtaiQwfBbt891fByXEGmqp
	fsbqf9wyyY4CQn6uL0SuhGUFIVasxVWtgvp7XE2TjA52y7qnrJBw/EZh1Kg8LJrICWBpLdUScfL
	g4vh/633z8ALfddtqnv9muSVTMGLmJMV8jwimDIgypv/5Lc4ZvoNhMOqM5/aZP/2CSIEkdLjbjF
	Q19sqZ257owRIDZS2x9wSBfvA8v2LlfXBYgD5xKKyefaA9z7+5rSenBWHjhIMJoBIX26Z8wohrq
	C1aJdJ7fb7hBtDQsN8MRKHb94mnQ9pvSbMd4IIU3qDbUsQ==
X-Received: by 2002:a05:690c:a858:20b0:873:5c0f:28b with SMTP id 00721157ae682-8b2b67dca42mr88447657b3.53.1793891379721;
        Thu, 05 Nov 2026 07:09:39 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309936bd7sm42386077b3.20.2026.11.05.07.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:09:38 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:18 +0000
Subject: [PATCH RFC v3 26/90] cells: add cell_configure()
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
Message-Id: <20261105-b4-cells-v3-26-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=5832;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Q6k1QdhI9pFIL/cTBXzkI5uE5xkaLe2nKZ9LLtyadOk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMLONaDgV+onnmlErxqSlnu7qr/dtXWQZ02TtBvZNkJxv3iW/+tD4IvhqUTY8hEgWo3VydYUjuB
 vMOLPUXHHEAE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Add the system call that changes a cell. It is modelled on fsconfig(): it
takes a command, a key and a value, and data only flows into the kernel.
Reading from a cell is a separate system call, so that a seccomp filter
can allow a monitor to read and deny it to change anything.

Holding the cellfd is the only authority that is needed over the cell.

This patch adds the framework and the one key that depends on nothing
else, the "hostname" string. There are no flags for CELL_SET_FLAG yet.
Every command requires the cell to be in the BUILDING state.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/uapi/linux/cell.h |   9 +++
 kernel/cell/Makefile      |   1 +
 kernel/cell/slots.c       | 136 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/include/uapi/linux/cell.h b/include/uapi/linux/cell.h
index f3589a23a596..22337cab3da1 100644
--- a/include/uapi/linux/cell.h
+++ b/include/uapi/linux/cell.h
@@ -12,6 +12,15 @@
 
 /* cell_create(): @parent is CELL_SELF, see <linux/fcntl.h>. */
 
+/* cell_configure(): @cmd. Data only ever goes in. */
+enum cell_configure_cmd {
+	CELL_SET_FLAG		= 0,	/* Set the flag named by @key. There are none yet */
+	CELL_SET_STRING		= 1,	/* Set @key to the string in @value */
+	CELL_SET_BINARY		= 2,	/* Set @key to the @aux bytes at @value */
+	CELL_SET_FD		= 3,	/* Fill the slot named by @key from fd @aux */
+	CELL_CMD_SEAL		= 4,	/* Validate everything and seal */
+};
+
 /* Life of a cell. It only ever moves down this list. */
 enum cell_state {
 	CELL_BUILDING		= 0,	/* Slots may be filled */
diff --git a/kernel/cell/Makefile b/kernel/cell/Makefile
index e343e0fa72b0..ac48bfb289d0 100644
--- a/kernel/cell/Makefile
+++ b/kernel/cell/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += core.o
+obj-y += slots.o
diff --git a/kernel/cell/slots.c b/kernel/cell/slots.c
new file mode 100644
index 000000000000..905672db9936
--- /dev/null
+++ b/kernel/cell/slots.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Cells: filling the slots of a cell, and sealing it.
+ */
+#include <linux/cgroup.h>
+#include <linux/fs.h>
+#include <linux/mnt_namespace.h>
+#include <linux/nsfs.h>
+#include <linux/nsproxy.h>
+#include <linux/pid_namespace.h>
+#include <linux/proc_fs.h>
+#include <linux/proc_ns.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <net/net_namespace.h>
+#include <uapi/linux/cell.h>
+
+#include "internal.h"
+
+/*
+ * Slots. All of these run with cell->lock held and the cell BUILDING. Filling a
+ * slot takes what using the object that goes into it would take: holding the
+ * cellfd is authority over the cell, not over what is put into it.
+ */
+
+static int cell_set_hostname(struct cell *cell, const char *val)
+{
+	if (strlen(val) > __NEW_UTS_LEN)
+		return -ENAMETOOLONG;
+	strscpy(cell->hostname, val);
+	return 0;
+}
+
+static int cell_set_string(struct cell *cell, const char *key, const char *val)
+{
+	if (!strcmp(key, "hostname"))
+		return cell_set_hostname(cell, val);
+	return -EINVAL;
+}
+
+static int cell_set_binary(struct cell *cell, const char *key,
+			   const void __user *uvalue, size_t len)
+{
+	return -EINVAL;
+}
+
+static int cell_set_fd(struct cell *cell, const char *key, struct file *file)
+{
+	return -EINVAL;
+}
+
+/**
+ * sys_cell_configure - change a cell
+ * @cfd:    a cellfd
+ * @cmd:    one of enum cell_configure_cmd
+ * @ukey:   the name of what is set, or NULL for the commands that take none
+ * @uvalue: a string for CELL_SET_STRING, @aux bytes for CELL_SET_BINARY
+ * @aux:    a length for CELL_SET_BINARY, a file descriptor for CELL_SET_FD
+ *
+ * Shaped like fsconfig(). Data only goes in. Holding @cfd is all the authority
+ * it takes over the cell. Filling a slot also takes what using the object that
+ * goes into it would take.
+ *
+ * All of it needs the cell to be in state CELL_BUILDING.
+ *
+ * Return: 0, -EBUSY if the cell is past CELL_BUILDING or the slot is taken,
+ * -EOPNOTSUPP for an unknown @cmd or a reserved key, -EINVAL for an unknown key
+ * or arguments that do not go with @cmd, or what the slot has to say.
+ */
+SYSCALL_DEFINE5(cell_configure, int, cfd, unsigned int, cmd,
+		const char __user *, ukey, const void __user *, uvalue, int, aux)
+{
+	char *key __free(kfree) = NULL;
+	char *str __free(kfree) = NULL;
+	struct cell *cell;
+
+	CLASS(fd, f)(cfd);
+	cell = cell_from_fd(&f);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	switch (cmd) {
+	case CELL_SET_FLAG:
+		if (!ukey || uvalue || aux)
+			return -EINVAL;
+		break;
+	case CELL_SET_STRING:
+		if (!ukey || !uvalue || aux)
+			return -EINVAL;
+		break;
+	case CELL_SET_BINARY:
+		if (!ukey || !uvalue || aux <= 0)
+			return -EINVAL;
+		break;
+	case CELL_SET_FD:
+		if (!ukey || uvalue || aux < 0)
+			return -EINVAL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (ukey) {
+		key = strndup_user(ukey, CELL_KEY_MAX);
+		if (IS_ERR(key))
+			return PTR_ERR(no_free_ptr(key));
+	}
+	if (cmd == CELL_SET_STRING) {
+		str = strndup_user(uvalue, 256);
+		if (IS_ERR(str))
+			return PTR_ERR(no_free_ptr(str));
+	}
+
+	guard(mutex)(&cell->lock);
+
+	if (cell->state != CELL_BUILDING)
+		return -EBUSY;
+
+	switch (cmd) {
+	case CELL_SET_FLAG:
+		/* There are none yet. */
+		return -EINVAL;
+	case CELL_SET_STRING:
+		return cell_set_string(cell, key, str);
+	case CELL_SET_BINARY:
+		return cell_set_binary(cell, key, uvalue, aux);
+	case CELL_SET_FD: {
+		CLASS(fd_raw, slot)(aux);
+
+		if (fd_empty(slot))
+			return -EBADF;
+		return cell_set_fd(cell, key, fd_file(slot));
+	}
+	}
+	return -EOPNOTSUPP;
+}

-- 
2.55.0

