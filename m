Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F53B9604
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112362; cv=none; b=KlL64MZ+ZlEosZ6jXO7mVOymRJfSFtCsKYbr1uLzg527Enhy1M79GwBbMj9PytOJxlTsTUTs2ddPdynkf//zzqQx19OzxXZsv0SR1Z84NYxJYAQAPot1W+rgQ3KnmWgRTQ6fV2e5mN6w53yCKYmrZQM8f5XijFkW8E0h70pua2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112362; c=relaxed/simple;
	bh=857ZAe0mduS9VFMFqaKfW/expzuU5bBWUgJR+Mpgl8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buJNU+w5coLeC7HrTy79dNZW70MYfnrPWE/QCu21qzSddN21cGbJZqRWD7/8n299bS2tgaj9Ft3Ye46ZAamHF8Cbi4biVqnzw/J3NJ31tTy+5Dyw0FznsMUswSeA3DSvzOhg5lsQGsJw1lbpA5v9CVKeJe7P1CRvvSZkO6T72NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=o+x3e9IS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="o+x3e9IS"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8299c75f730so2222052b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 20:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773112361; x=1773717161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGbxRmtnq4j2JJLS66I6xJ9tyvKo4E5pO4kbP3Ck6zI=;
        b=o+x3e9ISrmHQWlWO9mgn9Q8LZeBm0lbBDNsZUSLR9UUaMnobKat8UL/CprUMrHDWfd
         xja6OPC+joHrBPdErZjDjD+CI+BB4qZv390jVOI7elo4WeTT2/imc55rLLLdCMYaAXd6
         /w0zxLSGJyOG0tmDi5W5DVYVL9eZCcAV5wpes1NzGgWn8xkN1I0UNvl94EonMQ/icXBe
         CjiuzaX/Gf76CLNbm9+vyKKSBYwYZlY66V4wduv5psyoi+RWbifZ0gagA0X/kuCTPfjO
         WYOJOytYyhxqLmEeLsLcaItK/BRnawRqVwisK14WZdIIOvSgnubZZKUbU7govCgJiJ+G
         5QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773112361; x=1773717161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGbxRmtnq4j2JJLS66I6xJ9tyvKo4E5pO4kbP3Ck6zI=;
        b=SDRN/bFFD8rjjGaAI4B4PdY8vdaIGGLTbwlv9M4kUMHX1pKmuRCPyRBaOOv6QcY6oj
         92Inw4NFPJxvoNmKUmaqZu1mO3wbqKSHue1sWe5O/44JQTJWBVxmqiyqLeoCcbuub42W
         mKuudZ/A/MEPeRsQFD82c5AZs0nGlln6DzBXxAqbANt2/0loZn+XYEggwaev0xS17xdj
         fskrJgEzrv1Xrx0b87HsBiZS2FMYIwZATbpRpHLlf2d8L6k4oZoyZFltT0Sf6jmgP5ZP
         bxyQCPYhhlo1cZgq+eJtzCqrfPkt/ckQWOvxjbzz153/OCT9JSEb8W8II1J0OE/525lk
         PndA==
X-Gm-Message-State: AOJu0Yz4b/LTp8jhvhiRxaGzeajLq28i/FIUWk5u+MO1CJ8343TElx8N
	+Qs8no0LsoEXhLOCY1j/xVLd2mI3UKXd3lNiPnbtUhitXk+SakNBP1TvDh35+fSiU9A=
X-Gm-Gg: ATEYQzx+YmmMbDEq/5XMklNdiXnZO3d6mNrrAKxlexNMfNKhLTKZnloiZoRwY0fc9e6
	XDmXp6gbEsSr7EjEfLd6GzRkOy3L6DlmBCnzLYAv6FGaLvk13dg24GCWffUpuoUSxSUIY09F+y4
	GMtAU7upGuQzeJNHzd0MSncqqgR01k+aXQ32vZX4dMs8Zji/Tqx24DOxXrwlZPFe+ndiAS7+grH
	HeLZPI/HoeczsPtBo/WXA8AXuXENdaIsHbmIy6p0Us03jGnUXS2EKXC9AYWck0/6BiDCD7BzTjt
	3JW6YqCIW+Q2aPZ2lcBuDaU3wdPr7BmFmf4FOEpRdjdzraPDWkdixDgX9vOkhm68tHc5DResDFr
	hn+I2UzZoVtEeGfUuua0CjNbNvidLF4sU3UoCsaXLWs+JmwHY4YOZkwo7Dw4LPO1zHdHC+GILTP
	jCeBbHhsBF
X-Received: by 2002:a05:6a00:9517:b0:829:cbc0:f0c1 with SMTP id d2e1a72fcca58-829e3fe0536mr1540396b3a.18.1773112360560;
        Mon, 09 Mar 2026 20:12:40 -0700 (PDT)
Received: from localhost ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465c872sm14213691b3a.19.2026.03.09.20.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 20:12:40 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Zi Yan <ziy@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	WANG Rui <r@hev.cc>
Subject: [PATCH v4 2/2] binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for THP
Date: Tue, 10 Mar 2026 11:11:38 +0800
Message-ID: <20260310031138.509730-3-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310031138.509730-1-r@hev.cc>
References: <20260310031138.509730-1-r@hev.cc>
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

