Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12232C08AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106837; cv=none; b=AZPCyBXbdkeiSTG3f2mc7tqjV1qDjP0i731grTMfl/LeLfx0rCP/FgxY1IILpMvukrB4ZCvwR5v/y7HPvztJFn7d4DbjkIh5+637MSwjaSMh+pRxGtog5sCz4orRrBBKdNT2mWYverf2YJ3b+1DJ/ERfdVIe4k4/Lucvptrg7Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106837; c=relaxed/simple;
	bh=LGOHe3Q+N2DXozexMFe9YNC2S+lxzgYRIp9kDlu0v4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cwJjjSpVMndTZzYVSnmNxMapn2NtdMnziy7YAX/4WygkgPihlk8JkuuqWoZM1JQW5k2QVsIjxijHGP5c0mYVVyOJSJcwZdp8fOe/P7ZmMhED1oJZQVPnDvTq4yzU0cvptF/oPrqdE0CHkkFv4hrca21DhHdP12TRF4dnBTZBKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=ICzd4zPg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="ICzd4zPg"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae5636ab04so89627085ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 18:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773106834; x=1773711634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a7694XZeCof+FdxT7qTthMncnpG5NN0vfJefAJSmmkg=;
        b=ICzd4zPgWKgEQ/T/amfiFSzEb0GsSb0DhDWwKJ4j7gAuN1ab+43OPdH1DxidFZJ/vb
         SciPe5NxY1Cji/RcL6YjLn/FBPkPRa8H2pmvBoyYb/ilfMHFPf3nze5hZ0IgX8vSvd1A
         koEFzTa/Cuyp5HW/55ScCd1JXvKcwIJ0GVkOE1VJbuSqvCS2rAse6xIAUR6+AuU+Y90K
         zIrTtlGkzziIzVIpAp5xwoFteMRn+1LZbL+5JFk+wyRD9OWEReh8WYbCNaFTfSyCRkym
         kRyZz9YMJGz00Ed1phPtU/+w7ZerACwDctRIv6FU/oTDCX35n+iZEANYnbypRl0eTSrv
         yIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773106834; x=1773711634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7694XZeCof+FdxT7qTthMncnpG5NN0vfJefAJSmmkg=;
        b=g2Zo/I69WELwfUKhBiw+ISvz877MyOBVwBpMtcI8yAS6LUdCUAhddU7f9mxqrz/lbS
         2JKR9ivvNcl9I3oc9X+k9lshMq4NnoQehMXxhGmOUAkupQKkucgs8MCW2OAFExdS47yG
         MIrqA47mifMovOIO4ohfF33kebFKh+PlQvKPofeXChKV1ufuC6XXNFnyab59h3zHgNan
         aNqrVY+OhRiG/7fIVTHXuSlVcifWNexUZJ9DvN/wJL2A+Zv9Yc6Vg6jXaDadql8uGkQc
         LcPuIJK0RGAtDnMq+6WVuJ0b8cg09K7D66CRzsGWsR5SWQ81aHhtl5i58nDkgLH7Qs6W
         8nTQ==
X-Gm-Message-State: AOJu0Yxi98y873ZxpyliD0W+8xIKrAgs6uQipXMoBhz8ixFIuVIbWyyn
	o0RZ2biV8ZtDwg6raEO2O20skiY87YS6/S0QpE2rT7b+PTkzZB6S1pMU43Z/KGuNdPdOe6RGDPW
	4rkUb2vQ=
X-Gm-Gg: ATEYQzwD44pmfq4la/vRCf7D8etOdHJQNkLRs6t5sCBMR7L3584hCmaf8f3Fy+5NbwE
	+sYVDijDHQEq0YXO0ZrqLUENDvavRMHj0QPpkcKil0+vmbakI5gfYZB37epUFXQHMmtgML5Dncf
	nuLCza46HBlVS2U7wueKbYy3MfnYDiOzKG0nXxsCPWPjP0zoThlci1ehhemGluxCX86VtjJEGqY
	aMkU4PC3ZtioKuQLS/k8kZfGOo3anmeD2VJxWKGFar1tZ+O3HQaQ/tCna0J/GFLP05m8Ss1pQYX
	MOEGW++VQYo1wLShBnY9LoCyJCXC9ZU9t+kUrj1owSSEJoYiQicPwrSWbUQOCrF+AnUETD7jlKS
	1oO5so2I8/Dj+ANal6q1iGuxG4pSBciiiaFxwtCqVuvzWp+oniOcmAYhUDdVqoK0e2QJIj1HVyJ
	Tgt3vYmQUO
X-Received: by 2002:a17:903:1968:b0:2ae:8062:8362 with SMTP id d9443c01a7336-2ae82266d9fmr126325985ad.0.1773106834233;
        Mon, 09 Mar 2026 18:40:34 -0700 (PDT)
Received: from localhost ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aea3d26565sm6966515ad.2.2026.03.09.18.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 18:40:33 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	WANG Rui <r@hev.cc>
Subject: [PATCH v3] binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for THP
Date: Tue, 10 Mar 2026 09:39:58 +0800
Message-ID: <20260310013958.103636-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Transparent Huge Pages (THP) are enabled in "always" mode,
file-backed read-only mappings can be backed by PMD-sized huge pages
if they meet the alignment and size requirements.

For ELF executables loaded by the kernel ELF binary loader, PT_LOAD
segments are normally aligned according to p_align, which is often
only page-sized. As a result, large read-only segments that are
otherwise eligible may fail to be mapped using PMD-sized THP.

A segment is considered eligible if:

* THP is in "always" mode,
* it is not writable,
* both p_vaddr and p_offset are PMD-aligned,
* its file size is at least PMD_SIZE, and
* its existing p_align is smaller than PMD_SIZE.

To avoid excessive address space padding on systems with very large
PMD_SIZE values, this optimization is applied only when PMD_SIZE <= 32MB,
since requiring larger alignments would be unreasonable, especially on
32-bit systems with a much more limited virtual address space.

This increases the likelihood that large text segments of ELF
executables are backed by PMD-sized THP, reducing TLB pressure and
improving performance for large binaries.

This only affects ELF executables loaded directly by the kernel
binary loader. Shared libraries loaded by user space (e.g. via the
dynamic linker) are not affected.

Benchmark

Machine: AMD Ryzen 9 7950X (x86_64)
Binutils: 2.46
GCC: 15.2.1 (built with -z,noseparate-code + --enable-host-pie)

Workload: building Linux v7.0-rc1 vmlinux with x86_64_defconfig.

                Without patch        With patch
instructions    8,246,133,611,932    8,246,025,137,750
cpu-cycles      8,001,028,142,928    7,565,925,107,502
itlb-misses     3,672,158,331        26,821,242
time elapsed    64.66 s              61.97 s

Instructions are basically unchanged. iTLB misses drop from ~3.67B to
~26M (~99.27% reduction), which results in about a ~5.44% reduction in
cycles and ~4.18% shorter wall time for this workload.

Signed-off-by: WANG Rui <r@hev.cc>
---
Changes since [v2]:
* Renamed align_to_pmd() to should_align_to_pmd().
* Added benchmark results to the commit message.

Changes since [v1]:
* Dropped the Kconfig option CONFIG_ELF_RO_LOAD_THP_ALIGNMENT.
* Moved the alignment logic into a helper align_to_pmd() for clarity.
* Improved the comment explaining why we skip the optimization
  when PMD_SIZE > 32MB.

[v2]: https://lore.kernel.org/linux-fsdevel/20260304114727.384416-1-r@hev.cc
[v1]: https://lore.kernel.org/linux-fsdevel/20260302155046.286650-1-r@hev.cc
---
 fs/binfmt_elf.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fb857faaf0d6..a0d679c31ede 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -28,6 +28,7 @@
 #include <linux/highuid.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
+#include <linux/huge_mm.h>
 #include <linux/hugetlb.h>
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
@@ -489,6 +490,30 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
 	return 0;
 }
 
+static inline bool should_align_to_pmd(const struct elf_phdr *cmd)
+{
+	/*
+	 * Avoid excessive virtual address space padding when PMD_SIZE is very
+	 * large (e.g. some 64K base-page configurations).
+	 */
+	if (PMD_SIZE > SZ_32M)
+		return false;
+
+	if (!hugepage_global_always())
+		return false;
+
+	if (!IS_ALIGNED(cmd->p_vaddr | cmd->p_offset, PMD_SIZE))
+		return false;
+
+	if (cmd->p_filesz < PMD_SIZE)
+		return false;
+
+	if (cmd->p_flags & PF_W)
+		return false;
+
+	return true;
+}
+
 static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
 {
 	unsigned long alignment = 0;
@@ -501,6 +526,10 @@ static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
 			/* skip non-power of two alignments as invalid */
 			if (!is_power_of_2(p_align))
 				continue;
+
+			if (should_align_to_pmd(&cmds[i]) && p_align < PMD_SIZE)
+				p_align = PMD_SIZE;
+
 			alignment = max(alignment, p_align);
 		}
 	}
-- 
2.53.0

