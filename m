Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE193546E7
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201902; cv=none; b=rRppm3bSPEvg9blbqmEd76H+Ue9c/Uz9aeFdQHNv4ZkhXBaU1cviO0aIGCSUmGeW+ZjYzujqDUNz9w3euKKyUh+Y4LarNEhI/OQktzFRBHvGCEC20IjOksdud7RzLqZRTAz8kdU5OjQkgHLYP6bxlli5St0QRlJrZY6vgiXXcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201902; c=relaxed/simple;
	bh=2M8X3UYsESqQk+OXaR183ix8xQFEz8VYHxnC1HTOa4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3SC/OuftWim0o3PFJ3/H5CtQP3elJHZqyi1/jB4NPHUY3HZ+zZ9ZIXVdH2RjcTu/yQOCYRy03XnKBG3Ad/XdETS8PUdUEp85w3lLb3hpFkXfQscbzILxTMuMIiRh1gUOu5pqhtFMvzH8vt5/RfhsRpyapT8nNjn+T7uJeBYG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XQYNE7Qv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XQYNE7Qv"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67f94c078e8so6412728a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1779201887; x=1779806687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CoD4NnbWMh64fe1BLJuTuIvlCvqlrty8SggihEAdv6w=;
        b=XQYNE7Qv2qID23WFoRduDYL4E19ApdlKeVX6DMK1j5ActoY85QitdBxh4nV7P/Ee3z
         9UdZ0jH52XCppZBcI0JLzm5z6MX8bCRp1QZrE4B0gieHemGqGwdHTahs0omVf/oKryJx
         oxagLX1ppGjUgjnxMKEv7+31jL9fZswoQr/Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201887; x=1779806687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoD4NnbWMh64fe1BLJuTuIvlCvqlrty8SggihEAdv6w=;
        b=e03QBISWCnhzwMT1IWTvZbVW8zMs2cze+c3L2N1g8uT46+QtddkeQHs4OLIzBMISnM
         FTGVj8EFhsJC2yWXHEA4nTDD0sxZp6qmuzg44wohzEVrNnOaIJhufvuQc0EZuEN0X/my
         9N4RlONmPC6/5z+4ixENqvim+/QwmlX5XD7X7YD9yySujFX58uxa4Q+PFuBWfxm7Xg30
         qA/mG4Q5uXMbKDgu+y9QixWySZyFktN2AGbLt/8C/CE/qX2M2SdbenIcS/5HXG97tqBV
         Bl7clrp/hPQ1IIjo1BnJbRxExRhKpnubcBW0RF92EJ/U7eWHYstkb1lqJy4S7hJUZa/y
         TBzg==
X-Forwarded-Encrypted: i=1; AFNElJ93JF5jjFpFnqwikC0L3avR+CT9ymHkcu3WYUAO0QyJ+X99uqjPln31yLZhZSWP9qoIUHa1IhmJ/IWT10NS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0sHpQ+OCjG3PNKQXl3xcySFBxxei2x+JOwJUUck3gxSYIQhg
	whTObRnd2Od9kEvJhamlhbUm0p2efjkC2kR5C1swRI6LI5zxePsF3GWpRPAE4rpJvZpCBoG1jff
	DrO9rnCI=
X-Gm-Gg: Acq92OEgQOs4E/Vs/GRD7qRZea67mVVJmMPSY2IhmWs8y3kFGrNCQ8pRBuo4Q643M5x
	DN9qVI+s+6stpg6NPjU+AFZy0+kmtJ/gu+Tqo5Gb78gbhFPNLP1Pm9doWqDpDckEgUJPHhwQEjd
	BEDyZ69DEwthDBH5oodEdb/9zhlyBIMG+tb/Vnjlyj5NIEs64iaBo2VffRyt9Q05kLS1ThkkYzj
	9RvlQr4ivkzwz2xj5HIj7O/TOhIkLHBjk6d+B2BxgSt/zOnaMNsD3ZcfjtByFrxw2ncrKFBzuvd
	txi+u+luTWz86EG/cWlYcK7Yc4GY+BmXWowMZWskI9SNkeMyxm36ibEKyr//nRpPPvNIF7NYipf
	DduElx6GrGdf4OnqW1I9GhhYbnOg9nGkdnBot/9++3e2JgiMiCHzfZ0PjEHwClsIerUMg2n938Q
	XAdCc+6Nx1faeGgmlq8NesSPV2uc7CXRMOGSCom88FPh2n/nGyMy+AQZ+/SjS3ieBDah0IByG7
X-Received: by 2002:a17:907:3890:b0:bd3:1f67:1e10 with SMTP id a640c23a62f3a-bd51793130dmr1215894266b.40.1779201887180;
        Tue, 19 May 2026 07:44:47 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd0a40sm707486866b.12.2026.05.19.07.44.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 07:44:47 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67bb5ad91bfso8311480a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:44:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/AeAYCWJGaF6c1LWHMpfOp0IOKswkxNo7KzlngeL+BfTYyqFyCBs/lvbjrF/V3F1zeF6LfIGWtBbipeBwV@vger.kernel.org
X-Received: by 2002:a05:6402:4342:b0:672:bdaa:3e75 with SMTP id
 4fb4d7f45d1cf-683bcc9e48fmr12574873a12.9.1779201886399; Tue, 19 May 2026
 07:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-14-viro@zeniv.linux.org.uk> <ugllhpqcy62ludmg2wgc4dcsmm4z4m6pgpzdhcehkp7jvxnf4d@6mxgiskj5ct7>
In-Reply-To: <ugllhpqcy62ludmg2wgc4dcsmm4z4m6pgpzdhcehkp7jvxnf4d@6mxgiskj5ct7>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 May 2026 07:44:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ1pQYvN2a8qqJ-5dTGR-uSguB4mOENUuSnfNgaMCMdg@mail.gmail.com>
X-Gm-Features: AVHnY4K0-XR0d_6RPSGfPveh3LDe2Sd03GuZoLVwV1s2DX5I1vjMJMTaKMAZ1ZM
Message-ID: <CAHk-=wgZ1pQYvN2a8qqJ-5dTGR-uSguB4mOENUuSnfNgaMCMdg@mail.gmail.com>
Subject: Re: [RFC PATCH 13/14] kill configfs_drop_dentry()
To: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 06:13, Jan Kara <jack@suse.cz> wrote:
>
> Why is it safe to call dget_dlock() here?

That does indeed look very buggy. Even if there is some reason why the
child dentry hasn't been seen by anybody else - and I don't see such a
reason - it seems a bogus optimization to try to avoid the proper
locking of the refcount.

Was there some lock order reason for not just locking the child dentry?

              Linus
