Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4622CBD9
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075341; cv=none; b=rWLrK3C7eOf1qY3tI5N8BEjzSrTKAWPtfML7R6WPaDoCWUtC4679zPkzVHu9+BaZe+QiuSXeurczOADuPWXmIKdDqfIP0ekKU6xSDKxls/hJcTFb6FvU9Sw1jw4fXwol836QpzHkXGitQAP+vr8s7/IZlDra0AQ8F4zFYQPVa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075341; c=relaxed/simple;
	bh=5o86A89Z5MWE6H+q0agSl6Z3/q9EagTnYFlt2t3fqys=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=o8pu7Jagv5xlyqASDcwVxQ3xT2msGJCteUqBlQFLywlZ4QPkj/u3iv77jEicFdKiHqFaTssv3BKGhJDxiJI9lP1dWODCWN7TeNADLRlSlKcgP0YZFoN7MXK1b/uGBZYEAKCQnYp8kkPoanNuAhFdTbSC/x46Bapu3av/wocWD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Syyzcd/A; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Syyzcd/A"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381ed661712so5370394a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784075336; x=1784680136; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q6EUyZKF6G67Gt1NStk+455yKefIcrRIfkjtGEXNiGs=;
        b=Syyzcd/AAmnTZnTu7b6WRbyhIeuepJHfLt1IdaybX9m3NwOJkgjuX3Mf8aGjurOizp
         n4ub6zGIOC46qcfniZp6g/caVkXbWViZb0ufFwHT10QlCe3j05x2RT3Rp07mo0KTzF+b
         4HhOViN3IMZCn26sJhYJ29HRpZ/LcpMhqN0D6G1v0LzlUev1/MAMPG8005GqsSTZNhwB
         CvPeY9edymLCHwuf4KS3aVtDuGHJipre7gK1rTuISWtv4PF3guBSeZhdEm0usCpbdLUX
         1sx3l8vJRE3nXUQHRLNh/V7IGT78bDZr4xsKyXmjJ6YT5ZwLFgZlipx9KmC4gY3D1afe
         Y8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784075336; x=1784680136;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6EUyZKF6G67Gt1NStk+455yKefIcrRIfkjtGEXNiGs=;
        b=RfvD2CqlzGIeMf/I6DJ5cLf4CWQKJIL7Vm/ywpbPLXcXKVVjifyFG/qg/GT3n5sNa8
         PXO8kH9gmIfmioXb9LirRnExDepyVY6ByJxqYvBBuaQj8HwW4drt8JnSWvU0PcmaOwtN
         Zkh5nJd9qZwGs+M0s1oBeCnX11LuaS8AjQfE8sOck56qIQv4Zt/fuSwOlEy8OhSJZP5E
         20X0DnXuvUN0eORkZ6oiDyCRoNNUIhNqXnWyBWc+RtLa/OdKwgNfk3wbiCGI1opRovlG
         dDs1Vl28t4D1TL54QWeFxbL29iPqEhklsswmPsQ15SdyW9V68QzvfvJvd8szZliFCCoj
         XyKg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0KfFQ0cRrY08poQa/NEUVsEmPnjqFb0y8kPfBN94JlmU9SaAojDOPo7BHVBtaUL0N2j7+XPbKxTAhKM/R@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7D45nOiHLDSatJYe2FSVVK3/YKEr5ovmpZqyITLRRRF57rw0F
	SBjEfYyiaz6ZvanvoDCBFbRutScx/mHzrzqJYAUW7l8TxxPh1PNq9iEw
X-Gm-Gg: AfdE7cmZT+tkfIj3PU8TmPCX4wBnnZ9RbKWnUcoYWUZZCXC8nfuHGCBJD7GkNS3SK5y
	tXXm2PKWSF5V9ZdpMLufSueyeI5utbBftFQK+KOOcZTizqifZq0dty1tzciagViPKByiwlMX5mJ
	w2iz3uYmXuQX8/toAPT0Gc1sCjvj6qMhLRpbqRQsQi/+cyoExCYVQaCBoRpcCoVsM5kLT/Yt9Jh
	L5TRtcbNQwxYPagfN6/YOlk06/h/ZujpN+osTd4kcsU4J+gWLVtlQl+LcPhwETtY6wsAK7O5bV/
	VV6OJuZ0ec7YHyxQviPaSW5wZv5psSLy5fwxeOiQvcZVOCFihYn1rvlDIQY9IhbGTTbZ4MM70p5
	sTXItUqTM86d8r05+LOmMLrfuC5aM6OKb/lSb4BLBpjQKV89PYIHc/8/ZeCQZLJoNHsT3MSajEO
	sIQuCT7vmjxvPbBCVR
X-Received: by 2002:a17:90b:2544:b0:37f:9ce1:736b with SMTP id 98e67ed59e1d1-38e1af37168mr4216164a91.33.1784075336213;
        Tue, 14 Jul 2026 17:28:56 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm86075098eec.18.2026.07.14.17.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/9] binfmt_misc: wire up bpf-backed 'B' entries
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-4-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <20260714-work-bpf-binfmt_misc-v2-4-57b7529c002c@kernel.org>
Date: Tue, 14 Jul 2026 17:28:38 -0700
Message-Id: <178407531871.2243172.18093804936760543620.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 14 Jul 2026 21:58:09 +0200, Christian Brauner <brauner@kernel.org> wrote:
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index f7264b136..a8f641c4e 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -226,12 +240,51 @@ static struct binfmt_misc *current_binfmt_misc(void)
> [ ... skip 34 lines ... ]
> +	/* Selecting an interpreter is part of the contract. */
> +	if (!bprm->bpf_interp)
> +		return ERR_PTR(-ENOEXEC);
> +
> +	return bprm->bpf_interp;
> +}

The "contract" says that if the BPF program returns 0, it must take
ownership of selecting the interpreter. However the bpf_interp can be
NULL here and therefore is indistinguishable from the refuse to handle
case.

We might want to treat 0-without-interp as a hard -ENOEXEC-to-caller.

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
