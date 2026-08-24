Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193703F4DC2
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568599; cv=none; b=c51VHrh4xN2slYl+AibOC+ES6v9Tx2b6Gzcaz1eABmrXITVMlOatTr71dcIo9AiYCpTA8jgbSpB0BVdFRzHt9fUZzAaJMH4CTJm234CoijtmgcNPGMGIYvE18+vLjTE9eCe1NZqWgSerKvNMVqng0PsAKH5kq9aphFEXr9MWUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568599; c=relaxed/simple;
	bh=9/5FmTiNUNjJFDcgH5TqdZlD6TMa0N0OQTmCfTGJzbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hbxsf7R+9ose0+UlVERnK0G0oTk6giykHytEOZQfQaZurF1ValGRwZYMpE5YrtF+lc3pzOBzArVsKOrB63CdyftAZn9GhH1jqJqfx9uwmfmxEsYByQzIsGfUm/AkTjmhwI2K7oHHTGKYDcDQPip1Fx3i6nNV8rcy5ZGI8kgdEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNqtlhIl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNqtlhIl"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c197e7e4e94so586340166b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787568596; x=1788173396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nOd8+4g2mnunbTTjfkzCI8WvVdyCHxk83j5KrKNRFdg=;
        b=iNqtlhIlX7p9KvhuZlW+Yqi46IQu3N8hGulfoHBax2dGORT9oLq8ElIoezjSD/2RGC
         WBOT1zXWPb4pp1Qn8XiFxjkGnAF5zV8KgDdzlDKORVvTXWGUkMrM/f0MkgZRYN1Uj+tk
         THIdma38C4c0BUO9Bm36IHaEUKEune9Q+bGb12z747QwlWKUa5r29lq5e/8AwI38/GO9
         feCo6IU7xXC2kdRwsAYaePzbkDsz8DU5qCf/kV3h5I/Lg9fGlNL2L9hzg0+HFajKJWwh
         E5bjoN/a0OuGqTbXklPTFTpFf9+oa/qEmT9R76PdEHdxmuYrUardP/K+Iw48cCMCc9+j
         Soww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787568596; x=1788173396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nOd8+4g2mnunbTTjfkzCI8WvVdyCHxk83j5KrKNRFdg=;
        b=jGjFLabTwOOudmr2cxpw6Ep/lwG+JgaK2mSpw7t4qJV9YyDQlTvxbCbXCC4VlQpxfM
         s06TWs2VFeG7tL+DhlIoakcQ4LEKsZGKiqEXcTuKjI08RxqumKfqoasx43FA0uffi2EL
         vBomA6OgJOkYIUtqT4EHeYeMx8PmYh5M3qHS7TIbIvqq3n377lBAqEDLw4kj/KRhdqYc
         HCPAQ5xiZPzGIQ5gE+GcXPU2hQsRzHaQ/62eZO6efd0mbatqrXU95t/SNYaS+9IytBpY
         GnS4KqVm40VYSbswkoQ58brDNrKssp9f4xGuMA/YSm12yPjhJpztF1mHv0CIc7rgdNZB
         xQvA==
X-Forwarded-Encrypted: i=1; AHgh+RpmTrDMcD9a+QkHWgsUgbEsbo003pHyMZRXGTKhn7CpzFmxShianfdjqfbwk2fD3TBb9eKqb04b+OHUjyi0@vger.kernel.org
X-Gm-Message-State: AFuF++kzusOSYwge/SaSl5ArvF2BwhtKuigP7/CdHbxNigWL48ObbXIj
	OPTkT7oYe433gGI1Ras8EHw+jIiqrx84je5Of4g+a8c/wNB6QwDhfAZU
X-Gm-Gg: AR+sD12IOqU66/kwXj0F/2ZzwG/OnqEIDOlQ0Oy+WIO3DS5pNbjqUVl2u8W5Vh0cEJH
	if6hb+Npc73c5V4jPn2BVWJkq3VIkL9Qa7A42g34Z14BTFK5DcRGNLNa3vFfnEPBk12vjKGrjv2
	4IMHHMuYEw1hnlUKKeLvQVaEh2bZ5ZgQFny5YFsuQwjK2bwLhvSKN60wSpgDFNusKx6ckNeF0Tr
	JSLTCx9awy4c3x2HgKap2MDYEfAnsfzzvIzig2J90sPW+Dg+EQ5cA0TVypqbzQBUPdyngJNDlI1
	N44Rvv8NfUjRiUlbwdTG7ZKpbVICZk8qZMRQHuutqfntliFfGlQrOb+AxOTrmL+yO0ki3Xd2lYG
	YpbCyX7wrUpQWHroA5AfJOdRnxaR6ULYEBh5dqNRXN0Hvn2pCfor0XtwKuAIAx9OG2XYyFiCiVn
	tl2373ll4DbCuoRvsUFxjFf0OEACpbPGjcNJAzXr7qW17Cxzr9DH4KG3q6HgV9VOST0ED5CiupI
	3Il
X-Received: by 2002:a17:907:97c4:b0:c20:af9d:454a with SMTP id a640c23a62f3a-c2492621bf8mr1999188266b.16.1787568595897;
        Mon, 24 Aug 2026 03:49:55 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249672becesm1236373966b.42.2026.08.24.03.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:49:55 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	david@kernel.org,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next 2/3] bpf: Add user memory access kfuncs for linux_binprm
Date: Mon, 24 Aug 2026 13:49:30 +0300
Message-ID: <20260824104930.83453-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAEf4BzZTM5SehNnM83U3Kj0cz=NN=JwUtG-pcvSHdvZBsHdM3g@mail.gmail.com>
References: <CAEf4BzZTM5SehNnM83U3Kj0cz=NN=JwUtG-pcvSHdvZBsHdM3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review!

> making this linux_binprm-specific seems short-sighted and overly
> specialized, why not pass `const struct mm *` and call new kfuncs
> bpf_copy_from_user_mm[_str] ?

> and this seems to belong right next to bpf_copy_from_user_task_str()
> and others in kernel/bpf/helpers.c (and bpf_copy_from_user_task
> variants should just delegate to this mm-based APIs and minimize code
> duplication)

This is exactly what I did in my previous set of patches:
https://lore.kernel.org/bpf/20260811112154.94053-1-tasos.papagiannnis@gmail.com/T/
https://patchwork.kernel.org/project/netdevbpf/list/?series=1144046&state=*
https://sashiko.dev/#/patchset/20260811112154.94053-1-tasos.papagiannnis%40gmail.com
https://github.com/kernel-patches/bpf/pull/13211

where I got AI reviews with 2 main issues:

1.  Does marking bprm->mm as trusted-or-null here create a use-after-free
    vulnerability on the execve error path?
    Looking at free_bprm() in fs/exec.c, when an error occurs:
    fs/exec.c:free_bprm() {
        ...
        if (bprm->mm) {
            acct_arg_size(bprm, 0);
            mmput(bprm->mm);
        }
        ...
    }
    The object is freed via mmput(), but the bprm->mm pointer is not set to NULL.
    Could subsequent traceable cleanup functions (such as free_arg_pages) expose
    this dangling reference to BPF programs, bypassing the verifier's safety
    guarantees?

This is something that I believe is easy to fix.

2.  Does this break the BPF load-compatibility guarantee documented in
    Documentation/bpf/bpf_design_QA.rst?

    Before this patch, walking bprm->mm produced a dereferenceable register
    in every program type. In sleepable programs, in_rcu_cs() is false, so
    check_ptr_to_btf_access() sets flag = PTR_UNTRUSTED. In non-sleepable
    programs, in_rcu_cs() is true but mm is not in any __safe_rcu* list, so
    clear_trusted_flags() produces a plain PTR_TO_BTF_ID.

    Both PTR_TO_BTF_ID and PTR_TO_BTF_ID|PTR_UNTRUSTED satisfy the guard in
    check_mem_access():

    } else if (base_type(reg->type) == PTR_TO_BTF_ID &&
                !type_may_be_null(reg->type)) {
            err = check_ptr_to_btf_access(env, regs, reg, argno, off, size, t,
                                            value_regno);

    so bprm->mm->arg_start loads with no NULL check.

    After this patch, btf_nested_type_is_trusted() matches
    linux_binprm__safe_trusted_or_null.mm, so check_ptr_to_btf_access() sets
    flag |= PTR_TRUSTED | PTR_MAYBE_NULL. Now type_may_be_null() is true, the
    arm above is skipped, and control falls to the final else:

    } else {
            verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno),
                    reg_type_str(env, reg->type));
            return -EACCES;
    }

    Any existing program that reads through bprm->mm without an explicit NULL
    check now fails bpf_prog_load() with -EACCES.

This sounds to me a bit more complicated. In a prog attached to lsm/security_bprm_check,
bprm is trusted but bprm->mm is not trusted. So we need a way to have bprm->mm trusted
to pass it as an argument to the helpers. In that series, I marked linux_binprm->mm as
trusted-or-null, which breaks all existing programs that use
linux_binprm->mm->something.

Another approach would be to add one more kfunc (i.e. bpf_get_bprm_mm) to get
the mm from bprm and have it trusted.

The reason that I didn't push that further was that mm in general is
bound to either linux_binprm or task_struct during its lifetime. We already
have helpers for task_struct, and I thought that adding helpers for linux_binprm
would be enough. Other than that, there is only one security_*() function that
takes mm_struct as an argument (i.e. security_vm_enough_memory_mm), and possibly
in that case we do not need to read the memory contents, but only metadata
(possibly I am oversimplifying here, but this is to show my thinking).

Unless I am missing something obvious, I can see two possible approaches here:
  1. Keep the bprm-specific kfuncs as they are now.
  2. Rework this around the mm variants that you proposed and add one
     more kfunc (i.e. bpf_get_bprm_mm) to make that work.

Does the second approach sound reasonable to you?

Thanks,
Anastasios
