Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906273;
	b=BbUS6HqBd176NntKyWOYbJ8FKOk6X3rp5J2IHZOXxHg7fpVeilJI1Xxe43SAu9pyMlWL
	 bfCL/8sT3PkmTyUCJd4si3Fcj0em8MmiMk+iusfFoD7L+CLWOwSeYxoSDUfwwy+VXJFMq
	 OGqxsKo3DhHQP5z524zsMLbrlBFpPPZ/e9QiSOsicqLgJIwsa8ez0wCKr0m8BlKmnVP8Z
	 bRH6OTgDzPJ/idJtOfYRJ1wFO6Zq9BcNNDml7PxKLykvBfq1igWFMNenw4EykisIrVlsf
	 sT0d1pMu2W5I28+jFQzp4KQg7klC9nfvTLkUX812YUwBBTLKef5STYsTUxWM5G5Ce7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=NFfn01r/I2+FlzODQuMnSDaVkhXc6007Ui5uRs6gM1U=;
	b=e9Vp98abyROemk9diFh6sHIr3LMsEU35BbVtaPDqNWYpj5IDyUEIZ/A1dvJJx5k/l4FO
	 SEq9u6f+bUYHx1IWS+wqYsUUAUCyOmxEqKchSoYXkpbaUn0NdN1+mq0ZNroRT3Up4oGeS
	 DvJ2qqZrQOSscMrXvqbfII5ceLiKNX/aCHpKtRxoRTxJwvkZp8MUXnNw19feOtxh4qPgg
	 QM98HwCg9F/Tzd5sXWo/0lJFCpjYiVAIrx/evHnz2vD6EQ3jZd6UKhENRk2mTl3vq7UNr
	 wCI3+mJao75bUb2sK0yIXK1Z9iQZm5nXqxUgBJEv4DjwzlDBL7m9ECWBopjJayCTZqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=QR2IjSll;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99D606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 09:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A99D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=QR2IjSll
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b4c8b51b58so3570810b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 01:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794906273; x=1795511073; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NFfn01r/I2+FlzODQuMnSDaVkhXc6007Ui5uRs6gM1U=;
        b=QR2IjSllwZCap7dIGsWvdGybMobHzhdf0K6ybXEmYE5E44+iEXK7q1GYERnNlXkhKY
         GC2wvGo73nc1+dmssWwyPDR4NH+7UtaHFaDiGWU2HvBNZCH0755DyexnRvKOm5LXrV3E
         Lf3PKTlI8WrlDJQEfJrk4qRjoMmsKTYJFbpbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794906273; x=1795511073;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NFfn01r/I2+FlzODQuMnSDaVkhXc6007Ui5uRs6gM1U=;
        b=Kj4Koct8pTwjQBq/YD5KDzohqHnnKk0VVIZAETl2c7+pun1kIAHVviR8SDt+j9u1o+
         D0PpSewXlqomOGEXnjdFArazQRqnBLlVwUsuBxKMUwmg74tGQpmQJKzj+AXWVkLJuocB
         jRWKjrkt8gXYSHBxc1qCJw1FJrcWsKUDoGmtyvwot7hMGQsV7wjdGhYqsog2BW8lOw8d
         vRhsBr3Tv9HHlozBSSsJtW/aheoHVHV9DLj2eu5ED1ZsT1Kfkoj4lISgfxfTB2T5GnEi
         GF3cl7wn7lvVfiaVZjgeUg6d24+97dEwnipf5z9DjKpKG6A53vY1J7YR/sENtSBoyiKn
         pw/A==
X-Forwarded-Encrypted: i=1; AL+hErFR+gYyHIaWMx1bAHSvZAxWEC+HXcN8K5bjqqQBRjVC2VQY3fxsRoG9lUeTdqpp3y8WnPndIATMmeAUqrkE@vger.kernel.org
X-Gm-Message-State: APuU4Z+JkKUFY5wUqaPOch7HOgHnsKt8K6USteYpgE+Kz8iFCjwZD0xp
	JE8aNTM93WTJwtORs2ccpLWf9SEZQ7KEvayvuO9F+bv7JNXWYUgwSGZFMT6bMmks8Z0=
X-Gm-Gg: AYBFou1qJqVv5WTHqr2d0lpTrEVXc+m5AGqVYyLyn0naxLp1YrL0/bCA32BxF0/nnO2
	4bolRjxc9bANvX4je02dgIrbrBJO88RyOGDiJbC1DkH9A3XI1Ul5/pBHY7625LJk9hUfn9UToT5
	yuu9GHqX9RpoK78qQ7QECy3NNIyRWxOxqogRl8lTvCSbcKCqB9SyaIcgVEfp85GgbUjF8Yj+R7j
	I1LeSrpEJW5+nDgDBXQRhn0BocKHzYXThFw1HqI0h2O8XLOTWlZv2Ek6w+pKhWYMjPZoemaUtWE
	0ac/TcK9QOVikKBE4TeJBDLfnc4j99IALf8tfZ6GgVrksJQX3nyyRr7/3cXW5NvZqsPEH61hzq0
	DORFV/ndFynMU7RnSU2v2fH+HKe1b6lG3mfrTy225DziWSYSqQqjRNxdmwcY9iNut//LJfhYQyF
	KYwnMNuZYXXf6OV+tBdVlCCGWz3vybyiWju9oFdFHX9Wv9xVn4xp35Pb8ayVbWfzdGZJuAsI7p2
	358vnoiQgkwGfX2A3aT3zFe/7HuxsJKu0ZzxcEX6fZexeJDpWA0LKkLKRdNLbcU0RqVDfdthdna
	adX185lzKNu2PlVZjt+rltgSmq6cWGiQ3iFui9ozIM45g9vuQ8+MFw22XBmmpv9zSQEWCr9tGGG
	XllkJEVd9PbH5TQSC5JeBkNgMRJsUta4e5acF98GTX6jkhUQtKb5+9ntzc/Szz7U6vdUeYrRCOf
	Eo1aYKizNTOvF0yI5IxFZKSNUwXYQfteiIIs46C++nNqSh857xceUQGmht71TiPf35
X-Received: by 2002:a05:6a00:4518:b0:8b4:b88a:c2d6 with SMTP id d2e1a72fcca58-8beb6d604a3mr11459421b3a.39.1794906272633;
        Tue, 17 Nov 2026 01:04:32 -0800 (PST)
Received: from [172.20.0.3] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed20548fbsm5091791b3a.37.2026.11.17.01.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:04:31 -0800 (PST)
Date: Tue, 17 Nov 2026 01:04:28 -0800
From: Chris Down <chris@chrisdown.name>
To: Breno Leitao <leitao@debian.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	kernel-team@meta.com, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH RFC 0/3] fs/pipe: copy a run of pipe buffers in one user
	access section
In-Reply-To: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
References: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <avwYnDc2Au4mnHTd@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Breno,

Breno Leitao writes:
>fs/pipe.c into lib/iov_iter.c. The main question is whether that helper
>is welcome there, or, make the party a bit uglier.

Hmm, I think the part more likely to get pushback is patch 1, rather
than where the helper lives. :-) It adds an x86-only user copy primitive,
and then lib/iov_iter.c has to look for it with an #ifdef on its name,
which the patch (rightly) acknowledges as a bit of a Macgyver.

When Christophe proposed another user copy variant in April, Linus asked
for the existing unsafe_copy_*() helpers to be extended instead of
growing a new interface [1]. And in a related thread he called x86's
unsafe_copy_to_user() "almost entirely unoptimized" [2], which is the
same reason patch 1 gives for not using it.

Based on that discussion, I'd think that the better way would be to make
x86's unsafe_copy_to_user() use the rep movs body from patch 1 for
larger copies. Then copy_bvecs_to_iter_full() can be written with
scoped_user_write_access_size() and unsafe_copy_to_user() for every
architecture, without the #ifdef.

[1] https://lore.kernel.org/all/CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com/
[2] https://lore.kernel.org/all/CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com/

Thanks!

Chris
