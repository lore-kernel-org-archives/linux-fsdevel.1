Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795653871;
	b=S5sn5mK8anTIKL1Tbt5rFZlozGC6mdc+/BL3ev5Fdt7JQZDOvyiPuEalTnxsGEc1y53s
	 +4rfZfTRAntmfDqRD9mDijGTKsdkcKlDGLzt6xDwlHe2Wx4a6SuM4X93TxWk03Eg5mBXl
	 jiZXbn+vVMMbD8jUWV15MMNRuBGtpW24zva7styOvh2A3MrX+U4azn8W6dYuI6Hm7dK7R
	 FD16uu5XAebhozD1aeSWWaASBdciZsmg+VGYQNHjJNcKBbcvo+/VZmwco+Ev5zZalNUJb
	 ZY0Geb/tFVKmOS8t2fRb/2hGObdv9Ofx8Iia3IMnnnn0fm8+UQw3mtP96herwjh+uww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795653871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
	b=utpIu3ZQZqXjuKjKg7TvVqk807KyGsqFCQkIXJU4MQ8FyUo5+ew859LE9ZIkoDZCH+i6
	 kMDFjAEAEVPF0lpPumqMNP7hX+chQMLmvkEZX6KtuW8jn6y6HNKKwmU63unG4qid1ZUde
	 dV0pbZATkVs+YW78brR7tJdf9WWLK1K4dsO+ROe2Jjb4RINsNDco1lYkaPxAaliB2hZUh
	 DQtXxYZEYz2IBqsPzq5shlnT4rwaOVFpjoYlrOmmmFisBMi8faOkXMOaFBBeijFUABXxi
	 9p6LJqXRrd5LlDEaUAeFPxz082VMDAODdpNCQ6v7t7NFWdWxH84TMYGmBpuGdJa5zng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TFVWM1nN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94529606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 00:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94529606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TFVWM1nN
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50aaad19fbso710160966b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 16:44:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795653869; cv=none;
        d=google.com; s=arc-20260327;
        b=PGa/uqFImIAuLIIpanba8kYiMv0PtJbA95PjmxNpxTsMF18t3Eod3EbhFN5fsBytme
         nQLogwwoXdXtYU2h0x/ZapBicjBiz0KdwLVbLhkgyKFZwjN6fRPOoF4ewtn1thxkft42
         r096RGSceB3ZR/T2+kyA1kUjpBrl/Do7z0GDh9sr37IvwmHoQQ8969iUwGk58azIxyX9
         W2twz45wCKrd/2iVMyj69+JfbY4R0V7/V4gxqYdmlcawYPvN7C9DwFjWzlUeydX3fFaQ
         oHg8EjdUqGc/LN94ZJzmXHfifrQxPbI+HGKqUaVSH9Rh3ZZQEHVB2M6Nu3lahgONoGQm
         tfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
        fh=Bbwf59PyngX6C4bZV4fIx8IZJVwKNzdf7p0LizCSfX4=;
        b=SdiLg7MSs1dZxkDlH8JNg5sxNcv4EbzZP8vedPp9RS49dgh9g/EVcZVf4gp5Z5Y33k
         1XCgN8hLt7xVluXUAGFOuoyQcqITrjLNmcVOroUSXLXNE7qIR7AlxMUr/pYwiL+YKR9p
         Qy3iXDRFHao/6PgkDCa/NYMpxPDxHCNFiDZbCHBnMAZ0DyRThJm0HkumcpTtVZE9ZcKM
         JJBVQfX3lY3MXTTaldNbOR7ru42eWZT+NL9EG0eLGtJcm/vgtf0HaV3EiY0GNqmA5Bm5
         aDPPkoz93qYUa+68KLe+RnJJbZiW88gBgQTM1pBFa5wqwcFdJgZ2x0178hzv2KMkyVqL
         HxMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795653869; x=1796258669; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
        b=TFVWM1nNu5gApS+aRUNGAO2b47beOviKXKAUtZcibEAeTqBUzqYaxbl/Ez5VQvaHiJ
         TXrTwu8x0jRe4t5Qky6cuxp9+qXTOVpIHPYaRTuFvweUNvzRuyVro3GhlyImE69z5l6h
         8+10BUgXaVnSQdQJL56ogVd0eoghwHYtJzCo3zCbsQwT+vD3SGCXtB3FiXNUreuGXelJ
         f7VR1BO5S+hnTUr9vyAHKXMc2Z8rg1qIpqzDfb7vnBqg8zVirP17bCZUWs0HZkfhTJwL
         aGZZfKvpUl1Z4/v5oLfuk517qMaRDnLShKckyF1bvlHNxOJLhAHLt0pu9I70jGnqlzcF
         ZJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795653869; x=1796258669;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
        b=nOOjT8cZXTTPiGYxVTKK5JyTlOdhXfIazl1d5iAr6BjVw4pghhAEytQfiDwcYYpJQk
         h6/gwg2UDQa9i2HxEUHdtdwVfiQIHy8cKoCvbyTPFH+b7Cb05JSndfGxTmfz3D3fIec3
         fvMmGzMTdlOn3C1XnwxtJSSdBqumJa/JajVPm8Q4huMvCwXgQNRVDfRK7tRRgNJxcQwr
         Fw/JaqhllGSTzr4zQOI19ZSX9S2MlsHwWS4OvTm+ldkPWAt6Jeu7AX04ghK2dym+G0Ob
         Qtp7rwn/08By21UKQYrhFa8CHyLU4i3mzU4YhDW21ofbipDLegimd6TT9ImvXe3JREOo
         mKzw==
X-Forwarded-Encrypted: i=1; AL+hErGqn4HzTmB2W1WD5m+UAatpyv8vBJPKblfwxI31Epqtjdve9WAscl7/sMNiKf7fbEvBvsgdTmnEAn+pi+aR@vger.kernel.org
X-Gm-Message-State: APuU4Z+9Qrb1VH6a0HydBB/7F2/mdzwfeeLW8+/x3RnMBVInHGLlNG6d
	RDCzJsB4h4RKeVr0h4shQ6sQ1tUJY41EmwjVq7Jeq48n+uk8w31IaarUbRmnpDKgjtLCjfp4GOc
	db/0iFENCoh43/5Fb85HbGCEdacNB80uQ9ZlEPMjC
X-Gm-Gg: AZFdTZdv2VctN2bLLcKfWPPKOex243K7Gdxuj5LeBDl4321AnfTDqzAyhH/sBlFHJlt
	+gs0/jJBf3Hg9gu/eZt5Q5nOpyf0AxcjXSaukrtf3nXi+zn8JSnXfh4Trhg8wWzBAiiZpVKjibp
	NTaY6KKs29/Qf/W3xmhVwTv/wZ2RB5QDBFDQQmYHcTzeNk1vN9DiM7VOKAmfk8b563SOZOf4x2N
	/z9knE19gpfp0ChM65vM5z+sYO3KbP4d+5kQi9n3q7cZIFjPB8pTaENalLCrw6OQzmrTkGM9l+U
	CYH9bhEDd7AQQA2LVRzIZeoVgOfw9sTVosS5mf1uO6bCoJusZu+bS6bMuPvkF+ijzGOECtLW8fb
	WqmPfoxlyaeDDxqfBWB+jMJC0oArSCuIOY+keO02QBYjdexrF1xjARTXBdvM8FOfO2Hk=
X-Received: by 2002:a17:906:6412:b0:c51:24eb:e5ed with SMTP id
 a640c23a62f3a-c513aabb094mr1147878466b.42.1795653868573; Wed, 25 Nov 2026
 16:44:28 -0800 (PST)
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
 <20261113221248.3535369-13-wusamuel@google.com> <CAEf4Bzb6LQmHHkvB8WBezU6YRtggycRvvA3L03mQHDr3WQM6mA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6LQmHHkvB8WBezU6YRtggycRvvA3L03mQHDr3WQM6mA@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:44:16 -0800
X-Gm-Features: Aa3M54p3EatRpTsPAm_mcmxJ6hPDpQs1114Xl7F84nCmfTvZhGsQScuZoJFkxmI
Message-ID: <CAG2Kctr+6-EESkYn+Dspg0FxTOMFRoj8269UZaNNDFNf3d+bHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

[...]

> > --- a/include/linux/kallsyms.h
> > +++ b/include/linux/kallsyms.h
> > @@ -24,6 +24,13 @@
> >  struct cred;
> >  struct module;
> >
> > +/* Exact or prefix name query, optionally in one module. */
> > +struct kallsyms_name_query {
> > +       const char *name;
> > +       size_t cmp_len;         /* bytes to compare; includes NUL if exact */
> > +       const char *modname;    /* NULL matches any module */
>
> will "vmlinux" match just vmlinux? or how can one express "I only need
> symbols from vmlinux image" with this?

At the ioctl layer (patch 3/9), passing "vmlinux" in query_module
restricts the search to vmlinux without calling
module_kallsyms_query_name(). I will clarify the comments in both
patches in v4.
