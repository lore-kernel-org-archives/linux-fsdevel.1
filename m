Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569514317D
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780533970; cv=none; b=sFj/hfcuyAos8xKblQaKvbIyzYn+rzpxco5Z5HqVOm2oZgwRq5fRfrf9yBKb1ZPZVNyZYHzVDl4WIiXEpzrp7Y9fdnFmMCYcsUoPOD71rGXXK7yeo8R/phAhf9qb/fJ0Zk1lVBuLjmp3fi/z7LPBGjGtSo6ZcaqX07pi1ePhYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780533970; c=relaxed/simple;
	bh=4C6y2z/XTDC26AyRBpojFCbnM2K9+BeYPffxKjyVQk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP7cz16rVICy4J+S42k4C6Ut8kkhjxhFYYWLYPHOlx2hrWGqdcOwecTgayew5rizvUbwl4pJnlio2+TxrYiu/7YAxP3L01s0uWvc4MJkATdYrzKVhwXMjnEDeQheKf7S150ywkWGlvfM8+YTTpxBjNJFlKH66eurG8sIh0CGXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrlNUXfw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrlNUXfw"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-46019b190b6so73843f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 17:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780533968; x=1781138768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNgRjJgbYuUrLzdW/5WEzZhlyP27Ht6YujPqndZuMqc=;
        b=FrlNUXfwzS7pL69M0DoZJcXE3NOgDfUTkSvA79bs4sMyyTdDjnFXuGIVhIM8R+/vVd
         y8aXmKJWT8pf24DB278QhteM/8sKSgp2WcKgcXGcSroO/nWtaJ+m45Ol1uSVWr8cXaWu
         Ua+QhQ+F3q0XUr4/zTy0zqiEmQsX9/zupw2860iq9a0T2fwHxWTd8ShZduzbH4/qFehg
         9QBY89tzm3g190ZnNNNnaoeOtoxHpQA1pHt2HCY+EzdyUt8BFEYjUBBky1+PHy9WCuex
         fkjxXetILokfBi3bidiZrOB2NXxKGyLjrkex7VBTA4Cy8aA/j+PuYSLndF1aKR9sNJfS
         OpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780533968; x=1781138768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNgRjJgbYuUrLzdW/5WEzZhlyP27Ht6YujPqndZuMqc=;
        b=AmwcnpLej7uYaAJ04xtwBvjLVTBFynncsCx0lTnRB17qBBD6JJcF4DYNDRse8m64xb
         zoRSSVxuaZvVi97k9o4RFAm6RJx+aqzklcGyv7ZJmiMkUFb6nAkw3r3bG+2n8ovM+klJ
         jKXwm0vfoPcaUNuD0EZ/Wo15SjynIZ2jHLRWmBcDOUd45uOFgUz8+pww2qPJ/YITg7Ug
         Gv/1g+ty5lncsLKk61Pz38SPTK793Jvm7r/INcuAZwtBCx2cqFLmKtzpzA9W8OSlWFAB
         BGlEOau8drb5vPVb7fSxHe3+B8+o1IgAD7WuLbNdkoBF1YvBLsARBY9FTdXOLusTnO6U
         LQfg==
X-Forwarded-Encrypted: i=1; AFNElJ90UKTg94UnJPM7T/LATrWu2S8MKPtjIrI1RQvZgFlJoukTYHxtHKFDYgz7+lUjsBxWnHm6F+FsT01J+UFr@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3eedC3QR9UGpL0EWG3eCr0V1KTFIraJ/omgG269OyzP8J4X7
	lsQxyymaL/QlLPRlFDQKiFqkSQ5wyscOCEZfyyMPb16tg1G+wkGSVGhW
X-Gm-Gg: Acq92OGyrQYOEM8e7r1GHblvY8fgGNnUK7R2Pwa9cCj17sBD6YZU8z0zmLPUNjbPRvG
	/T4E5A7yeIOc7vvL1qylauUYmuquFa5C2d/66EJOf1F/VYQLiXTJSxzPxxBqQG0XLLf5LEUSFQ8
	l6Ldp1VXf211LFjrePgaVPogVhXkVg6lykT3QYBVIN8a2yFApAb6lv8st76x+vPCkFMZShYPBWl
	eEZPGrn4VZPEKqkHE2FmGBLMqEFbG0eE9dugs/CblBPHxkOOoMrKAymLmFex/k7aIZlheutqlC/
	Qjf+jsJb66Hy82Y6Y+PttRab6XvAruCaHQgLnPa/0/naRupO0r5jHveGnzIsSSJyFWhGQuwyRYB
	qgOO1C+pATdSt8l7+8Yf6nsWCLWe1ZU1zhNIy8PTa0aL15cK87TovFMvhuW9E83REXVtqM8NM9W
	9hxxtbWyvjb4Ez+kKqYBVVEE9JKTmQROLJ5cQhzCJs
X-Received: by 2002:a5d:55cb:0:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-460218f1283mr6820154f8f.14.1780533967626;
        Wed, 03 Jun 2026 17:46:07 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2dcde3sm13029996f8f.1.2026.06.03.17.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 17:46:05 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu,  4 Jun 2026 03:45:59 +0300
Message-ID: <20260604004559.1112474-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531010107.1953702-1-safinaskar@gmail.com>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Askar Safin <safinaskar@gmail.com>:
> For all these reasons I propose to make vmsplice a simple wrapper for
> preadv2/pwritev2.

This patchset is already in next, but I still kindly ask people to
carefully review it. I'm still a new contributor, and I can make mistakes.

For example, in vmsplice I do "CLASS(fd, f)(fd)" and then I pass
"fd" (i. e. integer) to "do_writev/do_readv". I don't know whether
this is okay to do so.

-- 
Askar Safin
