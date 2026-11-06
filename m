Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998667;
	b=ivnk8ccKoaT0lWjMKdJsfcW0luSt/nhZuAy4OeD3z/eLFcNPYKhmPgr0tav/gmfjLQfX
	 4pW38UyhFKDhdQLPLD9wEglf9w3jvsuFU1TD1lJl8sWUS97oiEf7njOmEDu82B8ARrtwf
	 r4reH62IDuhHzn0WJWSuRj+tSgyuMLcBpBAsjQAspuvXQORjXeGeKdD4KyeVS/5LcTfmn
	 tQEdRIQ4ugQnwLImhXPef/TUsdyGM4nEdJaY3U8ZipHJV9q51sYA5t8sVQUMrs7d401Oj
	 qvy/abbZsE1fQ9m9jAtzkgeLa3O4PcG+WiZZqAvY5h8PNX6u8tAK1yXqEdxnR6roUNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998667;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Ewn93dkGZpHFDMZE/S6AafHhS3ce9FIqGUZ6Arv8zrg=;
	b=aQxi75AZrJqmaLi/zUqqIikvv9RXj3hVguzPo9EGAjE/O19m5u4RgKtne3vn/cvFVpob
	 fGLNoXb5ZeuwpFhY8QAlDW0+4/AOV7FQVTK2XI1g7ejN6JegwVZGARCk+7cxcj6yg0hva
	 33suJAuMYDJg2bFinCisQsOEkKOXraAvMbyZlezFsE8jG2o5dIvmMtLzPNzrAukwb0Nsc
	 o5NN1j3ZzTMzeLFMme+AwM09W09BRab8PkW+7miA2ztDK/iQ8i0nL9BlCLOM3s9twmXQs
	 PyuexemPIIAtfF+2ZmeZiSaPatHQAZLNTzwbDmW/elbDQ+JC0MPYOm2V8P5xoXQ8QZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=Mv3GWYME;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E9606A326;
	Fri,  6 Nov 2026 20:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D65E9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=Mv3GWYME
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
	:From; bh=Ewn93dkGZpHFDMZE/S6AafHhS3ce9FIqGUZ6Arv8zrg=; b=Mv3GWYMEFCM7eiGpjj3
	uF4GYhEcOV4jBfmRKGr5s0EI8qwwQ4us6ZZvJ0y942mTk09d5j9V7IN6zHwjW+BQi5Eqeij04NHmC
	Crd+o5ELCViaYPXNE7qtXjPSlEbiARRFiymLyc4ujTv0c+rp7jOaVL819btqGLe3ZFjZrBHFKdQWM
	0oBv9puUVxEB7AaWSbQ1q6RjUEtWWhcZlu8GICNQFdKOlkpp+nbrs+7OB7dCgrIpgKlAUa1g9P/ww
	xp+ImbaSeMFYQ+wtjhNB4qnYmCBkX4DCM9RICw+NGHhHQSax0skCdicclCiXl68zAZ6fqVv/yNps1
	tLLxr9hAIfet3nQ==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xPQwI-001xD7-1Y;
	Fri, 06 Nov 2026 21:57:38 +0100
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v2 0/2] binfmt_elf: return the real error when program
 headers cannot be loaded
Date: Fri, 06 Nov 2026 21:57:36 +0100
Message-Id: <20261106-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-v2-0-1c8b7b1dae5c@virtuozzo.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEE/7moC/6WO0Q6CIBhGX8Vx3d8EMbOr3qO5pvCTtBAHyErnu
 yf2CF2e7ew730I8Oo2eXLKFOIzaaztswA4ZEX07PBC03JiwnJ1oTjl0HEaHI0QfrAPK6zOvoNO
 DMuGOLwU4WIMGXraVkHjspfNQ1KVSnRJFgYxs29uE0u+9e2t+7KfuiSKkWDJ6nQKf/Vikyfv3Q
 6RAQRW1qLgsS+TsGrULk51nexTWkGZd1y+qcgVREAEAAA==
X-Change-ID: 20261014-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-395ffbfc33e2
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Paul Burton <paulburton@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konstantin Khorenko <khorenko@virtuozzo.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5380;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=Dz0Kciz9xbnWEFdZaxNvTnIBk+1RrMxzuXIlAdPSDXY=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq7j9FV1ZzsdbwOi0L8boH1E/7Jho8NXtEqsL40
 Z2PFEx4R/+JAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCau4/RQAKCRBRlgpH+WFc
 KqqWD/9Z8AejCCQpb81V5vdyXSd1fqohKRoVPs7S/FPAXVswFZ2PsPddu7DZWOUdRZ+mRp2oBx8
 4DcCwaS2xXEk4kslcBmN4rttJ8rJ8Ui+O109HvzYw9sNZkgbmOLqTRFOUFbmXN6ogaux9EHiZIR
 2Yat/CaXdnS90VvxY9meIVKQ4ayH+v6nMlnX/DkUj5snYPEZ9E7JoQcovy01C8wUmJLovgBB1FY
 1T7M1glzJt8j2bOwSKHBv+pagL98UrFMHV3j7DqcRI/vsDgGZyrwtk5uhqlsjCXaPH8TiYmjxIc
 Q/X2jfwiFl0H1I/fB4tTs3SRJBHiQSwJrOSxmL0NQZnPif+ITUpn603i7sMz9cCjh3EPhUk1o+Q
 wGNmSFGm+6g6Yv9ni/TLuFbBt1UA7wMTCk6ycaatWmcuIEnDYcNtHSP5BOfHTSNcDP+fl6Oq7IX
 eVs7PhOUIfIvRfiDVwA977aCUxggFCswisoUNbWU94VaFoQ7GfaTbR3NYBUlfYhXa0O3OZcx46W
 Z+vzg9XzAk2/yileHr//m1yvMVBx0VdJaEIukAUOTAlXdFN3OUzbrP1vFF8BKse46yUBJzty+Iv
 eGnabYz3BgsTDbyXp2TPW+/AShFEe+g+DY7YU69AvSq/4848IX+VhhyrTR6/CwLaEEWO6Jv633p
 DGkF3j/dburSnvQ==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

load_elf_phdrs() returns NULL on any failure, and load_elf_binary()
turns that into -ENOEXEC for the executable and -ELIBBAD for its
interpreter. A failed allocation or read of the program header table
then looks like a bad file, and glibc's execvp() runs the ELF with
/bin/sh.

v2 changes the errno of those two failures and nothing else. Patch 2
adds a selftest for both what stays and what changes.

What changes
============

  +--------------------------------------+----------+------------+
  | the program header table             | before   | after      |
  +--------------------------------------+----------+------------+
  | has a bad e_phentsize or e_phnum     | ENOEXEC  | ENOEXEC    |
  | has an e_phoff past LLONG_MAX - size | ENOEXEC  | ENOEXEC    |
  | starts past the end of the file      | ENOEXEC  | ENOEXEC    |
  | gives a short read                   | ENOEXEC  | ENOEXEC    |
  +--------------------------------------+----------+------------+
  | cannot be allocated                  | ENOEXEC  | ENOMEM     |
  | cannot be read: kernel_read() error  | ENOEXEC  | that error |
  +--------------------------------------+----------+------------+

For the interpreter's table, ELIBBAD stands in place of every ENOEXEC
above; ENOMEM and the read error come back as they are. A read that
fails after some bytes were copied comes back from the page cache as a
short count, so it still gives ENOEXEC.

In the kernel, search_binary_handler() now stops at the ELF handler for
these two errors instead of trying the formats after it. All of those
decline a file with the ELF magic of this machine, so the loop ended
with -ENOEXEC before anyway.

Userspace
=========

The patch adds no errno that execve() cannot return today. Other reads
of the same files already pass the kernel_read() error through:
prepare_binprm() for the first BINPRM_BUF_SIZE bytes of the binary,
and elf_read() for the PT_INTERP path and the interpreter's ELF
header, while parse_elf_properties() reports a failed read as -EIO.
The program header table was the only read of an ELF exec whose error
reached userspace as ENOEXEC.

The execvp() family acts on ENOEXEC: glibc runs the file with /bin/sh,
that exec succeeds, and the shell replaces the caller and exits with an
error such as bash's "cannot execute binary file". glibc's
posix_spawnp() does so only through its compat symbol from before 2.15,
and musl's execvp() never does.

Shells check ENOEXEC themselves when they exec a command: bash reports
"cannot execute binary file", dash runs the file as a script. With the
patch they report the ENOMEM or the read error instead.

QEMU's cpr-exec live update re-execs itself with execvp() and resumes
the guest when that fails; on ENOEXEC the guest is killed instead. With
the patch these callers get the ENOMEM or the read error back.

Testing
=======

x86_64 KVM guest, mainline f66469d9905b with CONFIG_FAILSLAB and
CONFIG_FAULT_INJECTION_DEBUG_FS, selftests/exec:

  +------------------------------+---------------------+---------------+
  |                              | without patch 1     | with patch 1  |
  +------------------------------+---------------------+---------------+
  | load_elf_phdrs, bad tables   | pass                | pass          |
  +------------------------------+---------------------+---------------+
  | load_elf_phdrs, allocation   | fails: ENOEXEC for  | passes        |
  | failures                     | the executable,     |               |
  |                              | ELIBBAD for ld.so   |               |
  +------------------------------+---------------------+---------------+
  | the other exec selftests     | pass                | pass          |
  +------------------------------+---------------------+---------------+

Unprivileged, the allocation case is skipped. A kernel_read() error is
not covered by the selftest, as it needs a filesystem that fails the
read.

Assisted-by: LLM
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
Changes in v2:
- Dropped the read loop: a short read gives -ENOEXEC as before, and
  only the errno changes (Kees).
- Patch 2: a selftest for the errors of the table.
- Dropped the Fixes: tags on 6a8d38945cf4 and a9d9ef133f44 (v3.19):
  the errno has been this way since then, and the change should not go
  to stable.
- Rebased on current mainline, f66469d9905b (after v7.4-rc1).
- The Assisted-by line moved from the patch to this letter.
- Link to v1: https://patch.msgid.link/20261014-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-v1-1-f39c74d55e42@virtuozzo.com

---
Konstantin Khorenko (2):
      binfmt_elf: return the real error when program headers cannot be loaded
      selftests/exec: check the errors of an unloadable program header table

 fs/binfmt_elf.c                               |  38 ++-
 tools/testing/selftests/exec/.gitignore       |   2 +
 tools/testing/selftests/exec/Makefile         |   4 +
 tools/testing/selftests/exec/load_elf_phdrs.c | 399 ++++++++++++++++++++++++++
 4 files changed, 428 insertions(+), 15 deletions(-)
---
base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
change-id: 20261014-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-395ffbfc33e2

Best regards,
--  
Konstantin Khorenko,
Virtuozzo Linux Kernel Team

