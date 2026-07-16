Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8614204E
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784160641; cv=none; b=PdYHyS21fXO9LhTkVY/vLDnliW6bdaHB1mEydu+NTfuDOvB7jNIdbFKr3pmjCo3TjYOL3Y52LprogLdGjcnCVXhODGDuYEBONYp/FoOTp95Be4khF611byLBMtwwIUODM+nBnw8EV11ek8RFxv3iKuJGeE9i7o1yamKOji1Q4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784160641; c=relaxed/simple;
	bh=iFLgZLz3ksNBmau+Jra7CtGxgjSGyRGOtEuDc5teeQE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=QC7TJvbQaCL7Ek6HeRuHv4wcKBPxOmOV8SQs1RAz1sFgDksYn33KVv7N2rggn5KOv27ljaM/Duwwhu2/TCeOrxyomY907Pgb5WOKqDDhjtt/OUoJjFj2786SyKuOINrKJwsPVoTBB3LR2qPEhly5TmsvNEFOgcf11qKv/oLY8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGKLgxMZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGKLgxMZ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3811f512167so6611479a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 17:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784160640; x=1784765440; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P4jDzMSQG0md28knM5bL5uqnp/M0FWc4W2jCI8EKDHM=;
        b=bGKLgxMZE5H6aZP7O4yGap1QdkUUYV//Y27k5yYIuvArF5V1xSOiYsB3gR0H7hOgk6
         OkkHNP26vxtH4rzQretMwI+iGUwS2klN/AAxuG1BOw9coSYPhf8RkTGfu2hE9FK8/HGS
         UJ67DpPTzSVmVO5y5Qb7rvitQcYkYMrokUGNOYRTA8Y7RvwPUTOGev03rUdBtFmh5cdr
         VuOjMaR7QUQQyxchWwCONEgHhHIjTnyUrP7PYaSvZ2orSeZmEGlAzR6TZzy12L5SmMdd
         U9HXsObivCqSD5fZmDWjqAuIQnmQFfDjrXPnrlXhufVNeeR6jmaM2DLkMSJjwXf2WA0u
         +vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784160640; x=1784765440;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4jDzMSQG0md28knM5bL5uqnp/M0FWc4W2jCI8EKDHM=;
        b=XbqlYxRLATTcvuVk3+D2lru3/qeKqkpc5C7MfKOxBd+o+LUY8d2rX74nx1wj1SG+V4
         0tWbpaDbXWMRD1wYdKICg2pRlWzWzJmtGYyHsHG9czGiV12icFwPY4QLQCtZXtQJjkr5
         HZPM1lR4gPy0ZTYIfVdJ9oC6a9lr5ySEBOQMA1zyQkepRcGoW+8DRmYndsxxKZE4t6o5
         TUX9aY/7cihvsPqEblXzXEssViPB7EdjUq2esFNf8HNQU/cT+Nn9ljKi/OrmBWo4AMgI
         35s87R7xTr7jrLWvhLLAxsmhjqHxnzcSgBPj2F6/7Fc+OxPKTZtujb9Ald2QQvt7xzum
         9zzQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVnWw9TkX4ywnEGj1XeY6FhBH5HSweM32TPD0GvgBI+UwxxJa1e7NGTfKFjxev6B+BbQ6CuVm+D9ySRnt5@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/ypMUehHnqNXoZrGI8yFC96BMwGJXvzpAec8gONVlBs+sj3m
	uikkxSHXZtNkKW3Bv0R3+F3I6SPUZHFn2yU1ubTq7XEigS1slptGs7sR
X-Gm-Gg: AfdE7ckjRarDqTFSCrir9bsTcSv69YVmP1wUJgE6NWhDoW7wN9AtRoxQpHNlcN2w9D0
	0m3G7UhRskQ7BHDwkl32JmThxKsaP2tDdjNTwwtMd+CZbl351stR3Qmowix73Uh1HehcU7Bb8ri
	gx4aKOK7d4QWCL/WzkT815xhofa9dikQasBt3nQpazVnvXpcxKg5rhR1aMH39kf6uMI5AfTYWv9
	e+8vzhUjG0WmVgszq36OT7/u14yuUej45WsIU4BoC8fETk+FMReKIhFp59diHmmnwrFWrod5QRg
	hYLx0pwYzAhuy/z0fLZAq2jXfAC/SpAg7pRPEwk0zS0Cr4mlRQbzOZ7mZ2UjzTRCmD3RM80J+1e
	uwLQwzOBEgMNqM88VED4PMWxOTm6jkcAZJMhXMKxlVJK4PdtkTyz6tWjDrfwmRD0cQNZm7yO95l
	inukQ=
X-Received: by 2002:a17:90b:2ec7:b0:37c:774c:77ba with SMTP id 98e67ed59e1d1-38e1afbf5abmr8173040a91.21.1784160639936;
        Wed, 15 Jul 2026 17:10:39 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6ebe98sm4999273eec.26.2026.07.15.17.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 17:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 17:10:38 -0700
Message-Id: <DJZK5TY3IXQC.2XKA1X9IEGJDO@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Kees Cook" <kees@kernel.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet"
 <corbet@lwn.net>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <bpf@vger.kernel.org>, <jannh@google.com>, <mail@johnericson.me>
Subject: Re: [PATCH v2 0/9] binfmt_misc: bpf-backed binary type handlers
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <178407531866.2243172.12944140194021045628.b4-review@b4>
 <20260715-reorganisation-umtausch-radiergummi-8b38ca81ebb0@brauner>
In-Reply-To: <20260715-reorganisation-umtausch-radiergummi-8b38ca81ebb0@brauner>

On Wed Jul 15, 2026 at 1:40 AM PDT, Christian Brauner wrote:
> On 2026-07-14 17:28 -0700, Farid Zakaria wrote:
>> On Tue, 14 Jul 2026 21:58:05 +0200, Christian Brauner <brauner@kernel.or=
g> wrote:
>> > [...]
>> > 		.load =3D (void *)nix_load,
>> > 		.name =3D "nix",
>> > 	};
>> >=20
>> > Farid, this should slot underneath your qemu demo from [4] with the
>> > program ported to struct_ops. Feel free to take it from here.
>>=20
>> Thanks for the recent update.
>> Is it still "take it from here" or was this left-over from the previous
>> series.
>
> Leftover from the previous series. :) Sorry.
>

No problem -- just checking.

>> I think you've done the majority of the work here with the validation of
>> the few selftests and mentioning the gap for shebangs.
>
> It was a nice joint effort imo. I think this is in general an
> interesting idea. I'm also working on some glibc loader patches. One
> of the patches in this series allows for "transparent binary execution"
> if the loader supports it.
>
> In this mode you can pass AT_EXECFD to an interpreter and don't change
> the command line. An exec like this is indistinguishable from a "native"
> exec.
>

This sounds super interesting (orthogonal to binfmt_misc and BPF work right=
?)
but a neat feature nonetheless. I wonder if this makes it easier for
tools like perf to attribute the correct binary or they have already
handled interpreters in the cmdline well enough.

>> Please let me know what you would like me to do next. I just tested
>> reviewing the series with b4 + AI -- pretty cool. Was a little clunky to
>> get it to work but overall a good experience. (I need to tinker with it
>> a little for NixOS vim setup etc..)
>>=20
>> I shared this patch series at my workplace as well.=20
>> I think there is some interest in the work.
>> (If you are curious as to why, I can elaborate on that as well).
>
> Sure, happy to hear other use-cases. I have a plan to make it possible
> to pre-open a set of interpreters (pin them essentially) when
> registering the handler in binfmt_misc and then bpf would be able to
> select from a set of pre-opened interpreters but that's for the future.
>

This is assuming that in prior calls to the BPF it returned the path
string to be pinned?

As for the use case, we use buck2 --
a build system similar to Google's Bazel and does many things in spirit
to Nix by leveraging RUN_PATH to create links to the shared-libraries.

We have customized our interpreter however the lack of $ORIGIN means
that we've had to maintain a single glibc versioning across our machines as
a platform since glibc has tight coupling between the loader and the
libc.

This has been a pain point for upgrading. I think the ability for the
loader to now be relative to $ORIGIN meanst hat each binary could
diverge glibc/ld.so and not affect the rest of the machines.

tl;dr; ld.so from $ORIGIN itself is not only useful but since it's
intimately tied to glibc, it allows for more flexibililty across our
builds (very similar to NixOS in spirit).

>> I hope you are enjoying your vacation.
>
> Thanks!

