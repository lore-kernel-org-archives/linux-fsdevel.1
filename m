Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14975315D46
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776433708; cv=pass; b=lg7DKMxC759EbUvjWCNbJPDHbeBN2vsYT9hTbI1OddPCqrqpGUwC3/cPkS2vACWRQDbFVPLX6XtyvGm36XPEmOqJ9JXzF3vytOfmo2JN8IrJKKbWg+B2dD4lfFN0Ga2YDSW077b+eOcEaZtUGp7/0n0ZBhDwEJC69yE+ohS+KWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776433708; c=relaxed/simple;
	bh=epdooTCjdaaQWNQbHPFoui8Z7BrwSCiFwvDv3fwddmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWm1Drvw2QT+GQkIXrTm8Yq/wltbeQL3RR7OKiiuj0Om4T1yLOqC/A67SQfckXwnkoaSxASKMH1Ap1dJGY1LJrWDR+6Dcel2Kvu7bWqbmd91cX0objSKBF2GVQgkV5PH/JXl7pFOhuMngr0NCeiGWR7kgOVmMGNVFm8kKcuEmVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Jh3fhUFQ; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Jh3fhUFQ"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a3970f1a0eso8284266d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 06:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776433705; cv=none;
        d=google.com; s=arc-20240605;
        b=WXuN5aZG4Vw/XkO4eyRsuWB19KjpY55oss1D2S4FMRhDrvt/zag/Tp1lrp39KRZUWJ
         LlOSRPUl/9+Fbotpy0aXOwZhfT3HnpXkRAb0Q30ka+PWwA5rOJZ32MKWLoYLGAzFvYin
         ko5PKU0xzPMomIMqd94FRmvGx+R+ms4OKWFNV6c6tjs298Ccu8WkrCTo9OVJY8WV0V+X
         1pgRf9M7Os6QsGahbTiq07As2WS6wppFIQknJQavYbW8MYf1C0rnYYz4puUzFPke2VKR
         vvxQpbInsHM2Cz4Z4hP903gxIhB9gtm8uAk5Fd+9RKoKyRoLvPCtZ6Sejukh+IOt0SRa
         kTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RaBVFY7AnNSnD9b2BentSR20VU988SdCAvqd5GAeFSk=;
        fh=e52Y3u1bc6pUMMIgkdFHbQDRkmGHX73n+MSXSyV3ceM=;
        b=kVhsaZJKQP2PUnFoAzZRkhDCQNvQejHeiChTBD9g1WlEA2xgQix3FlGGWurrmtTJQG
         Iw1aBjITVQqAtmJArhRQEGtSeTfhNDgcDUPcBljdlbE7+nxUZSZC6aYAuCCoS+3RFtKr
         GEdlIteSHIbHZsYXxA1mA8YTl/Ord9pO6YYKQLAyPUxdPWX2gezGLYuAvs2K76smmIF6
         zKSSKyvIlkSr1i3rSiwT5zCpmV2KRP4J5OZxAxg8VNk9DSII+9jDotNoaX/DoPS+ZvU4
         duf1yLCdEX2TB83ib3MHX35rTKEHb4kFOGd+rWLEc4e8OSkasEtcOR4HrmAkWBeCigJr
         g18Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776433705; x=1777038505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RaBVFY7AnNSnD9b2BentSR20VU988SdCAvqd5GAeFSk=;
        b=Jh3fhUFQU6LAKZSkpnfTxYmfTWZ1owhxYqJ1O/ajRaTmsroHAcC10GCOg87MG7L8Lw
         5fd+EN+i5fmsie+k7uI07x4daqc+5+uX1UbWAaIzxMnSkx13epsaZ9vbU5oTux6HDCP8
         Tk8CP4DVITv5LqtGYGRJQPuOfil3AMIS0b87A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776433705; x=1777038505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaBVFY7AnNSnD9b2BentSR20VU988SdCAvqd5GAeFSk=;
        b=FKCYDtnKhptK/0FRQsIpPBqrb/XbSXDnaw0SrUfvKhqkMadyxfwGji076jArCl9o+g
         N4d/+7HxaTWqqNCLOaotwja9HBWYZ3WhI9AZ0qzroOxd7HbUlKSXnq5xLZf+Xu9zyuYQ
         Bnfyq0hPlw+LDCHL+y1s0kC1AEd6SY9FiS5YndvHF3tkzQ7A0/G7Vqphl3Z7J3DR6VO+
         YsMAbkbuVEIy9VUDiZOcEShb2RIT4rstYS08QqS3OG2VIhlXcXKFK6AQp60QqHZNG8L9
         1HnM644WuqSAtg/Wso8dyKgfPykhQe8mTz5rlMFyTz4JtwpHAdPPfIsiK/vBgBi6uMiD
         2Bag==
X-Forwarded-Encrypted: i=1; AFNElJ9GiTeg5RxBDsmFIdOZME2mReQ5UMK3PcYaJh+1KaPPJp6snv7GaA6CAN5nADxcmVBQe4h1qCFNz9XpmePO@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDZmD06skb4InBJUv6dlGSny0ZlhtmC4dnz+dSL1GPTG55nvE
	mROWstcoxSgJ6jgUQPNH+Hq+iKqIPXqiX4KFngAU04Tn7V8ohpkqJmP2Xsp0baVlSaBucXfpPEI
	+o5d7lpT5mwFzIy282jC29BNsLhBznsewjGJfpcORtw==
X-Gm-Gg: AeBDiet6iultDWOcX9L6yHzmiIagwkIR0ikr1EqyymblYF7xoHSMz7GXdlwfPaGkSXD
	H/k1AN2Bv8ADZREKAv7l2CCXx7vS689E5gduRQISOeZihhIwDMZUPiHtSSvpsvPG2agpjlkhVoY
	BbmKVGOv8+qzA62wuqgtlGq/SlpVC2dDE2oRyIdxpsQFDpA7RHzWhuTsD7PBiHB7/QBMvF3UxFR
	gZoj4SQBoB+oRms19NQDcXvas3I5mWQujxVlzOS8HVkyQhvDWNmlKYjtCHFqEk4VWJ+RXcbL3d5
	1xxT3wiYxjO1Ngkyz59uVxhaZplYkRwDTgcBLLr0TXi7/gI=
X-Received: by 2002:a05:6214:470c:b0:8a5:104b:e361 with SMTP id
 6a1803df08f44-8b0281693c3mr37122346d6.50.1776433704794; Fri, 17 Apr 2026
 06:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me> <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me> <aeFuarTL7xBbut0F@casper.infradead.org>
In-Reply-To: <aeFuarTL7xBbut0F@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 17 Apr 2026 15:48:13 +0200
X-Gm-Features: AQROBzAW7iBVOcbWzWDl5jliPnjlXzb1RPsfJkPFfxAumnXuWNvcGTGMUJbuMrQ
Message-ID: <CAJfpegtAeyMRENdneJkJrMKu8Uwnyk9LYBThjvTrFjHmPr6O_g@mail.gmail.com>
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
To: Matthew Wilcox <willy@infradead.org>
Cc: Nikolay Amiantov <ab@fmap.me>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	fuse-devel@lists.linux.dev, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Apr 2026 at 01:19, Matthew Wilcox <willy@infradead.org> wrote:
> What you could do, rather than unlock the folio here is to initiate a
> read of the folio and allow the read to unlock the folio.  But I don't
> think this is a good idea, I like the idea of invalidating the folio
> much better.

There's still a race window if the page is invalidated after being
ref-ed by filemap_read() and before i_size is read.

Should that code check for a truncated page and retry?

Thanks,
Miklos
