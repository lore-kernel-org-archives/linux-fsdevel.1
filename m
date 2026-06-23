Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0604395ACB;
	Tue, 23 Jun 2026 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245676; cv=none; b=KZ6fIK8cqS05txYoDlYs/fGdAkp2Y++IzCiC9vG8FiRefoPBaRdbCnRQU6t0fwbWbTgpoqx4n+oMi76eozgDeRBhuQa54Dy7+OyFf42GKPh06VghqVfRUZ0wNUVTLCjPWBOrcWMI1PWNOsupdqQV2KDOtpriB+G4nIM9hpGzuh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245676; c=relaxed/simple;
	bh=+NGHr3JwJhFyeVqNLHlK3enumdKIlg00Zx4KtBXAj6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5OgTBunzPoPJshGSQsKGBYdFSuPHwSx+LBAzI2dgxNLnXn8dbYdJ+XPb6fJKyc/A96VJ1sqKgGvYA3de6KjYg5anWd23PZZ9f5qpwh+zpW8PlrCMcnotKveuDSri7nGOGG52Dv0a8J7Qr6fKYJHqbnu6ATZYWvB/9yem8w6vmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJAZRpdB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJAZRpdB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB461F00A3A;
	Tue, 23 Jun 2026 20:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782245674;
	bh=Ra1bLWv4R1sxRHDql8Lrgj/OtpZzKuZ/JFVnOfvRwes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZJAZRpdBwWufrpjPgspdDTMpomP3SINRtHl8ZOxMtF3PzVz1QwLXUZTwQeAf+uol9
	 1eIpnqZcQyu2eA9WuB6vdOXm9HrjZdTgIPf+GrfrgLo8/1h8rMn/j5yDRNaQWYcg1z
	 SoHVXI9jcgMMPfJkeYwgC4Aatt17v9Hrbt5Q4aTLYVl0YHTUn9K219XN/LW5EzZI0y
	 B0d5t1wmHvNPJk9v6TNFwFUo5f4iAyISIUYJYHJhlyOkJaw1/mmdsfWGo5L315qei/
	 YFO0TfeLjSI4hSuiUWmQa08cUvaJ9yIlXFnzTK6RlmVc+HJmDya/kd/485ShKYpsJz
	 AZUK1DyLQaYzA==
Date: Tue, 23 Jun 2026 13:14:34 -0700
From: Kees Cook <kees@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	shuah@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: support $ORIGIN in ELF interpreter paths
Message-ID: <202606231236.325C882A78@keescook>
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

Does any other OS that implements ELF support also support $ORIGIN in
the loader? $ORIGIN isn't even part of the ELF spec at all and is a
glibc extension, IIUC.

I'm not excited about path-based string manipulations as they end up
being racy, and mucking with loader path seems like we're inviting
trouble (since the _binary_ specifies setuid-ness), and we've seen
issues with $ORIGIN before, even strictly outside of the kernel:
https://seclists.org/fulldisclosure/2010/Oct/257

> [...]
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

But even if we did take this, I really don't want to incur a universal
penalty on exec for it. This is doing a kmalloc+dup (and later kfree)
for all non-$ORIGIN execs. So even if this gets added, it needs to be
handled differently.

I would probably say this helper should return a struct file * instead
and have a fast-path for the common case. I think a check for leading
'$' (if strncmp doesn't get inlined) would be okay here as far as
"incurring common performance cost"; that string is almost certainly
cache-hot.

> +	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!pathbuf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	path = file_path(bprm->file, pathbuf, PATH_MAX);
> +	if (IS_ERR(path)) {
> +		kfree(pathbuf);
> +		return (char *)path;
> +	}

This still just _feels_ like an info leak or a race condition to me. I
can't give a credible example, though. But it creeps me out. :)
(I note the blog post also says "and the shabang" and I get even more
creeped out about seeing that patch.)

> +
> +	slash = strrchr(path, '/');
> +	if (slash) {
> +		if (slash == path)
> +			*(slash + 1) = '\0';

This is not idiomatic string manipulation.

> +		else
> +			*slash = '\0';

More readable, IMO, as:

	if (slash)
		slash[1] = '\0';
	else
		path = "";

But does this match the glibc resolution logic? i.e. should it be:

	if (strncmp(elf_interpreter, "$ORIGIN/", 8) != 0)
	...
	if (!slash)
		slash = path;
	*slash = '\0';
	...
	resolved = kasprintf(GFP_KERNEL, "%s/%s", path, elf_interpreter + 8);

(requires the trailing /)

> +	} else {
> +		kfree(pathbuf);
> +		char *ret = kstrdup(elf_interpreter, GFP_KERNEL);
> +
> +		return ret ? ret : ERR_PTR(-ENOMEM);

This is the same as the logic top of the function. This repetition smells
of the LLM. :)

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

So, I guess, I'd like more convincing, but I'm very happy to see a KUnit
test included!

-Kees

-- 
Kees Cook
