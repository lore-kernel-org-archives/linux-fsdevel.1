Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9333ADB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 04:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782103189; cv=none; b=JzG9oXKg/gmK4ttXI/GkWs5d3Mc626kKLKNaLsTudVZ6kDJ0jmYBoDmepMUYy0Q2JGQlQO80wM8Px5eV9kAYqbzWtwbHxa7PMfvYp5CVxq5LipMO1tABD7i186B8cIDzBIS3Zvqr6pjubNkzCs2Hnw3veOcZlnz4H7cAX11hXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782103189; c=relaxed/simple;
	bh=XXnZ0ZKvcb4NQKdoZxO1XTo5lGuDLJGHFkV7ikEF3xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss/t5Z40XAsYNXqXeE9efDkRQpc/0w0XJ3YMkUDgDjY6HNHN5Ocsf84jhqvLPwIMlBFaqv04KFH++DpgRt+WF03vnSQpxl2X1Z3zk0h3yJNXw/H6F+o+NhMIyKTegoAIxD3NGcAFIwwN23mC8bYCQyP3P4sN2B+45nrU9Wkyups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9HUfFvJ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9HUfFvJ"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e943356247so1559812a34.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2026 21:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782103187; x=1782707987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2URiiwAmBLau2vT0+5EPFKTJxMl3ImoKXAHWV/E4x4=;
        b=i9HUfFvJQ6fOcWpizFphuTLzryzzP/zt+SlNyqsSIoLmT+7orfU9jKRs8wLlQm5FEr
         QY0H6GtQgxbtS5T10Afvu3hD8w/hhZOf3q9/jx0vDud+RwHrRU0ZjXTAWxUvkDNodt2q
         UNHWqxdfC8RV5WjF11Z7txzwi1plLliG0cBBhd4dcAcE8AnzOkj+Kmpv36ZpslGM1WNN
         EChrdlqmPC+IeB0Buc9OWe+wRFAXzf1lTPvIRvm9S0uji+RK2wmSDdlhrlpKmt58G44o
         difdMX3hk/0TEN75avJHNAJsoRiQh2vy0fU3CJz385hebL6L6ibuGGgptNJdfQ5CKB+l
         +uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782103187; x=1782707987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q2URiiwAmBLau2vT0+5EPFKTJxMl3ImoKXAHWV/E4x4=;
        b=r5RL+48623ByYJCrs2acZwK0aXeplZQIqqMc3XfoXtq7jlFD2HQJ9Jcot8NIXbZ02S
         Ks0BPAhLP15WmVu+mU+ij2Gijb6LHwFtkgQg8SGywdC1ff0/5E6slAgK8vaBpCq6ntAi
         wIdBlG+g0lDntEs0VqaCa1K4TUfP0OZtC9J1cG2mFOc4IezgH36ia6cb4C4seHTKnW3a
         JHHysI03OFD56Q5L0X1myVIAvI1hTW1085ICrHAvcliKq5OfilKQiqBvBTT7zTgRkaAR
         mANXF5m8lzdMu8HLnEAre1linZ+7NWJULmBs9s7FvHh5nb/gCRhalaR8ecnBF0sMM3jl
         YXwg==
X-Forwarded-Encrypted: i=1; AFNElJ9MibinzL8ZnNVP9rsC7pNdGcduapLQHd2ythBZkm1W72e4H7vxG4MS7+P/+39W9wivxLhjcgF3BFiujnzf@vger.kernel.org
X-Gm-Message-State: AOJu0YzW0H6Ar9i2BLqvJkmsXqZKQpllve9Z+9B3jgLcGmK54kew2nwT
	MgN48H9nq1f/hHzZF6PhnNhdOznn2oPq0ZlaQztQ9HwORvnA8PukkziM
X-Gm-Gg: AfdE7ckUXX6WrRXcs6ddAZ3Sn4PYNvRodQB00qFkmprpLza8Nb/CkL4HyoCsiLKKjWq
	f4xTBIbVDbEqA3j1aUOc+TnURDdf9g/breF+4BzbQZZfWkkFD1jpnyIoCv5ofscWUHpMrcSp6hI
	/9hwX6TCYFE7/3CIoI4Q4hLY1Ew/6RrfDVA703mMRyXWD2RLsrYYQrCSxKwtGWCitWjbh95j8f7
	Zld1Hix+d0zr3360UbwkZG4IpP0+Aan7YRLqELSHOtH7bMrTjNGIOHyXAaOqnfK+f4YSvdbrRdw
	WRWbt/RTm82xbf+ANoB5UOc4aFOQ5bJu4CTGsx9dHHwCMEbFst3nI85OzYzTHlHjgU6uIKMI4Z7
	Wza/hZKJnmXKmmy6WA0Y2jPfqNzhYJfNvScyjsD6W36RBmBl7bHTFeZpD1KXyEPNHkfc+nh6BXy
	eg/cmgfyKsZupXFqrlQ26UV1lqr9+xBl1vsg==
X-Received: by 2002:a05:6808:5290:b0:485:507:ee5d with SMTP id 5614622812f47-4896aa2ce16mr12307300b6e.10.1782103187573;
        Sun, 21 Jun 2026 21:39:47 -0700 (PDT)
Received: from nyx.tail25a6.ts.net ([2605:59c8:74db:6e0c:3a80:a3f:f9f0:1b3c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9442ea144sm5428453a34.27.2026.06.21.21.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 21:39:47 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: kees@kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	shuah@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: [PATCH 1/2] fs: support $ORIGIN in ELF interpreter paths
Date: Sun, 21 Jun 2026 21:39:33 -0700
Message-ID: <20260622043934.179879-2-farid.m.zakaria@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, standard ELF and ELF FDPIC loaders expect a fixed path to the
dynamic linker/interpreter (PT_INTERP). However, for systems utilizing
relocatable dynamic interpreters (such as Nix/store-based environments),
hardcoding this path is inflexible and breaks binary portability.

Introduce support for resolving the $ORIGIN placeholder in the ELF
interpreter path. This maps the dynamic linker relative to the path
of the binary being executed, matching user-space origin resolution.

To avoid code duplication, implement a shared 'resolve_elf_interpreter()'
helper in the VFS exec layer. For safety, limit detection strictly to
the prefix string "$ORIGIN" to prevent complex parsing exploits.

Assisted-by: Antigravity:Gemini-Pro
Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
 fs/binfmt_elf.c         | 11 +++++++++--
 fs/binfmt_elf_fdpic.c   | 15 +++++++++++++--
 fs/exec.c               | 42 +++++++++++++++++++++++++++++++++++++++++
 include/linux/binfmts.h |  2 ++
 4 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 16a56b6b3..af11f96ae 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -872,7 +872,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
-		char *elf_interpreter;
+		char *elf_interpreter, *resolved_interp;
 
 		if (elf_ppnt->p_type == PT_GNU_PROPERTY) {
 			elf_property_phdata = elf_ppnt;
@@ -904,8 +904,15 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
 			goto out_free_interp;
 
-		interpreter = open_exec(elf_interpreter);
+		resolved_interp = resolve_elf_interpreter(bprm, elf_interpreter);
 		kfree(elf_interpreter);
+		if (IS_ERR(resolved_interp)) {
+			retval = PTR_ERR(resolved_interp);
+			goto out_free_ph;
+		}
+
+		interpreter = open_exec(resolved_interp);
+		kfree(resolved_interp);
 		retval = PTR_ERR(interpreter);
 		if (IS_ERR(interpreter))
 			goto out_free_ph;
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 7e3108489..e85727d71 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -230,7 +230,9 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 
 	for (i = 0; i < exec_params.hdr.e_phnum; i++, phdr++) {
 		switch (phdr->p_type) {
-		case PT_INTERP:
+		case PT_INTERP: {
+			char *resolved_interp;
+
 			retval = -ENOMEM;
 			if (phdr->p_filesz > PATH_MAX)
 				goto error;
@@ -259,7 +261,15 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			kdebug("Using ELF interpreter %s", interpreter_name);
 
 			/* replace the program with the interpreter */
-			interpreter = open_exec(interpreter_name);
+			resolved_interp = resolve_elf_interpreter(bprm, interpreter_name);
+			kfree(interpreter_name);
+			if (IS_ERR(resolved_interp)) {
+				retval = PTR_ERR(resolved_interp);
+				goto error;
+			}
+
+			interpreter = open_exec(resolved_interp);
+			kfree(resolved_interp);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter)) {
 				interpreter = NULL;
@@ -284,6 +294,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 
 			interp_params.hdr = *((struct elfhdr *) bprm->buf);
 			break;
+		}
 
 		case PT_LOAD:
 #ifdef CONFIG_MMU
diff --git a/fs/exec.c b/fs/exec.c
index b92fe7db1..0978ae613 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2024,6 +2024,48 @@ static int __init init_fs_exec_sysctls(void)
 fs_initcall(init_fs_exec_sysctls);
 #endif /* CONFIG_SYSCTL */
 
+char *resolve_elf_interpreter(struct linux_binprm *bprm, const char *elf_interpreter)
+{
+	char *pathbuf, *path, *slash, *resolved;
+
+	if (strncmp(elf_interpreter, "$ORIGIN", 7) != 0) {
+		char *ret = kstrdup(elf_interpreter, GFP_KERNEL);
+
+		return ret ? ret : ERR_PTR(-ENOMEM);
+	}
+
+	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathbuf)
+		return ERR_PTR(-ENOMEM);
+
+	path = file_path(bprm->file, pathbuf, PATH_MAX);
+	if (IS_ERR(path)) {
+		kfree(pathbuf);
+		return (char *)path;
+	}
+
+	slash = strrchr(path, '/');
+	if (slash) {
+		if (slash == path)
+			*(slash + 1) = '\0';
+		else
+			*slash = '\0';
+	} else {
+		kfree(pathbuf);
+		char *ret = kstrdup(elf_interpreter, GFP_KERNEL);
+
+		return ret ? ret : ERR_PTR(-ENOMEM);
+	}
+
+	resolved = kasprintf(GFP_KERNEL, "%s%s", path, elf_interpreter + 7);
+	kfree(pathbuf);
+	if (!resolved)
+		return ERR_PTR(-ENOMEM);
+
+	return resolved;
+}
+EXPORT_SYMBOL(resolve_elf_interpreter);
+
 #ifdef CONFIG_EXEC_KUNIT_TEST
 #include "tests/exec_kunit.c"
 #endif
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 2c77e383e..17419cd3d 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -150,4 +150,6 @@ extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
 int kernel_execve(const char *filename,
 		  const char *const *argv, const char *const *envp);
 
+char *resolve_elf_interpreter(struct linux_binprm *bprm, const char *elf_interpreter);
+
 #endif /* _LINUX_BINFMTS_H */
-- 
2.51.2

