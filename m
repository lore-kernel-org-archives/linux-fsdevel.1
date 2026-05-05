Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD13A785E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984331; cv=none; b=kjBxXEPZA7l65DkYq/Iae42vquMwdHiB8YADuYNcQ/8RygdyuTY63B51vMH2rvQRR45OA4J8qdEgZ7e35JIiqEr+yQ9aAbDN2iP2LEUla/WDFTL9IaeaPdXN+7iuAXHFbPlQ89OyH+CcACO+9G2WYm056QMw/stdtL2QDRc+j4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984331; c=relaxed/simple;
	bh=v3CwAjNu80mWfWvZYsKJ4iTkMXtCt2QEtM9Rxhgn3Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKtehD9LuWUK04SKM2/0o/o927cm0aYlXw7CBPXTHJHGwKEtlLSwoOnSZBQMgbI02wAqX4dMFIEtd0qCLSIY3dTh/CfBNzz9mu68b26e1Z6HLS+vsv1UpofId+1gJKlCrLzPNApGvyyLAbXo7KfOiNb7IelDDZZmYIhZOwKTlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id BF2A11D490;
	Tue,  5 May 2026 12:32:07 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id na7IHUfj+WmAZAEA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Tue, 05 May 2026 12:32:07 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v2 0/4] exfat: memory optimisations and stringent integrity checks for up-case table
Date: Tue,  5 May 2026 21:31:40 +0900
Message-ID: <20260505123144.730782-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reroll v1:

 - Mark the volume read-only if the up-case table seems damaged
 - Inline exfat_lookup_upcase_ptable()
 - Fix uninitialised variable(ret) in exfat_load_upcase_table()

Reroll v2:

 - Optimise and refactor filename up-case conversion
   (Suggested-by: Yuezhang Mo)
 - Fix memory leak on module init failure,
 - Remove exfat_init_default_upcase_ptable()
 - Use null-terminated array consistent with the convention in Linux kernel
 - Add missing function and variable attributes(__init, __initconst)
 - Return identity instead of zero from exfat_lookup_upcase_ptable()
   (Suggested-by: Yuezhang Mo)
 - Remove unnecessary global variables
 - Refactor exfat_load_upcase_table()
 - Add test exfat-test-illegal-chr.sh for exfat_illegal_chr()

v1 coverletter:

This round of patches introduces efficient upcase table implementation
to exFAT as well as more stringent check against the upcase table when
mounting the volume.

Link: https://github.com/exfatprogs/exfatprogs/pull/341

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
   conversion to ensure that no regression is introduced. The test
   finishes within 24 hours ;)
 - exfat-profile-upcase.sh and exfat-print-all-allowed: profile kernel
   memory use per mount and the worse-case directory traversal, entries
   filled with a range of unicode code points. Run with `make profile`
 - exfat-test-illegal-chr.sh: exfat_illegal_chr() regression test

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
  ...
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

Let me know if the test programs need to be added in the source tree
(perhaps in /tools/testing/selftests/filesystems/exfat/ ??)

David Timber (4):
  exfat: use upcase_ptable and upcase_range_info to reduce memory
    footprint
  exfat: optimise and refactor filename up-case conversion
  exfat: add default_upcase option (read-only)
  exfat: more pedantic upcase table validity check

 fs/exfat/Makefile   |   2 +-
 fs/exfat/exfat_fs.h |  49 ++-
 fs/exfat/nls.c      | 614 +++++++-----------------------
 fs/exfat/super.c    |  13 +
 fs/exfat/upcase.c   | 900 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1090 insertions(+), 488 deletions(-)
 create mode 100644 fs/exfat/upcase.c

-- 
2.53.0.1.ga224b40d3f.dirty

