Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF83ACA5D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708912; cv=pass; b=OUdr9iHZ1lhhkrq94Qh2Oi1QBbNpKtMa7+gPaYoz85G7pNWOfKX0bYf0CXXRl+nk1uTk6upPkzA0btZPgNkheSrDP5oK1SOqYOmYMyaRShFuDPa5j91jTzo6k8iY+syqqDZVbFOpZw+IhVepSRfchLsBbhNH05q9/rglRtGFpA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708912; c=relaxed/simple;
	bh=dcNim2xLAsZ6mWcMD2UAAp2eM/smiZNWdZX6D7+rjy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5y28XAHdsoOTU4XTYSdSbRnZUExUvn3mec0Rr+i0MkWKvEt8Xos0AsqmwDleHYLln1gspg39EnRqqBsWXRQtSI+deucdksMb2kJcs6WxtZ9cc6lCdEyIfAVuQRljikjmFuTQ91K6qTBeSjRsy6XAAJwLrZQ7Rlj9GGcxhKsk8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdxhI9hy; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdxhI9hy"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9c745e18a0so557005166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 11:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776708910; cv=none;
        d=google.com; s=arc-20240605;
        b=Pl0cDpeTEfa5PDISZmQ3GrVlG7qwZRk4BfNwraWheKQFpkMixB41dciuhCkJ/fyQPs
         u/UOaCjlCD5kWY39BCRkepKUS629aSY+iiqFTys4gqwcVYh+AbR82r5Tg/URKtyIiZhm
         Alqd3iOTIX38sJ0wqxS/fKS5YYqpfqBZLT1KRqe51d8Mt6JOsb4Qs5NTSBEaot/n13be
         rcfWDx3tCpGl4NTuh1vqf5P61mI9Pk5xQH1jWBKlHcf3bwi8mZBfRdKg3c/udrr3S4xl
         pTbIpspFAdiapfMTT7CtJmGChVyUHFsq6MHyuRDBvJeas2E9d11g6vj/ChsHK5vGiQZX
         +d5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NSuGz4W1sn/OTeqLIDzPo4ktqthdVFHGK2t7GgKe+14=;
        fh=vTEo/b0d1zX0BQZ3GWumRP6gLRWpkhRqLkC5GBvGqXo=;
        b=Ockhk60Yawy+M9Cu0ek/pSvmVmM8ZyA94fXRSk4vSTGPF+DFxfeyFa4V4aKmK5iwaA
         DtSz8V31lI7xHWMKMx9B8Ie2n18/JvEq0JGEaj/VgGMyFvPsgF8RGoHjbBGhmWdCzWH9
         oz3Q5SQwACFmb+L5tO5hh8u7+vpxtQTPe0Q5mSW3gMI3tujZ9Z2sSff7tfxjDfjCrVgK
         Ud9i9F8UrN0DjS0s7ksgH3z/YMKnvXlNC0lim0vKV94GjEVdNuWT9hudfQeumCw3xxgC
         GyAe3QDf2m0dxUoBQlo4OHJjWF8Pvvl7mszOQwXqf+4O3DQ91dGqP5H72LeDOp0cgeHt
         utHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776708910; x=1777313710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSuGz4W1sn/OTeqLIDzPo4ktqthdVFHGK2t7GgKe+14=;
        b=IdxhI9hyTXkvxGZPtoynggkyqKMZ2wBCeGbWpm39LFZAoW05wsg0ZC0k6EJsS91AYc
         5W+KF+yEzz72c+cLTQCZn3UtsIOLlzuOuwOcgdjtzB0xRC10rgTtZ9npxewW5LtCgc1b
         gb5tsLiwGUpffKKYX55SW6vR2nuv+9+f3mPmFjaal2l0uQWresZ3r/uzTok3PcD69/eY
         a2mvdNOGz75nbOnePhp25BPwhgL9d1mnTdBKdFHypwyK7sXOIMJQ+IVUcFv4hA/4jEH1
         JamidaFemf/SCyD3MwsgWsXCqf5BjrjgrEJy34/dLRu1ia59dRbX3R3fpqoB7jX3Z1aP
         06eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776708910; x=1777313710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NSuGz4W1sn/OTeqLIDzPo4ktqthdVFHGK2t7GgKe+14=;
        b=Uq80QbKkXIvBi+eKnTvjPP8x3IFVKShaNlblgaytGnf9t+ejSCFFrEvKsTuveggmuW
         +Tsx22WN5Gsy0+QcrI4ac4SyflkEETTG13Zyfz8g5E/dvDcfJP40Gqsgq7RFQLJ16g7e
         GWL/lEC0S6+qfDaIRG1v0DfN6VfsOJZGk7yrSQZdm3elK9r7qtnw9ksYJrQevndOz+rR
         N6S/AkCfENNMUINaHgIO4gsgmqOLxDuuaGowPYxMKGi7IbE1ZMoyVOo992Pq8ZiWJ6b/
         mnd0P9NKdlkqQXxgfUsRgElwP1rinBMTxuRw8ctmncNyHkOmPa2kx5/MCF0fhJFxTw9l
         /Z7w==
X-Forwarded-Encrypted: i=1; AFNElJ8sklYC0g9loJ70w1FEEMPcm4c6GUFOeOaNHb+CUiorfy7MhIDU0f/F9B7C6oDTZuwoT94UoAYfPs+Zu07x@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16R0XOQyEmRvIjK69H/yeI4Jubjm3x8dzhZOcyTqS6cLT5rbw
	26W+UvV0tJDCD17dQKIL6xgdxsZZo2Ap9dzlXsklIlrTYxT2txVWE66Gr8v8BI1DC9bm0r+z5Ud
	MT5s44h1ScFitgduEd7alBiyhk+b5qbM=
X-Gm-Gg: AeBDieuTI2PMupvorros6JK4ypypaCpfWNJJcx/gqjuEtuX4/jGyUIC0DnbY+HkHGxm
	h0IZGhV8WQ6PdGZbugOnDqQYwQS+DzGgZMFvgpAQtrrl9NDKT38DsADw7fe79Y8ybRHksq4dt/r
	5+1r/eR5rZmt/GCehLoFH4uxQlBqoHh6dqIqVG4SJqtycpL3emIGyK2ZdTjgEdBYMlL/8Jz7kTx
	vngHnyUXg/VsM0IHcnfa1mpbjiiMvXnXGm3LMwJKX9h/j2IDi5WZuS8xfQ/r3W8Slj9gCVTLVJa
	o0XlnIxEapX0jaAKVYXwYPLAn9kmHnefzPF2fM/czJ899vKhuYNF
X-Received: by 2002:a17:907:980d:b0:b97:6d1b:4be8 with SMTP id
 a640c23a62f3a-ba42063cd53mr622012966b.10.1776708909589; Mon, 20 Apr 2026
 11:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417142503.1436446-1-amir73il@gmail.com> <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
In-Reply-To: <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Apr 2026 20:14:58 +0200
X-Gm-Features: AQROBzARyuNEsoMJDLxxj1hCXicOCEkcGbdzU76OSPhseq59kvgHb1cTbSDYHL4
Message-ID: <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 4:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 17-04-26 16:25:03, Amir Goldstein wrote:
> > + - Handle security issues promptly.  Filesystems parse complex on-disk
> > +   structures from potentially untrusted media and must treat security
> > +   reports with urgency.
>
> I've commented on this in reply to Matthew. I agree syzbot results must b=
e
> reviewed and identified security issues treated in a timely manner. Howev=
er
> dealing with maliciously corrupted on-disk data isn't (IMO) a serious
> attack vector. Even current well maintained filesystems (e.g. ext4 and
> others) have some issues in this area so it seems unfair to ask this from=
 a
> new filesystem.
>

This is what I posted in v2:

 - Handle security issues promptly.  Filesystems parse complex on-disk
   structures from potentially untrusted media and must treat security
   reports with urgency.  Expect the filesystem to be subjected to fuzzing
   of both syscalls and filesystem images.  The filesystem must handle
   corrupted input gracefully without hanging or crashing the kernel.

Are you saying that ext4 and others do not react to crash reports from
image fuzzing which result in crash/hang?

Can you suggest a more relaxed clause or should I remove it altogether?

Thanks,
Amir.
