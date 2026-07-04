Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB53241695
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783199659; cv=none; b=ZVOT2JptZD16ZxbBO8mKVjAUkHlSQUrskBQ2ItuF1qv+/fR2D2Gc6spiFV9yFg9vp1/yc69s+1aC+fX/jXvT55zqLPl2pT5a4SyISy/x3ROUVS8of0cUpLEknd9lOsI1/LIlg0oJnNc/XZ0QMSVZ9R6jra02fg0H/xlbhyK4Mlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783199659; c=relaxed/simple;
	bh=i5lGcJWkBxS7CJBWynnEmiQB+QzayIHGBFaFnqq+f8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCs/5A5hxLl8+QIheJeYKDInf0PTfHppowNpIds00og2F77feRbszUAwRR7JHDYK8rKWrpOg3eUFimRFGrGE81bpThvgUQyrvv2xZmxEsa4RsODpgxllxp/vZTeYlEK9EkBX3R2bBywuOGSbQOO190+HG4jbQOGAoKKNGeQTeew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edwvnw1v; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edwvnw1v"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c89636920a3so724132a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2026 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783199656; x=1783804456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNObvvCR77mS9Inyq/bIvC7lHlQKSaAhco2QLbfN6gc=;
        b=edwvnw1vCvpbNgkyQbOHO5FK5IESVgizO2+kQtrTMjyutfA/PAlC4QTV69+jUWtsxu
         MHI1/k9f49fhmqwo4WlvgDFEdqfzwxa3XKcLE0Kic0NqR05nwnnlrX/CFA9y7GC91z1B
         gv5uTBILPxaZ2H99jSHOBEXi6CyPIrUQ4dE4/1pvzFuDxyriv/YildSm2Uq+D+8n0xSE
         BAXRVKL+2MIILifQVwpcmwQZG2cx78acBM2hDfe2SfA8TckfVs1BsYulH/WgUtcJYiUx
         HjmTOjaPciZPxpi1/FB/zldY4PWsEZmQLlMcoMRM7T8eZEzas46CRFffubGtnTXuZbhB
         DwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783199656; x=1783804456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wNObvvCR77mS9Inyq/bIvC7lHlQKSaAhco2QLbfN6gc=;
        b=X43U/0+bf3AYAbz5IiC1DsLzeoib09pXFYH9QG/myAuPOCszi4hISL0L6t+XJM67jZ
         FKXVCy9epbdR/l1icVPwr1yfSW/Ffh/yfQHXISJsN1iT70pdzWz9+Y8n+prKr+V6WwTo
         bybSBDmNpOFQzBpxmnzMf9WSo3xDBmIRyNw9wJ45Ebt6q6MVtHP3QCi9dYTCCT+dpkGY
         gCCPeJx4aM25oDSB7Q6I4r9qsKIBceoukCKJ99oL+ayfJCPrR5qQiv6pwHjYhmtnC0pf
         prz7PrGFQ75/MWnaS6c8nemtOlJj39pf6f8L5kFgp3hXV8ANnYzxmcVf6aJca/DJJnPB
         PLEA==
X-Forwarded-Encrypted: i=1; AFNElJ/1DoFWRxH5afhoI92wspl/RYLNGNGFBuGQlXzrPP49ZcFRRMzW+xBXHe6rwruwAy2UuuFs30ExITOdMcE3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+0q9ANrclsUC1FkqnED02Gbse0gPEuF22+Z6caRVyPlWCBGU
	IgKRZy+T231d9fTB3+fKek8WyE6TK3stuQSOeckWHUa1Hnq8aGX3HOXX
X-Gm-Gg: AfdE7clVpLXLNVOZQ0OEcVKrydMKeJwtMa3P5ALmYwyB4yEziPrumxYk1i0FtQOvcFD
	LNp98k+CdCV1fbFU1mUFlMJbDs3MAqQzl6gXeU3jQZ/TnguL2xkT9VzDuuLemxvKa83Zej0uJRf
	1NqZcJDmsf7JojlGD3TVjusernnEIOHyP0qjNNpLNTROY50WUqeB0FqmHJ5qFG8cbklIEo6ZFZX
	fRRKC9Qsw/wmxtLaTJV9Qj+3CouQd2uUwdB9mUuQTiXcJOoYer0eW/xAdcI2Rn+9TwTZFlQrj5o
	wORHgvpUz5X1UUF1iZoPTMfVr5cZ4AyEsP4jR9u7dJ3D2qgmMROZKeBapRSuDmW5FOPOmwASUGH
	eJeikZAAWpgPkysZssXdcNGw9R6dRMkjzZ7+64kGrNgj4QEQ+A9oNqZuyYcEam7Ag3fmIleBjdi
	wcRGo6u4HEPsUsW4HEwyCub7gESqQ=
X-Received: by 2002:a05:6a21:a91:b0:3bf:a698:ce4d with SMTP id adf61e73a8af0-3c03e5ea69dmr4576055637.54.1783199655731;
        Sat, 04 Jul 2026 14:14:15 -0700 (PDT)
Received: from nyx.tail25a6.ts.net ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f38ee1333sm18515569eec.24.2026.07.04.14.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 14:14:15 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: brauner@kernel.org
Cc: david.laight.linux@gmail.com,
	farid.m.zakaria@gmail.com,
	jack@suse.cz,
	jannh@google.com,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	mail@johnericson.me,
	shuah@kernel.org,
	viro@zeniv.linux.org.uk,
	Gemini <assistant@google.com>
Subject: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and interpreter selection
Date: Sat,  4 Jul 2026 14:14:09 -0700
Message-ID: <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically binfmt_misc has only matched binaries by magic bytes or file
extension, and always redirects a match to a fixed interpreter recorded in
the registration. This is insufficient when the match requires parsing the
binary header (e.g. inspecting ELF program headers) or when the interpreter
must be computed per-binary rather than hard-coded.

Introduce a new 'B' (BPF) handler type. A pinned SOCKET_FILTER program is
registered in place of the magic/mask, and no interpreter is recorded:

  echo ':name:B:<bpf_pinned_path>::::<flags>' \
      > /proc/sys/fs/binfmt_misc/register

When a binary is executed, binfmt_misc runs the program with the
BINPRM_BUF_SIZE file-header buffer as context. Returning 1 selects the
handler; returning 0 falls through to the remaining handlers.

Unlike magic/extension handlers, a 'B' handler carries no interpreter of its
own: the program chooses it via a new helper, bpf_binprm_set_interp(). This
lets the program compute the interpreter path however it sees fit (for example
relative to the binary). A 'B' handler is therefore a strict superset of the
existing magic handlers -- any of them can be expressed as a program that
matches on the header and sets a fixed interpreter.

bpf_binprm_set_interp() is exposed to SOCKET_FILTER programs and stashes the
chosen path on a per-CPU area that binfmt_misc reads back immediately after
the run under migrate_disable(); only a match that set an interpreter
allocates.

Assisted-by: Gemini <assistant@google.com>
Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---

Hey Christian,

Thank you for the suggestion and discussion on the mailing list. I took a stab
at your idea of driving binfmt_misc interpreter selection from a BPF program
(hopefully this is what you had in mind). The other approach was also to use a
static interpreter during registration but this current approach feels right.

This prototype demonstrates binfmt_misc interpreter selection from a BPF program
so the interpreter can be *computed* (e.g. $ORIGIN-relative) rather than recorded
statically. It replaces my earlier "pluggable ELF interpreter loader registry" RFC.

As this is a first draft, a few things you probably will have notes on.
I tried my best but I am a novice here so I welcome your feedback.

 * The prototype uses socket filter type. This seemed the easiest to wire up to
   start. My guess is it should be a dedicated type (eg. BPF_PROG_TYPE_BINFMT).
 * bpf_binprm_set_interp() is a "classic helper", but that list
   is frozen in favour of kfuncs. A kfunc needs BTF and can't be called from
   the raw-bytecode selftest I wrote.
 * The program only gets bprm->buf today.
   That is enough to match on the ELF header but not to compute an
   $ORIGIN-relative path from the binary's location, which needs bprm->filename
 * I have some selftests that exercises match + program-chosen interpreter. I don't
   include them here yet since it seems unnecessary when discussing the idea.

To demo the functionality, I thought it would be neat to see how this is a superset
and can replace all the qemu binfmt usage [1].

  $ ./hello-aarch64;
  -bash: /etc/binfmt-demo/hello-aarch64: cannot execute binary file: Exec format error

  $ bpftool prog load filter.bpf.o /sys/fs/bpf/qemu type socket
  $ echo ':qemu-bpf:B:/sys/fs/bpf/qemu::::P' > /proc/sys/fs/binfmt_misc/register

  $ ./hello-aarch64
  AARCH64_RAN_VIA_QEMU

All the per-CPU guards were recommended by AI.

[1] https://gist.github.com/fzakaria/bef27d2e21b0e36ffccda1cbf417b636

 fs/binfmt_misc.c         | 181 ++++++++++++++++++++++++++++++++++++---
 include/linux/bpf.h      |   1 +
 include/uapi/linux/bpf.h |   1 +
 net/core/filter.c        |   8 ++
 4 files changed, 180 insertions(+), 11 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 84349fcb9..cf6698d59 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -29,6 +29,11 @@
 #include <linux/fs.h>
 #include <linux/uaccess.h>
 
+#ifdef CONFIG_BPF_SYSCALL
+#include <linux/bpf.h>
+#include <linux/filter.h>
+#endif
+
 #include "internal.h"
 
 #ifdef DEBUG
@@ -41,12 +46,14 @@ enum {
 	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
 };
 
-enum {Enabled, Magic};
+enum {Enabled, Magic, Bpf};
 #define MISC_FMT_PRESERVE_ARGV0 (1UL << 31)
 #define MISC_FMT_OPEN_BINARY (1UL << 30)
 #define MISC_FMT_CREDENTIALS (1UL << 29)
 #define MISC_FMT_OPEN_FILE (1UL << 28)
 
+struct bpf_prog;
+
 typedef struct {
 	struct list_head list;
 	unsigned long flags;		/* type, status, etc. */
@@ -59,6 +66,9 @@ typedef struct {
 	struct dentry *dentry;
 	struct file *interp_file;
 	refcount_t users;		/* sync removal with load_misc_binary() */
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_prog *bpf_prog;
+#endif
 } Node;
 
 static struct file_system_type bm_fs_type;
@@ -78,10 +88,51 @@ static struct file_system_type bm_fs_type;
  */
 #define MAX_REGISTER_LENGTH 1920
 
+#ifdef CONFIG_BPF_SYSCALL
+struct binfmt_bpf_interp {
+	char path[PATH_MAX];
+	int len;	/* < 0 if the current program set no interpreter */
+};
+static DEFINE_PER_CPU(struct binfmt_bpf_interp, binfmt_bpf_interp);
+
+/*
+ * bpf_binprm_set_interp - let a binfmt_misc 'B' program pick the interpreter.
+ * @path: interpreter path, in BPF-accessible memory
+ * @len:  number of bytes in @path
+ *
+ * The program computes the interpreter path however it sees fit (e.g. relative
+ * to the binary). The path is stashed on a per-CPU area that binfmt_misc reads
+ * back immediately after running the program under migrate_disable(), so it
+ * cannot race with another CPU.
+ */
+BPF_CALL_2(bpf_binprm_set_interp, const char *, path, u32, len)
+{
+	struct binfmt_bpf_interp *sc = this_cpu_ptr(&binfmt_bpf_interp);
+
+	if (len == 0 || len >= PATH_MAX)
+		return -EINVAL;
+	/* @path is @len bytes of BPF memory and is not NUL-terminated. */
+	memcpy(sc->path, path, len);
+	sc->path[len] = '\0';
+	sc->len = len;
+	return 0;
+}
+
+const struct bpf_func_proto bpf_binprm_set_interp_proto = {
+	.func		= bpf_binprm_set_interp,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg2_type	= ARG_CONST_SIZE,
+};
+#endif /* CONFIG_BPF_SYSCALL */
+
 /**
  * search_binfmt_handler - search for a binary handler for @bprm
  * @misc: handle to binfmt_misc instance
  * @bprm: binary for which we are looking for a handler
+ * @bpf_interp: receives a kmalloc'd interpreter path if a 'B' program chooses
+ *              one via bpf_binprm_set_interp(); the caller must kfree() it
  *
  * Search for a binary type handler for @bprm in the list of registered binary
  * type handlers.
@@ -89,7 +140,8 @@ static struct file_system_type bm_fs_type;
  * Return: binary type list entry on success, NULL on failure
  */
 static Node *search_binfmt_handler(struct binfmt_misc *misc,
-				   struct linux_binprm *bprm)
+				   struct linux_binprm *bprm,
+				   char **bpf_interp)
 {
 	char *p = strrchr(bprm->interp, '.');
 	Node *e;
@@ -103,6 +155,37 @@ static Node *search_binfmt_handler(struct binfmt_misc *misc,
 		if (!test_bit(Enabled, &e->flags))
 			continue;
 
+		/* Do matching based on BPF if applicable. */
+		if (test_bit(Bpf, &e->flags)) {
+#ifdef CONFIG_BPF_SYSCALL
+			if (e->bpf_prog) {
+				struct binfmt_bpf_interp *sc;
+				u32 ret;
+
+				migrate_disable();
+				sc = this_cpu_ptr(&binfmt_bpf_interp);
+				sc->len = -1;
+
+				rcu_read_lock();
+				ret = bpf_prog_run(e->bpf_prog, bprm->buf);
+				rcu_read_unlock();
+
+				if (ret == 1 && sc->len > 0)
+					*bpf_interp = kmemdup_nul(sc->path,
+								  sc->len,
+								  GFP_ATOMIC);
+				migrate_enable();
+
+				pr_debug("binfmt_misc: ran BPF program for %s, ret = %u\n",
+					 bprm->filename, ret);
+
+				if (ret == 1)
+					return e;
+			}
+#endif
+			continue;
+		}
+
 		/* Do matching based on extension if applicable. */
 		if (!test_bit(Magic, &e->flags)) {
 			if (p && !strcmp(e->magic, p + 1))
@@ -139,12 +222,13 @@ static Node *search_binfmt_handler(struct binfmt_misc *misc,
  * Return: binary type list entry on success, NULL on failure
  */
 static Node *get_binfmt_handler(struct binfmt_misc *misc,
-				struct linux_binprm *bprm)
+				struct linux_binprm *bprm,
+				char **bpf_interp)
 {
 	Node *e;
 
 	read_lock(&misc->entries_lock);
-	e = search_binfmt_handler(misc, bprm);
+	e = search_binfmt_handler(misc, bprm, bpf_interp);
 	if (e)
 		refcount_inc(&e->users);
 	read_unlock(&misc->entries_lock);
@@ -164,6 +248,10 @@ static void put_binfmt_handler(Node *e)
 	if (refcount_dec_and_test(&e->users)) {
 		if (e->flags & MISC_FMT_OPEN_FILE)
 			filp_close(e->interp_file, NULL);
+#ifdef CONFIG_BPF_SYSCALL
+		if (test_bit(Bpf, &e->flags) && e->bpf_prog)
+			bpf_prog_put(e->bpf_prog);
+#endif
 		kfree(e);
 	}
 }
@@ -206,15 +294,27 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	struct file *interp_file = NULL;
 	int retval = -ENOEXEC;
 	struct binfmt_misc *misc;
+	char *bpf_interp __free(kfree) = NULL;
+	const char *interpreter;
 
 	misc = load_binfmt_misc();
 	if (!misc->enabled)
 		return retval;
 
-	fmt = get_binfmt_handler(misc, bprm);
+	fmt = get_binfmt_handler(misc, bprm, &bpf_interp);
 	if (!fmt)
 		return retval;
 
+	/*
+	 * A 'B' (BPF) handler carries no interpreter of its own; the program
+	 * chooses it via bpf_binprm_set_interp(). Other handlers use the
+	 * interpreter recorded at registration.
+	 */
+	interpreter = bpf_interp ? bpf_interp : fmt->interpreter;
+	retval = -ENOEXEC;
+	if (!interpreter[0])
+		goto ret;
+
 	/* Need to be able to load the file after exec */
 	retval = -ENOENT;
 	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
@@ -238,22 +338,27 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	bprm->argc++;
 
 	/* add the interp as argv[0] */
-	retval = copy_string_kernel(fmt->interpreter, bprm);
+	retval = copy_string_kernel(interpreter, bprm);
 	if (retval < 0)
 		goto ret;
 	bprm->argc++;
 
 	/* Update interp in case binfmt_script needs it. */
-	retval = bprm_change_interp(fmt->interpreter, bprm);
+	retval = bprm_change_interp(interpreter, bprm);
 	if (retval < 0)
 		goto ret;
 
-	if (fmt->flags & MISC_FMT_OPEN_FILE) {
+	/*
+	 * The pre-opened interp_file (MISC_FMT_OPEN_FILE / 'F' flag) only
+	 * applies to the statically registered interpreter; a program-supplied
+	 * path is opened here.
+	 */
+	if ((fmt->flags & MISC_FMT_OPEN_FILE) && !bpf_interp) {
 		interp_file = file_clone_open(fmt->interp_file);
 		if (!IS_ERR(interp_file))
 			deny_write_access(interp_file);
 	} else {
-		interp_file = open_exec(fmt->interpreter);
+		interp_file = open_exec(interpreter);
 	}
 	retval = PTR_ERR(interp_file);
 	if (IS_ERR(interp_file))
@@ -404,6 +509,10 @@ static Node *create_entry(const char __user *buffer, size_t count)
 		pr_debug("register: type: M (magic)\n");
 		e->flags = (1 << Enabled) | (1 << Magic);
 		break;
+	case 'B':
+		pr_debug("register: type: B (bpf)\n");
+		e->flags = (1 << Enabled) | (1 << Bpf);
+		break;
 	default:
 		goto einval;
 	}
@@ -492,6 +601,45 @@ static Node *create_entry(const char __user *buffer, size_t count)
 				}
 			}
 		}
+	} else if (test_bit(Bpf, &e->flags)) {
+		/* Handle the 'B' (BPF) format. */
+		char *s;
+
+		/* The offset field actually holds the pinned BPF program path */
+		s = strchr(p, del);
+		if (!s)
+			goto einval;
+		*s++ = '\0';
+		e->magic = p; /* Keep path in e->magic */
+		pr_debug("register: bpf program path: %s\n", e->magic);
+
+#ifdef CONFIG_BPF_SYSCALL
+		e->bpf_prog = bpf_prog_get_type_path(e->magic, BPF_PROG_TYPE_SOCKET_FILTER);
+		if (IS_ERR(e->bpf_prog)) {
+			err = PTR_ERR(e->bpf_prog);
+			e->bpf_prog = NULL;
+			kfree(e);
+			return ERR_PTR(err);
+		}
+#else
+		goto einval;
+#endif
+
+		p = s;
+
+		/* The magic field is unused, must be empty */
+		s = strchr(p, del);
+		if (!s || p != s)
+			goto einval;
+		*s++ = '\0';
+		p = s;
+
+		/* The mask field is unused, must be empty */
+		s = strchr(p, del);
+		if (!s || p != s)
+			goto einval;
+		*s++ = '\0';
+		p = s;
 	} else {
 		/* Handle the 'E' (extension) format. */
 
@@ -524,8 +672,17 @@ static Node *create_entry(const char __user *buffer, size_t count)
 	if (!p)
 		goto einval;
 	*p++ = '\0';
-	if (!e->interpreter[0])
+	if (test_bit(Bpf, &e->flags)) {
+		/*
+		 * A 'B' (BPF) handler carries no interpreter of its own; the
+		 * program picks it via bpf_binprm_set_interp(). Reject a
+		 * statically registered one.
+		 */
+		if (e->interpreter[0])
+			goto einval;
+	} else if (!e->interpreter[0]) {
 		goto einval;
+	}
 	pr_debug("register: interpreter: {%s}\n", e->interpreter);
 
 	/* Parse the 'flags' field. */
@@ -602,7 +759,9 @@ static void entry_status(Node *e, char *page)
 		*dp++ = 'F';
 	*dp++ = '\n';
 
-	if (!test_bit(Magic, &e->flags)) {
+	if (test_bit(Bpf, &e->flags)) {
+		sprintf(dp, "bpf %s\n", e->magic);
+	} else if (!test_bit(Magic, &e->flags)) {
 		sprintf(dp, "extension .%s\n", e->magic);
 	} else {
 		dp += sprintf(dp, "offset %i\nmagic ", e->offset);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528..3aef44b69 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3874,6 +3874,7 @@ extern const struct bpf_func_proto bpf_ktime_get_ns_proto;
 extern const struct bpf_func_proto bpf_ktime_get_boot_ns_proto;
 extern const struct bpf_func_proto bpf_ktime_get_tai_ns_proto;
 extern const struct bpf_func_proto bpf_get_current_pid_tgid_proto;
+extern const struct bpf_func_proto bpf_binprm_set_interp_proto;
 extern const struct bpf_func_proto bpf_get_current_uid_gid_proto;
 extern const struct bpf_func_proto bpf_get_current_comm_proto;
 extern const struct bpf_func_proto bpf_get_stackid_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 89b36de5f..dce155c5b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6142,6 +6142,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(binprm_set_interp, 212, ##ctx)		\
 	/* This helper list is effectively frozen. If you are trying to	\
 	 * add a new helper, you should add a kfunc instead which has	\
 	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\
diff --git a/net/core/filter.c b/net/core/filter.c
index 2e96b4b84..187692a4a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8397,6 +8397,14 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_socket_uid_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_skb_event_output_proto;
+#if IS_BUILTIN(CONFIG_BINFMT_MISC)
+	case BPF_FUNC_binprm_set_interp:
+		/*
+		 * binfmt_misc reuses SOCKET_FILTER programs to select an
+		 * interpreter; expose the helper that lets them set it.
+		 */
+		return &bpf_binprm_set_interp_proto;
+#endif
 	default:
 		return bpf_sk_base_func_proto(func_id, prog);
 	}
-- 
2.51.2

