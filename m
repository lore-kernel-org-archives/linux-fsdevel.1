Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793702064;
	b=ULnmLhv+T+lJIPPCC4drPbOcp3KdRuIiQXg67HvdF7E5mENmu8joNxcbPx2rNfqn0/LY
	 sZT34uFwKKvDgaGUeGfWibgbntG7ZbOnMgjaLW1udzvsjREGxh1fa2qE1bQZ21QnL5X6u
	 RWXkj6tz1RCcHcA5f6HvVfa0gN9pIOxb5MLMBHM7+RS492QESythMdgJ4Mpj4/ssgCvfp
	 K5yHBbcLyflUzzCf+hA0EOP81mf3329TCtO12JOt7myC0WhhC9dyYb0aJIAEocrVTmVDC
	 6WFf4mCsIx4FlLfEJsaHVzGDZIVcrKPhpjDPoWFAVWioqXuotl3VrajWCidCFigcCJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=XOmN6uI5+wry7lHPZoeSnGmX96UmyVh3KKEQZr7ankQ=;
	b=hQuXVxQO1gfI2zpdejQz5XMwne7eSdAV/b4B6c3+o9pV0/h2Bj2sLOyo92OHVveyHnrU
	 tm4Ex8Yluqi7cNoFG4RIyhEpCTqCOc/sL0d58MfVE4zvBRI3wNIJ2YquXtggFTBPh9jma
	 pg0owui0NHcjtvySJwP2CFn9zxpFCYgdSm1xBA4U/HoNd9HpwMd0NSAIOCYRpd67IGicR
	 XHPOl6yEUrT8JR/6jbSASTLR1B9g+vP8MRXWdvAvt2zRAIiuz+Cc1qaIjLpS0bor2RgMV
	 Rap6G+kGCkOHAyyiK24xQ37BbabTwkYXWP9Wt2gK38NHEl7+PRDLOPUB9+2jJHq0wCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QQNKNuGj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA0607DA00
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 10:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0AA0607DA00
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QQNKNuGj
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-53c4858eb76so1854753b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 02:34:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793702062; cv=none;
        d=google.com; s=arc-20260327;
        b=k9CHTSp/3pDcc7W6nq4IG1YmQbgY1UCAHjLfyHWW1LHb4+/KVfPLWAWxgEe5WFNMrP
         PDK85yWB/t40cN47C9hmpgpy69e2bvbUQgNvfH6RRMQ1UCrMuSccWx1EeD3GTRT00PYQ
         wEP83HxrFC2nOmNiDhby/g111v1g66YAAVDdTOuk2S9lZ5l3TfWJkNV/M+LzVtpDVips
         SHK5dXH/En4HaKAQCR3lC30WbOG7oroJDiav6Ye9BsN8b/LEgNaXfAFDA+F10pTLDu6r
         5ol65mXcDdlKm79Bh9MXqsaXq32c6EvXE3fqVbgKWyatrbFV1Qjz30Dp8oNj/TOa3ryo
         W34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XOmN6uI5+wry7lHPZoeSnGmX96UmyVh3KKEQZr7ankQ=;
        fh=KAJWPjMlUNCJxKM41V085WMmGfWN2IZYsko00Egn4NM=;
        b=SOdEJBmPgCh8YF8QiV8uL7O+Ns8IkS0qUA8g/SdGmRQfWjF7mnN/1x/gmmTV5wpDyy
         yMVBjgsr8ACFikGtjlJgWNmG1GpXSSEVX5iu5DDDuzMj0W+dU2/RQofYN60LoANuxwQA
         dErhvuNRZO+9LoSgnkf7J03nVDdJf7/xhlvp8rtFF1xUxDPz5MJOUOsDple/usDOwL8J
         /nP7l1mZqOFUTbvSlV8NFdHmLb5DscJguubyrmPNeC4gqLY+wxZ0yXnLemzbUrptDyRq
         JzqoZFpcNr8KQ1wX7xcrTylhAlQiNzaAQglXLM3MV0RI6Y3y7N4pOAquVVYSELE3vyFI
         bTkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793702062; x=1794306862; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XOmN6uI5+wry7lHPZoeSnGmX96UmyVh3KKEQZr7ankQ=;
        b=QQNKNuGjmwA56Mma1Gzi+QHMJju7hE3+AoXWA3w9Zjk970uNOO4ovFZiZl7gzB5C1N
         J7WDvynk50Mni27wvfa2ZXPcKBIQV7G8qE4YL6dohmV7MJhJZNdbni3r56oF052NtPEE
         rC0hv7+Mb4utA4q325CTjjqnxVlAbk/PWq8CneGcLzt/x0FAn9t7lXYMLmcPAAMbg3y9
         XX35lOXUbDcP4NCDFD4M2k/+YYaOWIHgYxLbAwVWAXG8XCYa1uWUwH9nPg238lQPEqgD
         KKuXTu996skOcqWgntwgfR/vgg1y+bV/07UYm2mU/VvfXwx6uDVXfSzF0pfpntXydSBD
         v31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702062; x=1794306862;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XOmN6uI5+wry7lHPZoeSnGmX96UmyVh3KKEQZr7ankQ=;
        b=LxWMwEH2/+w/7G/faAT304pq/VTMRwTQMNCY59OF+OhBNws4gwZfq4I84xJ8CknRuX
         GGs6NrX2sz0vavQRBPdzF8G6/gQOCIKWfqtkyKe/Q1d/TcjVor2zTayJwAFTena3dqg5
         JpSED8CoiGZ+lHm23l+U/xBu9nq1yKwyruPtkBdEm/lfQd/+DyDmvoF7M6jxBcn2OnSO
         Zct8DoxMpETVHTClHZaCEC2+FE7k9xtdeNunzNIP9ofzjnxkbdZXWmLnu1N3fVpLTuFv
         yXNJ4R7BmVd5MXOksJfmO7GIDl9VG5/h50geaisrfS0Qxz1ntbV5Ms1vrFA/jSdfS+x/
         2Blg==
X-Forwarded-Encrypted: i=1; AKwUvBwYzT/CYnT1YiMqv7nfI+YPtMEGZ3oPZfz6RE/Akp9opcR4uOLA6fETWt40mjS3W+Ue0sofyCzDG44skcwd@vger.kernel.org
X-Gm-Message-State: APuU4Z9mxRYQ/kwIV4xrm76BKra05zsn0zQD57CxIA6RFl7QbD4GVm7/
	zSNm/TjyrKhwo4FMGoDTRqrRWBvjinRSgtd+Xchx2K1ZYmJ1EAn9vRQqLLG9Zz8JPsjNdcCqww8
	KrgB6ITUPK52Au3V1dWyoj4k33Er1qMs=
X-Gm-Gg: AYBFou0SBANm7SmplW/BOnZlSoGwjHA5lXzpXUWhoMAoH8xpYCg7LmPZFW8qVDX8J5y
	OE2s2ewQFPngtb0bNHb/kWYO0prdAblIfNkz8NsrBJCGTSqicc9F6pbXR3xY9Jesm+LiZtIC8lI
	Fpqfbp6VkemRKBpjrDTmPzn3gcfFACvtQVi7F+u47bScidVvU79fdcHGelAbqZXQtVrn10/e03W
	tQVzwEkVbRBLvtLI178uMwIu0hbL+qHxN9ZplCD9/vaQMFZByl6d5dBjnUWdkWh9pMCK5i/0o7I
	J+fR1k55RO1LvFy+CWNfPuL2Wiq2IVz5HyL/sthIwv2ZETxjl8xXGS8gRiwvCEw9z5OfDA9f0oU
	rvVYEPJGSfz9cG0rQrKAQkECA6WOXvJrSg7z3Kf/nGlpbJtMcpNXiTFchIwRJpaDoiM2QKw==
X-Received: by 2002:a05:6808:17a3:b0:4ec:4c7e:37b5 with SMTP id
 5614622812f47-5640ddb4f38mr7698087b6e.29.1793702062547; Tue, 03 Nov 2026
 02:34:22 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025164619.89992-1-dennylin0707@gmail.com>
 <at9xXRhD2xZhszEj@thinkstation> <xmp7ni65vbinfj4j2baisrhp6xzro3asbepuq7xp3mvx6maptn@r4dnoj63uw4t>
 <at-XtWBQg3jv3H8Z@thinkstation>
In-Reply-To: <at-XtWBQg3jv3H8Z@thinkstation>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 3 Nov 2026 02:34:11 -0800
X-Gm-Features: AclHuK9ZD1xD5M3EAerFCyanz0JIq-n7E7W9-r11Oa-jyzsbvAJqtwo7Cf6PVcU
Message-ID: <CAGEkeHfq1xZf_jMw9a9cz3iunj6O3UZ4-=iW-65aN2Ss0oT3Uw@mail.gmail.com>
Subject: Re: [PATCH] shmem: do not extend i_size when no data was copied
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Jan Kara <jack@suse.cz>, willy@infradead.org, hughd@google.com, 
	baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 26, 2026 at 06:18:39PM +0000, Kiryl Shutsemau wrote:
> The per-filesystem alternative is a 'copied &&' in every ->write_end.

Would it make sense to keep this fix local to shmem for now?
I'll check the folio handling before sending v2.

Thanks,
Hungyu
