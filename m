Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32D3A4526
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112355; cv=none; b=CcwvAr/nNk3Z1zlukHlpR8uIVXzl3ShceqnCjXhwCAKcgQRApdfNAv914HwI++CEml4AV15wgzfdJsiuJAr411j1OmpE+bW5W8VzkVpsmOx6C9FxTEXZaiOfi85Bp6u1PUj3WnSyPX8sKr5uF54ZSJPTB4Oe2EKX/EQFtJS7Jyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112355; c=relaxed/simple;
	bh=FxuCb/kIbOwsma/01qsnWR92rq/SuGv9xfzQZP1zw7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bss8KBi5kL/6FH4tDGKZK2iGD8ASmXujuExDpHWmnCY34UjD0U8zgGUm2fH/LTzz/pdlxtpQT4Vm00YU0Y+51XGqXS5jT+uvySEggHzezzdzxOG2DYP72bbN0SBfJbIrJiePGlyaFyZfD2l1ZBt8uwamHVKfLK7CjDnmUyE8eXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=g326AwMP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="g326AwMP"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8299f1ca86fso1706023b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 20:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773112353; x=1773717153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qdvvi5cPomjzjf9BfHEmNolRXDMIdQNGPSx8FVbAXpE=;
        b=g326AwMPplLroeooHi4g4xDhZ/ecuEnmIWr3pmnKNf7oa0/DS0W1gE3oukCQ5nv2AN
         sCq9LdFlmfWArDejFqkVon7qs1WHY8r/98IRrTAhpowQ9NWkOXhShPNbMwq4x+N85xfB
         QFKm2xf0IUokLg1HfnsZvQwusX0CFth1hQS7s1OfIj1P348dKNxFrqFh+3jjOBY/XDxf
         MRXAHRGDQGs8HHcyrx/O4aHT2u9ZGUJx96L/JAqjCrQAowKBv/HoqSOfHLJBYRumi8LA
         pWVY6R1XmOR+PDz6vEXifWWuFlZnvNfvjpIdL2OkQ1axHP0iURvGCz6oyVjOXZ3mZM8M
         8+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773112353; x=1773717153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdvvi5cPomjzjf9BfHEmNolRXDMIdQNGPSx8FVbAXpE=;
        b=WXG51L5JUwFsXPHI3ZH49bilq4J3V1VkPftiIWx4CLeDxLbjL+8w7bxJOU6IGEXYNh
         YKhHTAXm2lTPXuX5wLkH4v2MklsttlOr4Ux+UM9Af10phjLc6ZM8N3/JaDiA+lmmDndr
         MI7Um6o09N8UTINZiC+Cw/1DCLmEXgcHHP6ge2gF54vtbaDnvgorxhFDnV6GT78YPvnn
         2gUUfhUvpiKz2i427pClUcJHkJPAXtB5UhZmLHfrjGU8jyYM6NCefdNsG09GJzmRNlnS
         PKT3KW8S42F3SFzg/suGRzl7DjalUrJZrPEUaAUdni2PCHdSLU3capBumn00myKXkNSV
         kAsA==
X-Gm-Message-State: AOJu0YxyVnyAGS1vIrhtbGImNgM06IpDNX8RKgu+UY4ZOSphuYclkMJL
	3hB+HmtNPUdF2i7eitl+TDfu6yvwenAsS/Nms2fL5whetD7ttKqCZUGWPEz9qxcoD/A=
X-Gm-Gg: ATEYQzxCjz+r5ZZCjuIkuOSRR14oc3N+dGAOp1Q67exUrrWbYJ91dW5hQJ2HMpwhYxk
	8qb8NmZXn8jUaOZ/OV8BlrLjmcVHKpHfHPhtv2ThKeJlkFqA2xu1iRXrUR96yDj/EkCySsIU5Mv
	qrpV1KKs0NSt76SqKe/R6jTra1NuwLJjyAjf1XGeI6nHqLEQC+CzpWCnmTNdty4lUTtyasbVb2m
	jZ5tljKOOWxQ59XA3k0IDZTyw7FP2KUzsK+eSBypW+h07i7ffPmcrszj59AfM/fAUzAsL5Y1Jhw
	i+W7psy6T03GBEoTF3FrxKLeW1RJKayWtO5DzHeEJwY4KKkMxU6Vd5YJs3RWDOPS3fPmO39MemT
	tGMn2U6hB9OytR/2+5N3xtA4giT/Nd+kJcagAnoQiWZmvg7VNGMsblRVLjhi+RF7mh3tqPyYrqk
	Spzjki6xDb
X-Received: by 2002:a05:6a00:66ca:b0:827:2c79:fa84 with SMTP id d2e1a72fcca58-829a2d88cbcmr10308211b3a.12.1773112352943;
        Mon, 09 Mar 2026 20:12:32 -0700 (PDT)
Received: from localhost ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465c872sm14213691b3a.19.2026.03.09.20.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 20:12:32 -0700 (PDT)
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
Subject: [PATCH v4 0/2] binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for THP
Date: Tue, 10 Mar 2026 11:11:36 +0800
Message-ID: <20260310031138.509730-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since [v3]:
* Fixed compilation failure under !CONFIG_TRANSPARENT_HUGEPAGE.
* No functional changes otherwise.

Changes since [v2]:
* Renamed align_to_pmd() to should_align_to_pmd().
* Added benchmark results to the commit message.

Changes since [v1]:
* Dropped the Kconfig option CONFIG_ELF_RO_LOAD_THP_ALIGNMENT.
* Moved the alignment logic into a helper align_to_pmd() for clarity.
* Improved the comment explaining why we skip the optimization
  when PMD_SIZE > 32MB.

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

[v3]: https://lore.kernel.org/linux-fsdevel/20260310013958.103636-1-r@hev.cc
[v2]: https://lore.kernel.org/linux-fsdevel/20260304114727.384416-1-r@hev.cc
[v1]: https://lore.kernel.org/linux-fsdevel/20260302155046.286650-1-r@hev.cc

WANG Rui (2):
  huge_mm: add stubs for THP-disabled configs
  binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for
    THP

 fs/binfmt_elf.c         | 29 +++++++++++++++++++++++++++++
 include/linux/huge_mm.h | 10 ++++++++++
 2 files changed, 39 insertions(+)

-- 
2.53.0

