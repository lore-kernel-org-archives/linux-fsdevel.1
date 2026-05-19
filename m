Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97A40757A
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185072; cv=pass; b=grjecJBcsEUdO+E7cPXsWFFCFnc4b1fagbluWHZ2i0rzsK9lC6zlmUI4L4IDzckbGDdqqD2OU4McKGnA2y+Zo8gY5A+IHGDleIL0j0RxpuNaMmqlNuW/dHnLlX2Q2kC0ArFRlAAKJSFV6BVXYvj7DltBkrTV0DL82rSAUHC4NhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185072; c=relaxed/simple;
	bh=Dhc6kVUygSwb3/WTWYpM6RSnRMfkL+MN9Utka5VIF60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3eEsHWNr/MYeafot4dTaIPWcSv52dMwx/NvkwB3pHNec2Te0ChFDxMsYbpjGYaDO8BYzPI1hLUe0kpv6PeZD+9tKOHLyN/cYgplpM3b1G91nceUcNTa37eOYfHRa/qcoKXrYHN1natxEzipSQdUf1H9mYBa8064J5HzwDETBCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cxuyoSUn; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cxuyoSUn"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d87c138e1so39977121cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 03:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779185070; cv=none;
        d=google.com; s=arc-20240605;
        b=PzCsIcRRS8WqQQ8zdGSl4KOl4QOq6XXnDQOsB0KmOeF7tvhnJZowX/Jj5uNvEbsCXx
         w+Xg29BoJJXOOQQ2UF+6TCWYdT6RPBlPpGBuxJ6LH/Qu8khgi7nBM5eQ99rIb8owboEC
         ukinEpGB8spuAEkSS2h8zTSRA2YAgRt/IB6qpgXWLXf6voIRkFmxfuZtAdABUOSKAdei
         dvsn3m30RxKjMuq1SPae/xubPOrWpHAzWJk26LgOR8i6M7LseoT01Yf6Xsaeqj6zcVM7
         yxBi8auJO4c1EtwvYjFf4JD7Y1j4P1IP4t8UUvu/RKZ49jw8zmCPO3C2HR/XxT+rEuRd
         HomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ctTJbFngTGuiEcSoy3QpBTsjTTAFbNNyypIjJbvOChE=;
        fh=9wFdk3q+qoaiVcHxH4oaUzC+g8HktTeTQWJ2N7RUoSc=;
        b=h+hx1u7ZK9z3Ee2OCDMKPAgmEHtX/1aUqkbqG1CvTerNkj/WWKTCe2olS5dDVw6jOf
         witrR6g70LKrEUjA6WrhnyVgJZ/BV0RudmyPKDQTfSzqP226kUN4ggE9xDFWEqBXdObQ
         dlDVNbTNXptuwnSNWqfogUj6kH1cPhLAR/KBidUmat1ZAmPz7bMPFFnnWm1XPZv65c+U
         K7DKVwuvEQd7ZZBkw8IKmrh2pjYh/nREMHvI98c4ASO+2VVeF+Lok83R6hEB2mSetput
         kQOu9oQTTtU683ivKu8P4igVpynmxfjjX2TjhQTR7jOeFFOj/FrvIADPFiLbmYAGKQxS
         FT+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779185070; x=1779789870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ctTJbFngTGuiEcSoy3QpBTsjTTAFbNNyypIjJbvOChE=;
        b=cxuyoSUn5VY0tansFe0w8a/pw3NirbNH35hG1sWOggCl4mNzAfr6JhA0HmnUUnZhx6
         tSm8tjb0Iu0nuzXmIekFprk1nhhY+ryaa2uG2luWrasuuLiLu74tbWKAPtgdC9Gf1f6y
         HEirliOlgEEt9giqoGcF9hewlZVyqPZwaXxAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779185070; x=1779789870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctTJbFngTGuiEcSoy3QpBTsjTTAFbNNyypIjJbvOChE=;
        b=j5BeyoRvkvwXM7QZvwJ0Xb0/r1JJTxQ/ln2meQ+ONAOGbwVXfv1Vv66arJSWKp6R5C
         iViyjIJ7y9FlVNHFCshB70Dj8y9ZranpNDiAIxhZHhbhMNG1j3NrVaqBfY6o5LQlD43A
         I5jBvwgg0t0VNx4IS0Jc5K0ysr+fUYsBwft67UetNyUJaNCgaAN2JrPo+Gs7y9GsMFnr
         N5PEBt5YBUfGul/0bRrN+1gzkvz92+JrD4hMamKkMCQNdaa/YZkrEhqkPNm50YMKD3ne
         YKdyOtopOqffLUmkjqotGBRImvauR7K/pGV7hDN4pA+ppvjpKxKM2zNaoX7+9BErDP36
         5K8g==
X-Forwarded-Encrypted: i=1; AFNElJ/VnnvQZpOeJpEPKYpgi9QT7eq1EKMJkgQA3dCCfNlNMbikPrTPvP04LfneLDRjYsXLiuKm24DPWcEYHOZD@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlnOtnB9VccuraVGJYmWMQ+d0DRLZ99Ha+BNSnSVdRY46OxE2
	Q+TWF8/+pKUPcjdswml0j7eBoXDtByN7EGjJfufqyi9t0ldKmjMI51Fwri4K9H07XU/OJ+WVz0l
	1YRclG5IhptxEAUeueynxWZUdLIXEuCSWVPzeozRFWg==
X-Gm-Gg: Acq92OFuqNCsNlL3OZUvO1j0ex4w9cUp3tFz5UA+Epz330TgpK2VpFJzp+wSo5RMsDI
	dK/XrPBNWJD/hj7bxUElZpBBbLio1jRyhP3IoTpZlxCtjEYahWQtq85oeT+00KvjHZ8QtaLWN2S
	OkwNRJ6GURJTCvmjFKFGB7zettmvmhOr7VM3S64tyGNHnacwrOr66X32BRJp8ek9jSPP0pqlWT2
	+ydo1LWCkViudIpNBw924RTWUWcmzebMsh0bkKqfY7zT25eYcr4RHg3iOFKu51jcK/7Bcc5I6F+
	vUEdGDy+GOFtk8jiCSHrHhHU2LLq2Xp+PtvLAZlJuF2ufZEDCA==
X-Received: by 2002:a05:622a:1313:b0:50d:9b2e:7ee3 with SMTP id
 d75a77b69052e-5165a0ccdd9mr263610661cf.38.1779185070146; Tue, 19 May 2026
 03:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519004746.3203156-1-mochs@nvidia.com>
In-Reply-To: <20260519004746.3203156-1-mochs@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 May 2026 12:04:19 +0200
X-Gm-Features: AVHnY4I6Nw30PU4eMzbpo1rRva11FapaZNtSMDO0MpY3BrJ8caDZotUSuHZn_vA
Message-ID: <CAJfpegsTsKqq+QQKyBexQFP1=EGd8YiMT=rbaCOPeTBvLsY_JQ@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: back uncached readdir buffers with pages
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 02:47, Matthew R. Ochs <mochs@nvidia.com> wrote:

> This was observed with a 64K-page guest on a 4K-page host, using an
> overlayfs mount whose lower directory is on virtiofs. Reading a merged
> directory through overlayfs failed with:
>
>   ls: reading directory '<path>': Cannot allocate memory

IDGI, the patch makes FUSE_READDIR supply an array of folios.
Virtiofs shouldn't need to allocate a large argbuf after that.

What am I missing?

Thanks,
Miklos
