Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608047;
	b=L80/JqSvdE+wXmtsz70QD0yLQZBqASVMb3kJ0fcyNmql4r6kQR0KY+NS0lDyL1B40knR
	 2ZmtfDxhytzvvC0yK+so21bmYASKQUqkpnKzO5RM8M/IkB+7fNZ+3nqg/nhEeBOaRn/hy
	 ThoOqnTKZntiflFZTUGF5D3I2qKJMqmw6HLSKFkfFzt78t75kZ7Ii6VEqEElC6bF+zEef
	 tEuyBSHZwVmTZWOAohFjkqf2MatVEiSRA5wa10bSW3z1hNd7ATRLsHXzhRgoORvsYiM8A
	 QEP4YLSX04HIzpnDYwyAGY+SP/uqSKuZ6vDEzPCj4mixoD+Z/4uCV6XtSDI3DFVYRHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=xRGclsVYgihn8KXrg7MdwsYc+zBVAwEON65aAassTFM=;
	b=oZCNK+ZfHj72/MS1xfDBfVA6pzYj1OZjXkpKfm4tKBclDwSLEm8GQo17ZU3e3bzoQAy1
	 T7nujmHAX03cFLXxJN4OItxK1Pv9ut7i1pLnZOiS3xTBcDj1cD/w9NvaMaFmDle8kLPNQ
	 fVwZJmaBSqc9VOM2DJvoj27NACwCFOTUCnMuCrO7Z0FHwfoz+cthilZIrASy0bbLi11zv
	 0b+5paVlkuEaBTaRSBk1dtEptM2uRrSUsSWEYBL0TEUrMsNP+7aRHlTpOl04UrG6wCuVm
	 QYHNCRfb48YebRrfPMCTjCKb16qKdJAVfMSlV7CFehTW7y2RC34no4pk5zSA/6zq0XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gp5vQMux;
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EE606A891
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 22:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 796EE606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gp5vQMux
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-458326d2d9aso1826061fac.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 14:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608046; x=1795212846; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xRGclsVYgihn8KXrg7MdwsYc+zBVAwEON65aAassTFM=;
        b=gp5vQMux2ymaiEi6tOh1fDOWEJUHLLWas0pVdwpyWkI3ugCjixVnBW7K3Dj5N2smUk
         GHjoawG0WKaKqO4sSfsvHKCal3PN/B53sn2McNHh89YQOIo9c7/9TKX+u7RdsA+0qkig
         DOpj35xWtFQnN7xCdUqmaSTYJx8wUdBisznQodXYjxsDEB4U6JEfSgt7yBlrJeuRRFW6
         1oE8NzfGd7gGS9D7WLOr3kkjtM1xe1ARmQUrdMT0K4365LghPSC0X1hONAj0qXZjwcqy
         gj8Pk6KqazJAyUztxqEGZiUHtYNFFsR8GKcgf9ebC8SHoGuEcL63JfOyjx2v0uBVN64w
         CETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608046; x=1795212846;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xRGclsVYgihn8KXrg7MdwsYc+zBVAwEON65aAassTFM=;
        b=J/r75IZuS4+2NjWr3mfcW79hrVL0F3+g2E+bnkTe0KFeRF6e5yuRII3rPPYE58sURJ
         Bz0dppDqDWRLU83zh6Gw8xyT/1J2If6oNUmJJVz6meFXqDDLKVGE43tiJFwd9rQ108zr
         FqRVimYgsBHKADMaPqWk5vVdGtZ/4tDyrcq4PUFCocs9zhusnyNWH+bvfLsAV8zkuMxn
         IF0u/UQbIshddQ7Jl24JUuPgXiL82xuC58oG+uE16PULjWCe7yZrgDDzKazF+VqP+SlF
         B2gklxXCPR/zhJTc9NikN4Wp8AhpyJwypY8cTBn8Y8DRkO3r2nBfpTzGMI8aFrNr4siC
         xVnQ==
X-Forwarded-Encrypted: i=1; AL+hErE1YET/w494eO269dEVchMrjHNoRKyBwuBmH6kOa8kWgI6u+PqdEPe+rLd/6PR22rKJtk1/ipcBwgzlD1k6@vger.kernel.org
X-Gm-Message-State: APuU4Z9QNVTNS0HysXyh1PF1F+y28iy8/sTj6Q1auQ9Wc20JMCEzE23R
	e+78fQsoZRJRg8yNpgOqYH7AeAn9EQBiJG2JPBBmuMgoebDZ17uaBr8UQkvH+rW22ablIP5Tjbw
	xHQs+pmKdc9H1Lg==
X-Received: from oaoo3-n2.prod.google.com ([2002:a05:6870:c443:20b0:4ae:45bb:afee])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:c0a:b0:494:7af4:954a with SMTP id 586e51a60fabf-4afdf1706bdmr3442581fac.8.1794608045968;
 Fri, 13 Nov 2026 14:14:05 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:47 -0800
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
Message-ID: <20261113221248.3535369-13-wusamuel@google.com>
Subject: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

KALLSYMS_QUERY_BY_NAME, added later in this series, needs to find a
symbol name or prefix across module symbols in one pass.
module_get_kallsym() walks the module list from the head and runs an
export bsearch() for every symbol index.

Add module_kallsyms_find_name(), and put the shared query struct in
linux/kallsyms.h, so we have a more efficient linear walk.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 include/linux/kallsyms.h |  7 +++++
 include/linux/module.h   | 13 +++++++++
 kernel/module/kallsyms.c | 57 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index d5dd54c53ace..d31f2f436159 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -24,6 +24,13 @@
 struct cred;
 struct module;
 
+/* Exact or prefix name query, optionally in one module. */
+struct kallsyms_name_query {
+	const char *name;
+	size_t cmp_len;		/* bytes to compare; includes NUL if exact */
+	const char *modname;	/* NULL matches any module */
+};
+
 static inline int is_kernel_text(unsigned long addr)
 {
 	if (__is_kernel_text(addr))
diff --git a/include/linux/module.h b/include/linux/module.h
index 76f4f3596477..07d5a74ecfcc 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -42,6 +42,7 @@ struct modversion_info {
 
 struct module;
 struct exception_table_entry;
+struct kallsyms_name_query;
 
 struct module_kobject {
 	struct kobject kobj;
@@ -978,6 +979,10 @@ int lookup_module_symbol_attrs(unsigned long addr,
  */
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		       char *name, char *module_name, int *exported);
+int module_kallsyms_find_name(unsigned int *symnum,
+			      const struct kallsyms_name_query *q,
+			      unsigned long *value, char *name,
+			      char *module_name);
 
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
@@ -1016,6 +1021,14 @@ static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
 	return -ERANGE;
 }
 
+static inline int module_kallsyms_find_name(unsigned int *symnum,
+					    const struct kallsyms_name_query *q,
+					    unsigned long *value, char *name,
+					    char *module_name)
+{
+	return -ENOENT;
+}
+
 static inline unsigned long module_kallsyms_lookup_name(const char *name)
 {
 	return 0;
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 1ff8ce857d92..72006c9bad42 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -406,6 +406,63 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 	return -ERANGE;
 }
 
+/**
+ * module_kallsyms_find_name - Find a module symbol by name or prefix
+ * @symnum: in: index to start at; out: index of the match. The index
+ *          counts the symbols of the searched modules in list order.
+ * @q: name query; if @q->modname is set, only that module is searched
+ * @value: set to the symbol address
+ * @name: set to the symbol name (KSYM_NAME_LEN bytes)
+ * @module_name: set to the module name (MODULE_NAME_LEN bytes)
+ *
+ * Undefined (SHN_UNDEF) symbols are skipped.
+ *
+ * Return: 0 on a match, or -ENOENT.
+ */
+int module_kallsyms_find_name(unsigned int *symnum,
+			      const struct kallsyms_name_query *q,
+			      unsigned long *value, char *name,
+			      char *module_name)
+{
+	unsigned int start = *symnum;
+	unsigned int sym_base = 0;
+	struct module *mod;
+
+	guard(rcu)();
+	list_for_each_entry_rcu(mod, &modules, list) {
+		struct mod_kallsyms *kallsyms;
+		unsigned int i = 0;
+
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		if (q->modname && strcmp(q->modname, mod->name))
+			continue;
+
+		kallsyms = rcu_dereference(mod->kallsyms);
+		if (start > sym_base)
+			i = start - sym_base;
+		for (; i < kallsyms->num_symtab; i++) {
+			const Elf_Sym *sym = &kallsyms->symtab[i];
+			const char *symname = kallsyms_symbol_name(kallsyms, i);
+
+			if (sym->st_shndx == SHN_UNDEF)
+				continue;
+			if (strncmp(symname, q->name, q->cmp_len))
+				continue;
+
+			*value = kallsyms_symbol_value(sym);
+			strscpy(name, symname, KSYM_NAME_LEN);
+			strscpy(module_name, mod->name, MODULE_NAME_LEN);
+			*symnum = sym_base + i;
+			return 0;
+		}
+		if (q->modname)
+			break;
+		sym_base += kallsyms->num_symtab;
+	}
+	return -ENOENT;
+}
+
 /* Given a module and name of symbol, find and return the symbol's value */
 static unsigned long __find_kallsyms_symbol_value(struct module *mod, const char *name)
 {
-- 
2.56.0.679.gc527c65306-goog

