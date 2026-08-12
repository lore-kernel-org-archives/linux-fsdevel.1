Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663C381E8C
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786560028; cv=none; b=MF3gX+/JM/HJN2y33tsuy9kzo5ql2nArnY5CJ+14zGzjysjxaF7v49Abt+levJPIGWduCi2Me8pXuQk+Wf8xtAuPz4WaZUMNqCJPifkqTvCNk8CRf6Fyk+yrK95TRaaaTujARujZCNFLbSrbUWkUwqxlbZ3tnPLG0QAhnqHKa0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786560028; c=relaxed/simple;
	bh=g4HJm8vBdf8AJN8t0j5W2ay0U/JrsXuXYHTvGcAEmw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB8zd/DkP5VjImTZI9VhxpEejCkOxJvZuaRokuJWjkzHcGtCp7f9qtWJtaQea4FrPmr7hPn2kglioCtvMAGIUuwNyTU4vnHCJAqnShXqB7C2Kbp/fmBM9vPE2AwmBf94ivhSQrLHP/jIynxfD32PYSBAcdRQ06gRX4+OokPFcD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiT9XWM+; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiT9XWM+"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-668296d0ff3so2174858d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786560025; x=1787164825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sKggjgOfMYzIGeOhc+tmd9M/20f2SVgkeM+/VOJ2kP0=;
        b=jiT9XWM+iCnboTN7gVq6zNqe6RxPnTRL09dM74jLnn6sgMFhN7YyFJENC/h1YHh7Nb
         cg6/UzJuDdh/GiphJI9E1OYKM9bBP30a5VGOpF11rs/N5gl8va5drbUy+ouLMvJ9jhCR
         IDjwiiKv/pgz/KFmROFuuCdvIJkY568KdOYvJigL1TAFhR0xWFU4y0BxNpaBRqVfHtoL
         CuGDZcJQrkfG8kEoyYn2XHTgecXno4kwMJ5kqpNGBwTLTNQ3iiDkSmRwa/ZbKV6KJHiY
         GsmMNTmFYT8qwYGTqSyQGeddj3BwaE1hRIci/Icj/h4J9Qg1eqM8MXbWkobhoM/p24fa
         IqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786560025; x=1787164825;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKggjgOfMYzIGeOhc+tmd9M/20f2SVgkeM+/VOJ2kP0=;
        b=sIIpgPQimbbM4z/eDbtEhhTm14d1f+zOECJ/1C3b3dBXvknH8nbzROaUnKtlkh1/N9
         IWxl9zwLvYWvmSjTb+PXBWfIeIPptGCw2u/Pqg2+9gU9/VsOqOZl/PlWPUVikmsO3IMm
         dz0jaM1fwDqg02ocgAZMWgSX5ABvYcrRJJ8pHy8CYmPcYRG4a2hwu6lRNtZzYFO1yzk3
         sWp3OH5p1YKOpZ6LmzliBT4OzHmzvBA+UUyo0kEurgpeAD4tTxSy3tQ57rbBWNslY8zd
         77PIzR8m1k0ArCZft8iu9i9WJ1vBwulwDPpVp0uuz1n/+B2Wp1lgURzTEAErRzhhcYR+
         yl1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp/wKGEcu4zXVh8iwHg3xzI3Yu/J2/IoFKXcdn75/sytU99ItyIHMH12THEoL7jhuTuwr1OchX9C7AAiRxH@vger.kernel.org
X-Gm-Message-State: AOJu0YzkrTjKK2ko+RSyxWLTjdkswYKlSZc8OlXoHxboicoGWVqg2Dql
	Jy5Sw9D9gaZK7R7lzWH86UGyNEJHM0AJRJYBLYrPnqWyd/47lEiS0C0O
X-Gm-Gg: AR+sD10dchUtXiwX3dlmX1EMLi/UnW5UHBb/HDAjTjg+tZDX9/1ut43Z9zNybkHYOpg
	m3Gp9/2vvi1iJBUaooed6FXHpWOSuI7sCX0WUZtsbCWSzkNj5gw4snpn0dv8Y+zpehEpdwoObfq
	nqLAGnveIQS2RAaAk/jbSYzSjArAXThKH+poskcEEL6ZGuRfIUMYJX+VI5nkQs7Czv+X4o1sYd5
	NMBWhtkOatsifu/fBJSw3CDUF0zWEe2hvXkSZXZ9PCOk4C4hlf5tWDIvAM2GQZgk7cEzS6E+htu
	8UvxLgg2Aqb0nFgzHhk1RxI9TD4/SjxgERAaLijokiv6JUmnwnlqyS8leE5xEdghQBojMs0Zvh6
	4AgXVimY5SQUETJXOaBzm1ufFfPXFfvyLTyFqk+eCOxaFh/kLJtuc/LC8m6pkTYfiR8l3HxSEQf
	srBaPU7zIYbO3W8BlCVzV6Eg1yyPEESeQjpl1FIeRZK6PCkRleKzKXRPxM+pozrQJhUMUWvlMxL
	XCPl743iZdHiyWgcy6qlw==
X-Received: by 2002:a05:690e:15d4:b0:66c:4937:d319 with SMTP id 956f58d0204a3-66c517f3293mr140199d50.46.1786560024796;
        Wed, 12 Aug 2026 11:40:24 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:3077:a5d:da73:f5b4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c4f16adc9sm324552d50.10.2026.08.12.11.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:40:24 -0700 (PDT)
Date: Wed, 12 Aug 2026 14:40:23 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kpsingh@kernel.org, 
	matt@bobrowski.net, song@kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf: Add user memory access kfuncs for
 linux_binprm
Message-ID: <any3wCj66dWbwgwT@zenbox>
References: <20260812111140.7762-1-tasos.papagiannnis@gmail.com>
 <20260812111140.7762-3-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812111140.7762-3-tasos.papagiannnis@gmail.com>

On Wed, Aug 12, 2026 at 02:11:39PM +0300, Anastasios Papagiannis wrote:
> When security_bprm_check runs, the arg and env strings for the exec have
> been copied into bprm->mm. The new address space has not been associated
> yet with a task_struct until exec_mmap(), so existing BPF user memory
> helpers can only read from the calling task's old address space.
> 
> This patch adds bpf_copy_from_user_bprm() and
> bpf_copy_from_user_bprm_str() kfuncs. Both use the mm_struct provided by
> struct linux_binprm.
> 
> Register these kfuncs only when CONFIG_MMU is enabled. On NOMMU systems,
> exec arguments are staged in bprm->page[] rather than mapped in bprm->mm,
> so these accessors cannot read them.
Would it be better to handle that case transparently rather than
requiring introducing a new kfunc / leaving that gap open for NOMMU?

Either return an error or perform the copy from bprm->page[].

Unless there's some reason I'm not seeing.

It would also be better for portability across NOMMU / CONFIG_MMU
systems (the exisiting kfunc is never registered, so a program using it
would be rejected rather than able to handle the error).
> 
> bpf_copy_from_user_bprm() has similar semantics as
> bpf_copy_from_user_task(). bpf_copy_from_user_bprm_str() copies one
> NUL-terminated string and returns its size including the NUL terminator.
> It accepts BPF_F_PAD_ZEROS to clear unused destination bytes on success.
> 
> This patch registers both kfuncs with KF_SLEEPABLE because accessing the
> remote address space can fault. This allows BPF LSM programs attached to
> security_bprm_check to read arguments beginning at bprm->p and reject an
> exec based on its command-line arguments.
> 
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---

These patches are nice, I would like a feature like this.

(useful for security tools needing to make a decision based on
env/arguments as you said).

>  fs/bpf_fs_kfuncs.c | 112 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index f1863a891db6..74befdadad68 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2024 Google LLC. */
>  
> +#include <linux/binfmts.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/btf.h>
> @@ -379,6 +380,112 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
>  	return d_real_inode(file_dentry(file));
>  }
>  
> +/**
> + * bpf_copy_from_user_bprm - Copy data from a binary parameter address space
> + * @dst:             Destination address, in kernel space
> + * @dst__sz:         Number of bytes to copy
> + * @unsafe_ptr__ign: Source address in the binary parameter address space
> + * @bprm:            Binary parameters whose address space will be used
> + * @flags:           Reserved for future use; must be zero
> + *
> + * Copies data from the nascent address space associated with @bprm. This is
> + * useful for reading the argument and environment strings before the new
> + * address space is installed by exec_mmap(). For example, at the
> + * bprm_check_security LSM hook, @bprm->p points at the first argument string.
> + *
> + * The destination is zeroed if the requested number of bytes cannot be copied
> + * in full.
> + *
> + * Return: 0 on success, -EINVAL if @flags is non-zero, or -EFAULT if the copy
> + * fails or is partial.
> + */
> +__bpf_kfunc int bpf_copy_from_user_bprm(void *dst, u32 dst__sz,
> +					const void __user *unsafe_ptr__ign,
> +					const struct linux_binprm *bprm, u64 flags)
> +{
> +	struct mm_struct *mm;
> +	int ret;
> +
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	if (unlikely(!dst__sz))
> +		return 0;
> +
> +	mm = bprm->mm;
> +	if (!mm) {
> +		memset(dst, 0, dst__sz);
> +		return -EFAULT;
> +	}
> +
> +	ret = access_remote_vm(mm, (unsigned long)unsafe_ptr__ign,
> +			       dst, dst__sz, 0);
> +	if (ret != dst__sz) {
> +		memset(dst, 0, dst__sz);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * bpf_copy_from_user_bprm_str - Copy a string from binary parameter memory
> + * @dst:             Destination address, in kernel space. This buffer must be
> + *                   at least @dst__sz bytes long
> + * @dst__sz:         Maximum number of bytes to copy, including the trailing NUL
> + * @unsafe_ptr__ign: Source address in the binary parameter address space
> + * @bprm:            Binary parameters whose address space will be used
> + * @flags:           The only supported flag is BPF_F_PAD_ZEROS
> + *
> + * Copies a NUL-terminated string from the nascent address space associated
> + * with @bprm. If the string is too long, @dst is still NUL-terminated unless
> + * @dst__sz is zero.
> + *
> + * If BPF_F_PAD_ZEROS is set, the unused portion of @dst is cleared on success
> + * and all of @dst is cleared on failure.
> + *
> + * Return: The number of copied bytes including the NUL terminator on success,
> + * or a negative error code on failure.
> + */
> +__bpf_kfunc int bpf_copy_from_user_bprm_str(void *dst, u32 dst__sz,
> +					    const void __user *unsafe_ptr__ign,
> +					    const struct linux_binprm *bprm,
> +					    u64 flags)
> +{
> +	struct mm_struct *mm;
> +	int ret;
> +
> +	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
> +		return -EINVAL;
> +
> +	if (unlikely(!dst__sz))
> +		return 0;
> +
> +	mm = bprm->mm;
> +	if (!mm) {
> +		if (flags & BPF_F_PAD_ZEROS)
> +			memset(dst, 0, dst__sz);
> +		else
> +			*(char *)dst = '\0';
> +
> +		return -EFAULT;
> +	}
> +
> +	ret = copy_remote_mm_str(mm, (unsigned long)unsafe_ptr__ign,
> +				 dst, dst__sz, 0);
> +	if (ret < 0) {
> +		if (flags & BPF_F_PAD_ZEROS)
> +			memset(dst, 0, dst__sz);
> +
> +		return ret;
> +	}
> +
> +	if (flags & BPF_F_PAD_ZEROS)
> +		memset(dst + ret, 0, dst__sz - ret);
> +
> +	return ret + 1;
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -390,6 +497,11 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
> +#ifdef CONFIG_MMU
> +/* NOMMU keeps the staged arguments in bprm->page[], not bprm->mm. */
> +BTF_ID_FLAGS(func, bpf_copy_from_user_bprm, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_bprm_str, KF_SLEEPABLE)
> +#endif
See above, you may be able to handle the NOMMU case and get rid of this
awkward ifdef block / verifier rejection.

Code looks correct otherwise.

Justin
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>  
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
> -- 
> 2.55.0
> 
