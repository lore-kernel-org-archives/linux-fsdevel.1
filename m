Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795653751;
	b=mQRYYCo9TYHqN3ekrX7oe+PhIO5k9qKCgnagaXflYhH/Gr12nvVviHEUaVcYFeOmXgv6
	 e1bDbY0nkO+SH6UCzVSChCEimsjQAhqdp9uVS9tCzmnEfzYe8vKoS7YkWNP9OqBwFW/Pu
	 IGsCp5d3DyZZS5iHw60eua9vJyRTkSsICMIEN/qHJ7PVILzxWP/2btmumFIsdNmnaGFvK
	 /CBIrNcOzU7kzEbqTi4AzwibvfhzADAG/ceTpTWydN4KdBihg7dTLuG58uJLMEgsxRMxa
	 BoeX9HJ/SBqeVZUEP2EtG7dIZzYmI0F9E4Wv7exbPBKtKfeiYwvpZ2bmqGqaciCuBEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795653751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
	b=SM8NouK9x/To66xC3EWW6nbp/QyfRaL5JBuTjaK5cHTe75jprDceDrdA1/0JvNpfGuQQ
	 ea2aHjIKGnP+p68OJObQTUcNaWuVVGNYYI7pPKEfQ9z+g4MrihZ7tbfl7P7PERd6dUuNI
	 ffGNnGTNPrb5FJr3X+5/TS0JVW0FseJGYJZOXl3Tf4A2AjMFAGON4MehhaZCYJQk/Jkak
	 ekL4nQGocJvbRn/AdjhQbdt0TthEhFPMjbaBUg+5aeWkPIniods8ZOJCyLOiSF8wO/rod
	 FURE56QirVMNSTaDjxDpWNtUSNDF4DdDVbAU5Dv5i2kuiK1aTFjUCFswm35bHGqWnPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpN49+az;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249F606A327
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 00:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D249F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpN49+az
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c50e26763a4so104781266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 16:42:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795653749; cv=none;
        d=google.com; s=arc-20260327;
        b=VRSYJsRWVakW/Yce2coi3EdUbDz1VZKatKq0zwhsFXDXgeg6zyZseDurweKljp4LwL
         X0rW5wKPTvDTu3e762KH0lXUisp224RPnNgGBle6PXUjeEoQ34w+YshewnT/HBq8rzce
         4JLXfxCDjUNnqQZry9wtrQH8ZrjaTfiw/f9wSqKgFO7oTNdD3Bicq42WUaGSvF7vnJrx
         DK0HS/mi91ULY5dDNUWmIvOU/YXlB1iV8MZAJtnW/smZXECu2aR4Rp4RtLsQAFxUTQAY
         JyQhl8ll8MAYYgDcVCazEOhBJaK6/wauZtBEIEl3m/j2rOlt9LwqPqepR6r39m13CjFu
         gsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
        fh=LT4XdQEmiZdz7FVWryORlEE61BYXzU+F0PfoFKgU7B4=;
        b=CPpmZat4pHjB3pQ67beiZRJpI+Tx4nMEc8yLjcshydU5hGIP/CT036FrDjNVLhM9Zs
         E0v6mvebUjd5Ay/UQQpWfbglozG+3/oAGCHDgQyyc+0Hq09oAUKsWd+DAjikaKYHiQMB
         Y3mvETioe93Lb9akkv6c8Cv9sdZMzTBNXkwwGGqcXjPdEcGOO/z1rE3rU16t/L81XARj
         fCEqtlg+IHhbLedvDZE5z712ru+IXAZnwzG8NhgPNYNWgYCJ9UZqIHWImEIqNFSmAxkp
         UOrys5c+JUTe7vKD3Gvrwj9XDVH4jsrzeXC7fAI7/6ejzRUxD8Jd0LHy8iZwN4Z3Z9mm
         FmNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795653749; x=1796258549; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
        b=LpN49+azCIrNLot1wWdZkbi4Wt9+5r7MX19ZP740YGH95NjHPkEZ3J8iTn5nZs2aU0
         YtfDizzXcozDLpMOLK52IGL19BDPPkZBwwaARaxU027w//2VU6VirePpo9PC6B6/Gvyf
         w2GVoXFxRvXbXsOKb1KJ+C3LWAAUbXNTn5yq/DRtNMB33KVLBN+E7CMg2n3o0WEACasU
         2Rm6jn9HoFPOXbo7vWifWbukhD/T5j5US9xUFhxajKYt4rvNrF1rO1KNwomR3ZLuXZ6w
         QUOmuxgTXoYSvlHBVpUm9Y0LfNn1TpJbekKTAn/WwvKBAhjn4jwfG9HFJEBd61cyDiFr
         AG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795653749; x=1796258549;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
        b=bay3iMGUK2dV6tsS2kUyUpDDsAVKDt09hhohSZQ/A+n7+botmIKqMCjMNzsRTMlLVD
         r557PXHgxt9rRcetvrlcVpSOOpZMke1KiJEtwTMYEeqvh+GX/WCpWoi8pSRq2iyIhyc5
         PxE8z8RkiV3SFPtf7sxmKfliV0O+ftwKMwdOKU/v2dky1Hs1Ff022E1Hl75k3QVGzBRb
         ucpMIPglL3fUzLXwccyKxsjuFgA3nY6p/HmMDLQltCfemTA53uX6J3c/s9UfI7m4kB6G
         QVWM9FCLembF/OBsAs3WhxgFtPnGw6AVgwgo7C1sRHxQ0JMKdhwx/jZ+dOGm9GYoT3KY
         kpew==
X-Forwarded-Encrypted: i=1; AL+hErHBSlEID9FkOmnEnbrTcSJbrV9obzfgXCu5GLqI1KIC+e6PJKWnFzHQzs5KQlGo3kv0eFcysrlAlUj3/OMP@vger.kernel.org
X-Gm-Message-State: APuU4Z+0c7j/xLRRiHRsTZXRiNMHQyM2W5iSbnaF5UjsnZQaajVtqeyS
	FokWt4CWVJyCgWfstnLDLYkPqjRmP/Awi5ZNL/6rXz8W4/nDnwyGb+seonSnSiv5QFOhRWwyzOk
	n4h/jQ4wEQFRWxh3ncYCdB0j6IWmk+JWpwmTMT1LL
X-Gm-Gg: AZFdTZec+Abhe4eR0fV7e+9acNWQjU1WRJV/ek+rLbPktmqhPftkBKM8oDsSWspqDoI
	BO0nSlckETcSXuPEmraFR4gSjv2M1ipM6Q6EkVtsafil7NQf2MTQecZw3F1Vw5hBD1BnLDxsVqt
	TpY05vWaEoOF79GgLXPfnTM6fDzmRc/wRrwj0jZK1RPCRCKltl3G5QRNc8JBO+shFuaZ1flCVDT
	VontUAGjaYQ+aSH1rVIKBv3sAyHuBDneTaQdcCvw2T8ShGj1Ck2cvGPg/KlgflNwvjDFNwhKYHO
	ZaisUq/oZB0XT72P514TKGet6L04ZPGNAAYWlWNFtISNlWJhaquWFHzYt/Gt6gBBsRQ9Mjo5M2D
	lJIFO3uYtEbqhfilNkpGmb5riEm9FiL2qSc0jHioazeXr0bymEYMFOjfm1PecuQxKu4QC6XTdBM
	tNb7x859Im64q0
X-Received: by 2002:a17:907:da1:b0:c50:5275:fb97 with SMTP id
 a640c23a62f3a-c513acb5e2emr1626085466b.47.1795653748662; Wed, 25 Nov 2026
 16:42:28 -0800 (PST)
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
 <20261113221248.3535369-13-wusamuel@google.com> <0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
In-Reply-To: <0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:42:17 -0800
X-Gm-Features: Aa3M54rYVczs2SqMo55_UQYl-QiaJqAFTx0CS_STMdfssfUbqw_TSopd5IfB7RE
Message-ID: <CAG2KctrMMo0j9Mnbg8fdNsSc-eQaaaW51dO4mqwVNn3hfSdx_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
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
> > + */
> > +int module_kallsyms_find_name(unsigned int *symnum,
> > +                           const struct kallsyms_name_query *q,
> > +                           unsigned long *value, char *name,
> > +                           char *module_name)
>
> Nit: kernel/module/kallsyms.c already contains a zoo of lookup functions
> with similar names. Adding module_kallsyms_find_name() adds more to the
> confusion, being similar to module_kallsyms_lookup_name() and
> find_kallsyms_symbol_value().
>
> I suggest calling it module_kallsyms_query_name() to match the
> kallsyms_name_query parameter and to express that this is a structured
> query, as opposed to a simple by-name lookup. It might be a good idea to
> similarly stick to "query" instead of "find" in kernel/kallsyms.c.
>
> Otherwise, this looks ok to me from the modules perspective. Feel free
> to add:
>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
>
> --
> Thanks,
> Petr

Sounds good, will apply s/find/query/ in v4. Thanks for the review Petr!
