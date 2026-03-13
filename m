Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B764E2D46B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363156; cv=none; b=q4ultUaLndn9xDoXnRfZ0+5Q7ksxc7+Jrx11DyV7Tu8NItiBD22E9SoGek7TV7blmyiZs5+8+YRD3uT/MR6MbApK7ha+pSdoSt1LAEhzxKCw55R7UIZ/xSXGIWBR1TpmQfxSTIB45x+9N66Hl1Oxv9XREJbOaOouBfN2bBG93n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363156; c=relaxed/simple;
	bh=1wDo3jXKa/91+g4XbNkQ2u1DZG7fYIBpjFkTHK5C6kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDClvqHH+Yul3YOdFINkAFCABvPBUVqDMX18Jhue6bgEByvRDFwfqfd4+Fh8uxLzk3TxPllNITqLJZUM3FMvTIo2/kqBL1uNQb9D1jsIieGbE9GrieZJapgP5klAI3xEXNBz4YYzrdDg+MyJr3FCo8tu0oz5jCMYYOZUwndm9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=wrEsarjH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="wrEsarjH"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82418b0178cso982571b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 17:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773363154; x=1773967954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGznOHQEDu0JbgYRJJzSYbQuqE+ZUTZUlFHToiIO7T4=;
        b=wrEsarjHeymS+a+yiJXaSFRye2GhfTySmQHQMW2EgTfJGPULsMQRMNNpG6nBAVH5r/
         goomdyhusLgKvauHi8218AWw1GSe2Hl3a3j97AuSlW88XsT7DJ/KXBnHsWXla/Kyk5Yx
         O3Ahx2/6NlTDE6RkcAdHLlmu0wlz4/X9X0E00ZSVBy/Fst0rlMhGVf/myHNbx0ilq3ld
         r2zvx4qvkHdOUUKiJ7RBiuEBcbS3qJjUnLlrhtuG7XuppHEJWIAg7fGq9+r36eqBbuvj
         BSslKmaeghMHANaUlbIBSEHVHyo7o39/EkV6Oyht6DFLc+8NgJeZt5hFVuBQD9nhkg7Q
         s1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773363154; x=1773967954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGznOHQEDu0JbgYRJJzSYbQuqE+ZUTZUlFHToiIO7T4=;
        b=D/C8Inj+QuLajjK3YlN0Yd7T2DXoOaWQkCYJzIFqDOfvB2ae151j/bnUIY3V7EL/IP
         3U5rg+VoMuTrqZEV1i1SD4K5P0sVQyJt7Rs1onZ7XU7B9W/KojKMzzPKLGjmmKid5vyP
         ++J/bj5moVcDcErNwMglIq3Tir+mlJDmZKno+jjqlHLL4Tl6/BAX9qwiyqnENKc0RB1O
         uSLhYEo0rYeT3cK5ymdHEAD95dgbdySec5vHMMmgUuzHMh5sXd3B8vJkJwwFMFkZvIgX
         lV78jqpQTIyoUFYT5ktvWE7fmY4OaskjM9p8fOl/bFQqw/IT9IvUcZaPym/Ng9CwmLyd
         16fQ==
X-Gm-Message-State: AOJu0YwnYQnL9iUPUtU/V/LiLQF45VeUe0zZdxa1QIvDzk326OhsmF4O
	BA5vpOz8IQrPa0rkR2s+EGO/fAWuEW3jYIDrQ/GKaJYJGQi6UQJ4XS2ydm8dulih3Xk=
X-Gm-Gg: ATEYQzzrtGufrGz5B2i5rFhI2kh1oqX7ngl2Mz3JSYg9DaoW6vXf4O16WiHNms5MuIE
	NXRac0TPCSVjRor671YGnUwe7SRxH4LfPNFqk95iNeqAYB9yZezy4Aw5HKVWHDhiuobva9JFe8J
	XhSw4N9oCrWTLAQ7DI1zZJJRmxkbp2mD91T4dD61eMkEJgjVU4J/uxyReKrFdLoUC2tWCvj62Wl
	sNrzLdfgTZLC0BCS9uHbXkNexUzd4By1+Sd6DCP32UK64teeLTaahBc0KNWpOIlrILm720pkoFt
	2dfnZh58ObVDErGiq3vOG3FLu55OqImwcqfnY3LnFmh2JaKOQS2feXnd6o5ZyNN1+9v4+Zo4JlB
	5DO4GaZJQ3zfmDPgxMHp0PKw3LDa3ScmGcFv6bKJO2WEE5mG35XnYD4J/qhjauNqmMca2U8oemq
	YMs+W1y0c16fT8q9mAcEQ=
X-Received: by 2002:a05:6a20:3d88:b0:398:7357:bb92 with SMTP id adf61e73a8af0-398ec9e200amr981009637.5.1773363154010;
        Thu, 12 Mar 2026 17:52:34 -0700 (PDT)
Received: from localhost ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a1e72cf33sm122827b3a.37.2026.03.12.17.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:52:33 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	WANG Rui <r@hev.cc>
Subject: [PATCH v5] binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for THP
Date: Fri, 13 Mar 2026 08:52:11 +0800
Message-ID: <20260313005211.882831-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File-backed mappings can only be collapsed into PMD-sized THP when the
virtual address and file offset are both hugepage-aligned and the
mapping is large enough to cover a huge page.

For ELF executables loaded by the kernel ELF binary loader, PT_LOAD
segments are aligned according to p_align, which is often just the
normal page size.  As a result, large read-only segments that would
otherwise be eligible may fail to get PMD-sized mappings.

Even when a PT_LOAD segment itself is not PMD-aligned, it may still
contain a PMD-aligned subrange.  In that case only that subrange can
be mapped with huge pages, while the unaligned head of the segment
remains mapped with normal pages.

In practice, many executables already have PMD-aligned file offsets
for their text segments, but the virtual address is not aligned due
to the small p_align value.  Aligning the segment to PMD_SIZE in such
cases increases the chance of getting PMD-sized THP mappings.

This matters especially for 2MB huge pages, where many programs have
text segments only slightly larger than a single huge page. If the
start address is not aligned, the leading unaligned region can prevent
the mapping from forming a huge page. For larger huge pages (e.g. 32MB),
the unaligned head region may be close to the huge page size itself,
making the potential performance impact even more significant.

A segment is considered eligible if:

* it is not writable,
* both p_vaddr and p_offset are PMD-aligned,
* its size is at least PMD_SIZE, and
* its existing p_align is smaller than PMD_SIZE.

To avoid excessive virtual address space padding on systems with very
large PMD_SIZE values, this is only applied when PMD_SIZE <= 32MB.

This mainly benefits large text segments of executables by reducing
iTLB pressure.

This only affects ELF executables loaded directly by the kernel ELF
binary loader.  Shared libraries loaded from user space (e.g. by the
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
Changes since [v4]:
* Drop runtime THP mode check, only gate on CONFIG_TRANSPARENT_HUGEPAGE.

Changes since [v3]:
* Fix compilation failure under !CONFIG_TRANSPARENT_HUGEPAGE.
* No functional changes otherwise.

Changes since [v2]:
* Rename align_to_pmd() to should_align_to_pmd().
* Add benchmark results to the commit message.

Changes since [v1]:
* Drop the Kconfig option CONFIG_ELF_RO_LOAD_THP_ALIGNMENT.
* Move the alignment logic into a helper align_to_pmd() for clarity.
* Improve the comment explaining why we skip the optimization
  when PMD_SIZE > 32MB.

[v4]: https://lore.kernel.org/linux-fsdevel/20260310031138.509730-1-r@hev.cc
[v3]: https://lore.kernel.org/linux-fsdevel/20260310013958.103636-1-r@hev.cc
[v2]: https://lore.kernel.org/linux-fsdevel/20260304114727.384416-1-r@hev.cc
[v1]: https://lore.kernel.org/linux-fsdevel/20260302155046.286650-1-r@hev.cc
---
 fs/binfmt_elf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fb857faaf0d6..d5f5154079de 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -489,6 +489,32 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
 	return 0;
 }
 
+static inline bool should_align_to_pmd(const struct elf_phdr *cmd)
+{
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return false;
+
+	/*
+	 * Avoid excessive virtual address space padding when PMD_SIZE is very
+	 * large, since this function increases PT_LOAD alignment.
+	 * This threshold roughly matches the largest commonly used hugepage
+	 * sizes on current architectures (e.g. x86 2M, arm64 32M with 16K pages).
+	 */
+	if (PMD_SIZE > SZ_32M)
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
@@ -501,6 +527,10 @@ static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
 			/* skip non-power of two alignments as invalid */
 			if (!is_power_of_2(p_align))
 				continue;
+
+			if (p_align < PMD_SIZE && should_align_to_pmd(&cmds[i]))
+				p_align = PMD_SIZE;
+
 			alignment = max(alignment, p_align);
 		}
 	}
-- 
2.53.0

