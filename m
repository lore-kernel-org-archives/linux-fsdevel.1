Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793055393;
	b=mHrscQVcKsyK8i8o83sWKsy2DMqncKYYEGqLLZv6nvQgYJ4M3ZtqFY4nkjqQnVu6zLm4
	 GM8iTFzthuooQUubNgDCx1/vAOtPxxASrc4kRjN6gKqDBYgEcELgzvDV3hpVwzMSLhLao
	 JXN5hAkdDHkR+b2bdkLraMQfBJP9qVjDcGHm97Vz3kUOQzaPoNRRAnttmxRshbfnKAENq
	 MELaN0Y3RgeYEoxHbFyS7EHiwhn+ojvwDwlhJrcwpWLVxx18B2t9+mFTXesAsG5Imogs7
	 vIXS1OZUvX2mgHTNdSikhNVYkgVVgC3a5nwSmEGzeMl3v2r2iCv7c6Ia0Ez4xPWowkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
	b=YMwsD3PZPjmxU8J4cJwY7s1ZWVULffRiIDQalLItjR4lLYy4kZrqiajW/SeLqdTVPdqk
	 9JASfbz55swoA/WBAZE3SwxQCnIBcvCqKFcCFPN77iafFhEK6IaFOmnodUqWrbSDHqtID
	 WIAeeWc0wbJ8fUqoUrh6Y73bnorRPhnr00RYpF2Bsfhw4/JBqKGNBI0eivm+HWwLWEaJT
	 YXTECq70OLuPuDL/SghyWBlkkOKMwlecNKsFUdDanZqWct4FAtkwNpfYLCcdo9sXTnFhA
	 i8vA7PF07OLNsA8nDaUGq0Xf5K9y/FTyucdvZoUFlZShMVEhRVaSG2MscfYZfOpssDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s8grGiR3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC3B606A322
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 22:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FC3B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s8grGiR3
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c418e215671so458894566b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 15:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793055391; cv=none;
        d=google.com; s=arc-20260327;
        b=PwZDukEyoeMOTiHLZWQ9bg+sGIFAjA8pyd3kfcGSLCqB0Qs27BOClJSRAHUaEHoyC0
         +yccc6tztKuQJewf9XeF6iAY3NokjbDjcze/3nUH+itNaOf5dzVyZNwCEhO4Dq9vIhSJ
         ojQpUXoRLl+6zTRdbfwz3TFBPp/CXUcrBgPkXHNvtKzqKSSTkXGm/igsEBG+gHEQgnIK
         AQqwnlqlC9CzFpyNK0bULRVOGmsvXXP91cIUyiVViTpXFwfazt9AeO7SUV/zUGmFXNWh
         J6fofU6mMZdNHFCgXz4fO+Y1iEU1o/g6M+kONLCtS9bb2+hyn94zqIosHALWFH2eMoGk
         GsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        fh=5vhJBkvX45qYwWjDAjJvZPrQFfAgd5722/nbsbYhCGk=;
        b=fAfIP15Vb9vNwv+OvI9jjx93N4oR6IfnVipIxzFP1JhW3XVJNna81elVzbecKjx403
         vOCzm7gsxGE7FoJ0KwdmcwP53IhXcQK1edOO0zjMN3LxnD1ICW+2BQLfUrAl5J1zZ1rc
         qr/urZF33QQcdNlAiqVXfCerLuZ/84EbhKhkvM0g/mZSJf4LwsZvpqfYeg2kykMPO0sm
         4smBhjoLEy5ujC2vHpY3/Imq8XV1+4ZsJSpwuHd7vHW6g2rBHfo5V2qJlzN6HzWoHG3z
         WG0LqioDMvn/8Bp7Kkzs/bJUCN8L27N+C0j8qYxhODW3CAW3ySBL81Y//IRpqW3LwAP1
         SEiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793055391; x=1793660191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        b=s8grGiR3jmOk9ry50/nEnZjaxWjWOPyppi2m4MHQTMfb5el8k0obk5/UMSWfPsQmIM
         HPtLzsEa12OcSsVXiRmiCNw+UUDDo1UYyS6DiU9bwXoKmoGF82ns9DjJzrfs9pJWdjkT
         dIxIeAf/R+LNQl/XTj1bdocyLOLlTkNfh75pW2KuZcZpn6JGMaXwZms8i83nnm2msMhG
         qxuIapSALuC5I4z0EKwNizZvGG6PaVYwrsYFc03clQ+zaffY9Yi7+Rd9DeVq8TqQMsPo
         mOa9KjkQgAnBHYiQJzjduIMO8ab1In9zxpTDESz20wql691IHa3z4eYMgIiR+VfFmdpS
         4rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055391; x=1793660191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        b=ZH3V4DfPDTSsF/jGg2IVaKSyB7nx7kqmqtgko2KcMPap3PfTCdT+0MNKB+2tmq0Tzh
         RDG05O3rYS5ROa3aeGLLLU0GlE9MiLku0Bxtn/JC4/gUsRjfK/ZX2FflB6YKnkWPWh0I
         aEVYcEFyLG/XjxHs0gDfpFdXP2EXkOINzYqYm10lLFMzfq0rJiufcBdsF4mpM/S1vJ88
         dSI3OoHufFKowb/KZRkEUV10c8uzy5zeXGFEC7v0L5cM7EPfPg0Kzb4WEk6G5LEM9VVn
         FdoyKmzAsADe879UDbbjPgDV/qjrddwozHYdXxUVX3qCKvW42FXYqJPS4lwtLtke263r
         ufQA==
X-Forwarded-Encrypted: i=1; AKwUvBz1CFZgT6Q2xvbyBsDoii6OGuVrnpPLsatGxCclEjeO/2YNFh7gd5i6bYaPsjc4VbqUITuiH50pWTBmJdjq@vger.kernel.org
X-Gm-Message-State: AFq9FYIHIINlUBppDtLWNf6rZpjHs/PVAXJDZLhKQor5q8kDtQtI+Wjq
	P+ITcywq0zoYLzqfpKWWhWRxyGshsBSXxUOjVdvvScX1jFA8K3qEc2FMgAOP73H5YSLtqvDV35r
	QnOSCdt+LQWgg3vJ10rbsZalO58zgp9DJZQNCdtfD
X-Gm-Gg: AYBFou2JtiAM288OzJ08Qc5Mhvl18oBXncyu4TZYgQ2Ajf0jFuWHYkxI+kcpy9zkMza
	tBmp277ErCK8vHi5TefxR8lQQZ4BscXvxqKD0ccxrlzzRaJltBaglYVNszSMgSE9xmfIROdNkD1
	7tk4GWNPfFEtBBsclc5xcC9ExfWvSIQQrt7OF2bRnWa/aOWacotfJh8rF5kbR1p+6EzOdFxnPNS
	l4gq1jYwzMN9xdhtAKbni46lhfm/yzd68vxHPulYQ6zMDU5Lk2qRhvZRnATMc718AcMyyZTPrcA
	iCRKTY9TGZGiUah1XRz8DV5ZpZG63VlMWVDXdrITTMsJ1p1+My+17Rk/Ozje5inB5ccN2xvh9lL
	g12ztH2daQFOZC5DmsIDP7kjM/BjtRNd/gFWEeJFGY0zOmgw0kG0FWHCMubL6tmlFU+yErv5MPH
	Q8rBz6n0ns/D19Gm8SjgBJUkQQyh/Wpw2qwQ65B5YCFHTw7HES6adL/99vEkdAF23fw52pLf0HD
	EOJ/GC/
X-Received: by 2002:a17:906:9c8a:b0:c2e:7da8:f54f with SMTP id
 a640c23a62f3a-c46bde874d7mr911731866b.38.1793055390933; Mon, 26 Oct 2026
 15:56:30 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-5-jthoughton@google.com> <bce97570ea9665a2f83216d4dfd7ab7ce17d54aa777f761c3d12db430ba21bb9@mail.kernel.org>
In-Reply-To: <bce97570ea9665a2f83216d4dfd7ab7ce17d54aa777f761c3d12db430ba21bb9@mail.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 15:55:53 -0700
X-Gm-Features: AclHuK_4pEIR4EnpfJkK690R4CHqdS4wt-7zneGKcf5MW03i114xuH5q5kcZiJk
Message-ID: <CADrL8HXeYRC8w7F7e_6ZXK6MHd6FRepN_zD632j0JPjNUDrLZw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] stacktrace: Don't unwind the user stack without
 an mm
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@kernel.org, 
	peterz@infradead.org, kees@kernel.org, arnd@arndb.de, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	jmattson@google.com, axboe@kernel.dk, asml.silence@gmail.com, 
	James.Bottomley@hansenpartnership.com, mkp@kernel.org, dsterba@suse.com, 
	mason@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, jpoimboe@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:30=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > stacktrace: Don't unwind the user stack without an mm
>
> TL;DR: Commit message only: the Fixes: tag may point at the wrong commit;
> 7e8e6816c649, which dropped the !current->mm check, looks like the real
> culprit rather than 214d8ca6ee85.
>
> > stacktrace: Don't unwind the user stack without an mm
> >
> > stack_trace_save_user() only refuses to unwind the user stack of tasks
> > with PF_KTHREAD set. That doesn't cover all tasks without an mm:
> >  - A user task that has already gone through exit_mm(), e.g. when an
> >    event fires from exit_files(), exit_task_work() or the final context
> >    switch in do_exit().
> >  - PID 1 before it execs init, and usermode helper children before they
> >    exec, which are created with user_mode_thread() and don't have
> >    PF_KTHREAD set. E.g. booting with trace_options=3Duserstacktrace and
> >    an event enabled with trace_event=3D unwinds PID 1's "user stack"
> >    during initcalls.
> > With the ftrace userstacktrace option enabled, the architecture
> > unwinders then read the user stack without an mm. That access does not
> > reliably fail: the user half of the address space belongs to whatever
> > mm happens to be lazily loaded, if any, so the unwinder may read
> > another task's memory.
> > Use is_user_task() instead, which also checks current->mm, as perf
> > already does for the same reason since commit 76ed27608f7d ("perf:
> > sched: Fix perf crash with new is_user_task() helper"). This also stops
> > unwinding the user stack of PF_USER_WORKER threads, which never run in
> > user space, matching perf.
> > Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> Is the Fixes: tag pointing at the right commit?
>
> When 214d8ca6ee85 added the ARCH_STACKWALK version of
> stack_trace_save_user(), it guarded the unwind with:
>
>         /* Trace user stack if not a kernel thread */
>         if (!current->mm)
>                 return 0;
>
> That check already covers both cases described above (a task past exit_mm=
(),
> and PID 1 or usermode helpers before exec, which have mm =3D=3D NULL).
>
> The check was replaced by commit 7e8e6816c649 ("stacktrace: Use PF_KTHREA=
D to
> check for kernel threads"), which switched it to:
>
>         if (current->flags & PF_KTHREAD)
>                 return 0;
>
> That dropped the no-mm protection, which looks like what this patch resto=
res
> via is_user_task().
>
> Should this be:
>
>   Fixes: 7e8e6816c649 ("stacktrace: Use PF_KTHREAD to check for kernel th=
reads")

Thank you, yes that appears to be correct. Updated in v2.
