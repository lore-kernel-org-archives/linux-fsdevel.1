Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654191;
	b=m2myenMkhb+2AEPqxKkS34vm+V2IIh23mKrmBNNKNacjW/83MYhQA5LFyyBzlAdC9V6e
	 9kxCVoDQd9vpqegO/0NRFwJcucFjViks/e9giQQRNdgXILnO7NeJFRotEHeLlHvMBCEnU
	 1Mwn9IDvQO3ZEpPo3aPHfWbXAcVExNWsgJ8845YuaetmCJ52uxBjewF6/SAZZG6m6wAAR
	 pXcme9+VIP7NHpUpcFvoqtECu3GidzMkJQkfa3dyWZF1Dx+NegTVyhqxLp2FxWTpG8n68
	 /zcEeiJ1gFlM7mAWHDqWHpDo3fnK4/GvBkSmFhwWr3DhfI4/T+R/Lalx2SP8nhjAvyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
	b=e+VxJHcANWCBtZcmwVp7njMterm9N9lYWSUvd5+V07lfCysZj3BdLcOatNe6hCQsHoY3
	 3R0S72V7n+Sio+EAsOPP1AYa19b4yG2+4/u2v+BmHLX5ZxIhtDxEMX5/YjQsF6AiL7S3l
	 zq4YC573oM3ztZTX+GwbGyV3KLSdexH8j/Saqdq+RKxd4aZYPawyhzH/bOwZGDUmU9rU7
	 42+JNZXZGSF+GJRNWB72u+o2k0LECstEB2BETuZP5fyoa72oe22jJTwF3xnMg9EEZi3pY
	 B7CrW6MI2oSeIUL8rg/TIttj326KxQrmQ4rYe2CUPsRX0RHTbvBjTj9Uaaqmdy4JCqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TD3ha0rn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795D606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 00:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4795D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TD3ha0rn
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50e26763a4so105430566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 16:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795654190; cv=none;
        d=google.com; s=arc-20260327;
        b=dvYdKrK6YwsrZo+Ft4yzw6qTZ60sHp+NSZACB/a0ucxld2dRMzDtcpndxpi9THBBuY
         7Yv30v6UNXJGW2AfGp9OoqJ6+vLB9jqT22SQAMEE730eDP+LqosCNcLPsCW8P0ArXiVX
         TwVEYqPYuzpS995626tYLpWc8Z6UhPRp1HgqAziPMh0RsbedCql2tXMr4Bs6zpDaMmMS
         G8UcZKnQTr9rMB/z84lAWHX1BQLMd3Rj0IL2KM+icQnF9ANf8uNVNgrpF7umV+R9FB9d
         NlbplCreB27AehMPpuBDZXbZHY+PVR2nP6J4JMjNd+FQBUDj1nvHt4Lejetp8OWt9acj
         R4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
        fh=vx1+NICpBY5Zw6UAGwpAla5p6EafD2eZaudCC144L+U=;
        b=I6TDCPJMvsUpwdb4RsxhdJTI+ji4eyy8FJLDfpZQlwXk44ofcT/BqoaSfUIe6DKp7x
         6ywaabvYxZdqnn7UgMKNyHg9j3JkptIyfSVeI2ty5uFPwc272jYJDkwp1P40ZtjSMyvX
         eOoMPKm/HC7iwwJU8IyzprgLJjFg3LkTRoLDfi1jENgfmYUMECsIab5EycSacg0WL3Ul
         9AMFz4G+6RnP6MDxxOhGyQ7i7XA8YMxN1sWRiHkU8yvIb1mp8JaRHfIKKAiddjYsK8m9
         iwT/0fy2FFgRy1McdqrxyhtVCbQkHrLRD4GfefiVLY0P4le4/E7aO30icPxQrB2evqJL
         /ang==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795654190; x=1796258990; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
        b=TD3ha0rnSCMzB6EDdCanCIo2aztnTVsAWrsh8HrG5Y/aRrFlN2ndLBXw880f1YHLZ/
         QSfxPbJeIna1/g4lWyiIQwpwJD12i4G3TGAPhErD+7VvOdvbXoNFUGW/sZDUdcKc+k/U
         fLW/extCpKtDduL/D3vHzyoVyDpb/98nn+tR+abZco9jsGFWEFngZqgt6TnMkhRshp4B
         KnHYS7XEZFGjKsHdNaQA1fEyq68/xePBost3IMRVEVegEsUL5tFkIeCHeASNeG2SkZb3
         JP9uGCT2U7VP0g68JLBP9wLuAWo5qxzvzbWaRKXYpp5AAo+d01ZiPGTRjL3TT/PoWk+S
         RpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654190; x=1796258990;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
        b=K52Rkaz0vDxNfGqk4M+UBtXAUmq12Tmx0aU4EoFQdp3FcoCTNDI5oabDvc28bR9axM
         Jhd9Y/Dxi1fTm4ydpYEPkWqHrHZw7Luqsfjba//wfmoSbv2AGSLz2MhDzAXQVdjfRZsY
         2x0h+TIqNTFmPcMHPyzNSpjuwTmBJjwBkm+GyK988fO/qMf/LprY0QNcwRw0NDOUW6nn
         b9yX3uHUS0UxlnJWcTk8BKX1UVgqpxJG1hGlBsBBzHWTL4tbzlEsI0/zO/8UiuRLNpRC
         aFg67M6wBBoNLbfn0OpWYNWhru56rCzt+JljoQT01M4nSbtWnhCUBCGOaD9FQobtAP6m
         fztA==
X-Forwarded-Encrypted: i=1; AL+hErEc9q1PemsY1DbKKL5n3sgkUK4JEOvpthXkHn26KafVFGCKmov517FQb/58vxZ8Gv27elKS83dRDkbqi3b2@vger.kernel.org
X-Gm-Message-State: APuU4Z9Tas9jVHLXwWoh8BsdLEJ543IIzEJFUUQghyJGshrgLtYbHikj
	G3EqNGONWwvKiNCW+y5QSKJcjNCioTThgyTCStLdMwsGYUWU7vkqfRaDGSAj9gLuwjgyFuEUDBz
	M/cS0xeWa4D5soX1in3e7nMhL4rLocORTvUnd2YA6
X-Gm-Gg: AZFdTZdZTYCcpt72s42gQTpsNkrgdP5pbLYWfEsG9zdNbuCej0nWtIFeydiiIeJwhZ0
	jcTpfb5i+Ajf4ZoNyY9ABfdJrxS+3qoUR+B7ljkWrfP3TPXxfJDFxM5D5+++XaiRJ1kiOQ4EI9q
	vmCWSChDKMC1ysyV1wIWZ9iSvmtIC6XLiX/8x/OdpCfd0/RS0uZyoRwRxEA1OacNEiPB+f+rv57
	fsx+mjfBRGVmuOZwYBOmF1mdNAg9qrLh3p8SWLr/VtXeSXswk1QiWOTgg6r5n60K65dLFTutHYS
	hn/0tyW/fjH4zcIy53t8mA4fTkheNThfkYSbkQqhXNjVNoC+hvoKG0AgAJjta3hxgbac7RB5XVe
	0Jk7DEe/GjzpU2KrCvP6AYl4RR61NsGfol2Z8of0/xCMZllEa5wbeqgbf8u3sPGmAIgE=
X-Received: by 2002:a17:907:e11a:b0:c3f:98d4:dfe2 with SMTP id
 a640c23a62f3a-c513aac21bemr1112327466b.18.1795654189395; Wed, 25 Nov 2026
 16:49:49 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-15-wusamuel@google.com> <CAEf4BzbdGw4=yWxFqdFuz1U7RBSFqh7baJX=SpBNJJqnaW5P_Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbdGw4=yWxFqdFuz1U7RBSFqh7baJX=SpBNJJqnaW5P_Q@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:49:38 -0800
X-Gm-Features: Aa3M54ol7ULgIQ7PyJ4MZUA4jeAQllgic7NBQxD7ZgZ6wx9FC8B6-VKox80ApLQ
Message-ID: <CAG2Kctr9Bg+4uz+cKWw79S6qFRPtW_PRDt0rFY73F6WpauXG9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] kallsyms: Add KALLSYMS_QUERY_BY_ADDR
 ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[...]

> > +/*
> > + * Find the /proc/kallsyms entry that covers query_addr, or return -ENOENT.
> > + * ftrace trampolines and kprobe pages are not resolved yet.
> > + */
> > +struct kallsyms_query_by_addr {
> > +       __u64 size;             /* in - sizeof(struct kallsyms_query_by_addr) */
> > +       __u64 query_flags;      /* in - must be 0 */
> > +       __u64 query_addr;       /* in - kernel address */
> > +       __u64 sym;              /* in - user ptr to struct kallsyms_query_sym */
> > +       __u64 sym_struct_size;  /* in - sizeof(struct kallsyms_query_sym) */
>
> nit: same as in previous patch, I'd keep "sym_size". But hey,
> "sym_len" is even better and follow same naming as with sym's
> name/module, no?

Ack
[...]

> > +       return kallsyms_copy_sym_to_user(karg.sym, karg.sym_struct_size, &ksym,
> > +                                        &m);
>
> nit: if it fits under 100 characters, please try to keep code in
> single-line form as much as possible

Ack
[...]
