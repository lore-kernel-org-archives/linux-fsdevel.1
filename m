Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795638304;
	b=y+A+Rw/mUcjra+UlX5d0h3M6shWWKzoAzUnXVQNzbl/LvkqVDHEIAfrBJPD/knVN6/pv
	 nsmCqjLtMdkvITIdg7Sd+1CyINNz6e+MdPrOUE7v7B15n5OTV6lFVr7Zonoo2FCjOfQte
	 VS+foiobdhKyJdc49E0MjgMqZoDyxNr7gzJIs8tXKAMVNs/zCc7fkdL7kot8h5sKNMA/e
	 eNMaOBP7Dcs7HZAHED9HMCdB7smeZXvPnMW4vJE0QT5swR6xpHc8gTAaXapaZ+hIVQ3OK
	 4lwAEfjc2JEv6zrQzJZ0DMMbiA+S1AcPu18dJLsVy6xSn2HCdEl1w+GSkuHQRCW4CYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
	b=bMjRF05kl6BsNbE/1glrzu5NdPEZkNV/+Yvnul2aeEj6Ck7wptZcm/s9R46NCXDbF6QC
	 ays3UoiNt7MIC6C/PraJu7jgzCsN3EvOe0PCcq5nF2CmFtCwELaljJ8d0nrJhk9Gsy1sy
	 1YOFTkynUcsJO5J1Q/qtUY6kBTsoZtm2aVbq6DW62nJehpinawWS+S6kXkOkYplousNbq
	 Sx8L6Ja2M1Xe74h1GwCa67oFKyUXl7CwR2o3s0pi8M92EGs9zeXlge3MdoHVurxG2kFhB
	 /PVka1kIdMgcu2eD7EFxxCBa3pu/qk1cAMgg4gSoOWtK27EnKkIdUadj/YV90xLVY2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxpVsnDh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93636606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 20:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93636606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxpVsnDh
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so36461385e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 12:25:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795638303; cv=none;
        d=google.com; s=arc-20260327;
        b=UIervPMOgesBZnYkmMvTo0wJfBuAOz8m6tOtsFX+AgpiFrPEGVNrFT6xxo221Dp0CX
         0MxDI45r7C8VdpBAEpKyRrEYlV/mx4OKxQahDIgH+ynEz7VWTQmEX7Ash5ePkBMGzzD5
         Z4i3qxtWMgrT101CYy+9MnszDKBI8rmJPq9eQq+3X7e7fRnKlXNbUXusLBl3yqDD/KWd
         7GmoV2+wvYZUMBXwqUDWcHu+ycf0ylFLuxLQBSN/t740wtGdWFFb8kugTEdFjCEqe0CX
         d9SDlqldUNSO26hBPRjNPwJ/sA26Ft8KHah5FyE1vlUhsnjdrzuMDa+3TY4RkCVVabio
         9Y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
        fh=+IrGPzkJjZs1fDrE6hW4opCXwEayZGraGsQYqahJTWs=;
        b=KBg0GGeziDY727dTnoLWZ9fYmorXsR7IIlWvXPHAPguNPSguz1dEC9sVILHqJmbdch
         ylfq2WigP2w+UQoCRYvTQg8f1MYQcsghSYqfAySja9DiryolpOfQHeUl3hVfazUW4qI+
         grw+kFi/AYMxw14/u+s0yj5zDtAefXjEukPeDaXs6jvytJfXE/8NOknrKm3+ns1S7zKw
         J1bVS97PjfUpegAkMoM3nktbG/DxtRAOFSSUcGtM7nZxb/MHfoCP7GyvC/XwfQxnjFTU
         g+RiyzwVCr85tZmoAf4zy3h2ENYXZxv+ysSndYlQM1PVJQpT190zqkQXnpvqAXwRM578
         9Qeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795638303; x=1796243103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
        b=qxpVsnDhKpASGf9nC11h7i3rrzbhgE1Ei3PO9P37aCNXYSI78K7dE3d/HkpdwHszrk
         LY2ewZzhpWyuiXGJ9Y/kVXRgwoqcZjc+AjjGTm6sKWOe26uegothRZycWdOMEmeKaehQ
         rcee0VmCBD9LHFqBMRGKRgu5+yxn/QVPc8+S1f0ZhA8k/QuPVe7lO4kH9kZ7PLYaSPsZ
         UOhEiycW2Hi29WbdqTe9JB7fMqfgVwt5DLrziudwFU1jlESg26yCSYwEh1zt9b/mn3Al
         7ZA2LJwSY/mdKqaAvIEdHaHjwDhtcY5fLQiXuVbUxvNBi+V1wIvq+poIXwdOZVw4io/Q
         3/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638303; x=1796243103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
        b=BWVf+JWLL/2WbCJ30jov+UXGNNxp/I8lWgUvQ3+f0tSo0qW3w5zIewoFp6V8deb+ak
         NyVyqJQpEv3DwLce0StKTlkn8hwm984dBBqC+RorNCy1Ny4FmSofETPttt6JDfP0PElP
         A6/in2zIz7ZEIAvPpg6h30VZrG6lJpdqSA1s3WnXCT1fyno37EYhvH94f2nwcHNkkczU
         HB/xa/bwUlRODK3Z/5Kfvq+LLlAGNdFJaGAR7HD0FJsEQKHZbaomtmiCWubKLHa7RKSo
         nW7tVz3cJzp05DvCj+CpdiDF0So3323JBj56zePGingaODYntqA+gEnXjKZv+ZdqSx08
         YpqQ==
X-Forwarded-Encrypted: i=1; AL+hErE+QwUpW+l24Dm5ceaY0eE4jT+F+zUA/UDz2Q7jIT8HvSJFIxX8QdsdxcVqyB1TgF05wHLly9ff50AULwrV@vger.kernel.org
X-Gm-Message-State: APuU4Z9z73J9qK/vjupyD3bx/Qdquw7jvGgyR05NNsROMs0f8zKBodat
	jdPzkvDcQGciZ+ABpFKio72M4z3PxOdqTmGls1EvHGzgO8shOnw3jiBjora6UwyE8SXzHIAVMq0
	DJdOx7p8+QLM6Q/IEiGM8mKue8RaJ0vc=
X-Gm-Gg: AZFdTZd3FMORE+a/gwcLp61aTGEOd/uCqsdRyY0lMnhsgri0kXrW4SqABbh74oExoho
	oeXON5TsmeaQgYmhjoC/3xB7qe8EfjtGljLU8IafLOU0Mq8pZYSyS79xDdxIgZOLQIWlKpaDUoT
	c9o1KOJnslfw87L3M8s61zTLvJVz86m7idCjr23c+u3S+XVrdnJbFC2ykV5igERuFCIkn9ewmnP
	+gwBA2TT0gbGeRK7CNFlusHjcpf8w9i6DS1N5YG29g3zN6+Wxz1nMFtHvlS33cHhx3OreFd3hsq
	lxjK0n8AdwEI++0ewLZ0qmG0T62r6Zn69Lp4c81uDoGKGRHmRcTrATFibNHW0iZ18QJO26gejeG
	7GEHpqFO7DNMzCbdpukWS1/D9WLO/9Fo1cPFVk41FRyfXpvsleB6PjpUcNSkXZYvDLb84ng5KUs
	dHbwtpDHOMPn1ZpziqhQ==
X-Received: by 2002:a05:600c:4ec9:b0:4bb:6a5a:782d with SMTP id
 5b1f17b1804b1-4bb88925fcdmr394635895e9.17.1795638302754; Wed, 25 Nov 2026
 12:25:02 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com> <20261113221248.3535369-13-wusamuel@google.com>
In-Reply-To: <20261113221248.3535369-13-wusamuel@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Nov 2026 12:24:51 -0800
X-Gm-Features: Aa3M54paGFwRi6x8xvkBaed95VaPlmoDIEKWnad49yMfBgn6GjtOde1UijdiQkw
Message-ID: <CAEf4Bzb6LQmHHkvB8WBezU6YRtggycRvvA3L03mQHDr3WQM6mA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:14=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> KALLSYMS_QUERY_BY_NAME, added later in this series, needs to find a
> symbol name or prefix across module symbols in one pass.
> module_get_kallsym() walks the module list from the head and runs an
> export bsearch() for every symbol index.
>
> Add module_kallsyms_find_name(), and put the shared query struct in
> linux/kallsyms.h, so we have a more efficient linear walk.
>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  include/linux/kallsyms.h |  7 +++++
>  include/linux/module.h   | 13 +++++++++
>  kernel/module/kallsyms.c | 57 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+)
>
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index d5dd54c53ace..d31f2f436159 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -24,6 +24,13 @@
>  struct cred;
>  struct module;
>
> +/* Exact or prefix name query, optionally in one module. */
> +struct kallsyms_name_query {
> +       const char *name;
> +       size_t cmp_len;         /* bytes to compare; includes NUL if exac=
t */
> +       const char *modname;    /* NULL matches any module */

will "vmlinux" match just vmlinux? or how can one express "I only need
symbols from vmlinux image" with this?

> +};
> +
>  static inline int is_kernel_text(unsigned long addr)
>  {
>         if (__is_kernel_text(addr))

[...]
