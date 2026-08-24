Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8045DF4B
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587232; cv=none; b=As8jcJJ9gNKpambYkThnONynC2d55yQvG/Sz0m2wqu3szgs6cxlNpQ8dXbOV/SwBl0pe4f8btKP+26FKs+hk/hCIvGbvm6YYa29IjJTGtWE76bgn7RR++r7vpnPbR2X3d1L8htJYj5gC1AJTw9GNueiXRdKBeS5NaUaOHRfplXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587232; c=relaxed/simple;
	bh=OqjgF/hJt3h9vezPyHTJHOceF1En5Mqbd8IuitZYJqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7Q1RkCmx+xbpfTDl+GapJ51bMstTp6G6F7li/hggxJ1onALsMLJDVz+SuoLtfMCxsGrvZwhZI2GaDBOVpjwRG59x29l7RCO0aaJk8/wQarrfaoVkex4vmDE8zhVofRkLItFeDCirbqcvqFzYzmoVsR+bnsBaelChr2jzAw0Jks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=Aadcp4eB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="Aadcp4eB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso40418095ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1787587229; x=1788192029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RczIctN1PpGQAiQyB2f3cROMeNeQg5Pc8F7QQbKXf5k=;
        b=Aadcp4eBl8UIbP66cPMkr03DJqbtTqbGd5JHkbDXqxCyk0a6+tqET/XC97nDWRG8eX
         tGK41tb/33r8KpYxIPn+ZhwCR4VBHQg7SF+kwtqk/Ct+6qOy18S7ucmOgfpNjiOY628a
         SULQt73jTUDQLfA5mmh2FlF4vP8xcmm0tGABA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787587229; x=1788192029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RczIctN1PpGQAiQyB2f3cROMeNeQg5Pc8F7QQbKXf5k=;
        b=Evk2TGD75r+klEqiDGDrhyOvV4Ya0GJBGKZk4eIFR9V5zAl7g5VNqsnoMwb6mrHZrC
         mjxtgRBUBIgxzV64hucOCJbkFTEhtHY5DeE+yvGWz/qEWO3rx/Bl5jB5I8J9jtok4XOx
         7lEpjHnmM5qSndI60qOzdW28B8GJoGQwHQkIrinoKcTnhTiBfhhAYu8w5LhXulrWCQiQ
         lfrgHgVtcySbJ0AzNszNDAdyncD7avRafI9oxeknt/UYhUoGgy7RnB5OANU5RBjYECR7
         /By4sofjQdtk73N0yVUvOAxW3Ijmo8mSjkk/R9PZ8Gy+TwYP05iUayDCiuuUzaoFlkPB
         Kplg==
X-Forwarded-Encrypted: i=1; AHgh+Rrmr0ERUXbr9m8YRByvc11tQ76bDnYYVpj52C+uU4G/GvevaizgmcVQjtGcl1DnxnrlpGpuonGeLMViuvNj@vger.kernel.org
X-Gm-Message-State: AFuF++kz4a1QmNWfmJg+9VEljSn+jNvjL7b3wGH/+P60nuULi8QU0KO1
	1+TL114iWB2SL4rSkUnZ4XNNDt3gsy5r7fruZGnf3vi0xRAzDjeToVVcEASVD7CqEuE=
X-Gm-Gg: AR+sD12sbfQvc5nN5fONfvIKXI+4ZfPQUVm1J5IZoQIsyWn6rNUr9PD8ikRrHIqS7lG
	/5v9aSJgfJdOaCI0bMa4QgEErjLZ0JHKDWM8WSCPMHSidFEIPppp79kbDT++aGN8j5nal6QSIEa
	H5ISieku6XbtUlfxjSv8N0PzJzSxFy3B6+reyNIluZxm8c52CweYQ6AUhKoReeK4c+uB7erEmLM
	P/4uib20cnpFDRi6zzb5lvX02AyITtuYQE5nIidjHCSL9ZFUS0szwOleyzi/GRFAwquFTvb0KAt
	512R3M5fAmlchZD7yVza0q2WH9yTIXJYU+XY941N63TiQZz8qQ/LLW+RGs7N5WIX9JdQ5VRCjBY
	mCM40S6BDptRkt7Tbq3twaAC/ArjziQSneLzSCTDoiPFAs3w1Y3J3pOeSW6skT1G6F7DBHRxnsb
	dSkbUqmZQJQdI9fy4wrMucE+pws8AL3g4UnB7q6+pOzuSakzD00y4BpHfmIbUh/TAQ0wTqT1vOb
	zAT41PZJhYn9lzRgjnaSSAVe9bPYcZzf3klGgf+tay0Ik12xfZC1jstHaERKCM2zcw+HjE0GrBK
	Y64O5aYmegtRRgSLlnyocc4Z85+7r/lqhQIj1ga8P6HBdT5zqIiJDg==
X-Received: by 2002:a17:902:e943:b0:2d6:3c2f:69b with SMTP id d9443c01a7336-2d64af6f8cemr525133125ad.8.1787587226570;
        Mon, 24 Aug 2026 09:00:26 -0700 (PDT)
Received: from leesin ([147.46.121.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768ba680sm19097655ad.63.2026.08.24.09.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:00:26 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	eulgyukim@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] general protection fault in path_put
Date: Tue, 25 Aug 2026 01:00:20 +0900
Message-ID: <20260824160022.2378192-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We found a "general protection fault in path_put" on Linux v7.2.
The issue was found by our own race fuzzer. We have not analyzed the root cause,
so we do not have a proposed fix to offer.

To reproduce the race reliably, we applied the delay patch below to the
kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
crash log we observed, the delay patch and the reproducer are all included
below.

The following kernel config options are required to reproduce the issue:
    CONFIG_UPROBES=y
    CONFIG_UPROBE_EVENTS=y
    CONFIG_TRACING=y
    CONFIG_DEBUG_FS=y
    CONFIG_FAULT_INJECTION=y
    CONFIG_FAILSLAB=y
    CONFIG_FAULT_INJECTION_DEBUG_FS=y
    CONFIG_KASAN=y

We hope this report is useful. Please let us know if any further
information would help.

Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

Kernel delay patch:
==================================================================
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c274346853d1..203ff3d601dc 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -10,6 +10,7 @@
 #include <linux/bpf-cgroup.h>
 #include <linux/cleanup.h>
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/filter.h>
 #include <linux/module.h>
 #include <linux/namei.h>
@@ -339,6 +340,9 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	int ret;
 
 	tu = kzalloc_flex(*tu, tp.args, nargs);
+	if (!tu && !strncmp(current->comm, "syzrepro", 8)) {
+		mdelay(10);
+	}
 	if (!tu)
 		return ERR_PTR(-ENOMEM);
 
@@ -360,6 +364,9 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	return tu;
 
 error:
+	if (!strncmp(current->comm, "syzrepro", 8)) {
+		mdelay(10);
+	}
 	free_percpu(tu->nhits);
 	kfree(tu);
 
@@ -371,6 +378,9 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
 	if (!tu)
 		return;
 
+	if ((unsigned long)tu >= 0xfffffffffffff000UL) {
+		mdelay(10);
+	}
 	path_put(&tu->path);
 	trace_probe_cleanup(&tu->tp);
 	kfree(tu->filename);
@@ -686,6 +696,10 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	argv += 2;
 
 	tu = alloc_trace_uprobe(group, event, argc, is_return);
+	if (!strncmp(current->comm, "syzrepro", 8) &&
+	    (unsigned long)tu >= 0xfffffffffffff000UL) {
+		mdelay(10);
+	}
 	if (IS_ERR(tu)) {
 		ret = PTR_ERR(tu);
 		/* This must return -ENOMEM otherwise there is a bug */

==================================================================

C reproducer:
==================================================================
#define _GNU_SOURCE
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <unistd.h>

#define SYSCHK(x) ({ long __r = (long)(x); if (__r == -1L) { perror(#x); exit(1); } __r; })

/*
 * Register a uprobe while failslab fails the n-th kernel allocation.  The error
 * path hands the ERR_PTR straight to the cleanup, and path_put() walks over it.
 * g_hot holds the n values that actually crashed, tried first.
 */
static const int g_hot[] = { 8, 9, 10, 11, 7, 12, 6, 13, 5, 14 };
#define NHOT ((int)(sizeof(g_hot) / sizeof(g_hot[0])))
#define NSWEEP 40

static char g_events[256];
static char g_target[256];

static void write_file(const char *path, const char *val)
{
	int fd = SYSCHK(open(path, O_WRONLY | O_CLOEXEC));

	SYSCHK(write(fd, val, strlen(val)));
	close(fd);
}

static void setup_tracefs(void)
{
	static const char *const c[] = { "/sys/kernel/tracing/uprobe_events",
					 "/sys/kernel/debug/tracing/uprobe_events" };
	unsigned i;
	int fd;

	for (i = 0; i < 2; i++) {
		fd = open(c[i], O_WRONLY | O_CLOEXEC);
		if (fd >= 0) {
			close(fd);
			snprintf(g_events, sizeof(g_events), "%s", c[i]);
			return;
		}
	}
	mkdir("/syztracing", 0755);
	mount("none", "/syztracing", "tracefs", 0, NULL);
	snprintf(g_events, sizeof(g_events), "/syztracing/uprobe_events");
	close(SYSCHK(open(g_events, O_WRONLY | O_CLOEXEC)));
}

static void setup_target(void)
{
	char buf[4096];
	int fd;

	memset(buf, 0x90, sizeof(buf));
	snprintf(g_target, sizeof(g_target), "/root/syzrepro_f0");
	fd = SYSCHK(open(g_target, O_CREAT | O_RDWR | O_CLOEXEC, 0755));
	SYSCHK(write(fd, buf, sizeof(buf)));
	close(fd);
}

static void set_fail_nth(int fd, int n)
{
	char b[16];

	write(fd, b, snprintf(b, sizeof(b), "%d", n));
}

static void *worker(void *p)
{
	char name[16], cmd[192];
	int idx = (int)(long)p, fnfd, evfd, it, k, n, len;

	snprintf(name, sizeof(name), "syzrepro%d", idx);
	prctl(PR_SET_NAME, name, 0, 0, 0);
	fnfd = SYSCHK(open("/proc/thread-self/fail-nth", O_RDWR | O_CLOEXEC));
	evfd = SYSCHK(open(g_events, O_WRONLY | O_CLOEXEC));

	for (it = 0; it < 64; it++) {
		for (k = 0; k < NHOT + NSWEEP; k++) {
			n = k < NHOT ? g_hot[k] : k - NHOT + 1;
			len = snprintf(cmd, sizeof(cmd), "p:s%1d%03d%03d %s:0",
				       idx, it % 1000, n % 1000, g_target);
			set_fail_nth(fnfd, n);
			write(evfd, cmd, len);
			set_fail_nth(fnfd, 0);
		}
	}
	close(evfd);
	close(fnfd);
	return NULL;
}

int main(void)
{
	pthread_t th[2];
	long i;

	mkdir("/sys/kernel/debug", 0755);
	mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
	write_file("/sys/kernel/debug/failslab/ignore-gfp-wait", "N");
	setup_tracefs();
	setup_target();

	for (i = 0; i < 2; i++)
		pthread_create(&th[i], NULL, worker, (void *)i);
	for (i = 0; i < 2; i++)
		pthread_join(th[i], NULL);
	return 0;
}
==================================================================

Crash log:
==================================================================
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 0 UID: 0 PID: 399 Comm: syzrepro0 Not tainted 7.2.0-dirty #3 PREEMPT 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:path_put+0x24/0x60 fs/namei.c:722
Code: 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56 53 48 89 fb 49 be 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 05 e8 c0 b0 f3 ff 48 8b 7b 08 e8 a7 ac 02 00 48
RSP: 0018:ffff88810c157c60 EFLAGS: 00010203
RAX: 0000000000000008 RBX: 000000000000003c RCX: 0000000000248906
RDX: 0000000000248964 RSI: 0000000b0f0a1740 RDI: 0000000000000044
RBP: ffff8881015b3d08 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffa557aa00 R11: ffffffffa19cb170 R12: 0000000000000002
R13: 00000000fffffff4 R14: dffffc0000000000 R15: ffffffffa218f5c0
FS:  00007a12c63726c0(0000) GS:ffff88817575f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007a12c63ed200 CR3: 0000000107ea8000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 free_trace_uprobe+0x8f/0xf0 kernel/trace/trace_uprobe.c:384
 __free_free_trace_uprobe kernel/trace/trace_uprobe.c:546 [inline]
 __trace_uprobe_create+0x222/0xb50 kernel/trace/trace_uprobe.c:739
 trace_probe_create+0x52/0x90 kernel/trace/trace_probe.c:2371
 dyn_event_create+0x48/0x70 kernel/trace/trace_dynevent.c:128
 create_or_delete_trace_uprobe+0x3c/0x70 kernel/trace/trace_uprobe.c:753
 trace_parse_run_command+0x19d/0x2c0 kernel/trace/trace.c:9565
 vfs_write+0x20d/0xa10 fs/read_write.c:685
 ksys_write+0xb0/0x170 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7a12c646e38f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 a9 d4 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 fc d4 f8 ff 48
RSP: 002b:00007a12c6371d80 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007a12c6371dd0 RCX: 00007a12c646e38f
RDX: 000000000000001e RSI: 00007a12c6371dd0 RDI: 0000000000000005
RBP: 000000000000001e R08: 0000000000000000 R09: 0000000000000064
R10: 00007a12c6371ab7 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000008 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:path_put+0x24/0x60 fs/namei.c:722
Code: 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56 53 48 89 fb 49 be 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 05 e8 c0 b0 f3 ff 48 8b 7b 08 e8 a7 ac 02 00 48
RSP: 0018:ffff88810c157c60 EFLAGS: 00010203
RAX: 0000000000000008 RBX: 000000000000003c RCX: 0000000000248906
RDX: 0000000000248964 RSI: 0000000b0f0a1740 RDI: 0000000000000044
RBP: ffff8881015b3d08 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffa557aa00 R11: ffffffffa19cb170 R12: 0000000000000002
R13: 00000000fffffff4 R14: dffffc0000000000 R15: ffffffffa218f5c0
FS:  00007a12c63726c0(0000) GS:ffff88817575f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007a12c63ed200 CR3: 0000000107ea8000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	f3 0f 1e fa          	endbr64
   a:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   f:	41 56                	push   %r14
  11:	53                   	push   %rbx
  12:	48 89 fb             	mov    %rdi,%rbx
  15:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
  1c:	fc ff df
  1f:	48 83 c7 08          	add    $0x8,%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 05                	je     0x36
  31:	e8 c0 b0 f3 ff       	callq  0xfff3b0f6
  36:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
  3a:	e8 a7 ac 02 00       	callq  0x2ace6
  3f:	48                   	rex.W
==================================================================


