Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E8379EFE;
	Mon, 27 Apr 2026 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309087; cv=none; b=EH/OaXczPj9KUt60SXpvSPJOrkA55inabRGLUENEvPl8NWdS8XR+feHJOs042mBnpuXA6cgrOSgvxZ2XqOewbWySDm5wmN/5BPY5Q9q8kNP9i2+M2vXHANgRYgQnRakETGkXQbsabq0oA8Jvv9K/3kgaHqMYIuqiCVs79HO0dAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309087; c=relaxed/simple;
	bh=yWG6LyTORVxmbB127qfvxFlIPJ8nQmGftxGSSDXFUHI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ebUvfIP/GbpjkEOVlL9PHvayt+Tt6p/A3Cro9EdYuMISoCZYKdUCclgGZ6Glj9DP3gIRpS3wFn35WBOAFb+fYSggnVIXwRJ1AtY9jVHEj+xP1R/WMKzRbWV2Xlp9DNIE3WZ4J8orgCwhpp5Wr+B1pUO8s58FitIcKnF2zGsMn54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=r2XYOrTG; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="r2XYOrTG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777309074; bh=kERBmO7DDys9vM4deWpg4OLJy4cGxCI6vaV3V0iZwtI=;
	h=From:To:Cc:Subject:Date;
	b=r2XYOrTGnv+MLXXKGqH8O1PLYP6cLF3SdRUSaM2M9ow8xMEziVLcMZevrsk+MgIcA
	 HN+9AvmV/fw9EzmrMFGuv3It6ogM2MOwkPYKcfh6Ih40N2NldfboTmoR9BUOYYFKD1
	 KRWFI7xH/R04JrZZifbqKSVYx9TgbQx0kkPNIJdA=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id E73AA4C8; Tue, 28 Apr 2026 00:57:51 +0800
X-QQ-mid: xmsmtpt1777309071t78x7yuar
Message-ID: <tencent_4EDE373816615C46CFD48A6EF3B61E232308@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeIXuabSxXgNxjCDp5Ll3NT2rbc+sorDduzfyOZXOOMZkXjhXLBA
	 DP6MvIbSOPjtkXuX6wwfhVFiBxY+ObCYjfOIN1+fjFaTNBM2RduRHl7HqdHhWnep864jp4MRCPDu
	 c/NsFwnJSbUMiO1bb+1BHGhGj4J3uWLnQhBuZcYs/Qc6Qiqm5eVdxlEtLu8JazKS8qdhUABj+puR
	 46wK+3UIf/YfPdYzpa7wiFMqvZVF0PTTRm9/6Qn/IgTybnJuJpaKJuw31FQZxy51D2G6Ly3R5vVc
	 vqMBUcA1QCcTmSJKcZaG03wsNaLXE6a8T6HNROrljEiUvNDSJU7T9c2EOzN0S4jlr9LMEwM/KDxN
	 k0S1yvjycLQVIRfL3S4Jn2zK7xSkMLRHYaipw3WAhQotC1TtdXOMcRiSiNrjrLZTFtlUuRVX6Fj9
	 dp+teW/qYM9klGKpv9XvrFAyIvPPTY+u1rwnR0TDbbuXK9UGZeJKiTlCGGRXVX9i5Z8SPRoupR7m
	 4LMl7qZhSy/51RH/cJ5Mo3TQr8CAVhN0VERpexi4bI0yENunh3ZLnOubPe2e6dlu5U8LrklIhttG
	 Bj7huPeBW4lw375CVt5OOhrOeqmnU1lkVtxer6yYyWD1F1a91l1ffzzSTLIZBHV0wyNqGbPZCeIT
	 QJOtcdyHm8tVWCn2UOCALFMKG0vwM7VEr5+Sk6j++ts47UZaQFuRsTgyH+m25d+IiIvMmHbru5tR
	 m4oXZhM/frb7e0lwiRxn41OtDmBfKUlSnBaVxXpntSW7c5oESfMVMKNJnrnklyfjyEfspCcXsnQ8
	 mYyC03y29kYcRb2uSMSHAehTwpM5VdD2m0apHDAfQ2TLDE6lXFThH6GgUHo2aZKj6clwFbsE/PW9
	 VTJecwE6OK+dcHfVCIAX2R8+N2siL+PJlj0Oj0jG9TY17AA9aOWLnBFyvc18cVKegBtDogkinBwH
	 ebnWXgHdr0VPcFk2kUAxfK0CFKDwoA0EvRZqUiVkNwibtUrrAPh9cC5pA3QQQXbWn1fW6JFpN8hI
	 HKBV1gCiUJaOlc0qeRdKHLx0jkgInuH9YeCla1+A==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: fujunjie <fujunjie1@qq.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Haoran Zhu <zhr1502@sjtu.edu.cn>
Subject: [PATCH v2 0/2] mm/filemap: tighten mmap_miss hit accounting
Date: Mon, 27 Apr 2026 16:57:49 +0000
X-OQ-MSGID: <20260427165751.746502-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v2 of the mmap_miss hit-accounting change.  v1 was sent as an
RFC.  The accounting logic is unchanged, but the series is now split
following Jan's review:

  - patch 1 limits fault-around hit accounting to the faulting address;
  - patch 2 stops FAULT_FLAG_TRIED retries from decrementing mmap_miss.

Patch 1 also follows Jan's implementation suggestion: the helper
functions no longer propagate a mmap_miss variable, and
filemap_map_pages() updates file->f_ra.mmap_miss based on whether the
helper mapped the actual faulting address.

mmap_miss is increased when synchronous mmap readahead is needed, and
decreased when filemap_map_pages() maps folios that are already in the
page cache.  The decrease side can over-credit hits in two cases:

  - fault-around installs nearby PTEs even though the fault only proves
    that the faulting address was accessed;
  - after synchronous mmap readahead returns VM_FAULT_RETRY, the retry
    can find the folio brought in by the same miss and immediately
    cancel that miss.

Current evidence comes from a local KVM/data-disk microbenchmark using
mmap_miss_probe, with an 8 GiB guest, 2 vCPUs, 8192 KiB read_ahead_kb,
cold page cache before each run, 1% of the file accessed, and medians of
3 runs.

mmap_miss_probe mmap()s a prepared file with MADV_NORMAL and then
touches one byte at selected base-page offsets.  The access order is
random, sequential, or a fixed page stride.  The harness drops caches
before each run and samples /proc/vmstat around that access loop.

The 20 GiB case below is a larger-than-memory file case in an 8 GiB
guest.  No separate memory hog was used.  The 4 GiB case uses the same
8 GiB guest but keeps the file fit-in-memory.

Each case used a fresh temporary qcow2 data disk, seen by the guest as
/dev/vda, formatted as ext4 and mounted at /mnt/mmap-matrix.

Each result is "pgpgin GiB / elapsed seconds".  "pgpgin GiB" is the
delta of the guest /proc/vmstat pgpgin counter, converted from KiB to
GiB; it is used here as an approximate block input counter, not as
resident memory or exact application IO.  "Elapsed seconds" is the
wall-clock runtime of the whole mmap_miss_probe access pass, not
per-access latency.

For the 20 GiB larger-than-memory case:

        workload       before                after
        random         223.377 GiB/101.293s  1.010 GiB/4.790s
        stride1021     204.214 GiB/97.557s   204.208 GiB/108.086s
        stride2053     409.584 GiB/193.700s  0.970 GiB/3.685s
        stride4099     406.452 GiB/134.241s  0.975 GiB/3.499s
        sequential       0.212 GiB/0.050s    0.212 GiB/0.057s

For the 4 GiB fit-in-memory case:

        workload       before              after
        random         3.987 GiB/1.960s    0.980 GiB/1.221s
        stride1021     4.002 GiB/1.838s    4.002 GiB/1.851s
        stride2053     3.991 GiB/1.835s    0.811 GiB/0.985s
        stride4099     4.001 GiB/1.836s    0.819 GiB/1.037s
        sequential     0.056 GiB/0.013s    0.056 GiB/0.018s

The 20 GiB setup also has an ablation.  P1 is only the faulting-address
hit accounting change.  P2-only is only the FAULT_FLAG_TRIED retry
filter.  P1+P2 is the combined accounting change:

        workload    variant   result
        random      baseline  223.377 GiB/101.293s
        random      P1        223.268 GiB/98.481s
        random      P2-only   223.257 GiB/100.091s
        random      P1+P2     1.010 GiB/4.790s
        stride2053  baseline  409.584 GiB/193.700s
        stride2053  P1        409.584 GiB/197.645s
        stride2053  P2-only   15.722 GiB/5.485s
        stride2053  P1+P2     0.970 GiB/3.685s
        sequential  baseline  0.212 GiB/0.050s
        sequential  P1        0.212 GiB/0.046s
        sequential  P2-only   0.212 GiB/0.050s
        sequential  P1+P2     0.212 GiB/0.057s

After the v2 implementation refactor, only the final P1+P2 shape was
rerun in the same setup.  The numbers stayed in line with the v1 P1+P2
rows above:

        workload       larger-than-memory 20 GiB fit-in-memory 4 GiB
        random           1.010 GiB/4.383s          0.980 GiB/1.088s
        stride1021     204.216 GiB/105.601s        4.001 GiB/1.783s
        stride2053       0.970 GiB/3.760s          0.810 GiB/0.908s
        stride4099       0.975 GiB/3.410s          0.818 GiB/0.870s
        sequential       0.212 GiB/0.060s          0.056 GiB/0.016s

This does not claim to solve every sparse pattern.  The stride1021 rows
are intentionally shown as a boundary: with 8192 KiB read_ahead_kb,
file->f_ra.ra_pages is 2048 base pages, and synchronous mmap
read-around uses a 2048-page window centered around the fault, roughly
[index - 1024, index + 1023].  stride1021 is 1021 * 4 KiB = 4084 KiB,
so the next access lands inside the previous read-around window.  About
every other access can be a real faulting-address page-cache hit, and
the other half can each read about 8 MiB.  For about 52k accesses in the
20 GiB/1% run, half of them times 8 MiB is about 205 GiB, matching the
observed 204 GiB.

---
v1: https://lore.kernel.org/r/tencent_3F158B17AE85E73945C5F97D8F8A918F9B07@qq.com

Changes since v1:
- split the original patch into two patches;
- move mmap_miss updating back into filemap_map_pages();
- drop the mmap_miss argument from filemap_map_order0_folio() and
  filemap_map_folio_range();

fujunjie (2):
  mm/filemap: count only the faulting address as a mmap hit
  mm/filemap: do not count FAULT_FLAG_TRIED retries as mmap hits

 mm/filemap.c | 56 +++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)


base-commit: 1b55f8358e35a67bf3969339ea7b86988af92f66
-- 
2.34.1

