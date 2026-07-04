Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B52E7393;
	Sat,  4 Jul 2026 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783152917; cv=none; b=duzIvLIxgX7uypcZ9bo5U28exhNYgUioIlSouqjKw4DCNbVdtJQD/T+7NjuyDJpDUWLtuqFzWRRUekaky7E6x16APYwx0zDl8czLYyizhrngnWeETR4vNo6kQG2AmaqotsPn1XV0zh/nDmgBjMUVWGFVv/4lt5gqGQT7HyfpH6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783152917; c=relaxed/simple;
	bh=aQ02crgCZAJDLjoIKy7OXQyHMlWcCg5rlozXxxQU8b4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=nv4RBKgkZiIR8L2gQJ/jCXpIFd//l1jwHyydyk3DxxPwzUxsvnFpz2J03jgAAMROymJiBgiAlTu+w3F2E0Z9cHe7vUjrwwCZ0Zia5oAbCa3e9Qdcg08WSpx/QtZMk6KxQZh4WTIWyTHdAbm/APGztIoqqfqOu49TtCXOGXonMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brbZmBO3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brbZmBO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDFC1F000E9;
	Sat,  4 Jul 2026 08:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783152913;
	bh=JcM3qzvM9CE9LUyEh5ejys738a9htxavEeDrNfu9Niw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=brbZmBO3khc8Rn0RhlAD2f3zxhQ8Lk54FRrWJ3o40CxMzEvbtszZAgjYKug9KI+R1
	 D4QmcNO9liS+83syZdlE8AW2H/ad+hZVNdF5jT5Llr0Q8DZ2UqV5R5FjyRFBLvXtNe
	 DV4ocmsVy3DDslVyb15H19+APdI4Y2ziYUYDDLA8sK/Vxm5xBnrKhy646yEUFtAcVs
	 KENJgDPpLE6kCzy5FmwfyE9NxfV3+pkIAT/T5QXohbCqaJ/eoxNYD/GsPt1NM1ut2z
	 sOYg0Egm9DlLlWsZ+jN0uYNQDMeOBTy3IFFgkWTY+NtdrTBUdrnL17Ca1tE1NFlPIw
	 xUedqTzahARWQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH] fs: introduce pluggable ELF interpreter loader
 registry
From: Christian Brauner <brauner@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, david.laight.linux@gmail.com, 
 jack@suse.cz, jannh@google.com, kees@kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mail@johnericson.me, 
 shuah@kernel.org, viro@zeniv.linux.org.uk
In-Reply-To: <CACCo2jkCFdqa1SQ_k1_42x_KYHReqcaGEScKp8ozt3FcAX7f8Q@mail.gmail.com>
References: <20260630185916.5a694895@pumpkin>
 <20260702214247.1253741-1-farid.m.zakaria@gmail.com>
 <20260703-meditation-ratsuchende-moratorium-9ecdf1f3f8bb@brauner>
 <CACCo2jkCFdqa1SQ_k1_42x_KYHReqcaGEScKp8ozt3FcAX7f8Q@mail.gmail.com>
Date: Sat, 04 Jul 2026 10:15:07 +0200
Message-Id: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=14470; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aQ02crgCZAJDLjoIKy7OXQyHMlWcCg5rlozXxxQU8b4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR5HOQNLW+6LuYw5/iVR0dY7hzbnO62NTVU0/VcjNajq
 556Mw1/d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwksZvhf+IzqeC5PinGM2Zm
 HZqnf2pCmtbKjsBuSf/deixJdxX/JjMyNH+LW3z62KmHb5l+XFV03L1urby26c8CJUv28tCql9W
 BbAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-03 11:32 -0700, Farid Zakaria wrote:
> On Fri, Jul 3, 2026 at 2:22 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > Introduce a pluggable framework for ELF binary loading to allow dynamic
> > > resolution and redirection of program interpreters (PT_INTERP). This is
> > > primarily designed to support hermetic path resolution like NixOS $ORIGIN
> > > relative dynamic linkers without bloating the core ELF loader or compromising
> > > system execution security.
> > >
> > > Introduce a new registration interface for kernel modules to register
> > > open_interpreter callbacks. Standard ELF loading queries this registry; if a
> > > plugin resolves a custom segment type (like PT_INTERP_NIX), it returns a file
> > > descriptor for the resolved interpreter. Secure execution environments
> > > (bprm->secureexec) bypass relative resolution for safety.
> > >
> > > Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
> > >
> > > diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> > > index 1949e25c7741..ef4277fd8050 100644
> > > --- a/fs/Kconfig.binfmt
> > > +++ b/fs/Kconfig.binfmt
> > > @@ -38,6 +38,21 @@ config BINFMT_ELF_KUNIT_TEST
> > >         only needed for debugging. Note that with CONFIG_COMPAT=y, the
> > >         compat_binfmt_elf KUnit test is also created.
> > >
> > > +config BINFMT_ELF_PLUGINS
> > > +     bool "Enable plugin support for ELF interpreter loading"
> > > +     depends on BINFMT_ELF
> > > +     help
> > > +       This option allows kernel modules to register handlers to dynamically
> > > +       resolve and override the ELF program interpreter (e.g. supporting relative
> > > +       interpreter paths with $ORIGIN).
> > > +
> > > +config BINFMT_ELF_NIX
> > > +     tristate "ELF interpreter plugin for NixOS ($ORIGIN support)"
> > > +     depends on BINFMT_ELF_PLUGINS
> > > +     help
> > > +       This builds the NixOS ELF interpreter plugin. It intercepts PT_INTERP_NIX
> > > +       headers to resolve relative and $ORIGIN interpreter paths.
> > > +
> > >  config COMPAT_BINFMT_ELF
> > >       def_bool y
> > >       depends on COMPAT && BINFMT_ELF
> > > diff --git a/fs/Makefile b/fs/Makefile
> > > index 89a8a9d207d1..bd81e7ff64f3 100644
> > > --- a/fs/Makefile
> > > +++ b/fs/Makefile
> > > @@ -35,6 +35,7 @@ obj-$(CONFIG_FILE_LOCKING)      += locks.o
> > >  obj-$(CONFIG_BINFMT_MISC)    += binfmt_misc.o
> > >  obj-$(CONFIG_BINFMT_SCRIPT)  += binfmt_script.o
> > >  obj-$(CONFIG_BINFMT_ELF)     += binfmt_elf.o
> > > +obj-$(CONFIG_BINFMT_ELF_NIX) += binfmt_elf_nix.o
> > >  obj-$(CONFIG_COMPAT_BINFMT_ELF)      += compat_binfmt_elf.o
> > >  obj-$(CONFIG_BINFMT_ELF_FDPIC)       += binfmt_elf_fdpic.o
> > >  obj-$(CONFIG_BINFMT_FLAT)    += binfmt_flat.o
> > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > index 16a56b6b3f6c..53fa2681555a 100644
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -35,6 +35,7 @@
> > >  #include <linux/random.h>
> > >  #include <linux/elf.h>
> > >  #include <linux/elf-randomize.h>
> > > +#include <linux/elf_plugins.h>
> > >  #include <linux/utsname.h>
> > >  #include <linux/coredump.h>
> > >  #include <linux/sched.h>
> > > @@ -870,6 +871,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
> > >       if (!elf_phdata)
> > >               goto out;
> > >
> > > +     interpreter = elf_plugin_open_interpreter(bprm, elf_ex, elf_phdata);
> > > +     if (IS_ERR(interpreter)) {
> > > +             retval = PTR_ERR(interpreter);
> > > +             goto out_free_ph;
> > > +     }
> > > +
> > >       elf_ppnt = elf_phdata;
> > >       for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
> > >               char *elf_interpreter;
> > > @@ -882,6 +889,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
> > >               if (elf_ppnt->p_type != PT_INTERP)
> > >                       continue;
> > >
> > > +             if (interpreter)
> > > +                     continue;
> > > +
> >
> >
> > >               /*
> > >                * This is the program interpreter used for shared libraries -
> > >                * for now assume that this is an a.out format binary.
> > > @@ -935,6 +945,20 @@ static int load_elf_binary(struct linux_binprm *bprm)
> > >               goto out_free_ph;
> > >       }
> > >
> > > +     if (interpreter && !interp_elf_ex) {
> > > +             interp_elf_ex = kmalloc_obj(*interp_elf_ex);
> > > +             if (!interp_elf_ex) {
> > > +                     retval = -ENOMEM;
> > > +                     goto out_free_file;
> > > +             }
> > > +
> > > +             /* Get the exec headers */
> > > +             retval = elf_read(interpreter, interp_elf_ex,
> > > +                               sizeof(*interp_elf_ex), 0);
> > > +             if (retval < 0)
> > > +                     goto out_free_dentry;
> > > +     }
> > > +
> > >       elf_ppnt = elf_phdata;
> > >       for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
> > >               switch (elf_ppnt->p_type) {
> > > diff --git a/fs/binfmt_elf_nix.c b/fs/binfmt_elf_nix.c
> > > new file mode 100644
> > > index 000000000000..d28b92c30939
> > > --- /dev/null
> > > +++ b/fs/binfmt_elf_nix.c
> > > @@ -0,0 +1,108 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +#include <linux/module.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/init.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/path.h>
> > > +#include <linux/namei.h>
> > > +#include <linux/elf.h>
> > > +#include <linux/elf_plugins.h>
> > > +#include <linux/slab.h>
> > > +
> > > +MODULE_DESCRIPTION("ELF Interpreter plugin for NixOS / $ORIGIN");
> > > +MODULE_AUTHOR("Farid Zakaria");
> > > +MODULE_LICENSE("GPL");
> > > +
> > > +/* Mnemonic value for NixOS-specific program interpreter: 'N', 'I', 'X', 3 */
> > > +#define PT_INTERP_NIX  (PT_LOOS + 0x4e49583)
> > > +
> > > +static struct file *nix_open_interpreter(struct linux_binprm *bprm,
> > > +                                      struct elfhdr *elf_ex,
> > > +                                      struct elf_phdr *elf_phdata)
> > > +{
> > > +     struct elf_phdr *elf_ppnt;
> > > +     struct file *interpreter = NULL;
> > > +     char *elf_interpreter = NULL;
> > > +     int i, retval;
> > > +
> > > +     /* Find the custom Nix interpreter header */
> > > +     elf_ppnt = elf_phdata;
> > > +     for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
> > > +             if (elf_ppnt->p_type == PT_INTERP_NIX)
> > > +                     break;
> > > +     }
> >
> >
> > > +
> > > +     if (i == elf_ex->e_phnum)
> > > +             return NULL; /* Segment not present; fall back to others */
> > > +
> > > +     /* Security check: refuse relative interp resolution on secure execution */
> > > +     if (bprm->secureexec) {
> > > +             pr_warn_once("binfmt_elf_nix: secureexec active, refusing custom interpreter lookup\n");
> > > +             return NULL; /* Fallback to standard PT_INTERP */
> > > +     }
> > > +
> > > +     if (elf_ppnt->p_filesz > PATH_MAX || elf_ppnt->p_filesz < 2)
> > > +             return ERR_PTR(-ENOEXEC);
> > > +
> > > +     elf_interpreter = kmalloc(elf_ppnt->p_filesz, GFP_KERNEL);
> > > +     if (!elf_interpreter)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     /* Read the interpreter path from the executable file */
> > > +     retval = kernel_read(bprm->file, elf_interpreter, elf_ppnt->p_filesz, &elf_ppnt->p_offset);
> >
> >
> > > +     if (retval != elf_ppnt->p_filesz) {
> > > +             retval = (retval < 0) ? retval : -EIO;
> > > +             goto out_free;
> > > +     }
> > > +
> > > +     if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0') {
> > > +             retval = -ENOEXEC;
> > > +             goto out_free;
> > > +     }
> > > +
> > > +     /* Path Resolution: Absolute vs. $ORIGIN */
> > > +     if (elf_interpreter[0] == '/') {
> > > +             interpreter = open_exec(elf_interpreter);
> > > +     } else if (strncmp(elf_interpreter, "$ORIGIN/", 8) == 0 || strncmp(elf_interpreter, "${ORIGIN}/", 10) == 0) {
> > > +             const char *rel_path = (elf_interpreter[0] == '$') ? (elf_interpreter + 8) : (elf_interpreter + 10);
> >
> >
> > > +             struct path parent_path;
> > > +
> > > +             /* Reference parent directory of the executed file safely */
> > > +             parent_path.mnt = mntget(bprm->file->f_path.mnt);
> > > +             parent_path.dentry = dget_parent(bprm->file->f_path.dentry);
> > > +
> > > +             /* Open relative to parent directory */
> > > +             interpreter = file_open_root(&parent_path, rel_path, O_RDONLY, 0);
> >
> >
> > > +
> > > +             path_put(&parent_path);
> > > +     } else {
> > > +             /* Naked relative paths are rejected for safety */
> > > +             retval = -ENOEXEC;
> > > +             goto out_free;
> > > +     }
> > > +
> > > +     kfree(elf_interpreter);
> > > +     return interpreter;
> > > +
> > > +out_free:
> > > +     kfree(elf_interpreter);
> > > +     return ERR_PTR(retval);
> > > +}
> > > +
> > > +static struct elf_plugin nix_elf_plugin = {
> > > +     .owner = THIS_MODULE,
> > > +     .open_interpreter = nix_open_interpreter,
> > > +};
> > > +
> > > +static int __init binfmt_elf_nix_init(void)
> > > +{
> > > +     return register_elf_plugin(&nix_elf_plugin);
> > > +}
> > > +
> > > +static void __exit binfmt_elf_nix_exit(void)
> > > +{
> > > +     unregister_elf_plugin(&nix_elf_plugin);
> > > +}
> > > +
> > > +module_init(binfmt_elf_nix_init);
> > > +module_exit(binfmt_elf_nix_exit);
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index b92fe7db176c..45813bbce833 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -46,6 +46,7 @@
> > >  #include <linux/key.h>
> > >  #include <linux/personality.h>
> > >  #include <linux/binfmts.h>
> > > +#include <linux/elf_plugins.h>
> > >  #include <linux/utsname.h>
> > >  #include <linux/pid_namespace.h>
> > >  #include <linux/module.h>
> > > @@ -108,6 +109,52 @@ void unregister_binfmt(struct linux_binfmt * fmt)
> > >
> > >  EXPORT_SYMBOL(unregister_binfmt);
> > >
> > > +#if IS_ENABLED(CONFIG_BINFMT_ELF_PLUGINS)
> > > +static DEFINE_MUTEX(elf_plugins_lock);
> > > +static LIST_HEAD(elf_plugins);
> > > +
> > > +int register_elf_plugin(struct elf_plugin *plugin)
> > > +{
> > > +     mutex_lock(&elf_plugins_lock);
> > > +     list_add_tail(&plugin->list, &elf_plugins);
> > > +     mutex_unlock(&elf_plugins_lock);
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(register_elf_plugin);
> > > +
> > > +void unregister_elf_plugin(struct elf_plugin *plugin)
> > > +{
> > > +     mutex_lock(&elf_plugins_lock);
> > > +     list_del(&plugin->list);
> > > +     mutex_unlock(&elf_plugins_lock);
> > > +}
> > > +EXPORT_SYMBOL_GPL(unregister_elf_plugin);
> > > +
> > > +struct file *elf_plugin_open_interpreter(struct linux_binprm *bprm,
> > > +                                      struct elfhdr *elf_ex,
> > > +                                      struct elf_phdr *elf_phdata)
> > > +{
> > > +     struct elf_plugin *plugin;
> > > +     struct file *file = NULL;
> > > +
> > > +     mutex_lock(&elf_plugins_lock);
> > > +     list_for_each_entry(plugin, &elf_plugins, list) {
> > > +             if (!try_module_get(plugin->owner))
> > > +                     continue;
> > > +             mutex_unlock(&elf_plugins_lock);
> > > +
> > > +             file = plugin->open_interpreter(bprm, elf_ex, elf_phdata);
> >
> > I have to say I do not like this at all because it also means you need
> > actual kernel modules for custom binaries. Yeech.
> >
> 
> Isn't this already true via binfmt for new binary formats?
> ELF support in binfmt itself is also built-in from what I understand.
> 
> Anyway, I'm not too attached to the idea, I'm just trying to
> brainstorm on how to get it done.
> 
> > I think you should extend binfmt_misc for that, combining it with bpf.
> > When binfmt_misc selects the interpreter a bpf program is run. That bpf
> > program is passed the necessary information to make a decision. It can
> > check whether it's in the right sandbox. Then checks if the interpreter
> > starts with the magic ORIGIN string or whatever. Once it has determined
> > that a binfmt_misc entry applies things progress as usual. Then you can
> > point binfmt_misc at a static binary that finds the right loader to use.
> >
> 
> My audit of this shows it might be doable, but it's definitely
> confusing, and I'm still not clear it solves the problem -- I will
> work through an example on my NixOS machine. I think I can patch
> https://github.com/nix-community/nix-ld to maybe act as this
> trampoline for binfmt_misc to read PT_INTERP_NIX. I will try that and
> respond back if it works conceptually at least to maybe keep the
> discussion moving forward and to explore the space more.
> 
> If binfmt_misc has to point to a wrapper binary, that wrapper must
> live at a fixed, hardcoded absolute path.
> I guess we could bootstrap it for NixOS only but one other problem I
> forsee: /proc/self/exe is now something else than expected
> 
> The entire goal of relocatability is to allow binaries to run on any
> host machine without relying on global, hardcoded system paths.
> Just to demo how Nix is designed to let you copy code from a machine
> to another with *ideally* no assumptions.
> Here is a simple hello world:
> 
> #hello.nix
> with import <nixpkgs> {};
> runCommandCC "hello" {} ''
>   mkdir -p $out/bin
>   gcc -x c -o $out/bin/hello - <<\INNER_EOF
> #include <stdio.h>
> int main() {
>     printf("Hello, World!\n");
>     return 0;
> }
> INNER_EOF
> ''
> 
> We can then build it:
> > nix build -f hello.nix
> 
> My machine uses the default /nix/store prefix, so the interpreter is
> set to there.
> > patchelf --print-interpreter ./result/bin/hello
> /nix/store/7nbi22pcc92y2fqbkyp7h3srvvklmckb-glibc-2.40-224/lib/ld-linux-x86-64.so.2
> 
> If I were to use a machine with a different prefix
> /home/fmzakari/.local/nix then I couldn't "substitute" (download from
> the cache), this binary.

This was just an example. The bpf program can calculate a path however
it sees fit including making use of ORIGIN or whatever.

