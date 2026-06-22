Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52A3A1E7E
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122061; cv=none; b=AneeE6IAc934/rtTnjSSf74Cf/fT+XPvyhAo6U1PllrayAwQ0fgDH6kn6yh74xN+8L9D5Wna5tRmokR6ijkC3zUvljnJNzewxbDOL90Tzj92k0wNLeX7rr0Q8O+GxdT+K1TUPkV8B3QcsnwO6pwUuPZW8KaeehnwmXLzBcNn3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122061; c=relaxed/simple;
	bh=6dZ4zYdErrEzfiYdiDusqu5liRpk/yR1ucrJzKf7SNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbnwCyNdW2CbkRE8YSWfBeGa4dLyANLedbXEmx9OBV7nQG4eIQ0ohx0nhXEOYXZFKUSIUre3Nh4CfRfU73xnUtZHB2zW8eBO26Bk9DZc0Hnjlh5HGgk4lY3sLZmQaRgM+2SLKmGvQzeQRndV5iBCiK5SaszwAKs0S69JPbGYv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=pA7DnmgH; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="pA7DnmgH"
X-KPN-MessageId: 2adeddfa-6e20-11f1-861a-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2adeddfa-6e20-11f1-861a-005056aba152;
	Mon, 22 Jun 2026 11:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=WYB+eqZtyTPDHDqFA/TVCR7NlWihAxG6DNjwFRFTBik=;
	b=pA7DnmgH6rlhfUQCpXYlI79jxsfH4rimPjNAm+HZgGflODLNdTkaX4xurSyY7FZUd2CZSvlA/3qYW
	 VGHME4+tuQ4ybG9E2W8pUC2QQScYL5igOxw9uUq0uYsZ+6OWKYGJ46ApOk5j/H7/BV3EPWAJQAEL6n
	 QiZ9DQr7F5xDg2nMlo81D7JLEjcUqTLnuAEJVj9p+5aoS9m9gIhrABljmG1dj38h89zUS0Qc4ZbWXF
	 Q3J/A5HGgZntfdXdrMZx4Qn638DNnd0bVMOMF0fOJfT8/Int4tt5xCrlQS9zxtxEWpS1BSBCGG0d6y
	 d7UaoDTawtYAZ6BNhOn3/1y1owRkGhw==
X-KPN-MID: 33|s6Wv9LN1ctw9HwwAkq60iXR8T4RFFzsoMvf18EvtivVebnxoErdXWyg+mBfQNzt
 JcB8gBRLVydk7A7QQppsb/kKHvLRMPEAu/QaKHmnyFOs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|o3S6nZtqmTOz249rQvIuKjiBhadAu4toWXmgwvxawbt1t7IkATPkQ3/os34uKRa
 X/uqlDigkjeOjG0/uek/mvQ==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2a610af9-6e20-11f1-a997-005056abf0db;
	Mon, 22 Jun 2026 11:53:06 +0200 (CEST)
Date: Mon, 22 Jun 2026 11:53:04 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: kees@kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, shuah@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: support $ORIGIN in ELF interpreter paths
Message-ID: <ajkEA0yqLhRjlJT_@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, kees@kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, shuah@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
 <20260622043934.179879-2-farid.m.zakaria@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622043934.179879-2-farid.m.zakaria@gmail.com>

Hi Farid,

On Sun, Jun 21, 2026 at 09:39:33PM -0700, Farid Zakaria wrote:
> Currently, standard ELF and ELF FDPIC loaders expect a fixed path to the
> dynamic linker/interpreter (PT_INTERP). However, for systems utilizing
> relocatable dynamic interpreters (such as Nix/store-based environments),
> hardcoding this path is inflexible and breaks binary portability.
> 
> Introduce support for resolving the $ORIGIN placeholder in the ELF
> interpreter path. This maps the dynamic linker relative to the path
> of the binary being executed, matching user-space origin resolution.
> 
> To avoid code duplication, implement a shared 'resolve_elf_interpreter()'
> helper in the VFS exec layer. For safety, limit detection strictly to
> the prefix string "$ORIGIN" to prevent complex parsing exploits.
> 
> Assisted-by: Antigravity:Gemini-Pro

This isn't a requirement from the community or anything, but I always
find it useful if I see an Assisted-by tag to know what assistence was
actually delivered by an LLM. Otherwise we might as well add
assisted-by tags for any editor.

Talking about LLMs, your patch has some issues flagged by Sashiko[1].
Please take a look.


> Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
> ---
>  fs/binfmt_elf.c         | 11 +++++++++--
>  fs/binfmt_elf_fdpic.c   | 15 +++++++++++++--
>  fs/exec.c               | 42 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/binfmts.h |  2 ++
>  4 files changed, 66 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 16a56b6b3..af11f96ae 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -872,7 +872,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  
>  	elf_ppnt = elf_phdata;
>  	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
> -		char *elf_interpreter;
> +		char *elf_interpreter, *resolved_interp;
>  
>  		if (elf_ppnt->p_type == PT_GNU_PROPERTY) {
>  			elf_property_phdata = elf_ppnt;
> @@ -904,8 +904,15 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
>  			goto out_free_interp;
>  
> -		interpreter = open_exec(elf_interpreter);
> +		resolved_interp = resolve_elf_interpreter(bprm, elf_interpreter);
>  		kfree(elf_interpreter);
> +		if (IS_ERR(resolved_interp)) {
> +			retval = PTR_ERR(resolved_interp);
> +			goto out_free_ph;
> +		}
> +
> +		interpreter = open_exec(resolved_interp);
> +		kfree(resolved_interp);
>  		retval = PTR_ERR(interpreter);
>  		if (IS_ERR(interpreter))
>  			goto out_free_ph;
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 7e3108489..e85727d71 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -230,7 +230,9 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  
>  	for (i = 0; i < exec_params.hdr.e_phnum; i++, phdr++) {
>  		switch (phdr->p_type) {
> -		case PT_INTERP:
> +		case PT_INTERP: {
> +			char *resolved_interp;
> +
>  			retval = -ENOMEM;
>  			if (phdr->p_filesz > PATH_MAX)
>  				goto error;
> @@ -259,7 +261,15 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  			kdebug("Using ELF interpreter %s", interpreter_name);
>  
>  			/* replace the program with the interpreter */
> -			interpreter = open_exec(interpreter_name);
> +			resolved_interp = resolve_elf_interpreter(bprm, interpreter_name);
> +			kfree(interpreter_name);
> +			if (IS_ERR(resolved_interp)) {
> +				retval = PTR_ERR(resolved_interp);
> +				goto error;
> +			}
> +
> +			interpreter = open_exec(resolved_interp);
> +			kfree(resolved_interp);
>  			retval = PTR_ERR(interpreter);
>  			if (IS_ERR(interpreter)) {
>  				interpreter = NULL;
> @@ -284,6 +294,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  
>  			interp_params.hdr = *((struct elfhdr *) bprm->buf);
>  			break;
> +		}
>  
>  		case PT_LOAD:
>  #ifdef CONFIG_MMU
> diff --git a/fs/exec.c b/fs/exec.c
> index b92fe7db1..0978ae613 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -2024,6 +2024,48 @@ static int __init init_fs_exec_sysctls(void)
>  fs_initcall(init_fs_exec_sysctls);
>  #endif /* CONFIG_SYSCTL */
>  
> +char *resolve_elf_interpreter(struct linux_binprm *bprm, const char *elf_interpreter)
> +{
> +	char *pathbuf, *path, *slash, *resolved;
> +
> +	if (strncmp(elf_interpreter, "$ORIGIN", 7) != 0) {
> +		char *ret = kstrdup(elf_interpreter, GFP_KERNEL);
> +
> +		return ret ? ret : ERR_PTR(-ENOMEM);
> +	}
> +
> +	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!pathbuf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	path = file_path(bprm->file, pathbuf, PATH_MAX);
> +	if (IS_ERR(path)) {
> +		kfree(pathbuf);
> +		return (char *)path;
> +	}
> +
> +	slash = strrchr(path, '/');
> +	if (slash) {
> +		if (slash == path)
> +			*(slash + 1) = '\0';
> +		else
> +			*slash = '\0';
> +	} else {
> +		kfree(pathbuf);
> +		char *ret = kstrdup(elf_interpreter, GFP_KERNEL);
> +
> +		return ret ? ret : ERR_PTR(-ENOMEM);
> +	}
> +
> +	resolved = kasprintf(GFP_KERNEL, "%s%s", path, elf_interpreter + 7);
> +	kfree(pathbuf);
> +	if (!resolved)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return resolved;
> +}
> +EXPORT_SYMBOL(resolve_elf_interpreter);
> +
>  #ifdef CONFIG_EXEC_KUNIT_TEST
>  #include "tests/exec_kunit.c"
>  #endif
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 2c77e383e..17419cd3d 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -150,4 +150,6 @@ extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
>  int kernel_execve(const char *filename,
>  		  const char *const *argv, const char *const *envp);
>  
> +char *resolve_elf_interpreter(struct linux_binprm *bprm, const char *elf_interpreter);
> +
>  #endif /* _LINUX_BINFMTS_H */
> -- 
> 2.51.2
> 

Thanks,
Jori.

[1]: https://sashiko.dev/#/patchset/20260622043934.179879-1-farid.m.zakaria%40gmail.com
