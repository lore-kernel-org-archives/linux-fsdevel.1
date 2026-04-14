Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467764
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776146244; cv=none; b=EmLzSAb/a6p55vriUdPP6JyFGEtbzFC19pDwTPMFJVZ/GWSCpeEABYy7KYmZ9Ds4PkWmzAkVFiH/hv1FpSCePqsfK5MggYP7hqjMtsaJH0qW8vFCYcUXDoGazp7Ki8YVl85CFcZEHa0MI8geU4Bz3/mlwI115/C6KdsRxUqVcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776146244; c=relaxed/simple;
	bh=HZXaVIGu+ux9GdYsyYuhOuFyiWJ5by5c6td0QoRBO/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IvYTTm6DFzVwz6aJiWgT/PiMM1w1yMr2I5RYsoxLCg1+LRqu+8CqmG6X8vFHcIsG/LQPptRSV3zAft/EqkaKKMADmm514iMgJVCIQLKqdRzj5QV5p7YT1SpKQ770TpOR7MvdtjwVfpQupLD1ZemObIZQmahv+4J97nzVYl1kGQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id A2B6829219;
	Tue, 14 Apr 2026 05:57:13 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id whsVFDnX3WnU8AcA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Tue, 14 Apr 2026 05:57:13 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v0 0/4] exfat: memory optimisations and stringent integrity checks for up-case table
Date: Tue, 14 Apr 2026 14:56:39 +0900
Message-ID: <20260414055643.1833401-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This rounds of patches introduce efficient upcase table implementation
to exFAT as well as more stringent check against the upcase table when
mounting the volume.

**Theoretical trade offs**

The use of "paged upcase table" saw runtime memory footprint reduced
from 131KB to 8KB(+some slab overhead). Other trade offs include:

 - Reduced .rodata usage from 5KB to 2KB at the cost of added delay in
   module initialisation for populating the default upcase table
 - Slight performance increase from reduced cache misses when traversing
   directories with entries with a wide range of unicode code points

**Tests**

Upcase table test cases are available in my
repo(https://github.com/dxdxdt/gists/tree/master/writeups/exfat):

 - exfat-default-upcase:
   - -c option: uncompresses and prints the default compressed upcase
     table
   - -p option: tests if exfat_populate_upcase_ptable() produces the
     same default upcase table included in the kernel prior to the
     patches
   - -pc option: generates .rodata included in fs/exfat/tables.c
 - exfat-test-upcase: brute forces combinations(2^32) of unicode upcase
   conversion to ensure that no regression behaviour is introduced. The
   test finishes within 24 hours ;)
 - exfat-profile-upcase.sh and exfat-print-all-allowed: profile kernel
   memory use per moun and the worse-case directory traversal, entries
   filled with a range of unicode code points. Use with `make profile`

**Profiling**

When tested with 16 volumes(`make profile`), ~1MB saving in memory
usage per volume is observed(available mem 122528 -> 140884).

**NOTES**

Errors found in the "recommended" upcase table are outlined in
fs/exfat/tables.c.

The value of EXFAT_UPTBL_PAGESIZE(512 __u16 entries or 1024 bytes) is
determined to be the best based on the data:

```
  $ ./exfat-default-upcase > test-control
  ========== page 1 ==========
  ========== page 2 ==========
  ========== page 3 ==========
  ========== page 15 ==========
  ========== page 16 ==========
  ========== page 17 ==========
  ========== page 19 ==========
  ========== page 23 ==========
  entries: 874 (1748 bytes)
  non-empty pages: 8 (nb_page * pagesize * 2 = 512 * 8 * 2 = 8192 bytes)
```

The program reports that the total of 8 "pages" of 1KiB are used by the
table.

Regression test:

```

  (with the mainline exfat module)
  $ ./exfat-test-upcase /PATH/TO/EXFAT/MOUNTPOINT > a
  ...

  (with the patched exfat module)
  $ ./exfat-test-upcase /PATH/TO/EXFAT/MOUNTPOINT > b
  ...

  $ diff a b
```

Let me know if the test programs needs to be added to the tree
(perhaps in /tools/testing/selftests/filesystems/exfat/ ??)

---

David Timber (4):
  exfat: refactor nls.c (tables)
  exfat: use upcase_ptable and upcase_range_info to reduce memory
    footprint
  exfat: add default_upcase option (read-only)
  exfat: more pedantic upcase table validity check

 fs/exfat/Makefile   |   2 +-
 fs/exfat/exfat_fs.h |  48 ++-
 fs/exfat/nls.c      | 547 +++++-----------------------
 fs/exfat/super.c    |  10 +
 fs/exfat/tables.c   | 845 ++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/upcase.c   |  79 +++++
 6 files changed, 1071 insertions(+), 460 deletions(-)
 create mode 100644 fs/exfat/tables.c
 create mode 100644 fs/exfat/upcase.c

--
2.53.0.1.ga224b40d3f.dirty

