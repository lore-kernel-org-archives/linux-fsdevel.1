Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793319844;
	b=WzsZ8uKb5nKC3ZpdqZMPu7InqpS+JtMRHiJARTadzg5pZL6rEq3n5QPQg4SySszKV0an
	 MZ6I+5TPhd0BG1USpXFV4UCON8Yxjfdz/F32AoQYxKKrt1hBD9bJhOifjan9w8NmrtJXU
	 KbW3zc0zfFH+DuBse0ZpbkoZjrU8v+GoOMKHGO2NPLV55Pp1Hw2z0GNwadtYfzYwIF5UL
	 CYxkr0l16Tv1EfQpUIQPjsimVYSCfDkriDsEvezXuy6KjKXDqpJ7JjzEQKsygZ8kZdfCq
	 AFMYj/7XnB/KfqSVmWN0UjNQweqdAYWna7AjIclWwlOpfHsRjREyv/Zg2s5HLeDYMHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VMmqUl9uJsPT0M2OBCk5mwHznWO8pexQECw7k6bATJE=;
	b=s87n3+3Pqrsey9BHpbHdrSQxFlfAVIB8EOel0eRtjatoljzn8p7bWOutZDFgA5V4/K61
	 KVLcYiE8hFh1ZTnZwOCgzUYA0t6sPEjOceGtPM408WjvOpYwFuwSxg2ajIvPPhhI3UezQ
	 Te/Vucg2AnmSPU4BQfAgPNv6tMwxSbJdZ7QrE2GChqQFVfjfzYahZ8kszPXfNyecgZa6t
	 raoSnRITeBdas1t/kXNzeBhXzIjDoycpM3PiNNMhi0nWni95x6BS+D9H2QxeVC4Q9ra2e
	 JPsrIdKgrthpDxtwxlEryG7exrmGZq+1uOgTNrJqgrvRDN+0Blh2g9K5RErDOhLQ1Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpGlNmog;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5431D606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 00:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5431D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpGlNmog
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c45551fa84eso15522366b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 17:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793319843; cv=none;
        d=google.com; s=arc-20260327;
        b=Ie8nfKKVyWNjvn/WWRLa5Ywg189ZWtjVOOYxOB2VJIC8O3QC3o/DO1UxwwbWMbpST0
         DXhTB38NjnjLK6CZotC1xYRSoyX64Yhn0uFJzor5Gfd4N8AG4CXnUseLvGNOng8SMaTY
         xUr4IjIAkoU/TZQJmAIqo8ilN6HzvT873nM/RW7uiAjTsgdsvzOvecb0WAySOMqyxoEd
         GBOnp0sJvtQcAoC4lkXOsoqDqNCx22VPXaCs342K70O1URcieyElxQAfw8nAMaC0abzD
         XTSvMm7PlnxZIa/g5Og46mXN8lMlIfh0iY3ukZUnYguiEHYOFXZRzpxiF9OpLKzjBEXe
         wFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VMmqUl9uJsPT0M2OBCk5mwHznWO8pexQECw7k6bATJE=;
        fh=zdCp1DQiClEschjjGuSEX/kVXhH55fHua7K4U4kqdEo=;
        b=bpAYckqO2i9MmxzHfbb9/jvQTJ8pB4KfVTO+Sz08qofZEGdoOyBdcU8p0FwDGxnOwJ
         o80aiSmOb2LgUhm8m0SS7ABHzO2J3GV6QYnZVD36ZKeTELHNy9+GBBigNglVpl423JmH
         rkuIlW2fMyq8uz4lpKameVyTsGQ5KlXpe2VZfSP1nDInFxOijQ/jBWFycxssmfLQZ4o1
         59BY1keQ3iGJ0kuL42sS7DNr32sYlmpYrzDJpnEbi9P6YBBL5I3mmsjMzHWYGuOGAMyp
         yHXKIrB2xvJz+1OmkbPFy5I15klFYGRlFEgCkWSgzr9zYG4RXJJKxJGB8H0IHoLnmkZI
         h2Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793319843; x=1793924643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VMmqUl9uJsPT0M2OBCk5mwHznWO8pexQECw7k6bATJE=;
        b=LpGlNmogTRImOIcoGkVK6kX1FwvGGuvBqIqbOQmm5KJ3xSt2iFKkzmTKCxMImHdVaB
         aDfTjwZqyoMW2Iv2ufgeHFBdYwUo31Cysp7oHlTZ5mddkgutsSip90Yu0xuL4dwsjPlG
         H2d2o1NYWkpAmpZotlXfjCTbgYadKtl2mltD866hVzSHDvqBS7/xSgXNB9gCvo5NaMp6
         UR5LppzANcnsvAThS9ZzZ+t3lqd2cQjUINGMXJlzmHMLf95KKq7TGISjrOlO8RGNlmd6
         PEsSvEAPMgc2Des3Z6s7C7VBy/qcyKQWcN9VLLn5h9MLqOJtFhjlOBczCmc7Ss729Ap1
         cjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793319843; x=1793924643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VMmqUl9uJsPT0M2OBCk5mwHznWO8pexQECw7k6bATJE=;
        b=Ywm9SCG9sEd7/d64+qP+VcG/kLeZkICKd4RllZJY+p0XFOxm/fTE03So9myJqPkdUA
         kmi7HS1hV+WVenQ+GhMKI4xlHICJp0CUqitQx64axlpfr0sxQUESZ9T2KQDz/TJygHlV
         y0XXmpYC/GSkCWU0N5UsdpxR75Ey/crCmBsSlrxESIYREltnyIc61/A1kUnMPy6ECapo
         G7IqF4B6BkigJD04YxySKgDG/8f3sJBNFlQnrjXhNLC+ET82uXXQ2mLOEU+5HMu6r3UF
         INVwN3puqz+TLYR+VJ3vH+OJdg2b1+8i9h1trzp4fYInc5GuKi6CUF8Eqy9wOZ2dBcqX
         vzWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxesY73Pk1+5c3Jvh8x3ehiPBiVqmIXPhIDx3Pozwzqp+rbyLkCKuSTfOaAEsfFNeK+kDL0frWmD6UeuS5w@vger.kernel.org
X-Gm-Message-State: AFq9FYIUHZz8on3MQZnLjtMhKzgTjtxdpInSnGaVo+2DUS+H4qZacB6J
	xyIqzn6QFEqNkar7/94553TsRXvTMsgMFaiYLJXcgFSF0eBhba80Rszs6eTFujVjxLDbEx/NsuS
	LECTdrUL4kA8vbyOR/RaOgP9C2VH2dK/WYLo7MDMB
X-Gm-Gg: AYBFou2i9fd6qU65USS5cs4Y6IT3yz+BAGxMT/h3YhoDidpSUjVbac5Uq//mVSeegTI
	L8qQARffl2T+eweDwTamQohgKwk0OOn5sJa57VlarvAim2Yz/QzhTkWdEA1OCs15p7C4af7xRlT
	ZyU8RGegAUr+MyqGzDf1SeR5STiCzJAXPxp+NhZSNeOffc5xCRsYqYZKHmzJ/Vwvd88gZtYW5os
	dVg+SRlGmJZdujj8EnF59IsmW4rMJZPGzShI/FuA/PiYsfZoZsDCRpuov6KDcaCmnez+3RwANjZ
	Aj89OJwDZHS/pDj5IzudzUrVkZ98xt6NFrjNnAiu3HHKTeUOzes8UKq+NZ4JAz9Yb7Y7mX4cLMX
	BIMwK7Uap6nAgOv+cKdQxBY0y0pgYgs/tuPZgOkKuTPFGcZen7LaKr9pX/cp8AKyF/C029AJSVu
	Z95jQOS5WBbD50LX/R
X-Received: by 2002:a17:907:6d20:b0:c46:7643:ae91 with SMTP id
 a640c23a62f3a-c4ca7a08673mr59997166b.8.1793319842360; Thu, 29 Oct 2026
 17:24:02 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <CAEf4Bzb--Jzz696u057G9_CgQN7zf6ksvoL80KJacKO2CorsnQ@mail.gmail.com>
 <CAG2Kctojb7xiOqTmwWqoAKFaNUECjOzXVc_t6KbG13Pqm2dbng@mail.gmail.com>
 <CAEf4Bzbs8F1DPBz=WXVTExrrNjzvaFsi4L+HEj+zbUTpPSTX5g@mail.gmail.com>
 <CAG2KctpSTCyWQHgJ8GyFEhHPdFawUa6zy0g7rkfCcujJRN6f6w@mail.gmail.com> <CAEf4BzbyqPC=RQGWEdpkqu1WDQ2_S0H8pZU2i=_gLuSDQtpFbg@mail.gmail.com>
In-Reply-To: <CAEf4BzbyqPC=RQGWEdpkqu1WDQ2_S0H8pZU2i=_gLuSDQtpFbg@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 29 Oct 2026 17:23:50 -0700
X-Gm-Features: AclHuK_8kDb2R9N0iMUoVO0Y5pzDVtS-1XOT4NszWcH8axoYKkVXrpd6hnWmpKQ
Message-ID: <CAG2KctrkKOTdsjWVRBEHuH45-9xpYsxDTk8PpZ4Gu6Ygq1Azew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:54=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 29, 2026 at 3:36=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:

[...]

> > I envision ALL_MATCHES to do some form of lower_bound() +
> > upper_bound() on vmlinux since it's sorted, and then linear scan of
> > all modules. Of course, just one of the two or both aforementioned
> > things depending on the module filter (any, vmlinux, module).
>
> no point in upper_bound() if it's sorted, you just start at
> lower_bound and go linearly from there. I don't think it's realistic
> to assume large number of duplicates, so I wouldn't optize for that,
> one log(N) lower bound + linear scan will be faster in most cases,
> probably

Ack, lower_bound() + linear almost certainly will be faster in practice.

[...]

> > My understanding is that the size is encoded in the ioctl command
> > itself: _IOWR() puts sizeof(struct) into the command number when
> > userspace is compiled, so _IOC_SIZE(cmd) is the struct size of the
> > header the caller was built against.
> >
>
> oh, interesting, I didn't realize we embed struct size into ioctl cmd
> and match it exactly. I see that pm_scan_arg has the same __u64 size
> in the struct approach, I'd stick to that, and when we extend any of
> them we'd need to make sure to either ignore or hard-code the size
> part, hm..

Ack, will include the size in the struct for v3.

[...]
