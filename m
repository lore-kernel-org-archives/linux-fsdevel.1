Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.3.242.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720488;
	b=hDv7Ewqr6PmuVEoZJ4AWKNQK+n4aYDfbHKKMZQTniKntTyGBb5j+VDKYeJ9SpgAxNVyM
	 F4JA7fP/zCEWKvwuVMJDmRG1g5Gk2BGfC8TRYhdDbui779alIuniQobBbA8pnjRWeJRh2
	 j+wiPwNVXjrmLzVcNx7jhG0xynD6H7JgjnpU8NILlMGBVlTI2P8mbgxzOhcEFSH15QjHg
	 5NwB0XH6kpq6jwX7wHzxCPziectZL8ZACxPyUYGneQecNP1VT1YPJar+T+6yoAliWl2bM
	 2LwjVNEO01kXabuAgd0Fp9Q+jmCFF6GJUFEmxWhcGNZl5PJ1IajbOdylLEvCeqteJ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720488;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CO-INDEX;
	bh=kEfN+lz4jC9aTNLTOmPGU5NO0fDKtkjBweUc+hWx6MM=;
	b=vRMmzRqbp/UeKLbhJi9eCoSpHERFqIbQ3I5ahdgG3CEsSFfWH4aTYW8PWCBcEW1jRPLo
	 lUa1kvaQNdJLPaEXSMcY4IckR9lBliVv9kZdLTwvGTKXjbPyXe1v0UO8FmUZxzBCBjIr+
	 tEn4+JVQ4YrpSuwRTgJz1zOvNJDZVOSe2isUBWFK4d5k+SGk9KJXzLcrRv8OPzDKgzuw1
	 RF5ca2QA8+hCl4Bjk6xMbvt6D8buxGPty5vlNw7maflZLGPVnOMh8jsZ+zYM7+B6krcke
	 9TwyTZaesJyRsV4GHIKAam728mCrIjQ8882H79YRn3qOtJF74weeyDNg/DCBuoBX4tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailfence.com;
	spf=pass smtp.mailfrom=mailfence.com;
	dkim=pass header.d=mailfence.com header.i=brianwitte@mailfence.com header.a=rsa-sha256 header.s=20240605-akrp header.b=EDrVvGmx;
	arc=none smtp.remote-ip=212.3.242.97
Received: from mailout-l3b-97.contactoffice.com (mailout-l3b-97.contactoffice.com [212.3.242.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D43606A319;
	Fri, 23 Oct 2026 01:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00D43606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailfence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailfence.com header.i=brianwitte@mailfence.com header.a=rsa-sha256 header.s=20240605-akrp header.b=EDrVvGmx
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by mailout-l3b-97.contactoffice.com (Postfix) with ESMTP id 633C060B4;
	Fri, 23 Oct 2026 03:54:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792720481;
	s=20240605-akrp; d=mailfence.com; i=brianwitte@mailfence.com;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=kEfN+lz4jC9aTNLTOmPGU5NO0fDKtkjBweUc+hWx6MM=;
	b=EDrVvGmxri9ofREdVPpPBZNnNxHebFqjfRzzXJJ93GYzrgzG12/r8IJOJpkT9Ews
	00N8wbDFz0w87sQbiN3sIeTV9aJYbKoS2F9yRSEi7HrhCbcXgUswpDLqy3Ea9EQoxKO
	rAH2bduHukf20f3FqXAPlN8cY6eOVWwlsfd1jrjYEuAKn9NPIDDgTOrHWZJuYJUQ/xJ
	fBXS/j/FmobO4vXiHl5m3tcQIJvcV/svlKSVmsNv0F7hM9T6rRyvXeO57wdnDncSriN
	qUvfpPMczS83cciA6qu+vg5AvoItHHhJyUQTS1pD44AmYhGRx82KfOcKDuDl2cf3Vbf
	Sowd8Uq20g==
Received: by smtp.mailfence.com with ESMTPSA ; Fri, 23 Oct 2026 03:54:40 +0200 (CEST)
From: Brian Witte <brianwitte@mailfence.com>
To: Kees Cook <kees@kernel.org>
Cc: Brian Witte <brianwitte@mailfence.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jann Horn <jannh@google.com>,
	Helge Deller <deller@gmx.de>,
	Justin Stitt <justinstitt@google.com>,
	Daniel Micay <danielmicay@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] exec: randomize the argument block's offset within its page
Date: Fri, 23 Oct 2026 03:54:41 +0200 (CEST)
Message-ID: <20261023015345.1594514-2-brianwitte@mailfence.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023015345.1594514-1-brianwitte@mailfence.com>
References: <20261023015345.1594514-1-brianwitte@mailfence.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CO-INDEX: 5Hfd5iwv96PZ+oxlg2+SbbocvRakgd9BwmPCE7Z93iA=

bprm->p starts one word below STACK_TOP_MAX, and setup_arg_pages()
moves the stack only by whole pages, so the argv, envp and execfn
strings sit at the same offset within their page on every exec. Three
execs on x86_64 put argv[0] at 0x7ffeee30af9f, 0x7ffdf3709f9f and
0x7ffc871e0f9f.

Lower bprm->p by a random amount under a page before the strings are
copied: about 12 bits of entropy with 4K pages and 16 with 64K.
bprm->argmin is derived from bprm->p, so the argument size limit is
unchanged, but up to a page of RLIMIT_STACK is used.

ADDR_NO_RANDOMIZE disables the offset; PF_RANDOMIZE cannot be used,
since load_elf_binary() sets it after the strings are copied.
PER_CLEAR_ON_SETID also clears the flag for set-id execs only after the
copy, and moving the strings then would mean copying them all. So
bprm_fill_uid()'s set-id checks are repeated early, without its
inode_lock(), and a set-id exec gets the offset regardless of the flag.
A racing chmod or sysctl write can make the offset disagree with the ELF
loader but never affects the credentials. Only the file passed to
execve() is checked: set-id interpreters, file capabilities and LSM
transitions keep today's fixed offset under the flag. The checks need
bprm->file, so they run in bprm_mm_init(), not create_init_stack_vma().

The idea comes from PaX RANDUSTACK; linux-hardened carries a version by
Daniel Micay and Levente Polyak.

Suggested-by: Daniel Micay <danielmicay@gmail.com>
Link: https://github.com/KSPP/linux/issues/283
Signed-off-by: Brian Witte <brianwitte@mailfence.com>
---
 fs/exec.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 5d7b0fe32dbf..1070f0799b27 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -70,6 +70,7 @@
 #include <linux/user_events.h>
 #include <linux/rseq.h>
 #include <linux/ksm.h>
+#include <linux/random.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -195,6 +196,33 @@ static bool valid_arg_len(struct linux_binprm *bprm, long len)
 	return len <= MAX_ARG_STRLEN;
 }
 
+/*
+ * Called before credentials exist: treat ADDR_NO_RANDOMIZE as cleared for
+ * files bprm_fill_uid() will treat as set-id.
+ */
+static bool bprm_randomize_args(struct linux_binprm *bprm)
+{
+	struct file *file = bprm->file;
+	const struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct inode *inode = file_inode(file);
+	/* bprm->cred, not yet set, will be in the caller's namespace. */
+	struct user_namespace *ns = current_user_ns();
+	umode_t mode;
+
+	if (!READ_ONCE(randomize_va_space))
+		return false;
+	if (!(current->personality & ADDR_NO_RANDOMIZE))
+		return true;
+	if (!mnt_may_suid(file->f_path.mnt) || task_no_new_privs(current))
+		return false;
+	mode = READ_ONCE(inode->i_mode);
+	if (!(mode & S_ISUID) &&
+	    (mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
+		return false;
+	return vfsuid_has_mapping(ns, i_uid_into_vfsuid(idmap, inode)) &&
+	       vfsgid_has_mapping(ns, i_gid_into_vfsgid(idmap, inode));
+}
+
 #else
 
 static inline void acct_arg_size(struct linux_binprm *bprm, unsigned long pages)
@@ -279,6 +307,10 @@ static int bprm_mm_init(struct linux_binprm *bprm)
 	err = create_init_stack_vma(bprm->mm, &bprm->vma, &bprm->p);
 	if (err)
 		goto err;
+
+	/* Randomize the strings' offset within their page; keep the top word. */
+	if (bprm_randomize_args(bprm))
+		bprm->p -= get_random_u32_below(PAGE_SIZE - sizeof(void *));
 #endif
 
 	return 0;
-- 
2.47.3

