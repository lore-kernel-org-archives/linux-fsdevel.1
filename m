Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975772857FA
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459410; cv=none; b=an2/lhSGk7SQA5Qp4W+yxAN7Wf5M8vaw8mzd7mQ/17mEwxVXLcWD7ng2QpczmVI9AgouEEPaES10+Rxotbw3lm1g32WqPzshr8Tb6ellj2YjhxZmS9X2KMTmjckUCTkZTAXBDxPlAuwPWHhBvK85/gko5oV8pEyEHo6T/FFrNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459410; c=relaxed/simple;
	bh=FhX8H7e8fEhgdrkXZXQss1k8Dm7Bjee7uAFe8zKnEr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxVb1WWzK3U36VVkRiYFyBw41MASmDDpTvdhIgr6eWjk6DhJH4xv0PRNc8gWsb12at6vBfjHHsK07e6nWJOJZu9r1nEYk5ypF6gdG2vCrTLnLtFw20KOeepBj4xh8JwywOKenGBW3mSG6y/pl4u/iGwZ79UQpRnjVHSVyUpkkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjLzdz1b; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjLzdz1b"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so15453465e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459405; x=1790064205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kcapaBho2kR7enVDRwYTAMH/Ad+5izpm6YLmaU/7cvE=;
        b=SjLzdz1bE0wvfdO7ErkQqxsSvwybG9pBrGUTKP5nyKSXosj7GoreONLt0WBzVretyQ
         T/o7gMWmbc7E1s6oTI/hg1VGBoIGMCb6B8TFf84q9bga3A8KrOLL3acDE0BLOv2LJ54e
         mVmiG7yMnEyc2VhSTJ90qzOBgV4xZmFMhzYt3MYTq3iUlZbT1Y7dBP/z8QlwD86gCjtk
         +iwVngEImM/OJbzVLZTV415ikxrOniCsBCmM2IYiZppnFN2OXUV2bCfNakC6+o/LQxPQ
         m6XmvCvM9G+KAsu7Wsj8X+DJfTlagMCilf8VMKqJKqQ+En8YPI8CPM7GRXNgUCITMIvs
         5jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459405; x=1790064205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcapaBho2kR7enVDRwYTAMH/Ad+5izpm6YLmaU/7cvE=;
        b=IvmH9IrYy+X4zzLBXDW4vD0oiZmMYi7V5UlUdj/wKuLkEigVibNe1PsW+0geT2x0I/
         GEoOGbQ8Pt9JqnKrG5Iqn+G1DQ7i5IOO0yoOwqxHGWxGLrENJDoA2kHkQkfhCB8I2KRg
         FrCgE9CdHX6aJ7Hcu5Y4xNBDCkW9DEnyqjDTPdrmpvZrnwrxqobtyn/F1DikAOfyprNS
         lgBB0fxR6objFWXR7Cf35wZ64gWj1CbPrI7425VWhZZvL52i64a7DTwzrYNtq71oO6JY
         8y32ppo6mdOmjSuVd2xyGGzHIEIi+ljvc57rhb3nG70BR8lXRsdAoOQuJa6qEq1nZL8u
         yUVA==
X-Gm-Message-State: AFuF++m4KMdLLnVSYb0kPy/Vw/M1G5oJr0KmjUiK1D6SCRA5qoHWAsxV
	NkSMfHYQGjiOLOoy/r+BJcuwzfHkyLKRbABjY/bkLaEXZV6pXV/GjT2+
X-Gm-Gg: AYBFou1RSrEriXXwFoQk3ALz2Xrf1GvF55t8gzvuK6izrg+mxEW7WeTt7/K7o6z1CVb
	3GtNYGs1gEExyFqA854oXn373znWxcCODAt0ztgYnebQERHOKpyNnc61RkzbdsD6VnYKOVXtvq8
	1z+7+ZSaw4FL/aleiyo34G2JUhfFYtQ0z+mfwnNQYPghhXfTdz+SWvfaOfvjs5K1Y/odDOowkvm
	4QbIHaIhOEMh1G6NejyguzxLZGrz8Kh4eldNCEoO+L6aEqUFMOPyzruhpsMMlGbxFX83VYaIGLZ
	UY4tl6I4fu1+cb7AB8qvQfE+hHQkOjeEp3+UJ6wqT4tL3odEhO5cHwX+ZMy6osqQhqru8aiVhfN
	1ouq+5afIhFiuCdduRYlvAD6+2IewMGRak6TkL9Kapq2JX1LUbIaDtYF8K3eN8muY4cFM+Yg8ap
	ZopRWNEQZhsIJIEL+0qy5KqvKyZSMAFbO4OXcRr/A8LUOx7aCwxabLqvXqcMoQzNU0SPJBDFV8+
	Uhz2Npv+r/YFAM=
X-Received: by 2002:a05:600c:19ca:b0:49c:fc6c:bdfa with SMTP id 5b1f17b1804b1-49e7a66aa96mr72885625e9.17.1789459405211;
        Tue, 15 Sep 2026 01:03:25 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35c071sm33764675f8f.33.2026.09.15.01.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:03:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 0/5] bpf: Add user memory access kfuncs for mm_struct
Date: Tue, 15 Sep 2026 11:02:50 +0300
Message-ID: <20260915080255.48929-1-tasos.papagiannnis@gmail.com>
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

Changes in v7:
- Use execvpe() instead of a hardcoded /bin/true path in the
  copy_from_user_bprm selftest while retaining the controlled environment.
- Remove the unused bpf_misc.h include.
- Rewrap the invalid-flags kfunc call to stay within 80 columns.
- Fix indent in mm patches.

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

v6:
https://lore.kernel.org/all/20260908135302.74963-1-tasos.papagiannnis@gmail.com/

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
 .../selftests/bpf/progs/copy_from_user_bprm.c | 122 ++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |   5 +-
 11 files changed, 399 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c


base-commit: 5ef40d69b38a93bc9951dadb1a15c85c597e1a40
-- 
2.55.0

