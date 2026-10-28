Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205377;
	b=F/k7mqIgilrYxPME8k3jkZ6By/9UOaN3P3nwlMmZlg3Y4I2VoEpGsJZhgJtFpJsANT8U
	 WOqNc+Pz6DBSNgc/DG/uDP5srt+mgHzsEp7+t5DjQ72Qa1/U314JgHRZcDbqSIkxhBkiH
	 RBi1gMPS5XsmHJUwyu4v8xPoSrXCJ7HZiP39Indjn/SY2ACSN3aZHgEF4HhEh3IrsNZcU
	 05WZOeLY8QFShh+4V5JNpCxpLuxnZQA7+3BOt4THOundF+s9PsJq5YA+iNBRyY4j4MLq0
	 yHD3UnKW0mEwT1S4fam4p1DTGF9VPk5I2VtDEttPSQN3OxHK3Afdftl28x07Lq94Luw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205377;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CQqkcYkZkr4rwHq/Ge5oniKK6l42vWnzPLUVwxlWki8=;
	b=42ObxmUS0r2bhsKpeYCcCvJ4XvEu69F4zXS4PcLAG6OH68uKD4vzqZfgiQuJihOznYI+
	 7aT04UNTDv7MQR1SWBuDljj+MgU8uUsnFJfhrDKr4EDFDANS5M3X91wrK1Y3KHexv6d35
	 RU6B2T+9Z0nve6bd3UosOXfxgL6/kgrYuVoF9Sk8NPJxub7x0X0FJGGhja5k+KlzD62Lx
	 OTObFld7Y5K5NmAmnXw58SioObUhrKK8x3Km+6Z81M5i5uY/22vQ+hh7TgWwYzulgMFea
	 AksvoJI0N2ZcQCGr1zBoN+eNObn0wNX0NQ/iVZ2k8n+mIEYc50zZL6Px3xuG+OfQ28A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q2TYhcHT;
	arc=none smtp.remote-ip=91.218.175.18
Received: from mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E7606A326
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 020E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q2TYhcHT
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z7cUKBLGFevtk/P5lF1oWiXGvvxjaOkFOKjx32fML8M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205376; v=1; x=1793810176;
 b=q2TYhcHTIDcit4LsXy97W2Jbj0O7THaDWZAu+9cPL34FtK9m4h/XRHunlDGAM/4oMbJyQhyA
 bFL63vJx/GjmqplekqtCeJXMyUTbKomVskwXsN8HC85ZKUeRTd2GNd2RVuOPwZNCyTx/2QxXdLz
 lvET+D1OhgPXXXdsuESs6aLE=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 2eb5e3b7019f42fd;
	Wed, 28 Oct 2026 16:36:16 +0000
X-Mizu-Trace-ID: 2eb5e3b7019f42fd
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/39] sysctl: store architecture sysctl bounds by value
Date: Thu, 29 Oct 2026 00:34:46 +0800
Message-Id: <cd3e2969a6a30dbfeb3e69d3bafb8bc52e06a719.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
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

From: Wen Yang <wen.yang@linux.dev>

Replace architecture bound pointers with numeric limits.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 arch/arm64/kernel/armv8_deprecated.c |  4 ++--
 arch/arm64/kernel/process.c          |  4 ++--
 arch/riscv/kernel/process.c          |  4 ++--
 arch/s390/appldata/appldata_base.c   | 12 +++++++-----
 arch/s390/kernel/hiperdispatch.c     |  4 ++--
 arch/s390/kernel/topology.c          |  8 ++++----
 arch/sh/kernel/vsyscall/vsyscall.c   |  4 ++--
 arch/x86/entry/vdso/vdso32-setup.c   |  4 ++--
 arch/x86/kernel/cpu/bus_lock.c       |  4 ++--
 9 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index b7a1f8b788bb..1c143e3a8d09 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -566,8 +566,8 @@ static void __init register_insn_emulation(struct insn_emulation *insn)
 
 		sysctl->procname = insn->name;
 		sysctl->data = &insn->current_mode;
-		sysctl->extra1 = &insn->min;
-		sysctl->extra2 = &insn->max;
+		sysctl->min = insn->min;
+		sysctl->max = insn->max;
 		sysctl->proc_handler = emulation_proc_handler;
 
 		register_sysctl_sz("abi", sysctl, 1);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 581f80e9b9b7..9db8f8bedc06 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -944,8 +944,8 @@ static const struct ctl_table tagged_addr_sysctl_table[] = {
 		.data		= &tagged_addr_disabled,
 		.maxlen		= sizeof(int),
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 34c1d498d1ca..6a1408dbf423 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -429,8 +429,8 @@ static const struct ctl_table tagged_addr_sysctl_table[] = {
 		.data		= &tagged_addr_disabled,
 		.maxlen		= sizeof(int),
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index f10b2f040cc2..012f9eae8e62 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) "appldata: " fmt
 
 #include <linux/export.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/sched/stat.h>
 #include <linux/init.h>
@@ -250,9 +251,9 @@ appldata_timer_handler(const struct ctl_table *ctl, int write,
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &timer_active,
+		.min		= 0,
 		.maxlen		= sizeof(int),
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.max		= 1,
 	};
 
 	rc = proc_douintvec_minmax(&ctl_entry, write, buffer, lenp, ppos);
@@ -281,8 +282,9 @@ appldata_interval_handler(const struct ctl_table *ctl, int write,
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &interval,
+		.min		= 1,
 		.maxlen		= sizeof(int),
-		.extra1		= SYSCTL_ONE,
+		.max		= INT_MAX,
 	};
 
 	rc = proc_dointvec_minmax(&ctl_entry, write, buffer, lenp, ppos);
@@ -312,9 +314,9 @@ appldata_generic_handler(const struct ctl_table *ctl, int write,
 	int active;
 	struct ctl_table ctl_entry = {
 		.data		= &active,
+		.min		= 0,
 		.maxlen		= sizeof(int),
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.max		= 1,
 	};
 
 	found = 0;
diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index 1397dab8a677..4455b081c652 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -272,9 +272,9 @@ static int hiperdispatch_ctl_handler(const struct ctl_table *ctl, int write,
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &hiperdispatch,
+		.min		= 0,
 		.maxlen		= sizeof(int),
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.max		= 1,
 	};
 
 	hiperdispatch = hd_enabled;
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 42fc0294f543..8ca541e2f50a 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -624,9 +624,9 @@ static int topology_ctl_handler(const struct ctl_table *ctl, int write,
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &enabled,
+		.min		= 0,
 		.maxlen		= sizeof(int),
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.max		= 1,
 	};
 
 	rc = proc_douintvec_minmax(&ctl_entry, write, buffer, lenp, ppos);
@@ -653,9 +653,9 @@ static int polarization_ctl_handler(const struct ctl_table *ctl, int write,
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &polarization,
+		.min		= 0,
 		.maxlen		= sizeof(int),
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.max		= 1,
 	};
 
 	polarization = cpu_management;
diff --git a/arch/sh/kernel/vsyscall/vsyscall.c b/arch/sh/kernel/vsyscall/vsyscall.c
index 1563dcc55fd3..fb4f465f380b 100644
--- a/arch/sh/kernel/vsyscall/vsyscall.c
+++ b/arch/sh/kernel/vsyscall/vsyscall.c
@@ -38,8 +38,8 @@ static const struct ctl_table vdso_table[] = {
 		.maxlen		= sizeof(vdso_enabled),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 8894013eea1d..53e2e2cd267c 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -66,8 +66,8 @@ static const struct ctl_table vdso_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 177f964d4d36..a9a8177ffccf 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -58,8 +58,8 @@ static const struct ctl_table sld_sysctls[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
-- 
2.25.1

