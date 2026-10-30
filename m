Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793320095;
	b=NRSBNx3xEQH3TVynf+Qqe0izBs9BExR7JzILntJE3gi9xWGT5w0iCp3L3wmc+mkE+Ov+
	 rteJ5xhFYRt1dnA9EPuM4WwW7s7pWqtR4qcHxw82G4G4tUtlZ56jdqRakHoTljWRVPzN3
	 BvdiipN++HRUcpl2IBGznBzjhDBdVUPpf7S8Tmo8OoKj+i+xBf05a9oM+yIqmh2DUSQrc
	 k65UHRkRM/vN5Pj0FOAY3B0gx016EzsnL8psQcwKR92b/HHQnP5i2/rMzSnWlZzw9pqwy
	 S6ujwq+drXG9lVx3TarQJaP25txDQLS8pvo8BCkdCOWtJH5pclh7bdemkIE3VkME34w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793320095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=brgLj6lJ9qrzkbEmy6aUespMxR1HwV6CvzIg1+zIkpE=;
	b=5VA6zgOeuUwzxXCB/11nQStrRdkfKrMwThAO86RUZfVugxRt/rMUYj7ODrlCf5J5KF30
	 FlJ/F20ffr2CHSRibJqWi7RIVZ/PUNYNBJZbJ++fIT60DJ86sbaF5+1kGL++6M6dZmhy2
	 sGP1aHmEdeXBs/4JiBqm7aNQ2JSkwgRhS8AEScHkAYXT5Qres7xl20Z7e10MxxxEKeszB
	 4u0xuOpI2w8/pgLb1PU24oAjnUlQWjwOJbGK19QWF0pY2o0I9xfkh/3/rCTlXFnWvaGBU
	 xewrCZqXcCjmW/4kyB0iGXL/p67sZLTZqQUTaip/QvzLFcDTSxS49fAIHCtruq+Me8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EPx92SD2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B1606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 00:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A7B1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EPx92SD2
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4682977f9aso12707666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 17:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793320094; cv=none;
        d=google.com; s=arc-20260327;
        b=l5QlnbE7QM1eXxj7MpiTrxyY9J3b8jC2gRAHve0I//52whsYFlupg4qclf/CuwfhPd
         j2qI9fF3WAhoSv3IQzAluwnJLjmokQ2m1LDSFZAAZ5dy15hs6f2GEMuQZ8FHVObE3Bzu
         uECVg48C4OvmnJtQsaa96kMcELiQ758LJGsJtavxLHvjhAlpsWeqzewyLJm5TZX9SkGI
         HmQ09QPm2Q4isnGo+QXdE85k5nZxyyXl0VIWkmh257kxhf0O9aMIILO39F8i76WpMbDW
         IkNpU9XHHzKSuYvZJqHixXp+Vvcq3DQugb6rUiSZQS1+DgdYy+VkYxVABxHqvVQH5rzU
         gAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=brgLj6lJ9qrzkbEmy6aUespMxR1HwV6CvzIg1+zIkpE=;
        fh=VipDkaDGQHh+G+6qoH9Y9GtAbOfEq/Fl4BC01637N8w=;
        b=FoesWNO6nCta0QuyULltcKZd1M5+a0zMKiEVwoNOCa2noPNA7grozZvvA3IEiDM+hR
         q2wQIl+O+ZJNxf/B1HNseENbAXlWTpkaYfK65CW1WisR6j1pBHhwjWsSJFJBBHZdscuZ
         Fmt5Q3VBChcrW4i51XRXaXbGVthKnPxo9jtuVnXHyfTqFZ+W1+ZG09E4mu8mX+8Ik/h4
         K/q1oYTRTYW22ebjkHSpQuJz8FqiQaoR+Ndt6Nd27UcibolXcP+c+800H9L3za/q4Lu1
         jOqaRYPvFuPMYdpKJUC/o86xMLSrEADL5Io8k2srcsZ1c/PJoQvamRika9GEofN+bbY4
         yLEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793320094; x=1793924894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=brgLj6lJ9qrzkbEmy6aUespMxR1HwV6CvzIg1+zIkpE=;
        b=EPx92SD2/nlj7Gy51oiGKSuUhEEV6f/QjPP90GOkDFVvLeS6MkjDeipocwNmUYAOHo
         Nma4hshQFzy8X4MAfiLVXTjTch8fzebGbKsTHtFJVZmvtcJ/XLqiU+X5MXeqsCMVmIYv
         Za79hAeh1NeJmDlCqaGo8wCd2EdswfqWUwrXH4+pxbUG3u1MGAduayGdfH3uUrZKg2FG
         eri6QEgtNhdn53F3TkjFc1eyvmQSMpWYENciLq1Xsp6jUql6lXYYI0BBLIWwe3DleuAP
         Gnl0sybHD7FswrWEWSln9OeTt7tTQs+RyhYAc6FCxYbGnZJZKGP3TlK3uV0H5AyQZyiV
         9+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793320094; x=1793924894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brgLj6lJ9qrzkbEmy6aUespMxR1HwV6CvzIg1+zIkpE=;
        b=vPf+7OwgWGLZzjdZz281kYSEIaFJ4+zn7bOzNPBvvQWUBK8mgkFqFHw8p5Eqxe1GII
         VvDtuBfwpzN/nqY5zTR5isQPUzKI/Yewgy5QutKaBDQxj9gxIb69o8nfN2bqZR175fNL
         sK4NdL+MN8+FZkH6uHtRgSBjWwNTrgKbZTo3IrNRZO4WgDwe+Zik80UGBVHqV8J5pyJD
         Ctom1gHqT0cdW9/4oTvnAcYSvwrS4ptPtDyKphNIgON3xFt+T9XGopQU/X61HJn7i7ZH
         ehoaVWqdJ4JegJIyY5k63sf4FOQpO9WkGIT3ylRgQSirf5VRQe4Rd/TRvkuBHMaed4A0
         6dOA==
X-Forwarded-Encrypted: i=1; AKwUvBysfL0WC6NKTzJ49tHzOW7ZWk9Fmx+GfE20ggCEIEVVW9j5bQNXZYyhvtVx32J4M0A4+SvPESJhpqCd4d/B@vger.kernel.org
X-Gm-Message-State: AFq9FYIx+ABLszhAVoVAIBXMzZ+6Ajt0wdWc2lB+nGxFooIWvEgT4dKn
	NxS9ErK5xGGXZ3HTKHwicUcElX4/5Zjkp1x4ydxi6KxpCx6EvbAztx/y6ZXiI8gfNj/vMI7cNxT
	q/0WRa+0XGBDAtE54GdOZh6U5KXuT9Wr4Z89wqqf/
X-Gm-Gg: AYBFou2/j7MrRLuZIN42NkpOTMIdeV6b2DVTQ3TfBVKaM6q2HGNr+fnha5+Gm7XWdpF
	YsNzNE/QnUxnI6zyof4lgHfzIK0+kGNTtSFi0NAqrcdLlCleOxUqCDMAVdE4sbkPsKTMyWKPg9S
	c+6UYYCSo5Xlf0X4aDZghQUEnIgOrmRJJQMu3OnLB0NykIcp3ddidLDsDTA71RJEIjJJWo9+IAs
	rACcXEl9kYxFS47wsIPj2LDfF0PtDnsMxmIpzq9V2G9tjfQMjTmRbLha1CAKEVsCh06ZafxOMbd
	gZjFMpxdIeOSdr5Wr9i8q4QyFNRSjnbtuzONeThJgF51LWEZ5L99tPeLdtf4LdRekheWgvM2YXA
	dkw22CKHRxVwF7JXJxUKCu+MMIMDLlZPDj1gR8yKPrISosHbskbJ/FXipb2WImB+uJFp66fY=
X-Received: by 2002:a17:906:730f:b0:c49:a849:cb90 with SMTP id
 a640c23a62f3a-c4ca7a9b33bmr56944566b.39.1793320093443; Thu, 29 Oct 2026
 17:28:13 -0700 (PDT)
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
 <20261028134012.01d52e94@pumpkin> <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
 <CAEf4BzYT4rvKwbOJ6UQ3zcp4wdsSBqRsMz-2=U1DA2RyUA3XSg@mail.gmail.com>
In-Reply-To: <CAEf4BzYT4rvKwbOJ6UQ3zcp4wdsSBqRsMz-2=U1DA2RyUA3XSg@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 29 Oct 2026 17:28:01 -0700
X-Gm-Features: AclHuK9TILtLrldY6faAGXZBT-kc2c2frEEMYWdaANb8mW26TierZlqcroORRGk
Message-ID: <CAG2KctrwzWGFRs6CZcSRaFOWx49WbH9LQVQJunWsPD3MOXn_iw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:16=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 29, 2026 at 3:06=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > BY_NAME matches names exactly, like kallsyms_lookup_name(), so they
> > would be different symbols at different addresses. Please correct me
> > if I'm missing something here!
> >
>
> foo and foo.constprop0 are different functions with different
> arguments, so I think we should distinguish them. The only special
> case is .llvm.<hash> because that suffix is added by compiler for LTO
> and I don't think the function itself is any different from the
> original

[...]

> I do think it would be good to spend a bit of thought on how to
> support at least one-by-one pagination from the get go. The same
> mechanism can then be used by batch version. I.e., think what can we
> use to provide data back to user which they can use to continue search
> after the symbol we just returned (at least for fixed set of symbols
> in vmlinux and modules; we also have dynamic symbols added for [bpf]
> "module", etc, we should support those as much as possible with the
> least possible deviation, IMO)

Let me sit on this a bit and figure out how to distill all of this
into a clean interface. I'll keep the .llvm.<hash>, pagination, and
batching in mind for the design.

[...]

> user code can be easily written by always setting buffer size, even if
> kallsyms_query is reused. This is the pattern with PROCMAP_QUERY,
> let's keep it consistent.

Ack, will have size in the struct for v3.

> also, returning actual size even if buffer is too short is a good way
> for user space to "probe" and increase buffer if necessary. unless it
> adds tons of complexity, this is a good and flexible UAPI

Ack.
