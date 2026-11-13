Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608060;
	b=pXamce2gyBuXTZ+MjPBm91dj4aoKz0jSaxkZxNI4/rB8p21pbrchl+PGuhgEJm0NhLCS
	 JCm1sDrxPqG/md9UNNcCAEEUHucPC7KWNzsZhizgCoO78UefIBMX8hvAar7iJD5h/LEni
	 r39CXUCW/324WML2IXs+b4bbwVIx00S2X8rFkiKcmgS4mGF+ALLFazspqA8HKS9GCQ8yK
	 mXppqOw0koPGIgG96/Xgo5OjhntsQn+gXFn9H+lOfl5J1bgcrDuwWnV+WzhahbpfoJB1y
	 cLNEz48y+ncgubVdyJdF0lHVDysjOhT8s63cYbQbkF1fAxM54VJsaQ9fICrtnqu6XGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pgq9kE5SUICsmlCxk4e9GW8xjHVaimZWvwiBTJYrn4w=;
	b=Y2Sl/OQv+6CqE94gK4bd1Qi6nX5gcnf34JZWixhRu2L4VNtrqxNgAVUmxyJcB4v4QPji
	 QHOuCyTLFjDVMtRc3l7gURtgqWs4OCJNV1lzp8KEsBf2IoJQLwybNya+YTb9+ASdCGy31
	 1arxXQP7FT0gFmQ4mBwXVZ0wIEClePo3Ny1XwxiHT7ivun5hcyow7VE0JMJOLP23HJTjy
	 YO76HziHlqDuFfZunTXhHHtDonjUT6PRQEQ7evxni/dcKN+HcnttEuskdqMJhRbmn50LU
	 HOout/cu10uY79VPRoWZQ7jrgs6PRb1VuMzkXjjvfbe6FMrUApjYFsYOozvVW90MKGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hWpqsqsi;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5C606A8A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 22:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40E5C606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hWpqsqsi
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-37549877380so1838836eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 14:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608058; x=1795212858; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgq9kE5SUICsmlCxk4e9GW8xjHVaimZWvwiBTJYrn4w=;
        b=hWpqsqsi5Ai7VfHGHkn2ypoSvjA52xdLL/+tVGmCOmpGeUZLIqhLbki3VsruNTrq3u
         Zg8eEN0fODY0o4LzDatAmU45Pmhobu/M38df8hpaaxPjwOXEaCT2HQ0MgxZJ1X9un901
         aTUU1JlNvDY6FMkQ8vFn/wJPP8zrdhvKoNVZE00dqIIDfsb8bBTajo9wOXN7eAeuUoKG
         MWG9s1NSljJW4v+a3EWb81B+yS2xNnPvdIJXLvJ0Hdue9E8vj8h5CVtFGQ7BXhXSCa/O
         YFjO2l86t7bZgMT74iKltKqoKIPcBFYhYkznd5vLUAVkVq/32Yr0ulo+K5FowxJNqOlq
         XYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608058; x=1795212858;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pgq9kE5SUICsmlCxk4e9GW8xjHVaimZWvwiBTJYrn4w=;
        b=c6Th3QP2aNEZCWqb8i+B43otvWjgroX/welVe9FoLqG4Re15kW4HXJu66y6NGbQ7ld
         lYoE6sd1sXywShlYEfTVOw3HmUST3AYQJCUKfZBZJL3spce5r6j/g5Tv5LTP4MpJLwMU
         fMYSYTbiX5XgIRZY2JJID4hcr8AKaxY2KGGKcUuPuKFd6KvaSsKerq46G1UuF5toutcs
         yoNV2+OQpIY3EssNZXNTKrzGxlxZ8xJYiB7LwyzTrCf4y6kZ9sd4TMm9waNMSTZOXTsN
         OjTRYTe2641RDQdY2zwg5roafpQNKna7rFytkdofZJxXddWwED5ncyUuUFDC3YuqjIC7
         pvkA==
X-Forwarded-Encrypted: i=1; AL+hErHRntcXKjKFIm4A/shwF2CdjevJn2WUx8P6XGJwgBNfuCD+/yEqYJ5DfxeMYC7LiEl2NseLSDRz/9XCf658@vger.kernel.org
X-Gm-Message-State: APuU4Z835BbhXGZAiuREuIYSDMlrwetGQ5txRrDcfhP9z6504EEqNrJr
	QU6uZCl5gGniY2i2U6ZGFArfRKKZpolVKM2EBctb404C1KSUibhFsgR+AUXvktoYekvQJsikOT6
	7JPR7eJ3Qp83FnA==
X-Received: from dyay11.prod.google.com ([2002:a05:693c:62cb:b0:36f:9364:dc98])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:90b:b0:34d:755b:d60b with SMTP id 5a478bee46e88-37968b8a031mr3155013eec.34.1794608057786;
 Fri, 13 Nov 2026 14:14:17 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:49 -0800
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261113221248.3535369-15-wusamuel@google.com>
Subject: [PATCH bpf-next v3 4/9] kallsyms: Add KALLSYMS_QUERY_BY_ADDR ioctl to /proc/kallsyms
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Symbolizers such as Perfetto read all of /proc/kallsyms and keep a
sorted copy in memory to resolve addresses.

Add the KALLSYMS_QUERY_BY_ADDR ioctl. It returns the symbol that covers
an address, from the same sources and in the same order as %pS. BPF JIT
symbols are hidden when /proc/kallsyms hides them. query_flags must be
0; it is reserved for other modes.

The command uses 'f' 0x31; register 0x31 in ioctl-number.rst.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  2 +-
 include/uapi/linux/fs.h                       | 13 ++++
 kernel/kallsyms.c                             | 60 +++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index f5dbb597257a..d9b66e7a29b7 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -250,7 +250,7 @@ Code  Seq#    Include File                                             Comments
 'f'   00-0F  fs/ocfs2/ocfs2_fs.h                                       conflict!
 'f'   10-11  linux/fs.h                                                conflict! procfs ioctls (PROCFS_IOCTL_MAGIC)
 'f'   13-27  linux/fscrypt.h
-'f'   30     linux/fs.h                                                procfs kallsyms ioctls (PROCFS_IOCTL_MAGIC)
+'f'   30-31  linux/fs.h                                                procfs kallsyms ioctls (PROCFS_IOCTL_MAGIC)
 'f'   81-8F  linux/fsverity.h
 'g'   00-0F  linux/usb/gadgetfs.h
 'g'   20-2F  linux/usb/g_printer.h
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 987569dcdbea..c1a63c8560e2 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -676,6 +676,7 @@ struct procmap_query {
 
 /* /proc/kallsyms ioctls. -EPERM if the opener cannot see kernel addresses. */
 #define KALLSYMS_QUERY_BY_NAME	_IOC(_IOC_READ | _IOC_WRITE, PROCFS_IOCTL_MAGIC, 48, 0)
+#define KALLSYMS_QUERY_BY_ADDR	_IOC(_IOC_READ | _IOC_WRITE, PROCFS_IOCTL_MAGIC, 49, 0)
 
 enum kallsyms_query_flags {
 	/* Match query_name as a prefix. */
@@ -717,6 +718,18 @@ struct kallsyms_query_by_name {
 	__u64 sym_struct_size;	/* in - sizeof(struct kallsyms_query_sym) */
 };
 
+/*
+ * Find the /proc/kallsyms entry that covers query_addr, or return -ENOENT.
+ * ftrace trampolines and kprobe pages are not resolved yet.
+ */
+struct kallsyms_query_by_addr {
+	__u64 size;		/* in - sizeof(struct kallsyms_query_by_addr) */
+	__u64 query_flags;	/* in - must be 0 */
+	__u64 query_addr;	/* in - kernel address */
+	__u64 sym;		/* in - user ptr to struct kallsyms_query_sym */
+	__u64 sym_struct_size;	/* in - sizeof(struct kallsyms_query_sym) */
+};
+
 /*
  * Shutdown the filesystem.
  */
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 29a9da04d8a3..6d7032cd3fd6 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -1223,6 +1223,64 @@ static int do_kallsyms_query_by_name(struct kallsyms_query_by_name __user *uarg)
 					 &bufs->m);
 }
 
+/*
+ * Look up symbol from addr. Copy the module name under RCU, and hide BPF JIT
+ * symbols as /proc/kallsyms hides them.
+ */
+static int kallsyms_find_addr(unsigned long addr, struct kallsyms_sym_match *m)
+{
+	unsigned long offset;
+	char *modname;
+
+	guard(rcu)();
+	if (!kallsyms_lookup_buildid(addr, &m->size, &offset, &modname, NULL,
+				     m->name))
+		return -ENOENT;
+
+	/* Outside vmlinux, only BPF JIT symbols have no module name. */
+	if (!modname && !is_ksym_addr(addr)) {
+		if (!bpf_jit_kallsyms_enabled())
+			return -ENOENT;
+		modname = "bpf";
+	}
+
+	m->addr = addr - offset;
+	strscpy(m->modname, modname ?: "", MODULE_NAME_LEN);
+	return 0;
+}
+
+static int do_kallsyms_query_by_addr(struct kallsyms_query_by_addr __user *uarg)
+{
+	struct kallsyms_query_by_addr karg;
+	struct kallsyms_query_sym ksym;
+	struct kallsyms_sym_match m;
+	int err;
+
+	err = kallsyms_copy_query_from_user(&karg, sizeof(karg),
+					    offsetofend(struct kallsyms_query_by_addr,
+							sym_struct_size),
+					    uarg);
+	if (err)
+		return err;
+
+	if (karg.query_flags)
+		return -EINVAL;
+
+	err = kallsyms_copy_sym_from_user(&ksym, karg.sym, karg.sym_struct_size);
+	if (err)
+		return err;
+
+	if (karg.query_addr > ULONG_MAX)
+		return -ENOENT;
+
+	err = kallsyms_find_addr(karg.query_addr, &m);
+	if (err)
+		return err;
+
+	return kallsyms_copy_sym_to_user(karg.sym, karg.sym_struct_size, &ksym,
+					 &m);
+}
+
 static long kallsyms_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct seq_file *m = file->private_data;
@@ -1232,6 +1290,8 @@ static long kallsyms_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 	switch (cmd) {
 	case KALLSYMS_QUERY_BY_NAME:
 		return iter->show_value ? do_kallsyms_query_by_name(uarg) : -EPERM;
+	case KALLSYMS_QUERY_BY_ADDR:
+		return iter->show_value ? do_kallsyms_query_by_addr(uarg) : -EPERM;
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.56.0.679.gc527c65306-goog

