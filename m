Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F54346E43
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382300; cv=none; b=Lp0ba/pZeKcrXO4/2OMhWVLqJeNUy84h+7E6DyEq41FOSs5YzMBgweGcCdsJcxujEv/0NBuh0awLGsz1A5GXKXefPSQoeZhas51yzGk9+pEC6ZnINLxbQaP1UZ9mfTg11oPFRJrED6imdyyP/UD7YaTkhtrf+o/1ipA4gcgK1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382300; c=relaxed/simple;
	bh=XGh9YDm1F7Whc/NJ9BuaKR7akM8txwMpeQmBzjBxQ4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEBmBadmZFfuf8tawFZCuEL/i010nSKJl4edOs3DhF2ysDGnaCmLy4W870Taxd1aqYIsqXclCa6+zfAPMISFe3PzZBFcChFeVzjz9HgFZ138esv06wu07MO4mFgF7GTdR+kK/owfFm91P9u2z1Kt201lrMUTUDI+C7Nr8WpHXF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPrK5FFe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPrK5FFe"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b9318997so11245855e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782382298; x=1782987098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELq4DcsgmxsG/xQ7iP6tdp51y3PfpvNXYbA2lrH5JcM=;
        b=LPrK5FFeAMFxHQd1eI9ZUBuFijk9vElLzashpH3ekU+3+iA1xRInRhJUtGPNgs4BRM
         MycH7eDTqhClWuBTRmwSV4BCvDRjbC2gLG8KNPZNwjbUue01EuEzRRQgGHPHnVTjXa0y
         CqI1m3QTgipa0o2k4hXrkNG1DFE5JeBx0KRw/DyKJMI2pKY3wHr8yDqBO9MN73rGvG7J
         GFOEResFpLE8U14JyJvM4fYKic6fQuJE2HuPBGjYJMo3eFkV7u93vhjc7ByRfKK1ZmyL
         243GBSKdy15ww8qMuTdeBVtU0IinYc4lSgUKdNvxFA9jtvZ7K9UNlxRp7eBawCOg5S61
         t6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782382298; x=1782987098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ELq4DcsgmxsG/xQ7iP6tdp51y3PfpvNXYbA2lrH5JcM=;
        b=a39IXsBHMdyL9Te7fkSUlr5ZtBy0XKJ+QVHC6Jeii6h3+TecRjNl537BHcfn5sGC6j
         kAV4emzZOXBfTrZFRgYLarnb+jmYHXxB7ayeL4ODs7R6VFFCitjtJ2BvQ3Cnn8YHa86z
         rsmh0XbL2PW+zsMSrGAF6uoUanLrTu/tbCNAdh/IEfGHS+faOS/gX0TEB1ql+H1JRSJE
         ZR4P3lt3m7oYo4sppWny6u5GdnjuVyj0dK5HcKaca2VGg2PHtC4ztQwVh+5i0Jo1GbOS
         e9Tfa6PL2lxiilrkZibc+Wu6oAihV3RirMw0VdaBJNd3x61lWh6+E5v3xRpSLaXDPk6G
         94Mw==
X-Forwarded-Encrypted: i=1; AFNElJ+hgwTDnY6dtW94QRtK7IhRyxnFSuByo3cZkKgufkYdDfPNz1KlPbwpXfNLxOwEx1dck4r9QDYuNP84E4tA@vger.kernel.org
X-Gm-Message-State: AOJu0YyEI13U24gvpxgVFQAL04Td9XjIw+lzcmHt5slqzp32Yg5m9Qeb
	Kd/HQu+CE/DwkZ9oWQG6QiEIshOwMCI4Uc/B8YSTglb5JRq4NhBWtcZQSEZTKn+9lAg=
X-Gm-Gg: AfdE7cmot1xX0SlIw2QrfEiT0xPfbiNYxXaIRNUKlK5nnNwTzJKuWe4VM+Hhg10+XGA
	NAPiVOnselxS/lpdMSxYtnravRIH2iBBpPHEL26NLFfhylICb/deTEuIzjL/EDMtGgmCTH0Ern+
	3PyhHsyLg1XHdFerlcjrOuf/ro16kfcN+U8fy4pb3QIXUTPjGt2bAiUxwErTPQB79MBxVGpRd7j
	5cJ5SlJIb7mlBgjxldEju2bZAh9D0cQ6CXLR0hPLzNfkJVAZWeobWc8hXxcL5l4BZmWVhSP03Ki
	2IsZSrUvLsHj3HscxzissSkxpZCis122N+oYx4py2wlQcl4Cgm8QLZaDIdlF+XAdYZs7Mpfoijz
	etxkQUyIEA3h9BeJ1zZBpLGYPN2hlesH+S/2mjKMi8Fao4d6RERr3bMs00+R2azEbs63R8909Sh
	7LOqoZlL2s
X-Received: by 2002:a05:600c:8b53:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-49266864977mr24965995e9.14.1782382297752;
        Thu, 25 Jun 2026 03:11:37 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4926417f0c7sm59950125e9.14.2026.06.25.03.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 03:11:37 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	avagin@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	collin.funk1@gmail.com,
	david.laight.linux@gmail.com,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	joannelkoong@gmail.com,
	kernel@infinite-source.de,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	luto@amacapital.net,
	metze@samba.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	val@packett.cool,
	viro@zeniv.linux.org.uk,
	w@1wt.eu,
	willy@infradead.org
Subject: Re: [PATCH v2 0/7] vmsplice: fix some problems in my previous vmsplice patchset
Date: Thu, 25 Jun 2026 13:11:32 +0300
Message-ID: <20260625101132.3859505-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <89ea76b3-e956-4232-8180-ee3929adf905@kernel.org>
References: <89ea76b3-e956-4232-8180-ee3929adf905@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"David Hildenbrand (Arm)" <david@kernel.org>:
> I think we concluded that we cannot rip out vmsplice that way at this point, and
> I suspect that Christian will drop that topic branch from -next after -rc1.

I think my patches still have a chance.

On fuse regression: I return EINVAL for particular combination of
flags used by fuse. This causes fuse to fail-back to non-vmsplice
code path. I did Debian code search, and I found none significant
packages, which use same combination of options.

So I think I was able to deal with fuse regression.

On CRIU named fifo "Not supported" regression: it is handled.

On CRIU major performance regression: it is NOT handled. But I still
think my approach is right. (See cover letter for details.)

(I wrote about all these in cover letter for this v2 patchset.)

So all regressions found so far (except for CRIU major performance
regression) are handled.

Other option is to introduce some deprecation period (as
suggested by Andrei Vagin). I can do this, if needed.

-- 
Askar Safin
