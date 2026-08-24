Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DF746F482
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592543; cv=pass; b=cYXZQhOX96/PIOQn43omsGJlwh3jh/85AH/2CWQudY6KYuR5Hics8WlwhhSIGEOEmtNFR1RpPkCk7IuJlTNh38rNNj0NLwh1olZKZk2StRD28Zv3d+XEESlW4Stf1y+BDKn7H105l7bPTtqf5BWh+UgxToKOh7dA6r/P88vUeXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592543; c=relaxed/simple;
	bh=cMo9Wf0m8H2wPLLbHbMj71h5nTiMNFrhZZOi0/3IlBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7kxbrGq3e5kTk4zKwingNEzwMM9+umJOUxrDok2I6jWY8SEE5D3SP/rFERt/ix+0Xq6pByTvaiTy5zpYdMERFCL+FSnlBmHalj49BuuoRLjbsjlfaQHsSWinnCcLji2qp3VL0gcMcK75r0v7oAMzmxCnr/WV2VDhHCAOa6zRXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sS2fsQA5; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sS2fsQA5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d3b445a84fso9035ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 10:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787592541; cv=none;
        d=google.com; s=arc-20260327;
        b=YvYGk678FJzu/vZP4ddooXa5WmONHwWrsyIGw8lweOzgTK8MbVxRgn6KwTbsQe1b3h
         sFt79Fw3QMq4gnILXuKymJo7Y3h8sUQ5y7IeszNscEWZzY8i2xIwoAcfSNGh3sMfcN2D
         SlJ1pHZIN8YHSwrB6mqeNEYMqADc7CtlWLJe7KIY4NN8ZUMqXnpU9U5msPC/sBZKiKVJ
         R8HKWEvqRHwzxtvyxMTj7CF/qkFpGXyL+7O/7kVgMQ77BTg7UL4XlMGD3hQaDwb7whcw
         8Xjh5LOznwSmKUUzupbLLmy1PEUiKZ7cH6nDPWbcAcvL3QFtTvjjPmFjmiKWacXudtEX
         AHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UfDdC/RWyrUaNw5va538e4PXp9Bi22FQE/a0vb8LJJg=;
        fh=ZkXKlrYmuY9mbgi0gZ7shrgS3mq2Bfh16R2dywaWavo=;
        b=WRzsI/Y9N/FuH6bF/wdDSkzOa+haBbYFwNxvv1ttYT49wqQf2xKZWC3FwrdinrUYjI
         DHEVmvhhPqE3adViHvA/Qa6xqROtHZAHXOgyNrC3XK20m7vMGGMJO/I8hn0SXSyVhq+d
         kT3kmvbXFTLcFVUqZcHaMr/DlDK+m7ABRq1vUIymeC7LZs/V4tb9pMUtaP9SCXT+w/Rt
         RGL62EszOiUPdj9J21qnuyzVevWrHwU+pvuSaPBXuljrLrW7EIMPEiQD0HLV0OaVNtfx
         xUVCaER1Bv8gbhKuXnZO2iC4T35Hy+53deMYxWWDAriAGDLXmdO3Au9JLURiCqS+Tgqt
         TWhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787592541; x=1788197341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UfDdC/RWyrUaNw5va538e4PXp9Bi22FQE/a0vb8LJJg=;
        b=sS2fsQA54rfiLXyMZPoRIjfKpEjMYPUH1qtECP6WckTpEPjeLDV7tpfvk/j4q30m59
         vG7xPB/Eyt9RlqmAUHVUeQ8r9oi8M7VXSvHbB6nT6lySCx1PUO95Yo7ZGC5JUxHu6mH9
         lS0Oz1iQPPasPm1UDFqXRGQconNgVmT8wnFv5IvdZYSmoCUrPXPMMqjZZfeNMgonS0W7
         8p0jT1KpA0guHh6OXN0Zv+0pc2sfXSIZHkt20ycUxpkrW2m4ex3a21FLDvLnRGaqBSe+
         Mt9jofl+7qsVhkiGxc7jCf7eJTFOseFtTmk5/+14v+AbG4reuiGPkhBEBTmXbRJBkhke
         RfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787592541; x=1788197341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UfDdC/RWyrUaNw5va538e4PXp9Bi22FQE/a0vb8LJJg=;
        b=QSZM3lR2K0docQuibL/9vcgREu7RD3jpWfMTmvzg6fls5OPRVrT2b9pQGwc9kT3b/Z
         uvb89dY7n6+Qg+yizJvU1K4j4gDkppplVWeoF92411Xbyp1XEKsRGTB0/k40vsZr+blC
         3kRJwkkchMqoOJB3QiEyWAVs4RlmEyMWUUvDwMpu6qT2kzVLfif86ghElpE9tHMewCmz
         EexfFt0WFHhhiY+h/Bqb8ohOAhk5EscyxXXLaLJZokWmaask9WVgSKf+nU309o1lTKMF
         dLWpf4uEAw3GiBruuAqeXjNE0O1oGeHjBQZM1dz6swnm9hoQ2RJaS93JpAZIoZo3zgQT
         /FDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpeojgYQEliD0kvxlra4SA8L8BBtYEmjkWszp1Zrok7XqMiRY0J3fgFNWFBi9c4MnSneeFDaBMN6gXD46YC@vger.kernel.org
X-Gm-Message-State: AFuF++nNdlk64U7bs3/k4sD2diyXacyDEh62lshBo7TTLviO9A/sfVM7
	vrr67HNq5tfG3nNYFSEzmm7pvAytOIR9oB+KRkJsa8Ao8+m6QZyUK7aIqS3vEPJdksi8BaoxHdt
	kqnRxtnh/DAF/iwGJ0g8QmEvWY/OMHLUfZH8mY+nG
X-Gm-Gg: AR+sD13RyVxnaic2IoEO/cthYUe8QdU3rpnT/3iwqAzgPZtWvnHTxzKD+MGdVI+xtJv
	E7HouX+KGmDCxx2FVY0IE4Ybo+iGxTHirfxJf7psZjl4J90Thk8L8BzGL3arMAO2r5KbFLbv5KC
	Or4Ub9mevvC1xUTv7pWq27dT44H3NVwBAVlPtBydyB0GWji2fJvgR0cTNkIkEJ7WwQS3+7Qs5nj
	N6otcl81HGozNvMFci94FRKuJJ5A6WPk2QrCkSfa7jjodx0RzT5e2LvSlYrrNKf7yyP8Rh5VqyF
	KD2WmrDx/MFKsN7Y4HpkCDQYugK1gU6N1Nbr/pNKZRD+UL2uuUmiuAZ2qeCg8giH3icmh9lxm+k
	IWI+KuqfE8xRlO5ZFX2+y3HaqLrt9JLA=
X-Received: by 2002:a17:903:1acd:b0:2c6:a078:bfb7 with SMTP id
 d9443c01a7336-2d673b9b705mr10399295ad.7.1787592540643; Mon, 24 Aug 2026
 10:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <aoifijlkCRzeO4bj@gremlin>
In-Reply-To: <aoifijlkCRzeO4bj@gremlin>
From: Jann Horn <jannh@google.com>
Date: Mon, 24 Aug 2026 19:28:24 +0200
X-Gm-Features: AcwNN1Vx1mdrG-hGZfBBtnczl0hD68Qs5NDgSLNpjnU_6pjoKXhzXOErcbktMiU
Message-ID: <CAG48ez1HA30JUi-R=6KydkQy2P3_ineM1ZzRMQC6QP1UAwjewg@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 9:00=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
> > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently hav=
e no
> > good opportunity to block a process from overwriting read-only code in =
its
> > own address space through FOLL_FORCE writes via /proc/self/mem.
> > The security_ptrace_access_check() LSM hook is bypassed when a process
> > opens /proc/self/mem because this is considered "introspection".
> >
> > This causes a hole in SELinux EXECMEM enforcement, which tries to ensur=
e
> > that a process cannot create executable anonymous pages.
> >
> > PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> > accesses are only possible when the LSM allows ptrace() attachment; but=
 it
> > is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> > environments running lots of third-party code, such as Android.
> >
> > So, introduce a new LSM hook that can forbid FOLL_FORCE specifically fo=
r
> > such "introspective" accesses.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>

> > @@ -886,6 +890,8 @@ static bool proc_mem_foll_force(struct file *file, =
struct mm_struct *mm)
> >               }
> >               return ptrace_active;
> >       default:
> > +             if (priv->introspection)
> > +                     return security_introspect_mem_foll_force(file->f=
_cred) =3D=3D 0;
>
> As per 3/3 I wonder if you need an additional parameter to cover the fd -=
> some
> other process case?
>
> Like:
>         if (priv->owned_by_owner) {
>                 const bool is_remote =3D current->mm !=3D priv->mm;
>
>                 return !security_fd_from_owner_mem_foll_force(file->f_cre=
d,
>                                 is_remote);
>         }
>
> (I'm not sure how LSM hooks are supposed to look :)

We could do that if we wanted to treat cases differently based on the
identity of the writer, but I think in general that's not a good idea.

In general, if you send an FD to some daemon, and the daemon writes
into the FD, this should not cause access control decisions based on
the identity of the daemon, because it can cause "confused deputy"
bugs - the daemon might think it is just writing log output into a
normal file, or something like that.

> > diff --git a/security/security.c b/security/security.c
> > index 71aea8fdf014..d0f790a534eb 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -595,6 +595,21 @@ int security_ptrace_traceme(struct task_struct *pa=
rent)
> >       return call_int_hook(ptrace_traceme, parent);
> >  }
> >
> > +/**
> > + * security_introspect_mem_foll_force() - Check if introspective FOLL_=
FORCE is allowed
> > + * @subject: credentials of the process accessing its own memory
> > + *
> > + * Check if FOLL_FORCE is allowed for a process accessing its own memo=
ry, which
> > + * bypasses the security_ptrace_access_check() hook.
>
> This should be updated to also explicitly mention the fd case. As surely =
in that
> case this is not true? Unless I'm missing something.

Yeah, I'll clarify this comment.
