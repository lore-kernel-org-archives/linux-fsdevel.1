Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA43597B
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773546433; cv=none; b=hDgM368t+DKhWQ1SjITtNZz3eI/2wvG/kkGHLAccrwtSV/iqa9bmJ3NzsAhIaCR/RI2mS1M/PCLsfGSTgScM4/Rv2u/Z+QAw5yWzXENrXbocb9DQYHXKPIOjm87b8r6NxHj3YtZrgnkARF38YClEXZrg52Z7xG0oNNUTbgVYGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773546433; c=relaxed/simple;
	bh=JSvdq5q5x8uvcRfbTRjVJXb7C+3P3o4fE+wFwPONTzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLeenb6N44xLhkL3jXtLMG5IDaUYyy3gIr+WwOIHh1cM5z3I2ggDXzbsi/HdWc2afkxQXLMnXjduaSq8lNNGUvfKLdfcWWMYX7JojXcA98O92ZIA2pjbJbRXCNWwewhaEZzD6xuKxbXCNKzLfRwzCEQtpII6hRnIdsBUrW5pNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ECghoyWQ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ECghoyWQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773546419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7Nj+C4buAERt/DCqiV+RAaqLwYdsTcea6HrGcK7f60=;
	b=ECghoyWQ9JPM54JjuKAsHMky/5Lkp72KV93HMtCD0xvw1ZhnuKuZ3Mofp+qGCm9x2GQ/qM
	qhnSL7bj0+k2shoxtfHntotiKE79LACkFQPjMfcYPr+rXWiE8VD18wvPXz20rGEaNbFAz4
	hf/QKKOrxxp5nGolHKhVOHJAt8gWjdw=
From: Lance Yang <lance.yang@linux.dev>
To: r@hev.cc
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	david@kernel.org,
	jack@suse.cz,
	kees@kernel.org,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	usama.arif@linux.dev,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v5] binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for THP
Date: Sun, 15 Mar 2026 11:46:47 +0800
Message-ID: <20260315034647.8462-1-lance.yang@linux.dev>
In-Reply-To: <20260313005211.882831-1-r@hev.cc>
References: <20260313005211.882831-1-r@hev.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Rui,

CC Baolin and Usama

It would be better to keep earlier CC list across revisions, especially
for people who have already reviewed or were explicitly include before.
Otherwise, they may simply never see subsequent revisions, and from
their side the discussion just stops there ...

Thanks,
Lance

On Fri, Mar 13, 2026 at 08:52:11AM +0800, WANG Rui wrote:
>File-backed mappings can only be collapsed into PMD-sized THP when the
>virtual address and file offset are both hugepage-aligned and the
>mapping is large enough to cover a huge page.
>
>For ELF executables loaded by the kernel ELF binary loader, PT_LOAD
>segments are aligned according to p_align, which is often just the
>normal page size.  As a result, large read-only segments that would
>otherwise be eligible may fail to get PMD-sized mappings.
>
>Even when a PT_LOAD segment itself is not PMD-aligned, it may still
>contain a PMD-aligned subrange.  In that case only that subrange can
>be mapped with huge pages, while the unaligned head of the segment
>remains mapped with normal pages.
>
>In practice, many executables already have PMD-aligned file offsets
>for their text segments, but the virtual address is not aligned due
>to the small p_align value.  Aligning the segment to PMD_SIZE in such
>cases increases the chance of getting PMD-sized THP mappings.
>
>This matters especially for 2MB huge pages, where many programs have
>text segments only slightly larger than a single huge page. If the
>start address is not aligned, the leading unaligned region can prevent
>the mapping from forming a huge page. For larger huge pages (e.g. 32MB),
>the unaligned head region may be close to the huge page size itself,
>making the potential performance impact even more significant.
>
>A segment is considered eligible if:
>
>* it is not writable,
>* both p_vaddr and p_offset are PMD-aligned,
>* its size is at least PMD_SIZE, and
>* its existing p_align is smaller than PMD_SIZE.
>
>To avoid excessive virtual address space padding on systems with very
>large PMD_SIZE values, this is only applied when PMD_SIZE <= 32MB.
>
>This mainly benefits large text segments of executables by reducing
>iTLB pressure.
>
>This only affects ELF executables loaded directly by the kernel ELF
>binary loader.  Shared libraries loaded from user space (e.g. by the
>dynamic linker) are not affected.
>
>Benchmark
>
>Machine: AMD Ryzen 9 7950X (x86_64)
>Binutils: 2.46
>GCC: 15.2.1 (built with -z,noseparate-code + --enable-host-pie)
>
>Workload: building Linux v7.0-rc1 vmlinux with x86_64_defconfig.
>
>                Without patch        With patch
>instructions    8,246,133,611,932    8,246,025,137,750
>cpu-cycles      8,001,028,142,928    7,565,925,107,502
>itlb-misses     3,672,158,331        26,821,242
>time elapsed    64.66 s              61.97 s
>
>Instructions are basically unchanged. iTLB misses drop from ~3.67B to
>~26M (~99.27% reduction), which results in about a ~5.44% reduction in
>cycles and ~4.18% shorter wall time for this workload.
>
>Signed-off-by: WANG Rui <r@hev.cc>
>---
>Changes since [v4]:
>* Drop runtime THP mode check, only gate on CONFIG_TRANSPARENT_HUGEPAGE.
>
>Changes since [v3]:
>* Fix compilation failure under !CONFIG_TRANSPARENT_HUGEPAGE.
>* No functional changes otherwise.
>
>Changes since [v2]:
>* Rename align_to_pmd() to should_align_to_pmd().
>* Add benchmark results to the commit message.
>
>Changes since [v1]:
>* Drop the Kconfig option CONFIG_ELF_RO_LOAD_THP_ALIGNMENT.
>* Move the alignment logic into a helper align_to_pmd() for clarity.
>* Improve the comment explaining why we skip the optimization
>  when PMD_SIZE > 32MB.
>
>[v4]: https://lore.kernel.org/linux-fsdevel/20260310031138.509730-1-r@hev.cc
>[v3]: https://lore.kernel.org/linux-fsdevel/20260310013958.103636-1-r@hev.cc
>[v2]: https://lore.kernel.org/linux-fsdevel/20260304114727.384416-1-r@hev.cc
>[v1]: https://lore.kernel.org/linux-fsdevel/20260302155046.286650-1-r@hev.cc
>---
> fs/binfmt_elf.c | 30 ++++++++++++++++++++++++++++++
> 1 file changed, 30 insertions(+)
>
>diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>index fb857faaf0d6..d5f5154079de 100644
>--- a/fs/binfmt_elf.c
>+++ b/fs/binfmt_elf.c
>@@ -489,6 +489,32 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
> 	return 0;
> }
> 
>+static inline bool should_align_to_pmd(const struct elf_phdr *cmd)
>+{
>+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>+		return false;
>+
>+	/*
>+	 * Avoid excessive virtual address space padding when PMD_SIZE is very
>+	 * large, since this function increases PT_LOAD alignment.
>+	 * This threshold roughly matches the largest commonly used hugepage
>+	 * sizes on current architectures (e.g. x86 2M, arm64 32M with 16K pages).
>+	 */
>+	if (PMD_SIZE > SZ_32M)
>+		return false;
>+
>+	if (!IS_ALIGNED(cmd->p_vaddr | cmd->p_offset, PMD_SIZE))
>+		return false;
>+
>+	if (cmd->p_filesz < PMD_SIZE)
>+		return false;
>+
>+	if (cmd->p_flags & PF_W)
>+		return false;
>+
>+	return true;
>+}
>+
> static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
> {
> 	unsigned long alignment = 0;
>@@ -501,6 +527,10 @@ static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
> 			/* skip non-power of two alignments as invalid */
> 			if (!is_power_of_2(p_align))
> 				continue;
>+
>+			if (p_align < PMD_SIZE && should_align_to_pmd(&cmds[i]))
>+				p_align = PMD_SIZE;
>+
> 			alignment = max(alignment, p_align);
> 		}
> 	}
