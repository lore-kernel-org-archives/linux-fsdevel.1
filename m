Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793308010;
	b=2C3Awg7UgJif7cFR5C3jJAruqUBFjZlBsMYo2g1mYBlkBBJ+37ao8HKMZz7GwsSMvYl3
	 3jFkA/0jx3QR3/GADN5lJYEuGg9PBwyWhax0TK59191TWHw7I3iG3MIpKZQABCu8cEoy9
	 0gl4c/sIOyA1eWZwEnfk+QyPKs5cCli5UOiFAQQGO/y8X3tEntyKrl3DdhOqud5Jq5jq+
	 XqNyX/KuyWfJ4IegHG4pzt+5kWEWZ0NXHpIcam+Qb26V0ZWSKfRkuUa48IvKVK5s35jR7
	 LUFt/SWjhBmYrb4YqfaaQCUbHUeg0BstofgLsN5YD+Oj7zq5ysohGB8ZCHV/AKtoI6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
	b=s4JgPAbYDi9Aa5WfoteKM/rZ78zMAEd9S/wBPNvLbrIgVg3BBBk2a6yRpte7J6Vi3HLZ
	 f5s3AWTfyCDLfKjB0LOV/v1Kyz1YQTB51zZPKRdjJ9gCh0AQPQbAGLnEBi+xZdJZ10Vu8
	 6E+D1fDQi0SULvHor62GpUenMr2SujVagdCkSCpkJBhbqvWgSofIKXkWw/pimKTu+3+08
	 Q+TI1IvKzplLMF4fL3rMh1bcIydihWb2ZzPGy6BfMwoQZJK/2pyCulnPttkAa64PLLre0
	 mcX4W4m4OdmnbPGA7gTdVh58RXtSkW+mjLNexHEjDSm/t6FHONQRWgY3oJUr8lIgw3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B3606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 21:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E8B3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so1911882b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 14:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793308003; cv=none;
        d=google.com; s=arc-20260327;
        b=SbpHb0+4KuiiS9vlnqGUbvOQmlHYFCmnM3bGSWy3vk4ET1T1szRufMYNJiDbN12xIE
         DOmz6bs3imKVyVPTSctQ6/nw055Kaa+V+xbH8cUHkw3YPGsVo3CfVNOwBEBeauzSPzIF
         iQv5Ulg5vAcHJMltjVgYJjCauCVmSWZZEzKaP8T6KpQFUINJMJgo/akyvMXF4F1JC1OT
         8hwS7lK+9sXWQ8Bl4XcwaEOKn0AgLFJ+n7LLjp7dlHxEYcm7qVRqWoM3LWjTYYEPLxew
         icLBIYRT6D+A6xQphZdwq+ZfNNU5+RNbeZMc6s0pX0bZoNw1sOUGgZiDDWQLqiltNA+B
         ahNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
        fh=SVRf1FX0pn3orfkSWevt00CjaMb3GuNecOe071Cjlss=;
        b=O3yo1qnfKqafCde+ykIzKXzdhexPBaVc/+W2a7rl+EcfkYmhtwUib5j9knO/0b1XPZ
         W6BijBRzUCXvGYzLn3aWsV8jDG9XUpAPON9WrAf5/TWgBxGJB2Ae3sQ5y2FnAF93wUoF
         /MKUktIewwza80bpRFM9gcvecI+BGqspwIgd8ZZPRpn08cO6smGzzZ0hYr941IJB+AfM
         eE8wMqeDRB1defXJHuaj+Zz/v7zhPVT1LjYxW8hicIjUabS1IZHaZ1te9AFZlmZJAR5k
         IvQXrIOSB4yJ8tI5AuTrFbXqmQA9Dg4Re7YkO0GWhVBXYWQl0yZ/eEQQs6Mj7CrgaQ1L
         9LjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793308003; x=1793912803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
        b=SUMWHyeoy05LlaPkkQo68Lctqx8jCJMBTP5h1s5JBg1inkctrhBizK7c4vICrVd4ST
         tFgaTBblbt25voa4mPfQrBUwVI2YrctmrtYJ63fqjqiCjZArQrKO4OKXUqCQLnZIerKB
         9+pJORukUAKGMBg8JR8BdJgf1joFHY09BQARFm1AoO9N4jDb/hxCp5cBEDF6KEs4eZLA
         s5zDXJAWJfqzLNKMabhR+qdErWq+anDkdWSt4GGzkvx7RJRsY7B9xG6OwOuuiyrfA07o
         SZGBXLg0jYjyyW/ttddurHjHLMVw89R1WFqxnex86aQjNutVESFg8w7ztk95DE/2a0uq
         MykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308003; x=1793912803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
        b=rLeejjI5QMRTqHapveJhe4DUvrzRHBV28qeAwnCFI6UkLEzmARv0DGBKDlhiHowCdU
         TC4puTqtvBH2niwUM+o2W6VBWREmj/QP4nf+noe83NxhnqezWUMpmbZLMIKPswaBZev2
         FntMwT7CaJZ42pxTQQnZNPtfknZ9vWwXTr1zXz/AVcj/zCDDJkXnB2IqyaX6/mLR8sWj
         n8BElwup9zJbSvg1WJNWVb3zBbsYLAWNV2qpR6i4R1dTm+o964uT/TKPrm6X7B5hRI+B
         /uyMD0/77nmXOz0wPvIJ061k74feGqtfSH7P6fVvCV9aP8aXtA3uFpbmp7OO0iOuNUXF
         Wmlw==
X-Gm-Message-State: AFq9FYIWFMewLrXbtbKQyq29c7Bprx/QuOOk4cVrc2e4sDD7eqZQ30Zm
	EEKVFU7V1rWqFICgM6wB/s8QYdlSm69YZBdi0SRFyha9B70oh3DdfVPznnFzaxrqEykK05oTmwm
	b9huCWnAu0FRriikyx5e4qxQzK5+FcoUPfURciP44
X-Gm-Gg: AYBFou0OASWb6Ub6q32LHhjdiRW2SP3GgyH+n3k3TaoR1fbGGCtKBPzgeem2CY+1Kwx
	8xt7VI5+7a7R7eqWF4CbLcBpqTbtI8DL7zAgiVaRwJpByPyvULTMHkvdhFYqbopU0ZQgr7sDchQ
	Mm+65HHXW0rKImZNOWoIxeg/m/wgbkm9sDAltsraDsGwSTyj2+U26m3vB9/yFAroMJc6kzS3S+s
	Re8A196DHhMZfnkg0a/kn1Vb5BnUFaFtbCtzSi/ugasiA87c2xg1+nWr+2dPr+08mpJJMg7QVIw
	lJN2ipPNrarxVeNmg4qpGPp95J08WYwgcTNSBQgVKw/rTnTtIghBz4zTKP49cBNZ36stsW/fYBY
	5kVUj4KkhovN6uK9ffGRs4Fkg67kF9XA1ne0zk7izsazQYiFaScWawqOxw5vqrBy0VKJrPZ/WtR
	coKS3CqmcjPb6S2Q==
X-Received: by 2002:a05:6a00:1491:b0:8a0:5d6f:8a9d with SMTP id
 d2e1a72fcca58-8a9bcc0e982mr298168b3a.35.1793308002978; Thu, 29 Oct 2026
 14:06:42 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Oct 2026 17:06:30 -0400
X-Gm-Features: AclHuK_BZX5V0V1r5inK-ll44mPJ2Gl9ZXGK3V5AGh6lbgKe2qd3dfFfw4B3CLM
Message-ID: <CAHC9VhRwD1c1qKK4=Uc8cbMy27iF722C0DZeXy4WGtH-kOBOcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:41=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> I tried to switch systemd-nsresourced over to the namespace_free LSM
> hook that went in this cycle. I explicitly developed it to work nicely
> with that. But the version that is merged is broken for that case.
>
> The namespace_free hook is never called. security_namespace_free() bails
> if ns->ns_security is NULL and that's only allocated if an LSM requests
> a namespace blob. Nobody does. Landlock doesn't care as it only uses
> namespace_init and namespace_install but a bpf program attached to
> namespace_free never runs. And it can't work around that either. We
> could make the bpf LSM request a blob but that would just be a way to
> make the hook fire. So call it unconditionally like we do for
> superblocks, files and bpf maps.
>
> The bpf LSM also marks the arguments of namespace_init and
> namespace_free as trusted. Curiously that patch was also dropped.
>
> namespace_init is called before the namespace is set up and if anything
> fails afterwards the namespace is freed without looking at its reference
> count. namespace_free is called on the way out. There's no kfunc that
> takes a namespace yet but once there is one a program could take a
> reference to a namespace that's about to be freed. So add both hooks to
> untrusted_lsm_hooks.
>
> The namespace_init hook also always sees a namespace id of zero because
> the id is only allocated after the hook has run. The id is the only
> identifier of a namespace that is never recycled. So it's what a bpf LSM
> wants to use to track a namespace from namespace_init until
> namespace_free.
>
> The inode number is recycled way too quickly for that. So allocate the
> id in __ns_common_init() before the hook is called. Then ns_tree_add()
> doesn't need to allocate ids anymore and ns_tree_add_raw() can go.
> Landlock now logs that id instead of zero when it denies the creation of
> a namespace.
>
> I'd want to get the whole series into v7.4 since the hooks are new this
> cycle. Otherwise v7.4 is the only release where namespace_init sees a
> zero id and where Landlock logs zero for a denied namespace creation.
> The systemd change I have for this uses the namespace_free hook whenever
> the kernel has it. On a kernel with the hook but without the first fix
> it would never learn about dead user namespaces.

I'm renewing my comments from the v1 patchset (see the link Christian
provided below) about the LSM framework changes being appropriate for
Linux v7.5, not Linux v7.4.  It is clear that the BPF LSM use case was
not tested prior to the merge window so BPF LSM support for these new
LSM hooks should be deferred to Linux v7.5, allowing for proper
testing.

Disabling the BPF LSM support for these new hooks can easily be done
by adding them to the bpf_lsm_disabled_hooks list in the BPF LSM for
Linux v7.4, and removed in Linux v7.5 when the LSM hooks have been
changed in a way that is deemed suitable for all LSMs.  The
bpf_lsm_disabled_hooks change would be substantially smaller than this
patchset and would be fully contained within the BPF LSM.

As a reminder, the LSM hooks and their callbacks are not part of the
kernel's stable API and are subject to change between kernel releases.
LSMs that wish to provide a stable API need to provide an abstraction
between the LSM hooks/callbacks and their API; the LSM framework is
not responsible for ensuring individual LSM API stability.

> - Link to v1: https://patch.msgid.link/20261026-work-security-namespace_f=
ree-v1-0-ffa3ebbf71bd@kernel.org

--=20
paul-moore.com
