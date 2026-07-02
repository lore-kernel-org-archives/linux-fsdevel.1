Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDB38C2AA
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028592; cv=none; b=Xt97IUYFEvFekiaCd1Aq1zRXFr6F6EmyxkBnkvDq3EEbPEsW14qUYvj2Wal3NTA2ctc7JMgshaTj0m6QMT4J0A3ZWhhRnERFNqfkM3gGMwfEuAh+Z00deLp/upO9ZipdSZanlBF5Vb5MZukpzkehXCEWfDTOAz5Xvx4cGP0ADdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028592; c=relaxed/simple;
	bh=c4uPFLu2AEPbWYOKvIhrlVNSBdCuIyz0lFpcDkOeT/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8/wICbPENceprauDbVRpFBJefz76uisK+PRxApON9lalqfhTgw5eV4nwxgZsrzy1prmSOE38DyM5CTL+HIwRERJAo1jXlcAQQ9unsGLLDqHSDMCNzx7GNFu2nVt68DO8yCSd423J7w10XmlePU9y+xm3btzWltV4pobOT8GsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx1JyQ+n; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx1JyQ+n"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8894387780so1259527a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783028590; x=1783633390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQmnbToj2uNt+38fsrDHgZM8w5YoOu6ycBL01BwfMxY=;
        b=Sx1JyQ+nA+eSkqANprsy27OPMdecDj2RxUyOigRM3/kkLELgjIVJSUPyICXjxVUGoV
         XNliEKPw1WC56yA0phoL1hJpoMbMJVCGVT0FBBLBPdfzgn4umEktOzz1JBH8sNt1aGZv
         iDyEUaon1eMaHy+4W5DqA8Z5K8F5ZydfWBhr/SlXXHMV9ilRQH4PRA0DhURfw0z2GMwq
         OSp06bDo0TEnkYXmaV2e8LTB3H0uqrhLIu+gZvIulYcGxpGKJLTa0seFJoYFRyF7iJXT
         Lu/r5xxnuaDp+HW8S8KK4PN0EOSo1yh9xmnEa24qW0sv1VxlzdwM2vq98mbWTZfrVXZC
         3FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783028590; x=1783633390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FQmnbToj2uNt+38fsrDHgZM8w5YoOu6ycBL01BwfMxY=;
        b=rUeKjnyBzfXpIbrUaxMYsl+QYkY5YUmQ0hyE5xZth7kMJdAY5U+Jt0M14Rp28tvvPP
         UjZXyj+o0/XMuVxQ3Q7zSWSf2twbEAVGPSo5TTiGVNnQe+u7xeDvIf5+KvJCuki87qVl
         LDCh5tSLAZvmjUpzpUGqx80u9LYdn0y2EvvAH209Hsn1Vgh2HpjyaDzBm+uImfa5b2rC
         rcpbiv5FJEvoZRRh0tpB1ztyjPyl7TpWoH2EUk8Y8HoPhWsEpml/5CFpSsX/WOX/lZUr
         t0vHcj4AdG3Sa1zCa4yu//fxGj1bJijEWkJMN+GAgpiyBkid3meAZj++EPMKvAWF523x
         IeFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SS8lh2hBaVSk8FL3aEICIv+2jtpfa74BnxQ7vEGroj/6sa5prFRftPLA0Nw9qFpgCSnutDUZnGjPHGpM8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9FKaVuQTTqf/WiC6tvGdlYP7S2dH+86q94Dgo7FSV8Nyx7ULk
	n6WoeL8iJhVVQAgxOvHvyei5UmrjSDx4EHQVUP9jq8BpOgqVznSUG/fD
X-Gm-Gg: AfdE7cmSAsDdltb6J34Cp14ceJG1zU22RinvZgzEX58uxtzBCPawADHaNJRaNDoQC9Y
	jrJAXvYdcPOGYVoz87NAaYjCr/3dhdPolpT3JxJU5ieUx3LVduLyZ+xt9J2w9YCn0z7eUKOrBX2
	Lhm9Jag2Q2vZwsqAGes/27gDnC8PGMi8DYBvPQx2yT43ouYhCJbkTo3tWYVhitA8yBOXNfVPOME
	KWHAyLIYzi794uvzHg8QE38Zmu4PFa9wRGLPtRwcM67Sj9AxMIUf6Xov7ib/GN/6pV5IR2/88TU
	nScBm9VRuoIEiQp05dTKPhDjcsaMs9IUhzbK+0A/FvU6TuURrhDYnWeA24159j5CP8wpvOznK7Y
	LdrbqVl0zhxA51j4JAL84msXObstZVtjb8Co7PrDoAYRgU+Jo0DbuU7noMqA/zyGtCYTExZUm+I
	aoZqCQdHS1ihwR7hItxln/LixfQjA=
X-Received: by 2002:a05:6a20:2d23:b0:3b3:1b38:d9d6 with SMTP id adf61e73a8af0-3bff4255e0emr7781388637.39.1783028589316;
        Thu, 02 Jul 2026 14:43:09 -0700 (PDT)
Received: from nyx.tail25a6.ts.net ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84405sm18270279eec.17.2026.07.02.14.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 14:43:08 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: david.laight.linux@gmail.com
Cc: brauner@kernel.org,
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
	viro@zeniv.linux.org.uk
Subject: [RFC PATCH] fs: introduce pluggable ELF interpreter loader registry
Date: Thu,  2 Jul 2026 14:42:47 -0700
Message-ID: <20260702214247.1253741-1-farid.m.zakaria@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260630185916.5a694895@pumpkin>
References: <20260630185916.5a694895@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a pluggable framework for ELF binary loading to allow dynamic
resolution and redirection of program interpreters (PT_INTERP). This is
primarily designed to support hermetic path resolution like NixOS $ORIGIN
relative dynamic linkers without bloating the core ELF loader or compromising
system execution security.

Introduce a new registration interface for kernel modules to register
open_interpreter callbacks. Standard ELF loading queries this registry; if a
plugin resolves a custom segment type (like PT_INTERP_NIX), it returns a file
descriptor for the resolved interpreter. Secure execution environments
(bprm->secureexec) bypass relative resolution for safety.

Assisted-by: Gemini
Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---

Hey Christian,

Here is a rough draft of what I thought something could look like for a pluggable ELF interpreter loader.
I've included the relocatable loader in the patch but this can be out-of-tree if needed; it's also named
"Nix" to distinguish the need for it. 

I chose to read from a distinct segment type (PT_INTERP_NIX) to avoid backwards incompatibility.

The default loader itself could be a plugin similar to binfmt_elf, but for now I wanted the patch
to be small to demonstrate the concept.

 fs/Kconfig.binfmt           |  15 +++++
 fs/Makefile                 |   1 +
 fs/binfmt_elf.c             |  24 ++++++++
 fs/binfmt_elf_nix.c         | 108 ++++++++++++++++++++++++++++++++++++
 fs/exec.c                   |  47 ++++++++++++++++
 include/linux/elf_plugins.h |  39 +++++++++++++
 6 files changed, 234 insertions(+)
 create mode 100644 fs/binfmt_elf_nix.c
 create mode 100644 include/linux/elf_plugins.h

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 1949e25c7..ef4277fd8 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -38,6 +38,21 @@ config BINFMT_ELF_KUNIT_TEST
 	  only needed for debugging. Note that with CONFIG_COMPAT=y, the
 	  compat_binfmt_elf KUnit test is also created.
 
+config BINFMT_ELF_PLUGINS
+	bool "Enable plugin support for ELF interpreter loading"
+	depends on BINFMT_ELF
+	help
+	  This option allows kernel modules to register handlers to dynamically
+	  resolve and override the ELF program interpreter (e.g. supporting relative
+	  interpreter paths with $ORIGIN).
+
+config BINFMT_ELF_NIX
+	tristate "ELF interpreter plugin for NixOS ($ORIGIN support)"
+	depends on BINFMT_ELF_PLUGINS
+	help
+	  This builds the NixOS ELF interpreter plugin. It intercepts PT_INTERP_NIX
+	  headers to resolve relative and $ORIGIN interpreter paths.
+
 config COMPAT_BINFMT_ELF
 	def_bool y
 	depends on COMPAT && BINFMT_ELF
diff --git a/fs/Makefile b/fs/Makefile
index 89a8a9d20..bd81e7ff6 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_FILE_LOCKING)      += locks.o
 obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
 obj-$(CONFIG_BINFMT_SCRIPT)	+= binfmt_script.o
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
+obj-$(CONFIG_BINFMT_ELF_NIX)	+= binfmt_elf_nix.o
 obj-$(CONFIG_COMPAT_BINFMT_ELF)	+= compat_binfmt_elf.o
 obj-$(CONFIG_BINFMT_ELF_FDPIC)	+= binfmt_elf_fdpic.o
 obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat.o
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 16a56b6b3..53fa26815 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -35,6 +35,7 @@
 #include <linux/random.h>
 #include <linux/elf.h>
 #include <linux/elf-randomize.h>
+#include <linux/elf_plugins.h>
 #include <linux/utsname.h>
 #include <linux/coredump.h>
 #include <linux/sched.h>
@@ -870,6 +871,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (!elf_phdata)
 		goto out;
 
+	interpreter = elf_plugin_open_interpreter(bprm, elf_ex, elf_phdata);
+	if (IS_ERR(interpreter)) {
+		retval = PTR_ERR(interpreter);
+		goto out_free_ph;
+	}
+
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
 		char *elf_interpreter;
@@ -882,6 +889,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (elf_ppnt->p_type != PT_INTERP)
 			continue;
 
+		if (interpreter)
+			continue;
+
 		/*
 		 * This is the program interpreter used for shared libraries -
 		 * for now assume that this is an a.out format binary.
@@ -935,6 +945,20 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out_free_ph;
 	}
 
+	if (interpreter && !interp_elf_ex) {
+		interp_elf_ex = kmalloc_obj(*interp_elf_ex);
+		if (!interp_elf_ex) {
+			retval = -ENOMEM;
+			goto out_free_file;
+		}
+
+		/* Get the exec headers */
+		retval = elf_read(interpreter, interp_elf_ex,
+				  sizeof(*interp_elf_ex), 0);
+		if (retval < 0)
+			goto out_free_dentry;
+	}
+
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
 		switch (elf_ppnt->p_type) {
diff --git a/fs/binfmt_elf_nix.c b/fs/binfmt_elf_nix.c
new file mode 100644
index 000000000..d28b92c30
--- /dev/null
+++ b/fs/binfmt_elf_nix.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/path.h>
+#include <linux/namei.h>
+#include <linux/elf.h>
+#include <linux/elf_plugins.h>
+#include <linux/slab.h>
+
+MODULE_DESCRIPTION("ELF Interpreter plugin for NixOS / $ORIGIN");
+MODULE_AUTHOR("Farid Zakaria");
+MODULE_LICENSE("GPL");
+
+/* Mnemonic value for NixOS-specific program interpreter: 'N', 'I', 'X', 3 */
+#define PT_INTERP_NIX  (PT_LOOS + 0x4e49583)
+
+static struct file *nix_open_interpreter(struct linux_binprm *bprm,
+					 struct elfhdr *elf_ex,
+					 struct elf_phdr *elf_phdata)
+{
+	struct elf_phdr *elf_ppnt;
+	struct file *interpreter = NULL;
+	char *elf_interpreter = NULL;
+	int i, retval;
+
+	/* Find the custom Nix interpreter header */
+	elf_ppnt = elf_phdata;
+	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
+		if (elf_ppnt->p_type == PT_INTERP_NIX)
+			break;
+	}
+
+	if (i == elf_ex->e_phnum)
+		return NULL; /* Segment not present; fall back to others */
+
+	/* Security check: refuse relative interp resolution on secure execution */
+	if (bprm->secureexec) {
+		pr_warn_once("binfmt_elf_nix: secureexec active, refusing custom interpreter lookup\n");
+		return NULL; /* Fallback to standard PT_INTERP */
+	}
+
+	if (elf_ppnt->p_filesz > PATH_MAX || elf_ppnt->p_filesz < 2)
+		return ERR_PTR(-ENOEXEC);
+
+	elf_interpreter = kmalloc(elf_ppnt->p_filesz, GFP_KERNEL);
+	if (!elf_interpreter)
+		return ERR_PTR(-ENOMEM);
+
+	/* Read the interpreter path from the executable file */
+	retval = kernel_read(bprm->file, elf_interpreter, elf_ppnt->p_filesz, &elf_ppnt->p_offset);
+	if (retval != elf_ppnt->p_filesz) {
+		retval = (retval < 0) ? retval : -EIO;
+		goto out_free;
+	}
+
+	if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0') {
+		retval = -ENOEXEC;
+		goto out_free;
+	}
+
+	/* Path Resolution: Absolute vs. $ORIGIN */
+	if (elf_interpreter[0] == '/') {
+		interpreter = open_exec(elf_interpreter);
+	} else if (strncmp(elf_interpreter, "$ORIGIN/", 8) == 0 || strncmp(elf_interpreter, "${ORIGIN}/", 10) == 0) {
+		const char *rel_path = (elf_interpreter[0] == '$') ? (elf_interpreter + 8) : (elf_interpreter + 10);
+		struct path parent_path;
+
+		/* Reference parent directory of the executed file safely */
+		parent_path.mnt = mntget(bprm->file->f_path.mnt);
+		parent_path.dentry = dget_parent(bprm->file->f_path.dentry);
+
+		/* Open relative to parent directory */
+		interpreter = file_open_root(&parent_path, rel_path, O_RDONLY, 0);
+
+		path_put(&parent_path);
+	} else {
+		/* Naked relative paths are rejected for safety */
+		retval = -ENOEXEC;
+		goto out_free;
+	}
+
+	kfree(elf_interpreter);
+	return interpreter;
+
+out_free:
+	kfree(elf_interpreter);
+	return ERR_PTR(retval);
+}
+
+static struct elf_plugin nix_elf_plugin = {
+	.owner = THIS_MODULE,
+	.open_interpreter = nix_open_interpreter,
+};
+
+static int __init binfmt_elf_nix_init(void)
+{
+	return register_elf_plugin(&nix_elf_plugin);
+}
+
+static void __exit binfmt_elf_nix_exit(void)
+{
+	unregister_elf_plugin(&nix_elf_plugin);
+}
+
+module_init(binfmt_elf_nix_init);
+module_exit(binfmt_elf_nix_exit);
diff --git a/fs/exec.c b/fs/exec.c
index b92fe7db1..45813bbce 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -46,6 +46,7 @@
 #include <linux/key.h>
 #include <linux/personality.h>
 #include <linux/binfmts.h>
+#include <linux/elf_plugins.h>
 #include <linux/utsname.h>
 #include <linux/pid_namespace.h>
 #include <linux/module.h>
@@ -108,6 +109,52 @@ void unregister_binfmt(struct linux_binfmt * fmt)
 
 EXPORT_SYMBOL(unregister_binfmt);
 
+#if IS_ENABLED(CONFIG_BINFMT_ELF_PLUGINS)
+static DEFINE_MUTEX(elf_plugins_lock);
+static LIST_HEAD(elf_plugins);
+
+int register_elf_plugin(struct elf_plugin *plugin)
+{
+	mutex_lock(&elf_plugins_lock);
+	list_add_tail(&plugin->list, &elf_plugins);
+	mutex_unlock(&elf_plugins_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_elf_plugin);
+
+void unregister_elf_plugin(struct elf_plugin *plugin)
+{
+	mutex_lock(&elf_plugins_lock);
+	list_del(&plugin->list);
+	mutex_unlock(&elf_plugins_lock);
+}
+EXPORT_SYMBOL_GPL(unregister_elf_plugin);
+
+struct file *elf_plugin_open_interpreter(struct linux_binprm *bprm,
+					 struct elfhdr *elf_ex,
+					 struct elf_phdr *elf_phdata)
+{
+	struct elf_plugin *plugin;
+	struct file *file = NULL;
+
+	mutex_lock(&elf_plugins_lock);
+	list_for_each_entry(plugin, &elf_plugins, list) {
+		if (!try_module_get(plugin->owner))
+			continue;
+		mutex_unlock(&elf_plugins_lock);
+
+		file = plugin->open_interpreter(bprm, elf_ex, elf_phdata);
+
+		mutex_lock(&elf_plugins_lock);
+		module_put(plugin->owner);
+		if (file)
+			break;
+	}
+	mutex_unlock(&elf_plugins_lock);
+	return file;
+}
+#endif
+
 static inline void put_binfmt(struct linux_binfmt * fmt)
 {
 	module_put(fmt->module);
diff --git a/include/linux/elf_plugins.h b/include/linux/elf_plugins.h
new file mode 100644
index 000000000..826a32854
--- /dev/null
+++ b/include/linux/elf_plugins.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_ELF_PLUGINS_H
+#define _LINUX_ELF_PLUGINS_H
+
+#include <linux/binfmts.h>
+#include <linux/elf.h>
+#include <linux/list.h>
+
+struct elf_plugin {
+	struct list_head list;
+	struct module *owner;
+	struct file *(*open_interpreter)(struct linux_binprm *bprm,
+					 struct elfhdr *elf_ex,
+					 struct elf_phdr *elf_phdata);
+};
+
+#if IS_ENABLED(CONFIG_BINFMT_ELF_PLUGINS)
+int register_elf_plugin(struct elf_plugin *plugin);
+void unregister_elf_plugin(struct elf_plugin *plugin);
+struct file *elf_plugin_open_interpreter(struct linux_binprm *bprm,
+					 struct elfhdr *elf_ex,
+					 struct elf_phdr *elf_phdata);
+#else
+static inline int register_elf_plugin(struct elf_plugin *plugin)
+{
+	return 0;
+}
+static inline void unregister_elf_plugin(struct elf_plugin *plugin)
+{
+}
+static inline struct file *elf_plugin_open_interpreter(struct linux_binprm *bprm,
+						       struct elfhdr *elf_ex,
+						       struct elf_phdr *elf_phdata)
+{
+	return NULL;
+}
+#endif
+
+#endif /* _LINUX_ELF_PLUGINS_H */
-- 
2.51.2

