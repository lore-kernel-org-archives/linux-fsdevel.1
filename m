Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68123256C61
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103574; cv=pass; b=BYdMfUcBO5YNX9rpwiOL+LVNenVoUwnCKFBfpgBGiIirhxT4YZ5JpyoL+3lWf0PzbzkgQfqH51IEt7SfkgjRsq6Xij40SK/vO8n+MIFH99raJqImp6/HvR7n/OX0C5Ie+pPYADKyZfYCK+r76FjQdj7NnE3oPQv5KxHCkNHMW/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103574; c=relaxed/simple;
	bh=5kW7D966yJD4XNrJla9R2uSsmGdJPEDWuthJIMMyVSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrMXxGYjMl/yYUUJMABzVkHo4uFCNN1m0JXYKvzRFqM2yPtGis6Fq5RBqPp1UWjzsAOBMiPxrV5xDpiknS+p8d99BKRBzag3r2dfcx3pA6im+Y20rd1uNKo/TMQpyKz34UZyq8lB0z86780AqgW45MuJb7AaprX8aluxN3AYen0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMhEV0VP; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMhEV0VP"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-495ecb0de70so488904b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2026 11:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783103571; cv=none;
        d=google.com; s=arc-20260327;
        b=qE25wf1942M0alO7R6UUs9W3pGgnW04PXjqgDuj4pzXCrq8xDE46H+CBAeGtrBHMtZ
         Jpn7qtcrFl6FLWdNDEcIRrIpD6m7DWYIDjBv7LXGx9zADJdQHH/2UXMgEU+wAChh5xBt
         wAUy53fddxi0P4BxpsIHqDwgj+5ls7dZdlQfChuyIl4txXBnT6GxZPCnzc7/ZJbMzeh2
         bImMMmiTokZ0OG+7aoX04aSeACtEHfLC/pYC902sx2G+e4ATsLK3I3wLxJmmfMbpn3FQ
         TP7247VT0O14Hotb6/kRziP0k0nYQ+pTAqCb+SdQqfMTB7p1F6C05g142DgugVsLzy3R
         W8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jGxxuYIICA4XkrM04fmbBq4SZy/bQdrB/PRjF642fak=;
        fh=1tkRGG86lB2ew92TindWI0dnHo1cqnZwHBgEngSzgns=;
        b=If1KZGxM7UcZ+TIxdbFb4vZS0NRr3yNcNTDDqmGvW/4V2vj04FHKLmEgyrT7sFzlts
         d7/hVnHFcV8iP+3SvRIa+PQncHuSwp9aM17j8yGN8P+zNMkAEsziZvl/tX2j3yD6f+nz
         Z0Qojy7oIPOnUP4WFDCoW62v0ql3C82aG3+3wZHwrQLvCmF/IlW11FC8+NeBHbq+QI5N
         XM7fNHGuIzT03RhcLlozEeAtO9Hl/rqJ4JkWvPui9UEPProCHeQvSGWfUIMeLrnG4ley
         HS1SybE1OrHmJMJ6BW8YmLWNwQLs6VwWF42NR+7Ka9OLMColUa0RHeY2wr6W8IJ+7e/f
         Kxyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783103571; x=1783708371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jGxxuYIICA4XkrM04fmbBq4SZy/bQdrB/PRjF642fak=;
        b=PMhEV0VP7+0kMgRiKBF13pJQ02jVUYcv1+B+CzeV7GqCgsnwS+43D4qDU95YT/ouKy
         3btpAiPKNbWwr92TGZgRN/yfhGMFzdgGVkMiZj3sYGJLoGKjPUuurZzGWQvk9a5tSK+J
         q1Pp/vFpLMvbYsxs7GV8UcbDsj3W44UvLpbnTl5BxWBAddK29ZQ4rZXUfOVY3t+K9mTX
         NulnrinfrVFW/UEv1rGqjKPYQlTLNyKXEUCP8EfNaEUuUQobb4XxgCcndcVlvifRVKiE
         tZzwHm72h9GmG0dSiT/f0h5mbytWeXDpMGVpKtAE6TnDSmbJ2p3+bEcuSqy3MN3UWpXN
         XBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783103571; x=1783708371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jGxxuYIICA4XkrM04fmbBq4SZy/bQdrB/PRjF642fak=;
        b=WzEw+87HH6Ogu1mj6grcsf0sH6Mqgdp04zF1DAoJysUzZTSjCXawHDOGfHYUlE5ZKd
         hvYW2Ellex3xyp494kpHORn7bDvpq3jTp5rqqRLeIcIOoVVHyVa/NcQ1qFtV2pzFUjfJ
         ZIs0K3gj4XWy/cM0gpftO5zX7a2VP0rlJVB0unv1aMnNg2AirnK/Z3VN2rkd9g09X2Pd
         qlxdbRuUmgxgBW/g1k6oX5Y1vFZ9u1Picl1DgMRGZHG9yL7lck0Ev5I+Gu/4OydrBmu7
         lVxWnkx6Ku9twr7xK7pHrUuLQt0u7znSBQLn3cXvPTYHHWkgcA6T5edd2/vF9qlKzx6/
         E0XA==
X-Forwarded-Encrypted: i=1; AFNElJ8WwrFEybnNpRt2jiNnZ7OK7lTZ97y8wCx+ChYbmvgFUrzxBYM3f6F15Hp6KIT4yvmvYDTd+46NOj712Ddr@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyVzcXOpHz2LtUuDr3OS4cq1sdiBcxhQVJH4TSHaoBz+3QDjD
	IEGrDdzcVTFyzw3Y3ekcp59Ui6f2BQ3oVgHtNgnhRgMqieROozpwQoVCjB6hl7InWfHLP7E21MV
	ZwOKGIi30RtHxBNYnK90E9U21m0zNb9g=
X-Gm-Gg: AfdE7cmwyelRieUtSX4WNzyIh2NAvMCxX/IjaxykNhoNTTBO/ny/fCBJm4bxrLHZ4aT
	DUYgJKsy8m0+3Y96n+npG3MHRV5GAHCN+R9iqGj1QZVB57TkffSlaAeQqHkzhLGiO3GJl7ryvto
	KC2CCug/uSMmT1kIcrJRNEEtS1l3e+3IGzATIhlZqWHxTPx4l0Of/eytWDdkUNf7d3n/Xa95ZeD
	BDTgXNH7FkHyFtnDO4OKjEHVLlR+Vtbs3C2QoRM4NOv5v8MCOeyqdcwwA2HwY6w21CDpGIEMyC3
	CA1C
X-Received: by 2002:a05:6808:c145:b0:492:8920:81b7 with SMTP id
 5614622812f47-499b6477461mr229466b6e.8.1783103571184; Fri, 03 Jul 2026
 11:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630185916.5a694895@pumpkin> <20260702214247.1253741-1-farid.m.zakaria@gmail.com>
 <20260703-meditation-ratsuchende-moratorium-9ecdf1f3f8bb@brauner>
In-Reply-To: <20260703-meditation-ratsuchende-moratorium-9ecdf1f3f8bb@brauner>
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Fri, 3 Jul 2026 11:32:38 -0700
X-Gm-Features: AVVi8Cd92ozOgdmrIKRm-TUElsCXe-xdr671pT3QnWUHq6iaEWsPZ767F3i70qg
Message-ID: <CACCo2jkCFdqa1SQ_k1_42x_KYHReqcaGEScKp8ozt3FcAX7f8Q@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: introduce pluggable ELF interpreter loader registry
To: Christian Brauner <brauner@kernel.org>
Cc: david.laight.linux@gmail.com, jack@suse.cz, jannh@google.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mail@johnericson.me, 
	shuah@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 2:22=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > Introduce a pluggable framework for ELF binary loading to allow dynamic
> > resolution and redirection of program interpreters (PT_INTERP). This is
> > primarily designed to support hermetic path resolution like NixOS $ORIG=
IN
> > relative dynamic linkers without bloating the core ELF loader or compro=
mising
> > system execution security.
> >
> > Introduce a new registration interface for kernel modules to register
> > open_interpreter callbacks. Standard ELF loading queries this registry;=
 if a
> > plugin resolves a custom segment type (like PT_INTERP_NIX), it returns =
a file
> > descriptor for the resolved interpreter. Secure execution environments
> > (bprm->secureexec) bypass relative resolution for safety.
> >
> > Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
> >
> > diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> > index 1949e25c7741..ef4277fd8050 100644
> > --- a/fs/Kconfig.binfmt
> > +++ b/fs/Kconfig.binfmt
> > @@ -38,6 +38,21 @@ config BINFMT_ELF_KUNIT_TEST
> >         only needed for debugging. Note that with CONFIG_COMPAT=3Dy, th=
e
> >         compat_binfmt_elf KUnit test is also created.
> >
> > +config BINFMT_ELF_PLUGINS
> > +     bool "Enable plugin support for ELF interpreter loading"
> > +     depends on BINFMT_ELF
> > +     help
> > +       This option allows kernel modules to register handlers to dynam=
ically
> > +       resolve and override the ELF program interpreter (e.g. supporti=
ng relative
> > +       interpreter paths with $ORIGIN).
> > +
> > +config BINFMT_ELF_NIX
> > +     tristate "ELF interpreter plugin for NixOS ($ORIGIN support)"
> > +     depends on BINFMT_ELF_PLUGINS
> > +     help
> > +       This builds the NixOS ELF interpreter plugin. It intercepts PT_=
INTERP_NIX
> > +       headers to resolve relative and $ORIGIN interpreter paths.
> > +
> >  config COMPAT_BINFMT_ELF
> >       def_bool y
> >       depends on COMPAT && BINFMT_ELF
> > diff --git a/fs/Makefile b/fs/Makefile
> > index 89a8a9d207d1..bd81e7ff64f3 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -35,6 +35,7 @@ obj-$(CONFIG_FILE_LOCKING)      +=3D locks.o
> >  obj-$(CONFIG_BINFMT_MISC)    +=3D binfmt_misc.o
> >  obj-$(CONFIG_BINFMT_SCRIPT)  +=3D binfmt_script.o
> >  obj-$(CONFIG_BINFMT_ELF)     +=3D binfmt_elf.o
> > +obj-$(CONFIG_BINFMT_ELF_NIX) +=3D binfmt_elf_nix.o
> >  obj-$(CONFIG_COMPAT_BINFMT_ELF)      +=3D compat_binfmt_elf.o
> >  obj-$(CONFIG_BINFMT_ELF_FDPIC)       +=3D binfmt_elf_fdpic.o
> >  obj-$(CONFIG_BINFMT_FLAT)    +=3D binfmt_flat.o
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 16a56b6b3f6c..53fa2681555a 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/random.h>
> >  #include <linux/elf.h>
> >  #include <linux/elf-randomize.h>
> > +#include <linux/elf_plugins.h>
> >  #include <linux/utsname.h>
> >  #include <linux/coredump.h>
> >  #include <linux/sched.h>
> > @@ -870,6 +871,12 @@ static int load_elf_binary(struct linux_binprm *bp=
rm)
> >       if (!elf_phdata)
> >               goto out;
> >
> > +     interpreter =3D elf_plugin_open_interpreter(bprm, elf_ex, elf_phd=
ata);
> > +     if (IS_ERR(interpreter)) {
> > +             retval =3D PTR_ERR(interpreter);
> > +             goto out_free_ph;
> > +     }
> > +
> >       elf_ppnt =3D elf_phdata;
> >       for (i =3D 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
> >               char *elf_interpreter;
> > @@ -882,6 +889,9 @@ static int load_elf_binary(struct linux_binprm *bpr=
m)
> >               if (elf_ppnt->p_type !=3D PT_INTERP)
> >                       continue;
> >
> > +             if (interpreter)
> > +                     continue;
> > +
>
>
> >               /*
> >                * This is the program interpreter used for shared librar=
ies -
> >                * for now assume that this is an a.out format binary.
> > @@ -935,6 +945,20 @@ static int load_elf_binary(struct linux_binprm *bp=
rm)
> >               goto out_free_ph;
> >       }
> >
> > +     if (interpreter && !interp_elf_ex) {
> > +             interp_elf_ex =3D kmalloc_obj(*interp_elf_ex);
> > +             if (!interp_elf_ex) {
> > +                     retval =3D -ENOMEM;
> > +                     goto out_free_file;
> > +             }
> > +
> > +             /* Get the exec headers */
> > +             retval =3D elf_read(interpreter, interp_elf_ex,
> > +                               sizeof(*interp_elf_ex), 0);
> > +             if (retval < 0)
> > +                     goto out_free_dentry;
> > +     }
> > +
> >       elf_ppnt =3D elf_phdata;
> >       for (i =3D 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
> >               switch (elf_ppnt->p_type) {
> > diff --git a/fs/binfmt_elf_nix.c b/fs/binfmt_elf_nix.c
> > new file mode 100644
> > index 000000000000..d28b92c30939
> > --- /dev/null
> > +++ b/fs/binfmt_elf_nix.c
> > @@ -0,0 +1,108 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/fs.h>
> > +#include <linux/path.h>
> > +#include <linux/namei.h>
> > +#include <linux/elf.h>
> > +#include <linux/elf_plugins.h>
> > +#include <linux/slab.h>
> > +
> > +MODULE_DESCRIPTION("ELF Interpreter plugin for NixOS / $ORIGIN");
> > +MODULE_AUTHOR("Farid Zakaria");
> > +MODULE_LICENSE("GPL");
> > +
> > +/* Mnemonic value for NixOS-specific program interpreter: 'N', 'I', 'X=
', 3 */
> > +#define PT_INTERP_NIX  (PT_LOOS + 0x4e49583)
> > +
> > +static struct file *nix_open_interpreter(struct linux_binprm *bprm,
> > +                                      struct elfhdr *elf_ex,
> > +                                      struct elf_phdr *elf_phdata)
> > +{
> > +     struct elf_phdr *elf_ppnt;
> > +     struct file *interpreter =3D NULL;
> > +     char *elf_interpreter =3D NULL;
> > +     int i, retval;
> > +
> > +     /* Find the custom Nix interpreter header */
> > +     elf_ppnt =3D elf_phdata;
> > +     for (i =3D 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
> > +             if (elf_ppnt->p_type =3D=3D PT_INTERP_NIX)
> > +                     break;
> > +     }
>
>
> > +
> > +     if (i =3D=3D elf_ex->e_phnum)
> > +             return NULL; /* Segment not present; fall back to others =
*/
> > +
> > +     /* Security check: refuse relative interp resolution on secure ex=
ecution */
> > +     if (bprm->secureexec) {
> > +             pr_warn_once("binfmt_elf_nix: secureexec active, refusing=
 custom interpreter lookup\n");
> > +             return NULL; /* Fallback to standard PT_INTERP */
> > +     }
> > +
> > +     if (elf_ppnt->p_filesz > PATH_MAX || elf_ppnt->p_filesz < 2)
> > +             return ERR_PTR(-ENOEXEC);
> > +
> > +     elf_interpreter =3D kmalloc(elf_ppnt->p_filesz, GFP_KERNEL);
> > +     if (!elf_interpreter)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     /* Read the interpreter path from the executable file */
> > +     retval =3D kernel_read(bprm->file, elf_interpreter, elf_ppnt->p_f=
ilesz, &elf_ppnt->p_offset);
>
>
> > +     if (retval !=3D elf_ppnt->p_filesz) {
> > +             retval =3D (retval < 0) ? retval : -EIO;
> > +             goto out_free;
> > +     }
> > +
> > +     if (elf_interpreter[elf_ppnt->p_filesz - 1] !=3D '\0') {
> > +             retval =3D -ENOEXEC;
> > +             goto out_free;
> > +     }
> > +
> > +     /* Path Resolution: Absolute vs. $ORIGIN */
> > +     if (elf_interpreter[0] =3D=3D '/') {
> > +             interpreter =3D open_exec(elf_interpreter);
> > +     } else if (strncmp(elf_interpreter, "$ORIGIN/", 8) =3D=3D 0 || st=
rncmp(elf_interpreter, "${ORIGIN}/", 10) =3D=3D 0) {
> > +             const char *rel_path =3D (elf_interpreter[0] =3D=3D '$') =
? (elf_interpreter + 8) : (elf_interpreter + 10);
>
>
> > +             struct path parent_path;
> > +
> > +             /* Reference parent directory of the executed file safely=
 */
> > +             parent_path.mnt =3D mntget(bprm->file->f_path.mnt);
> > +             parent_path.dentry =3D dget_parent(bprm->file->f_path.den=
try);
> > +
> > +             /* Open relative to parent directory */
> > +             interpreter =3D file_open_root(&parent_path, rel_path, O_=
RDONLY, 0);
>
>
> > +
> > +             path_put(&parent_path);
> > +     } else {
> > +             /* Naked relative paths are rejected for safety */
> > +             retval =3D -ENOEXEC;
> > +             goto out_free;
> > +     }
> > +
> > +     kfree(elf_interpreter);
> > +     return interpreter;
> > +
> > +out_free:
> > +     kfree(elf_interpreter);
> > +     return ERR_PTR(retval);
> > +}
> > +
> > +static struct elf_plugin nix_elf_plugin =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .open_interpreter =3D nix_open_interpreter,
> > +};
> > +
> > +static int __init binfmt_elf_nix_init(void)
> > +{
> > +     return register_elf_plugin(&nix_elf_plugin);
> > +}
> > +
> > +static void __exit binfmt_elf_nix_exit(void)
> > +{
> > +     unregister_elf_plugin(&nix_elf_plugin);
> > +}
> > +
> > +module_init(binfmt_elf_nix_init);
> > +module_exit(binfmt_elf_nix_exit);
> > diff --git a/fs/exec.c b/fs/exec.c
> > index b92fe7db176c..45813bbce833 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -46,6 +46,7 @@
> >  #include <linux/key.h>
> >  #include <linux/personality.h>
> >  #include <linux/binfmts.h>
> > +#include <linux/elf_plugins.h>
> >  #include <linux/utsname.h>
> >  #include <linux/pid_namespace.h>
> >  #include <linux/module.h>
> > @@ -108,6 +109,52 @@ void unregister_binfmt(struct linux_binfmt * fmt)
> >
> >  EXPORT_SYMBOL(unregister_binfmt);
> >
> > +#if IS_ENABLED(CONFIG_BINFMT_ELF_PLUGINS)
> > +static DEFINE_MUTEX(elf_plugins_lock);
> > +static LIST_HEAD(elf_plugins);
> > +
> > +int register_elf_plugin(struct elf_plugin *plugin)
> > +{
> > +     mutex_lock(&elf_plugins_lock);
> > +     list_add_tail(&plugin->list, &elf_plugins);
> > +     mutex_unlock(&elf_plugins_lock);
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(register_elf_plugin);
> > +
> > +void unregister_elf_plugin(struct elf_plugin *plugin)
> > +{
> > +     mutex_lock(&elf_plugins_lock);
> > +     list_del(&plugin->list);
> > +     mutex_unlock(&elf_plugins_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(unregister_elf_plugin);
> > +
> > +struct file *elf_plugin_open_interpreter(struct linux_binprm *bprm,
> > +                                      struct elfhdr *elf_ex,
> > +                                      struct elf_phdr *elf_phdata)
> > +{
> > +     struct elf_plugin *plugin;
> > +     struct file *file =3D NULL;
> > +
> > +     mutex_lock(&elf_plugins_lock);
> > +     list_for_each_entry(plugin, &elf_plugins, list) {
> > +             if (!try_module_get(plugin->owner))
> > +                     continue;
> > +             mutex_unlock(&elf_plugins_lock);
> > +
> > +             file =3D plugin->open_interpreter(bprm, elf_ex, elf_phdat=
a);
>
> I have to say I do not like this at all because it also means you need
> actual kernel modules for custom binaries. Yeech.
>

Isn't this already true via binfmt for new binary formats?
ELF support in binfmt itself is also built-in from what I understand.

Anyway, I'm not too attached to the idea, I'm just trying to
brainstorm on how to get it done.

> I think you should extend binfmt_misc for that, combining it with bpf.
> When binfmt_misc selects the interpreter a bpf program is run. That bpf
> program is passed the necessary information to make a decision. It can
> check whether it's in the right sandbox. Then checks if the interpreter
> starts with the magic ORIGIN string or whatever. Once it has determined
> that a binfmt_misc entry applies things progress as usual. Then you can
> point binfmt_misc at a static binary that finds the right loader to use.
>

My audit of this shows it might be doable, but it's definitely
confusing, and I'm still not clear it solves the problem -- I will
work through an example on my NixOS machine. I think I can patch
https://github.com/nix-community/nix-ld to maybe act as this
trampoline for binfmt_misc to read PT_INTERP_NIX. I will try that and
respond back if it works conceptually at least to maybe keep the
discussion moving forward and to explore the space more.

If binfmt_misc has to point to a wrapper binary, that wrapper must
live at a fixed, hardcoded absolute path.
I guess we could bootstrap it for NixOS only but one other problem I
forsee: /proc/self/exe is now something else than expected

The entire goal of relocatability is to allow binaries to run on any
host machine without relying on global, hardcoded system paths.
Just to demo how Nix is designed to let you copy code from a machine
to another with *ideally* no assumptions.
Here is a simple hello world:

#hello.nix
with import <nixpkgs> {};
runCommandCC "hello" {} ''
  mkdir -p $out/bin
  gcc -x c -o $out/bin/hello - <<\INNER_EOF
#include <stdio.h>
int main() {
    printf("Hello, World!\n");
    return 0;
}
INNER_EOF
''

We can then build it:
> nix build -f hello.nix

My machine uses the default /nix/store prefix, so the interpreter is
set to there.
> patchelf --print-interpreter ./result/bin/hello
/nix/store/7nbi22pcc92y2fqbkyp7h3srvvklmckb-glibc-2.40-224/lib/ld-linux-x86=
-64.so.2

If I were to use a machine with a different prefix
/home/fmzakari/.local/nix then I couldn't "substitute" (download from
the cache), this binary.
I would have to build it and the whole graph down to our bootstrap
seeds with the new store prefix.

Nix then let's us then query the graph and copy it, including ld.so
and glibc to any other machine to ideally run.

> nix-store --query --tree $(realpath result)
/nix/store/adbwpmzwgdcmk5qcskyqwygmxbkffb32-hello
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80/nix/store/7nbi22pcc92y2fqbkyp7h3srvvkl=
mckb-glibc-2.40-224
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80/nix/store/fv5lgysa3hmf3l3d=
kkpwvndcg6xwhy8m-xgcc-14.3.0-libgcc
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80/nix/store/qywg7bxskvihq62m=
s2g51fkzkrdnyfkh-libidn2-2.3.8
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80/nix/store/hjwp=
pd89fk8781xl4r35xqlddwqi5f66-libunistring-1.4.1
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80=E2=94=80/ni=
x/store/hjwppd89fk8781xl4r35xqlddwqi5f66-libunistring-1.4.1
[...]
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80=E2=94=80/nix/store/qywg=
7bxskvihq62ms2g51fkzkrdnyfkh-libidn2-2.3.8 [...]
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80=E2=94=80/nix/store/7nbi22pcc92y2fqb=
kyp7h3srvvklmckb-glibc-2.40-224 [...]
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80/nix/store/ybp235ps7m4yd85v0pgvqkhd4xmx=
f6jq-gcc-14.3.0-lib
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80/nix/store/7nbi22pcc92y2fqb=
kyp7h3srvvklmckb-glibc-2.40-224 [...]
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80/nix/store/phpq5h7cp6y1w84a=
ysy29548irqy5dd9-gcc-14.3.0-libgcc
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80=E2=94=80/nix/store/ybp235ps7m4yd85v=
0pgvqkhd4xmxf6jq-gcc-14.3.0-lib [...]
=E2=94=94=E2=94=80=E2=94=80=E2=94=80/nix/store/adbwpmzwgdcmk5qcskyqwygmxbkf=
fb32-hello [...]

I appreciate you engaging me on this topic -- thank you.

> --
> Christian Brauner <brauner@kernel.org>
