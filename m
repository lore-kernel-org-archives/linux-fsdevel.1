Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920BB550DCB
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875631; cv=none; b=oXizRNJVqy1MZzWZX24MjA9Kh5fq0bN0XufSa8HKyMFTMSxva15CcfvrWiBVzAmj5oJEh26zTsTItnu52eylM+AzpW1EJ/1Og+Z8gkUp9a38YFYsMN4YUGJVfbt6lEgq3BLetevcngGxTSQCfQ+DLulSKezhsNWBSDVLXmCKNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875631; c=relaxed/simple;
	bh=ij03oJY21juV2tmTiy7OKrMd0x9VLIOWMM0HGl3Q4kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/eZyJsMwPqj8SZaGuStguegkVe3SZcOh96OuYMmGMqnK1pLDXVW0IueQ3X5/7JejLniIpmI+9ffVlpguJ/H24N+ej7eLOuTM6NbFwaZ66Q5T2L2w4VW09+Yo3dqEZOxklkx9lnEQnuav8/gUBQd/yrPHOeO3qMpHQPtTptq5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsSjp2lf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsSjp2lf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49557167508so55655575e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788875614; x=1789480414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=otL9ZeSyGNhMuE2AATxuE56e68gyPCqm69FwDFFVq2Q=;
        b=EsSjp2lfBWxJ65AEImaMpb4qto2HmbsW8srANdn41qN7j20VG1y52/npbs5u6VU/vc
         d1TMeGyvy8VvyMIg68cSHe43ljycKKHtjD/Q3gogXYDL1KbKFMhC6q+oTY4FLbnRPOIS
         Dbf2rvSTlaGz5qSOImNYihIIQuhd9mehFUScQ+kubHYedphQU005Z3LnHg3E+h4LrPx3
         VT7pFYJbH+ZeewRtQTjO2KlcNor3pb3BwLEYDvsP3dZIbWlJHNr6kX5sPlJPUSd1vpiV
         sMbwQUvG/02RimhhgOeS7gY6jmhyOrSFN39KD1hKgAwGrfgFvLtcrKvp71zehTsVMLJy
         ryeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875614; x=1789480414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=otL9ZeSyGNhMuE2AATxuE56e68gyPCqm69FwDFFVq2Q=;
        b=X6lPgQul6jYFSR31rQ45cxBEWVn6UPsspOkfIMqPqPFLrynl2eWfD422wp09AWMio5
         WKWDl9F8vf870wNMWSxdSV/1qkFu9AY94TFRYln51r4ZkHpm3bcXkzct1vFIr+s0Za1W
         Ux1BtKq4bEu03Yi93s4z5H/sjYQQGbM9oyw+ubwPIftGZnaqiwGKcElIKeRwuoGbey+v
         Y0DosI2oFmcLRffkXX0GbTBQD+bOJZvuvmmr8ITrenfmS2jf89wiCPAqMue4yNalbn8m
         t5l1Ub7iDElOdBKNstDtVkiNxLaSckgD4jqLvhe+okrZAJZsI3R7rf8fyEseRMLknbFY
         nBZQ==
X-Gm-Message-State: AFuF++nGYJ1d2P6h4s7rZGBDOyrcl+s03K7d0bL97qDU0fNgZFzEQw7V
	tbao39KGcSUKWg65e0kWuaUmpFG+JgmdXQg1Emn809d7Xpi+iJAYyjKq
X-Gm-Gg: AYBFou1eYoeD7Qrp1hzkHEDBh+1ifai66I1X7Vrj+tQ9iWGqtlZN0ad1Z3c47rOg+UT
	sXnLwJXhEQFMQ+L7V+U9Qp6jOK6o5L1W0JpANfXDk6sIPayStJXcSj1FsXq/EuMDRJrjUeV1QFd
	lSLWDo7URuGMjW920ciUByO439tfSBMpKGDg/DFmaAScUkw+6bXlIrjgYJpgDLGMG8s3gNiiF8e
	yUsQSQU3BhNI/Ol1Y54h8Jlx2yQ36t2uTV1+UiOZCU0mVBMszp/i6euufNt/LtTtr9RVUU93nXu
	uhBwgFMi6WGS3IDZpGxIxQuZudRUcYBu20y2zjNWNB/kuc+BnWRUBiPO5M17gd8CzlngJw85lmY
	HuhtgT3kWlLF37Tz/Wh+RlfPxQRWSE96hyS9e/vf7StlU6NaivQ6fOEXXhjCUKFOrET4d1rgM44
	uzXx64oMXMp1YuRfjXNkGmDfXUcfRNKwYm5jM+ykE7S3SBCqM9Y1JCWrpIXR1DohCskgqqvzjb4
	w==
X-Received: by 2002:a05:600c:3f12:b0:49c:c8de:96a9 with SMTP id 5b1f17b1804b1-49cf7fdd2dfmr588960425e9.2.1788875614332;
        Tue, 08 Sep 2026 06:53:34 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm377235005e9.3.2026.09.08.06.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:53:33 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v6 0/5] bpf: Add user memory access kfuncs for mm_struct
Date: Tue,  8 Sep 2026 16:52:57 +0300
Message-ID: <20260908135302.74963-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MMU systems, during exec, argument and environment strings are copied
into the new address space held by struct linux_binprm before that address
space is installed on the task_struct. Existing BPF user memory helpers
operate on the current address space or one associated with a task_struct.
Because no task_struct refers to the new address space at this point,
programs cannot access these strings from the bprm_check_security LSM
hook.

This series adds two sleepable BPF kfuncs for copying bytes or
NUL-terminated strings from a trusted struct mm_struct. It also marks
linux_binprm->mm as trusted-or-null, allowing BPF LSM programs to pass it
to the kfuncs after a NULL check and inspect exec arguments before
allowing the exec to continue.

To make the trusted-or-null annotation safe, the exec paths are hardened
to clear bprm->mm before dropping the reference it owns.

On NOMMU systems, exec argument and environment strings remain in
bprm->page[] until they are transferred to the new process stack. They
cannot be accessed through bprm->mm at the bprm_check_security hook.
The new kfuncs remain available on NOMMU for address ranges represented
by a supplied struct mm_struct.

The series adds selftests covering both kfuncs while reading argument and
environment strings from linux_binprm during exec.

Changes in v6:
- Drop redundant extern keywords and CONFIG_BPF_SYSCALL guards from the
  remote memory copy declarations.
- Drop the explicit bpf_copy_from_user_mm() prototype and share copy 
  logic through inlineable static internal helpers instead of calling 
  between kfunc/helper entry points.
- Validate flags and zero-length requests before acquiring the task's
  mm, preserving existing behavior and ensuring internal helpers are 
  called only with a live mm.
- Drop the verifier relaxation for unchecked reads through trusted-or-null
  pointers and its tests.
- Fix the existing LSM selftest to explicitly NULL-check bprm->mm after
  marking the field trusted-or-null.

Changes in v5:
- Move the shared wrappers to mm/util.c and handle zero-length requests
  at the entry points.

Changes in v4:
- Add negative verifier tests for atomic RMW and load-acquire accesses
  through trusted-or-null BTF pointers.
- Preserve explicit nullability-marking coverage for tracepoint
  arguments, dentry->d_inode, and sched_ext .dispatch.
- Use the already-nullable mmap_file argument for the negative store
  test, avoiding dependency on the later linux_binprm->mm marking.
- Clarify the bprm->mm lifetime invariant and move its lifetime fix
  before the mm_struct kfunc patch.
- Reword the trusted-or-null read change in imperative mood and remove
  its redundant before-and-after summary.
- Document that the existing task-based user-memory interfaces delegate
  to the new mm-based implementations, reorder the string-copy kfuncs to
  remove an unnecessary declaration, and annotate the remaining
  declaration with __bpf_kfunc.

Changes in v3:
- Replace the linux_binprm-specific kfuncs with generic struct mm_struct
  kfuncs, as suggested by Andrii Nakryiko.
- Move the kfuncs next to the existing user memory helpers and make the
  task-based variants delegate to the new mm-based implementations, as
  suggested by Andrii Nakryiko.
- Clear bprm->mm before dropping its reference on exec error paths.
- Mark linux_binprm->mm as trusted-or-null.
- Allow fault-protected reads through trusted-or-null BTF pointers to
  preserve compatibility with existing BPF programs, as suggested by
  Andrii Nakryiko.
- Add verifier and runtime selftests for trusted-or-null BTF pointer
  reads.
- Rename __copy_remote_vm_str() to __copy_remote_mm_str(), as suggested
  by Andrii Nakryiko.
- Clarify that reading exec strings through bprm->mm is limited to MMU
  systems, while the generic mm-based kfuncs remain available on NOMMU.

Changes in v2:
- Register the kfuncs on NOMMU systems and return -EOPNOTSUPP when called,
  as suggested by Justin Suess.
- Add selftest coverage for reading environment strings, as suggested by
  Justin Suess.
- Clarify that copy_remote_mm_str() leaves the destination untouched when
  called with a zero-length buffer.
- Use sizeof() instead of hardcoded argument lengths in the selftests.
- Use ~0ULL for invalid-flags checks in the selftests.

v5:
https://lore.kernel.org/bpf/20260907165220.52431-1-tasos.papagiannnis@gmail.com/

v4:
https://lore.kernel.org/bpf/20260904145340.40212-1-tasos.papagiannnis@gmail.com/

v3:
https://lore.kernel.org/bpf/20260831092305.42062-1-tasos.papagiannnis@gmail.com/

v2:
https://lore.kernel.org/bpf/20260820131801.68759-1-tasos.papagiannnis@gmail.com/

v1:
https://lore.kernel.org/bpf/20260812111140.7762-1-tasos.papagiannnis@gmail.com/

Anastasios Papagiannis (5):
  mm: Add copy_remote_mm_str()
  exec: Clear bprm->mm before dropping its reference
  bpf: Add user memory access kfuncs for mm_struct
  bpf: Mark linux_binprm->mm as trusted-or-null
  selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm

 fs/exec.c                                     |   7 +-
 include/linux/mm.h                            |   8 +-
 kernel/bpf/helpers.c                          | 130 ++++++++++++++++--
 kernel/bpf/verifier.c                         |   5 +
 mm/internal.h                                 |   3 +
 mm/memory.c                                   |  41 +-----
 mm/nommu.c                                    |  41 +-----
 mm/util.c                                     |  62 +++++++++
 .../bpf/prog_tests/copy_from_user_bprm.c      |  72 ++++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c | 123 +++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |   5 +-
 11 files changed, 400 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c


base-commit: 1b7415bf70be95b9a1e7e87d544867881065613f
-- 
2.55.0

