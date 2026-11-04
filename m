Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793828904;
	b=JtH069FNGd4cZw1Eb7aCbbiwQLsUJuk3RuYAMvKX+3LUhvpWIZLDbjoVUaIaVezdbVqS
	 phzmWdU3DLjnvqv3b40KdY0YbRKsspnHZK1yufX9VkY2ubRvrRVeGYuQYaerUcXVSmzGF
	 sQOEvPr91z+lpLPG2fz47gfNK+iJL7Fs8qDZHb6jc94qcS5k3BlqpPJaHZWY2nuJqp8pr
	 PeTc3za1hjSiiEpq25b61yu/ONbM5LI0ojOVyw2RyF+Igt2YCfPE2ww385IIrHEzSg6Rx
	 taDsqyYjGgj6knp8BS49v7GmMJw+2rCITNXvpmm332BmFRJsL0b93AQ71rZOE6ZyPPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=HFxih8R9lRpDAVACkYJBW0qLU/VjGrR4AQyRfvWPnWU=;
	b=BSBLzTJEFZudNmV66Qv/ETthr1WJDEc2jtya60ErHHC4LdeHEwEwGgmsoelY+OmaKJy6
	 l9yYg3nZuecqOERlJTiyeY8lnryJTCL3WzsTDg6YGu0/fSm50JlBabus3xhqETXXFyqfW
	 gSUSEGlO0a9/Br3/AUlDuLFAUm6NNF2kj8yqz85XLRTApIMCOC0KfzgHwdJBzrT8w/+6J
	 hepLdtJCA7FctL2ZS9pMkbW3SNx61vXmRZ/kPhAYkyi8Ek5KUyB6RSOBbbccr9EK3H9hw
	 zzInvBD0oAeB+Kes8Om6xoOcgd3gI2p+Oj4hKVttguxt+yJvzCuHNAhtf8HQ9eQc/kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jwrr4D5U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072EC6071AF6
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 21:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 072EC6071AF6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jwrr4D5U
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so17605ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 13:48:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793828903; cv=none;
        d=google.com; s=arc-20260327;
        b=EQO+isVLJa0dx0m46BSftshG/mqNZ+Dmrhun85vaOb2IvKpY03iYEf79Bh1fxajTEV
         BHf04oozBO4p30pIH9hG2sG/d//5tY07QRrwfrBC/l7zM7sZodtkPS4jYAXwcAEo6EU8
         YdNGtFdk0fDJAqNd6srUWRUOAxaJpmUYHeRChgWswLIrWGTK7DzXiMh4IKfjiZd3nGIu
         hSnddlzrW4il+/DESHJpmgb/mn8kBmFfHNuZr2JM50+nJp7o5nVZ2iZZmG81l0hHGG2R
         bYng7JzCK5nWwVwsEUPOz3tcci48MBnSMg20T9I9o4yJp6kGvQ1ne5L/l9p16UhpDVpz
         wxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HFxih8R9lRpDAVACkYJBW0qLU/VjGrR4AQyRfvWPnWU=;
        fh=7mJUVuDvnfYWIVRqWfdluoKVGa5gmjySN/dGUDufUu4=;
        b=otHNO4eaTrx+9og4yP86N01rpj07cOcdhOcBeHiAiRhflfec2AaTwaO/EutJ3N87Ad
         gkpHmMMM36o3UvpjtAgaYDqmV4opMJ+iFPN+ySni7NuK65CRq4m25WrITvCCEyMGskfz
         EGqF4gy5JX/An9SRDcUEo0etEV+zojrpN3CSnCubQfSsGzcnitF0ulNmUYMjbjFDAGRL
         mQwTymZmkM38IvhqKQSlPMMtg+PuWbUM7DSN5AQsmE0OodNjkxaM/5ddOKhUhcegheoO
         pi2cG/uO9m3n4F8BYXUoPl2iO3kK4f9gHmU+28uQYqbOl1+Ury/UQ/eu7T0GlKwAGOUK
         sGfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793828903; x=1794433703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HFxih8R9lRpDAVACkYJBW0qLU/VjGrR4AQyRfvWPnWU=;
        b=Jwrr4D5UuX35OaQFRDRYFnZTLylt7Jl7BBvQqycX3F+ObQ3/FiqISCXH1qDPsBHVYG
         yDRNq12hSA6qw3BsfcCiC6HK7jSB0TU8FStpkbCw0DdpvLCbzRbjRekp4dC1CkbgnVte
         G5g+6ITyA6UJR3kceA+bEjgoZXgR72bL2sJxJmzu049NBWhT+mOSmWsgPV1QkHzbLGB7
         jfeHKe7vMAsA+quEXL7dJK+POHqtvuOUPx40kkcQMkwmX9RIyZYUUpSBJGQ07Xc5RtYs
         6xThrvDCiGaDVPaAggjJniaAUyZnqUFWFRGdmuFr5ZNvY6bDJ3s+yr8+dfiF1RQT931p
         49TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793828903; x=1794433703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HFxih8R9lRpDAVACkYJBW0qLU/VjGrR4AQyRfvWPnWU=;
        b=BUmFqYi7uu+W1H5Jf+01EK9w6Z1YCdEZLDneM4gaXPpCC7VN+5G5/meaGhVg/34LYN
         UD3qD5zj94yU6Pwb8w8BoCYG3zXdpecB5gpSXRraG95XvpM6m+B4WRRETq2vWokPaMGI
         GzlGMn/XKzZi0SzecHt3nAFLx4ZYF3YXMSpqmY1FpXE5e2GnXrx7heRVZkyJHiBhpGFr
         hT6KuNyjTMFq+sYQoLtl70EFHq7laFSObU5o/7srwny8N0tNELohUsTLE3cNgJolc04s
         K5J+sXgZhBV2jSiPrZdRQVyV06N/oof36DlRBleoOToEkNGlqknaGIpinfqyJORaHqt4
         nUkg==
X-Gm-Message-State: APuU4Z/mEiKAiBSWAYOplhzoENg7nv3zt45GZDuc3P9Ibp9C6L5DUD9P
	atoncNU0aEcbb5nyjIJkG2W+OgswFRiYOp4bMOk3kSNEKPdoXAYwo8RWDMtsrxH6Pk7hSrYVqk/
	x9ig5uSNaZqDKDuZxp51mGW1fpg3rlflaYNKMeYuv
X-Gm-Gg: AYBFou1iRCb1Cq9BuxeHi6YwHEK/yMLhXEcOPF9L500DB844euFxussyNq7CKzBDGHl
	Ya2lVf1y5WJEVsloXHMgS0/Z0anTypq1aXy+rlz+uSG5+qTPufhgxc9+J8x7ILWnmB+H49IVJB+
	KiqcoYz0xWT6OsOeaUaBzOhXygLiL799sXZnBrYketGzzSnIaYgPUWdt+1S/FfkhKA+aBbWrLem
	uIlDAml9pF4SfjKwz2vbKcQxQ7m4Roei2vXPlZbUoHq9SZ+u4H7gFMrgOjL0S0AgPFhzUyN/ayb
	GP9qI2ilQr8IeMiA+Mz5B9abiuvqZvrWPQUCY2q4PycyB1uGJvSJwisLZCcs+KRTKKY1v+tc9k7
	Z2vw253OxqUBSXfkyOlp3gAKOQpMT1T6vGXJGRw/zXrqm1O+mmhe6uPPmMiFz/B1Q685z1Vx4Kr
	GBo0XDcXVMcygyZLJBZ7U+Rw==
X-Received: by 2002:a17:903:3d0f:b0:2c9:b404:b55 with SMTP id
 d9443c01a7336-2ed2627b4cdmr1247535ad.6.1793828902569; Wed, 04 Nov 2026
 13:48:22 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org> <20261030-work-procfs-ai-fixes-v1-5-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-5-772392d3ccfd@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Nov 2026 22:47:44 +0100
X-Gm-Features: AclHuK9WwZ7ks_pjfrqZ3vI5RBoe_i56RVrQkAqFQZfkVz7rz4ObBUhaFFI4x3U
Message-ID: <CAG48ez3sOYAE-Pu7y1dmNtS8-ohrgS=vXAoQzNk57EAkVXxWGw@mail.gmail.com>
Subject: Re: [PATCH 5/7] proc: stop fd directories at a privileged execve()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 5:12=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> /proc/<pid>/fd can only be opened by the owner of the task and
> /proc/<pid>/fdinfo only with PTRACE_MODE_READ. But once open the
> directory lists the task's descriptors for as long as it lives, also
> after it executed a set-user-ID program.
>
> Use the exec id helpers. A single check at the start of getdents() isn't
> enough. The entries are copied to userspace while the file table is
> walked and the caller decides how long that takes. With a buffer backed
> by userfaultfd he can sleep in the first copy until the task has
> executed the other program and then read its file table. Holding
> exec_update_lock across the copies isn't an option either because then
> the reader blocks the execve(). So take it around every
> fget_task_next() instead.
>
> All this tells is which descriptors a set-user-ID program has open and
> how, so there's not much at stake. But there's no reason to allow it
> either.

Yeah, it shouldn't matter in practice but I guess we might as well
make this stricter...

> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Suggested-by: Jann Horn <jannh@google.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

> @@ -267,10 +283,13 @@ static int proc_readfd_common(struct file *file, st=
ruct dir_context *ctx,
>                 char name[10 + 1];
>                 unsigned int len;
>
> -               f =3D fget_task_next(p, &fd);
> +               /* Don't hold off execve() across the copy to userspace. =
*/
> +               f =3D proc_fd_next(file, p, &fd);
> +               if (IS_ERR(f))
> +                       return PTR_ERR(f);

(Non-actionable sidenote: I think this "return PTR_ERR(f)" means that
getdents() could return an error after having already advanced the
read cursor ctx->pos. But as long as nobody tries to keep calling
getdents() on an FD which already returned an error previously, that
won't matter, and it looks like other ->iterate_shared()
implementations do the same, so this should be fine.)
