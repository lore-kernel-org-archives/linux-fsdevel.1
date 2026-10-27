Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793137573;
	b=o2eP6dyfTMFy6KLAS6sP3AHPuQJIsLZVPR0Qcpo8zJKZlGjTOM7q5DhBMkqYikTa/O50
	 7JfxJGb7W4t92smB9nf/P2QazWVEAbjOl/9F9Xh3tPT7RU7oTPACLUH1P+waKDXaHhEHY
	 pvk77DCwrMcWF3igF04Uw+WrtZEFzfwpJRaOV/ExtBE+6t6Kfx0VZjv4WOa9Wg0etibci
	 ZEBpftC48mYhbgdIoz0pJzYdErmWjM7weFH5e4KrkILwM1P08BnNknEx9QnZx7E+6LsoQ
	 BEPV1eomSGTShkuXY1TGvLyXRRdDQquUGAYgGNBPSSn0V45tlVMoKSJmyXdJ8+5jHVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eVSNb0KQbTxZM+AQXhdYZUTzoSM560pyx9+jZ9Z1qdI=;
	b=L+g9c+cfOGHLJw0R6GoXw66GiofUXnFQxCWYY54YW8QasM9Y2ieR9O/utXXTDlT4n4HV
	 2XpO5moEO+hKLd7N5oRgEgVbmJoGmaM9DMCz/PsoJUxrS5U63SAyEI8buws55t6qg8fic
	 ZVaVNII7+i9uP2Qk/ep0FFTAJu8bR9X5o3q6GMHsa/fw5n0vwuXWNwqc2oii2jJOk4upF
	 njFWBye4UhMj7RPyBS86kyKfX2JucSSGhxNV7tpUXbXivDxWiVRv9T3sG9Pfs1Vn9teEN
	 j+MHPjPDAY5GHfSO+jkl+Gkicf4JWq8C+PC/KCzprLfvlkcPjqrrTtVPapR3pJOFy4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wbne8OHp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADC606A320
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1ADC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wbne8OHp
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so531204a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793137571; cv=none;
        d=google.com; s=arc-20260327;
        b=S65F48VZ7xLzbDi4HGCjw4/WKjr0eMtkq0ypMiBb6hkYsTbyXWbAAV7bcg7jO9us84
         f0TNLAt8PKSimGbZhZS+nlRvN8eDixM+ybCwzOHT1Lpl51fV4eWftFSdCZ72sE3ePoxv
         6KPKHgW8chlnKifoegNHReQ3oz9yLSHSyuACLuh9EkC28nkXDGUmA+u3VhlUXAWV31q7
         JE3PatY1C0RY/N5lBPs2mThZejhGvtoCj9j7CfuLQS/CTxubwBnxHngXMeZV0g1zTBtw
         ETHFxbcQ50IG/zDMfDJ8cxCsDZ9UdPkYCI/bdhXNzeAMXdu3Xo2xgaO62oijGjcrEc2+
         XZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVSNb0KQbTxZM+AQXhdYZUTzoSM560pyx9+jZ9Z1qdI=;
        fh=Nyeja+PAgGJXw0sVbeV9anCFnaiuSqqzaLAWgFGb93w=;
        b=FoEjU1h5S8HEV+/ayCkWZ+4VKSWJcd9fJGfsXanxlDs61BGTQC7SHeXnyf1gcZ8FIr
         mv3VzTkSqJvJVX+0pScei16Yi5TaK63K4G2dxJClTljuq/hnAiLopvN6V1FKvrEaR7/s
         kykMfS48Z7H3btRlQ35r7IqtQ0EoENjK0/LOWYhrMhr60UjerkahjA5v8Y7r5fcc4gWC
         UsQmDlS+sSmMQ1KW44n9FlDm5guA/h6SaJgrW8hS2CFWekOHopOIq/viZODx3fqNmCXO
         ZNahbRZO/Odv9vSnmIE0jNPlddkYTudX/krvkqEtzVD+efXPWd8Sr7NI1Sza7fTqwLP9
         /ilg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793137571; x=1793742371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVSNb0KQbTxZM+AQXhdYZUTzoSM560pyx9+jZ9Z1qdI=;
        b=Wbne8OHp5wFBPP5dxuR8+Kp5ZHrm8v80mBFme9V3XRymOzyPXT+ANjuS8mZtAutbOt
         ODy1sui91Ycwohd+oEsUjL53uPSBpLjWgEgWbT0Ma2aK7Hvfe3g01z4xkvRH6s2A/fGZ
         +Zbv9XzVpEdyJwXjAhRmHLJ3XY730+XSfkzgh8qi4omMFnsRCwCi2Puq9v4j/9LjCquY
         7A7TovQ1C2rR2zd4geupuZI+05Cnugg1XhJ4MHSma5JAUcS+LWaaA2qCMueEuNn/BKvO
         xSW9c+bot29ZINzBkQ0CD12vMG5F6NsY2dux4jMT3EVU1twWW7mORuqkOTF0o5JB3euK
         EGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793137571; x=1793742371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVSNb0KQbTxZM+AQXhdYZUTzoSM560pyx9+jZ9Z1qdI=;
        b=ZjmQHXlqJ20zjqlBO4yEyhqIxEmLuNRmiluxf30aN86oXed6oClr4FXglkOTFuc8Tc
         MWUgMT7Zv9tT66OKW6vqfG+7OoH7xVB6o/lGgFz5nPBmJhG1B3IlTBrASnhdU98ruXA9
         4xhBVlDAhLzI/JF7I1mGxWQ5iiIC6EIXwh6w+9xd1xWgXfzeuF58yTmGBiP2xjAHUB4i
         EraqzHV1Soo+nwNCiMatwTE7xPdretl1aKAEhY4D0MOKUyxrtvbpIo+pq3MJdJr2lk4l
         kIjjP3DvhdZEzWuf+Xlhw/9ohr9FUdX1ux51QC/KKMtcOugkzOQLw+6RLwi1izRw1lJu
         zItA==
X-Forwarded-Encrypted: i=1; AKwUvByWQHEQci/R0GnnEbQo68Ise78bF9PiC8RUsIM52ntX/odgMVCcFtYVwwTPtGK5oEnYE+XThzvnXb23siNn@vger.kernel.org
X-Gm-Message-State: AFq9FYJwC8PgWBRzd42kc51qEAAFkGoKSGQ9G9dRdHNlUT7jr7S2BKVq
	0TTzVLxvkKMnNVqUwchnFud+VnfFMXZlEqj4S3GGGOp9pTi1XPfeOXoJDRPqonZI2Eg7xRpZhBO
	/IOkxdYAdNtgMsYzM003ijKlYJv92gvOEP0XYYCns
X-Gm-Gg: AYBFou079AokrPrh2rAo2qoePVsFrHq/gr0T2FvazO3In3LcBOKv+vZZOocCwYQwH/p
	ZFdv2sDj3MudNmvDSqscknMXk03eQzcDI3GBKoyqO8MUN+az8BC3jFWWeK9pRJFYHf8GFvczqDr
	r3szlHVI9LFO/h6caL/PT6XX+bccTdxXvece2RgFlsfWIVZjHUOP9WxN9aqy6tlRsraqLugst8t
	mjLACiaL5nryys7NHsOIa4f+/z8C2boe5weoxyLWstYrykGdKdCIcBevqEDS5RhY39fDcUoOyfD
	b7wHcMhdENPSO40jcFN+4XXmCOVdTfX8MsMSZI1TJxigCmc11cLZmprV50fz6U3lS61CWXKJEB4
	+4+EkP9iEkalu4VjWQxNmR5zuus3D5f9n6zCetqTfHac3TLieSynkqQaRUQqNZndCfUc=
X-Received: by 2002:a17:906:794a:b0:c36:7579:fe6d with SMTP id
 a640c23a62f3a-c49bdf3769bmr41163366b.11.1793137570881; Tue, 27 Oct 2026
 14:46:10 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-12-wusamuel@google.com> <90371d2279a5eb08966a82325922e1f15eb93560d4019f5c9020956cadb4120a@mail.kernel.org>
In-Reply-To: <90371d2279a5eb08966a82325922e1f15eb93560d4019f5c9020956cadb4120a@mail.kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 27 Oct 2026 14:45:59 -0700
X-Gm-Features: AclHuK8QaCDsAbnjPaGufNN4kMFz5cqAaOc_WFmJQjgBqVdaEIaSp_a56eCEZoc
Message-ID: <CAG2KctpuWLxdxB+LzrBO8eGsL2E0m_DphcG4cauB0cHuEDEoRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY ioctl
To: bot+bpf-ci@kernel.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, andrii@kernel.org, 
	eddyz87@gmail.com, ihor.solodrai@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:51=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:

[...]

> Would it work to fall back to libbpf_kallsyms_parse() for typeless extern=
s
> that are still unresolved after the ioctl pass?  That only costs extra ti=
me
> when a symbol is actually missing.  Alternatively, the kernel query could
> match the .llvm. suffix for data symbols.  I did not find a fix for this =
in
> the rest of the series.

Yes, for strong externs. In v3, if a strong extern returns -ENOENT,
I'll fallback to /proc/kallsyms to scanning .llvm.<hash> suffix,
keeping the same semantics as before.

Weak misses must default to zero without falling back to a scan.
Otherwise, all objects marked __weak would pay the full /proc/kallsyms
scanning cost. This is a slight semantic change, as a weak symbol with
a ThinLTO-renamed static now resolves to zero. However, this is the
behavior of the light skeleton (gen_loader.c), so perhaps it's
acceptable. I'll note this in the v3 commit message.

[...]

> Should the fallback cover any error other than -EADDRNOTAVAIL (and other
> real lookup errors), or at least -EACCES as well, with a pr_warn() for th=
e
> errors that are not handled?

I'll update v3 to log pr_warn() and return on open() failure or lookup
errors. And then I think I should reset partial state and fall back to
/proc/kallsyms on ENOTTY, EPERM, EACCES, and EOPNOTSUPP.
