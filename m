Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8976C42A80
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101090; cv=none; b=TRSM1YT+IOZS5ZXoHtoP+Z9K4mpdLyzyabBi64ShZho/VF8g+QrFDX8PrdJVe8/nQB399KJh6/ouGkODpwaC1ZdBc7TT8q6Vkb10EdJOD4fUXip+cDxHyW/xyaEAk6267tWuB9SsZkZnkCzBsRb0V70fNxTP+jDzgSnGZ32jQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101090; c=relaxed/simple;
	bh=BJ9c/ol6w+Ube8nVPNM3mIfu3An8puBsF+RZnr8il0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGj+8p0C7lGaGQd3HpskFlkjWtk+LedY0rpVNBBWJB+Vpgs+XC3gm7RDCvS87AEc5+KZvtM3p4QKMQN38i9Kzl4rCvext35isd0bWpdN9gqi0i5ysjjm0A5v2Aa8iu5tDcx1uXzKKQMd22AHbbEVcVmkX9/WnKEHfUkgRWJoS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CWWrU+NA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CWWrU+NA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-842338c18e0so4747428b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1781101089; x=1781705889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TtsvHh9Pn+Rylz6+XRT7TQz3RFIWkIYkOyPrXmDgVAQ=;
        b=CWWrU+NAqIHe1MjCdcoGTuGcxliYUKtV6VShf1pO1Nyu1M7w9jla39XFf/gW4xCDyr
         QJR2YfkY67w48MUgo21WXSs5gKxCE8+CFoZfMjBdSWSrGWTmfinWTFVZUiS95UN9CO3X
         +RG8EGcsSb6yf160mTa+gm//3GNyKnGw8nlgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781101089; x=1781705889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtsvHh9Pn+Rylz6+XRT7TQz3RFIWkIYkOyPrXmDgVAQ=;
        b=LJ0ULOiDY1MQ5EdmUEjJj7TnwQtkpU75UJ5SLkfasNCJuOkZtQVK/Qoxk5u2Y9/ySZ
         zA6izi2e+cZi0lG4Wn4TqLcqh1EmReeZFJgxj/khJSdlO2SRIPG5nMZ3l535IU8wq/8E
         aCP4ZcLwpCWoCT6ttjHyRNt/JaQZVUdm2p3o9eHPROU/B9gBva98e8YxV/4nXKbdcWOK
         vvgSToR8cbuftf051hllfohCGbvVcQjUvK2TFmPVd6cNuOFcdQ4CbYAm+vKn4FOyVfZX
         dqcTquoeHJlkf9NfyOrAEw0Nw/6In95cKzpknxe8odkKTDmwEdawfzVsBRvMYG4EwNgR
         Sumg==
X-Forwarded-Encrypted: i=1; AFNElJ+mvmBEQ3eWJttupitb4XCRtmS6tkZ5w/EmbZmGsQ+RII4o6xJPSGkYKoBYi+5jAMCKf7dcTDZ2jOiLbah4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46Lvgls3wdpdg1fkdI15Zyn8rvfh2PrELWw+YyHtlqav+jT10
	c466QRIznlhRzI51g5DjgWXnYmD7WcdxUq4h3P6OV0cJvpGcT0xcC+kgJ83anlwgCiTbg4Qc1Af
	59NDQr4w=
X-Gm-Gg: Acq92OGtz6PxdoltDkH71RQ0WbgmPY7FRTbastajsUFiHoIh1Vyx5j1pWxOM7PgDD68
	gFK+/p4mhxGrxkV5SUqJAuMvHI3nMgLWi5SI5Txy8WXPu+Ry1RSaS+D8LmJbAQqBg1G4306zEcH
	rQN0lHoQgG2ejyJ0xnCRInlrr+45ub4sGLl2zGIUhBiRSLG2hCSTHrBizjFKyBOvl6YQRn1Ly2q
	tJ+AsqeE2Wq7zmsJMY+haspJVwwPbBcYGSYW8wXqRi+e/ob4qer96tSiwfBq/2MnBJ9ImaQHJuo
	ybUEqyE2xhP0dmCytUJ6WUWBIh/kqn/n8P7AVjbBp/DsO3mVkCxZ6Co+qzq3jEK6Mj51pz7amTj
	brlFppV6wYAqYECeo5SeCI/MnoQSYTrorFyXjHN0jWPs4EBbnLra3BYCA43zIXVkC35ldaUwXt9
	vQWEabpvN4i4teqwmAnXJdG7Ui9LfK1vlGyWR6GKKDYkPid9x0J48/FNwSF5RROfBWpx20PmAEv
	lMijEfVVV/Fo9XXm7mwt4TUpA==
X-Received: by 2002:a05:6a00:13a7:b0:842:48ae:1d6c with SMTP id d2e1a72fcca58-842b0f5477emr27621272b3a.24.1781101088830;
        Wed, 10 Jun 2026 07:18:08 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com. [209.85.214.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428235006dsm25745819b3a.13.2026.06.10.07.18.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 07:18:07 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0b944f6edso69522785ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 07:18:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/jE6GmximyzmBzbmi6qoAthbY36ZKzKMMPxhh9CFrvjRcaxz9iqzztYKIK3HNyfevGqTIuRX179I+c1bus@vger.kernel.org
X-Received: by 2002:a17:903:244e:b0:2c0:ab92:584c with SMTP id
 d9443c01a7336-2c1e8209b98mr287326215ad.25.1781101086478; Wed, 10 Jun 2026
 07:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whL0oLvmh3FO9SapDhgrXMT_d6qkP2V3OBjysOWXod2Og@mail.gmail.com>
 <aijyuX14ahOf53zM@gondor.apana.org.au>
In-Reply-To: <aijyuX14ahOf53zM@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jun 2026 07:17:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeLy2n9H82_THob=wzOEfsQT_yP05ZH9qY7NTWgj2R_A@mail.gmail.com>
X-Gm-Features: AVVi8Cf89LEbA8IWp6kUXfdfvHtLXSvqRDQpEPExTR6LsZaq3LaagKRbHX8i3Yg
Message-ID: <CAHk-=wjeLy2n9H82_THob=wzOEfsQT_yP05ZH9qY7NTWgj2R_A@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: metze@samba.org, luto@amacapital.net, safinaskar@gmail.com, 
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jun 2026 at 22:14, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> How about using write access as the gate to zero copy?

Well, it's too late now - no sane user would open files for writing
just to read from them.

And if the file isn't opened for writing originally, it won't show up
in the fd. So we'd have to do some after-the-fact "is this writable
using the credentials we had at open time" thing.

Which we do for some /proc stuff etc, but it's disgusting, and it
isn't how any of this should work.

Plus honestly, in any *good* setup, the normal case really shouldn't
be that the source is writable anyway. In benchmarks, sure. But in
real life? Hell no.

If you're doing web serving of static content, your web server simply
should not have write access to what it is serving. If it does, your
web server setup is simply hot garbage and probably riddled with
security issues anyway, because you clearly spent absolutely zero time
on any kind of "minimal privileges" model.

(I'm not saying that splice would be primarily for web serving or that
serving static pages like that is an interesting load - I'm using it
purely as an example of why saying that writable files should get
better treatment is crazy: it's not how *any* of this should work at
any level at all).

So no. We should not treat writable files as some kind of preferred
model for performance. We should discourage that kind of behavior, not
encourage it.

                  Linus
