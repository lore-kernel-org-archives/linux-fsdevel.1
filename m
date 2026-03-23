Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDE43C942E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288444; cv=none; b=Vdxetejd3nYfbdeELApaya8TJkPEXult7/O1Uv3LFaPuIpKEY2Wm2DcsitG1ZR5HoZCAtZUiWhh3YidbRiyw7+8Ycu+VUEUFgOK/FinxTMnslPTxhat/G764HGQED6I1ZC8AVENjbNz+AMQhcZC4OoM6D/tHUJ6052HAEaRzbYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288444; c=relaxed/simple;
	bh=yiSvanU+b3R9AvelUdQG47d6JdC1zJCKosFLTaFy2yg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f9RiQHqiWj4PTiCz10w2Mz7VGtsB93ekgCTEro9dceAKptfBcXVEm4CATS7fe9ARCV9rujXzblJxuN38RrA5hkB8GIx4kLwfZ33tI4bP6ombku2uqTqb6/FIk4DY40Erb7USthOCV22yxD/wte/VttMaFMMEBbD62vlb7yn+oSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaVXj7tN; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaVXj7tN"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-4670a0ad001so13039036b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774288442; x=1774893242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A9CUPvPqmkALquwn3kP/A/dGd5HZtJJQeBn1Jn3L+v0=;
        b=IaVXj7tNOm0FTsvuLsfrAaX3Fqy+BCj2zxdUQNszdC9crZBr8nmwJ1wPsRb21wHUQQ
         c8v1qIuUKOYduyJZYsNbsR5miAuYdP5y7eOqS4paxewwL6EjI4mbo5VfxfMR7brIAwUC
         WBUckgiDitK7GxIyB37KvE2+v08oOEfXs96sHiCHmrERtidZPlkCD5qqFtj9yI/UId6C
         tvH8FDRHKabdExcHlSOgST0vlydOJ6dS+sM34fSRi8EHf0t2yQBXHpLB2q4PDlGvAWj+
         CIeQ2rpyf7BQ9wna10KLXrJPPUa9RmvWlURnKCocCG1hyZUr7N5Bt+eZAUx21ET1rS2l
         epmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288442; x=1774893242;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A9CUPvPqmkALquwn3kP/A/dGd5HZtJJQeBn1Jn3L+v0=;
        b=XPqq9xxzNSt1PmJN0d1upcoryzZW8W2S/BwkAlFOieLQyE2kIud4CqF+pX1dHfF7kM
         hqfLbOAbB0tQdinzflCzflMqh3MK4KMVC9LI0l5zZNUABT8JFRPE9oax7KMHAuzhY7D+
         lIM2TKGFCemI5k3Rm3XyUgn9hW5xeGOPEsSfO0kbKF75SUedq86V0h5d4JuXjOrTzZTY
         0HrU72okTkEV77J6mO7l9I7+atwIGTY61ADGdyzkBC16YxeXiRVt/tRmQYApHPsktQfT
         8V/xc+1tu53NkVoGU4+7QjlCY/zIcM/vUaNg4VJ2l8TlFB5EvH5UDXRi1G7E/9MeS/OK
         MLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7vIKaWBo1FQxn554686i2fV7TQDdsM/pOCF3jDO3zwOhO49zauGPlZsjkpXtm3Rc+X09bUolvQXnIbXDj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+tiK5fKyaPO1Qd4eNsoQtuA0tZkvQPqUQJGOW08UjCHP+R+XQ
	pnaElLX3gzUsIHX+0lJloB1BDMkzN72v9gACRucST+Hr7mI6yrf/KsJAsV4oPwQPNNxS9USdtFv
	vX3g3vQ==
X-Received: from jabjy12.prod.google.com ([2002:a05:6638:a30c:b0:5d4:6f13:358c])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a4a:e904:0:b0:67b:d1cc:db3b
 with SMTP id 006d021491bc7-67c22bb5ed4mr10163213eaf.15.1774288441712; Mon, 23
 Mar 2026 10:54:01 -0700 (PDT)
Date: Mon, 23 Mar 2026 17:53:36 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323175340.3361311-1-avagin@google.com>
Subject: [PATCH 0/4 v5] exec: inherit HWCAPs from the parent process
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Cyrill Gorcunov <gorcunov@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Koutny <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"

This patch series introduces a mechanism to inherit hardware capabilities
(AT_HWCAP, AT_HWCAP2, etc.) from a parent process when they have been
modified via prctl.

To support C/R operations (snapshots, live migration) in heterogeneous
clusters, we must ensure that processes utilize CPU features available
on all potential target nodes. To solve this, we need to advertise a
common feature set across the cluster.

Initially, a cgroup-based approach was considered, but it was decided
that inheriting HWCAPs from a parent process that has set its own
auxiliary vector via prctl is a simpler and more flexible solution.

This implementation adds a new mm flag MMF_USER_HWCAP, which is set when the
auxiliary vector is modified via prctl(PR_SET_MM_AUXV). When execve() is
called, if the current process has MMF_USER_HWCAP set, the HWCAP values are
extracted from the current auxiliary vector and inherited by the new process.

The first patch fixes AUXV size calculation for ELF_HWCAP3 and ELF_HWCAP4
in binfmt_elf_fdpic and updates AT_VECTOR_SIZE_BASE.

The second patch implements the core inheritance logic in execve().

The third patch adds a selftest to verify that HWCAPs are correctly
inherited across execve().

v5:
 -  Fix reading of HWCAPs from auxiliary vectors of compat processes.
 -  Defer HWCAP masking until ELF table creation (create_elf_tables)
    to handle compat process correctly.
 -  arm64: Disable HWCAP inheritance on architecture switch (e.g.,
    AArch64 to AArch32) by clearing MMF_USER_HWCAP, as HWCAP bits have
    completely different meanings across these architectures.

v4: minor fixes based on feedback from the previous version.
v3: synchronize saved_auxv access with arg_lock

v1: https://lkml.org/lkml/2025/12/5/65
v2: https://lkml.org/lkml/2026/1/8/219
v3: https://lkml.org/lkml/2026/2/9/1233
v4: https://lkml.org/lkml/2026/2/17/963

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Chen Ridong <chenridong@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Michal Koutny <mkoutny@suse.com>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>

Andrei Vagin (4):
  exec: inherit HWCAPs from the parent process
  arm64: elf: clear MMF_USER_HWCAP on architecture switch
  mm: synchronize saved_auxv access with arg_lock
  selftests/exec: add test for HWCAP inheritance

 arch/arm64/include/asm/elf.h                 |  12 ++-
 fs/binfmt_elf.c                              |  13 ++-
 fs/binfmt_elf_fdpic.c                        |  13 ++-
 fs/exec.c                                    |  54 ++++++++++
 fs/proc/base.c                               |  12 ++-
 include/linux/binfmts.h                      |  11 ++
 include/linux/mm_types.h                     |   3 +-
 kernel/fork.c                                |   8 ++
 kernel/sys.c                                 |  30 +++---
 tools/testing/selftests/exec/.gitignore      |   1 +
 tools/testing/selftests/exec/Makefile        |   1 +
 tools/testing/selftests/exec/hwcap_inherit.c | 105 +++++++++++++++++++
 12 files changed, 234 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/exec/hwcap_inherit.c

-- 
2.53.0.959.g497ff81fa9-goog

