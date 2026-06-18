Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90692F8E88
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814858; cv=none; b=h1ORGh6CrFky1WH2uu7ED23HIhIxmLzuH3RMMOY0Ml38yjPu4U+ISP97sun7OqswxjavKuMhzdeDeUr1sHSol3ER576tLq/3vXI9gDZdqi8L2/hXEX7pCx6X4rvjTdCRoAfd9p3QP4NUYv9CUIlyKKxwECNJqxIXZa+OeGlGTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814858; c=relaxed/simple;
	bh=58J+e+qzOqSL8rLq819iM9p8hX+gCfzoDVUQTirsvLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cq8nf3wLebQzTEZyvAyImA8oabmAiOysrulJdKPuiCHPfVijBbpYYqzDTOCnKGm/ESw4BqRZxifVUOag67fyhgHAYxV4XxDNoNycaKRsuDYAJ6f8uE7Ri1GH8yudXB20/8gnIQ2ZYW9vhyKxMZ4a7jXk31KkWlJFINM5ocA0aNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpZDhoWP; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpZDhoWP"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8cce22e029cso34428156d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814856; x=1782419656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DA8ujigZ7IZh+Xr0JA9p0ivPwgMz7UTZBS7avx55oOk=;
        b=ZpZDhoWPKMWpdhZAt8MJSKrpVWP33cTDKaLOR8NEm9junQifEuiYa61pJ5oKMbbDUp
         42KlQxUeHhddXxpPPL9P1duAU4scCVYsf9Fv7rU3/GthpI/WNmrIVWvBONGMBsDmatKx
         9pmj94Sw9dU5HEm0wqLwGiSYEfF/PvlCwC97ckbrUYXu7AtWeIuQdJtx42WNlmaLrw7d
         zgOG/03uEJsvIoAfkBVVZG1S6pcC6/hKSd5wun/hlHCOOqb885aiX/JzgcJxPOMCXMc3
         SBBF0xL/wmhsbV9oTsLOSFhom3l53/qIZn056E6zi+qFXQVjmzHM55+LIqbAFSK1CsxM
         Ckyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814856; x=1782419656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA8ujigZ7IZh+Xr0JA9p0ivPwgMz7UTZBS7avx55oOk=;
        b=obrTZX/GGCHnMqaZz37J+biwJ+oIRTt8vKXZsRCVUip2zDrKvm8usE+zyHKRrx5iY5
         eCkxRNnTHHwj2LDJaEijksi8Il/9jXYbbE+L+4zxdV/r8QRIFfZ3AHMa5u6PHBaGB2ah
         XcU08RlqzVD3NlcEDW3/hcQa7iaFmIr5Oe+APTwpMdmz7YEHeSOJCZrjCwB+Dd0dn5p+
         aChPkg1s7C77Plk0J9OeZT3+a3fU0GLyMhdfaQCMxSRtNwLJdq79uPJkE++Tr2JgnHU0
         Qmf96w3fnvYrmm6mCB+IUHlksJuTzp3GaLLXG1f8cCuCR2ZJCeLhkY518/sQvV0H00ZV
         f2AQ==
X-Forwarded-Encrypted: i=1; AFNElJ/81+7CSB9jpMVjmZ7Dh8Q42LlCeHbxDY/rszc6YfnFXtyaZbcTBHOH+qyCoUPg+IZnbzjZ5iqWYbfJjZBi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QWVhupT8k7sXKApgAGnXxOg1iBo3s7ul78RHS1UU3NGfaSxo
	vd7HKY/dGwK2UYnG2suADfDu0kl81JNQXXBgMK7paYVwclf0/Bv8dtdS
X-Gm-Gg: AfdE7cmIuqevBWuZiOOqQLm637WayPf+q15GE6QkIz/rcBPRQIH68X3CsHkVU9iWJgF
	McIaAAM4vL4n6ozmMW25sBWJlO0GE67j6eETn/qvkTnQZpTaRWFF+ZvdzecfjXkfcqSGnwJRbM5
	GVkEZx83OEkfgUINDRQFGjuEzw/TLh0cKHuTYTGiJDrE/X6bmGqNqRp3uWDT5msw85943ZklKEU
	AW1JiXoKfOEdTjuezbBN9MvH5ucteDklwiOZP0JZDjEm3eTy+MWiWE0FsQeVzOFl5Gyxl63wxXc
	200lcI+1fNUtqygTXKoSu+zLtFPd4r72KiWjOHHQYOO4aHPCXv1p/ZgmoPiySUmLh4Qs+itZH6s
	O0rm1TXYlc8nqoBCYWqOpQ4UMi7RdnRHwVxiRGu6HNnEmfMlVk7BVypn3NhrC4/h05FwR2E3OE6
	AjiXYG8py7pHMkBzWYleJAcEZAxQStLsDhFs+3Urah+9kRipt7LYpvidxfiEjZDSHUSM6DA0een
	uDx87ILq7SlvIUhIX5HB3dvKQ==
X-Received: by 2002:a05:6214:dc1:b0:8dc:939d:b03d with SMTP id 6a1803df08f44-8de4c76b7c5mr8335506d6.16.1781814855698;
        Thu, 18 Jun 2026 13:34:15 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5e12d1c3sm2176166d6.10.2026.06.18.13.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:34:14 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Thu, 18 Jun 2026 16:34:09 -0400
Message-ID: <20260618203411.73917-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
extended attributes. For these LSMs, atomic labeling during inode
creation is critical: if the inode becomes accessible before its xattr
is set, it is briefly unlabeled, which can disrupt LSMs making policy
decisions based on file labels.

Existing LSMs solve this by setting xattrs directly in the
inode_init_security hook, which runs before the inode becomes
accessible. BPF LSM programs currently lack this capability because
the hook uses an output parameter (xattr_count) that BPF programs
cannot write to, and existing kfuncs like bpf_set_dentry_xattr
require a dentry that isn't available until after the inode is
accessible.

This series introduces the bpf_init_inode_xattr() kfunc, which takes
the combined inode_init_security xattr context argument to access
xattrs and xattr_count, and internally writes to xattr_count via
lsm_get_xattr_slot().

v3:
  - rename struct lsm_xattr_ctx to struct xattr_ctx (Paul)
  - increase BPF_LSM_INODE_INIT_XATTRS to 4 (Song)
  - enforce per-hook attachment cap at attach time to prevent
    runtime rejection (Paul)
  - add init_inode_xattr_attach_cap selftest

v2:
  - pass the xattr state as a combined context object and drop the
    verifier fixup path (Kumar)
  - restrict bpf_init_inode_xattr labels to bpf.* namespace (Matt)
  - cap bpf_init_inode_xattr() at BPF_LSM_INODE_INIT_XATTRS slots per
    invocation (AI)

Link: https://lore.kernel.org/all/20260503211835.16103-1-dwindsor@gmail.com/ [v2]

David Windsor (2):
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            | 106 +++++++++++++++++-
 include/linux/bpf.h                           |   1 +
 include/linux/bpf_lsm.h                       |   3 +
 include/linux/evm.h                           |   9 +-
 include/linux/lsm_hook_defs.h                 |   4 +-
 include/linux/lsm_hooks.h                     |  16 ++-
 include/linux/security.h                      |   5 +
 kernel/bpf/bpf_lsm.c                          |  10 ++
 kernel/bpf/trampoline.c                       |   3 +
 security/bpf/hooks.c                          |   1 +
 security/integrity/evm/evm_main.c             |   8 +-
 security/security.c                           |   7 +-
 security/selinux/hooks.c                      |   4 +-
 security/smack/smack_lsm.c                    |  27 ++---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 105 ++++++++++++++++-
 .../bpf/progs/test_init_inode_xattr.c         |  31 +++++
 17 files changed, 306 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
-- 
2.53.0

