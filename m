Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987DA377ABB
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601694; cv=pass; b=PCM/AyXy4Ei17wP1aJ3hUkWVusX4hNqpiROg9nsI21tGT2VzyRdB8BGieCYA5ThCW2qlaC0hvoCssCX4eV6WK8irNZmylhQxYgwCM2XSPdcXVS/j68WvGO8qCP7eJM3KaUgXl/OJ3WVWKmbkThXfqmF1XqOXUtS8dWIPuT9Icxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601694; c=relaxed/simple;
	bh=AhPdWam+MmDkim0rHFIqc0fVyLI3SCTIPl3Q617vj+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utaR5yAoIvOI0q8PSh3UQKlnb5E0L0CMT7UOn89RhJqWS/T94ucl0R32FxmdSYvYpd1K3Yks5PcVLuzhtZw51Y1dd8hkWyBIAWQjdQ2hTBwccpmHoqU3+sqWmJJn7KzhAeln77uh3ynU/8NWxVLXrp7kRKV4CAJ11uM+QL0oPAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blkq5EBa; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blkq5EBa"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc149372c14so2851576a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 13:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787601692; cv=none;
        d=google.com; s=arc-20260327;
        b=VR7gLgZS6QLirXtCbxanqhFO3OswPiIJpYFi+q0DoPSVrhaIP0LRWYx5K5hixZF0+B
         To+keEP71qtj6lBUlNNpSwLWjUSF31i+b3T3mTcl1LSzdMpIIUGQe6peQs6tBgCkgZDZ
         1gVaIebj+zHpeGgGRK3dUcNB9qktKROL9n1tPo/evj74iPyF41Yk0xISkTsSzFkhC6b2
         TwbQoiuPGGxE/9NDYt4upUQY6USKI1emOLYFNbKLhhAVAmAohpGPbmzBnq9lBRwo6tyM
         pcGCxvSInYVUIlVbMb4n8YmWtfSsCtEeQyUalHn89RRkaoPrL7DXzJ5qjpuin4b0bR9T
         OZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3YYVbHmzYNMo9iR3w7Aron4iVAyXE98ecr/hPSAyXc4=;
        fh=2doYdVS1WbRE52CxxS/RY9VXOHVoNVJuUAg4H7SUsBc=;
        b=ZnfzLUgOjVHzd3DaTyLZ9yOubtGD0Psf5t3qZgPWlDu3oSCjGkxJLtbYCpqDtJ87Kc
         SWePt14D4N9sT9VM1lWDXu1s+a+vBCBnJvw6cXkUKUQBBUXXeCb3cJjKoOO+PICXcrMe
         WzGaJ1E2ApVz6CLbhZAH6wOL1GfD6gdwf3xhEG/q+3cwdVFNBJUMC04L0R+6e65xr5fo
         ye3Lo1Jgkl4BCZrmoF4nBu+FYuiaHiYfmDrU162QXFAj6bo3p/JH2VCEvkV2DehtXg1X
         GRon9+F34XQr7YimqVv+1Iu4P04OD1Q4oX+nsYY68dzYXDuBXgqvPluTv1dnzF+pXzTv
         At0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787601692; x=1788206492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3YYVbHmzYNMo9iR3w7Aron4iVAyXE98ecr/hPSAyXc4=;
        b=blkq5EBa9yljjXGU1+8Qj4MaRDfO6c/hN81r8AOVCBlW8n01Nk2S8vCfNomdSBocfU
         i3Bhe34yWDhH+J623x53PrNpt1qaZX5fz0yuEyV4ZyzVc1YZRSQKYUeyHMcoa51FfZVZ
         Us/7q5jFlQ9BvReI0yyb3xrN7tTEzySaZGncFvPn1ZY9tSgmuJc73Xa4dyBY50U54w1J
         xps22D2xa14Tkv5kp8YQSBGSHCbcsjgB7n0AX2At4zxnDx4nh0h1OnuGEG7iTGnuYITi
         QDiAwRoWJCGEPjF8iG/06+hmbzf/OGGx/2VkgaTxXhEXX0ZZf2DeFUbPYFppfvZvJ6Sr
         mzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787601692; x=1788206492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3YYVbHmzYNMo9iR3w7Aron4iVAyXE98ecr/hPSAyXc4=;
        b=D5f6NBQP8ti+fM409/wsPOsxLo4ccFuL/75cg5z8KKxYV/UyAK4Cpfo3F6zGB7//O5
         0ZhXRDggMSomJzLfUHmYMjlBF74/pSoRNKOEo1LEe+peCrAcZDlU4jVRUW/sMK8QNelg
         hd3uQohbtiM7fzgQs8E4RfbnKlIHDkjii9njKv5WosVdHQobKsBE4WW5aUtUlaTAG2Kt
         Gx3EPvwQY75Ze0mm/lESNoKFJWw9zSg513gIrZW0zOU1gcGUQd/7KN3CsL1+bXQAw4fa
         vb+b86oAY+p9WgQnK7qiLOHsE2VddOOvVsLtI/O6vBeY670bSbTR1MLNHa+auvhfl+me
         56Pw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0uPsJDL9/F3qZeizdnPDnIkZQNjQV0D+OkdV3TBWfFvQaOfLFR/XDXgZzsPMGwxD0unOIrr+tAy7ndo17@vger.kernel.org
X-Gm-Message-State: AFuF++nIEEg1mLnE7vZVHi6NXwD541G30TaDGexpIsKX+upJeBvFOAS1
	7+eWWOouh5i1iwrm8L3tEaECslS6kHxb63Yy1Ox0f4GsjV0rGwAehWHugXDi3L4MOmaFHbTng+y
	Bi9sWzXDUx1XgkU8UsOviy4MMWgHtH2E=
X-Gm-Gg: AR+sD12RkkOzVapt7r4i9dA4fGXrUknJIyRIqIlrAvLxsFvpvVJlAXi5DomoDgl2R9w
	PfOgiAM7ZF3v0yw7u3CWxtYmoNBeRm+T61SaeeJc1js9b2cI77Zb3rmPXNWIz4GeXqwoGPQfait
	wbmMS17oKs3zkQy1UH9tX3pIjqqlRlpyWub0qqfx5XwjDPeUr0rUNDMYyg1zLGlRTe75yJoks6N
	fiIbR1TQ5UMPUYDIYsgoL0UQbQtKRbIO3WBlgkHx6bq1hpOr/BKacJVwVNirOAJ/RWamPSjQYP4
	4T9uySz3lhKuyhob2yeeArmJi9egjpFS4onQABO2PtO6PkjW3tfDQyz5wwGoLUGah90FmEJLSfT
	fpMThqyZapefznrcc6JgdW4Yuug/eaZ/izlGq20EQdA==
X-Received: by 2002:a05:6a21:3381:b0:3cc:841d:bb26 with SMTP id
 adf61e73a8af0-3cd913240damr2559487637.15.1787601691946; Mon, 24 Aug 2026
 13:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzZTM5SehNnM83U3Kj0cz=NN=JwUtG-pcvSHdvZBsHdM3g@mail.gmail.com>
 <20260824104930.83453-1-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260824104930.83453-1-tasos.papagiannnis@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Aug 2026 13:01:15 -0700
X-Gm-Features: AcwNN1VRJvQsJzFSZeK4Dv3vlANYJItg-44_okx_VAvveMLZt9tyHGMAHD-LhsE
Message-ID: <CAEf4Bzb9szFTDo5uUxLgUVD3qA1XF-5A7GZGxJjX6d1MYLhbFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add user memory access kfuncs for linux_binprm
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, brauner@kernel.org, daniel@iogearbox.net, 
	david@kernel.org, eddyz87@gmail.com, kpsingh@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, matt@bobrowski.net, memxor@gmail.com, song@kernel.org, 
	utilityemal77@gmail.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 3:49=E2=80=AFAM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> Thanks for the review!
>
> > making this linux_binprm-specific seems short-sighted and overly
> > specialized, why not pass `const struct mm *` and call new kfuncs
> > bpf_copy_from_user_mm[_str] ?
>
> > and this seems to belong right next to bpf_copy_from_user_task_str()
> > and others in kernel/bpf/helpers.c (and bpf_copy_from_user_task
> > variants should just delegate to this mm-based APIs and minimize code
> > duplication)
>
> This is exactly what I did in my previous set of patches:
> https://lore.kernel.org/bpf/20260811112154.94053-1-tasos.papagiannnis@gma=
il.com/T/
> https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1144046&sta=
te=3D*
> https://sashiko.dev/#/patchset/20260811112154.94053-1-tasos.papagiannnis%=
40gmail.com
> https://github.com/kernel-patches/bpf/pull/13211
>
> where I got AI reviews with 2 main issues:
>
> 1.  Does marking bprm->mm as trusted-or-null here create a use-after-free
>     vulnerability on the execve error path?
>     Looking at free_bprm() in fs/exec.c, when an error occurs:
>     fs/exec.c:free_bprm() {
>         ...
>         if (bprm->mm) {
>             acct_arg_size(bprm, 0);
>             mmput(bprm->mm);
>         }
>         ...
>     }
>     The object is freed via mmput(), but the bprm->mm pointer is not set =
to NULL.
>     Could subsequent traceable cleanup functions (such as free_arg_pages)=
 expose
>     this dangling reference to BPF programs, bypassing the verifier's saf=
ety
>     guarantees?
>
> This is something that I believe is easy to fix.
>
> 2.  Does this break the BPF load-compatibility guarantee documented in
>     Documentation/bpf/bpf_design_QA.rst?
>
>     Before this patch, walking bprm->mm produced a dereferenceable regist=
er
>     in every program type. In sleepable programs, in_rcu_cs() is false, s=
o
>     check_ptr_to_btf_access() sets flag =3D PTR_UNTRUSTED. In non-sleepab=
le
>     programs, in_rcu_cs() is true but mm is not in any __safe_rcu* list, =
so
>     clear_trusted_flags() produces a plain PTR_TO_BTF_ID.
>
>     Both PTR_TO_BTF_ID and PTR_TO_BTF_ID|PTR_UNTRUSTED satisfy the guard =
in
>     check_mem_access():
>
>     } else if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID &&
>                 !type_may_be_null(reg->type)) {
>             err =3D check_ptr_to_btf_access(env, regs, reg, argno, off, s=
ize, t,
>                                             value_regno);
>
>     so bprm->mm->arg_start loads with no NULL check.
>
>     After this patch, btf_nested_type_is_trusted() matches
>     linux_binprm__safe_trusted_or_null.mm, so check_ptr_to_btf_access() s=
ets
>     flag |=3D PTR_TRUSTED | PTR_MAYBE_NULL. Now type_may_be_null() is tru=
e, the
>     arm above is skipped, and control falls to the final else:
>
>     } else {
>             verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env=
, argno),
>                     reg_type_str(env, reg->type));
>             return -EACCES;
>     }
>
>     Any existing program that reads through bprm->mm without an explicit =
NULL
>     check now fails bpf_prog_load() with -EACCES.
>
> This sounds to me a bit more complicated. In a prog attached to lsm/secur=
ity_bprm_check,
> bprm is trusted but bprm->mm is not trusted. So we need a way to have bpr=
m->mm trusted
> to pass it as an argument to the helpers. In that series, I marked linux_=
binprm->mm as
> trusted-or-null, which breaks all existing programs that use
> linux_binprm->mm->something.

this is probably ok, but also we might want to look into having
verifier still allow to dereference trusted ptr-or-null into untrusted
ptr_to_btf_id to help with smooth transitions like this.

Not sure how complicated that would be in the verifier, but that would
be a nice backwards compat preserving behavior.

But to keep things simple today, I'd just mark that bprm->mm pointer
as TRUSTED_OR_NULL.

>
> Another approach would be to add one more kfunc (i.e. bpf_get_bprm_mm) to=
 get
> the mm from bprm and have it trusted.

sound quite specialized, but I don't have a strong opinion

>
> The reason that I didn't push that further was that mm in general is
> bound to either linux_binprm or task_struct during its lifetime. We alrea=
dy
> have helpers for task_struct, and I thought that adding helpers for linux=
_binprm
> would be enough. Other than that, there is only one security_*() function=
 that
> takes mm_struct as an argument (i.e. security_vm_enough_memory_mm), and p=
ossibly
> in that case we do not need to read the memory contents, but only metadat=
a
> (possibly I am oversimplifying here, but this is to show my thinking).
>
> Unless I am missing something obvious, I can see two possible approaches =
here:
>   1. Keep the bprm-specific kfuncs as they are now.

no, I think that's a bad idea

>   2. Rework this around the mm variants that you proposed and add one
>      more kfunc (i.e. bpf_get_bprm_mm) to make that work.
>
> Does the second approach sound reasonable to you?

yes

>
> Thanks,
> Anastasios
