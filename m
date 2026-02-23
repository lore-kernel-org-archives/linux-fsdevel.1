Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD59364055
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859404; cv=pass; b=DBiT1A9+fAxSqJYshyDXwgQpH6eZQMtn/MFvHFDCBsGEDe5Er3vv2DKatlco5riOGoSipkMFnl3EiEJAxiLtMfkP3C4KOPoWVZkOpbEYw0MPtMFxLut+1Z/5U6jOp+YRaogFlu67wWNN/9Fi3Og7/w6tkkbcUX2juvQKDzAbJ7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859404; c=relaxed/simple;
	bh=68+0GYjfNsF/v2lhskj0isLu8qOQzsFCvpehF7MPDUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzj/dUcEM0wNiQDxgRKo3vcm09Z+q+fofmfsdr2Ok9ByRDOVNQcfKa5YlwAJNDn1QjusKIUmB/943v9ljPLIS1V8bL55F45k6gFeIYUVzc9BnWd+1LISxC39H15R0UyDkLwEph4W4sBBwdhaAHjKzzG42biopVdunbN+Uyt4VPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rZUSiUXh; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rZUSiUXh"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506aa68065eso39193991cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:10:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771859403; cv=none;
        d=google.com; s=arc-20240605;
        b=CVNYYWjwEoEaHtQ7/bJ1gNdO7HOb0u25S3HXVNKyd2l+xGFJScGtMl2OXoojWKzckt
         tNtwQ4DPq8OhKraED/mWPHOzTw8xaKb7wrTRRXYEJfifAcb7VNfB01LkPUIxlUD4jtdA
         6a983jpOYmCAedsOC8fRdt/zIjy/zfKhkdgyIf+KncSsaNgH81CJv/XSI5JZ6Aq9Ckob
         M1I0ASeKHNvO5iOwmE5o28gyhw+sD0M0P4AhYL+5dVcrd1b1enKSwhsvZ580nwOUm5y3
         H8XvuJQcOemd7nERl0klmrhbxn1a0m2PQA2Rnzqg4mnmbGWVgotFWSLp8nulMrDdwrkj
         IEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=68+0GYjfNsF/v2lhskj0isLu8qOQzsFCvpehF7MPDUs=;
        fh=x+1PyLCxMNvUFK8jxdLAxx/8+QTiDIRbeC0NEeDNb4c=;
        b=FtTLU1Fy1p/+n1Vz38tTjsC+95A8pDAF9J0K0wYnojCkmBuliLcA4l9XqbxmWKgkU8
         P/Dd59YGH8MBkPn0um4EAYXVVpD86mTjOPmYzlwxnsSLH5w4e8/K92+T4kSo9n+u2PWv
         R0IR5f60s/5GM9MlaILWpHpwRpmQ78oMIsjCabFnnUW/IccYG7FT7sh8vxIt4mjsdirA
         J3ORie1YlEJLiE/tbgV2UuzV+W26Ni9Zu+nIvjfcpXJuERPjubFgVneEZN7EXT2STVSn
         +S248P9W5N4mSmIspCW+Ia9p2mKsCWehcGUudmQNB5AW5JqHzLH+4MUCmrbWakuSKonq
         lReQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1771859403; x=1772464203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=68+0GYjfNsF/v2lhskj0isLu8qOQzsFCvpehF7MPDUs=;
        b=rZUSiUXhi7Wok9FV3G/8nvOK0rA3wHSOBN9YTxZATA3OmQuchezrYb2M1qyUlE07BI
         0DSfUhcqJmQIuv+TPGHIb3BPf4z7ExRfTA4yncCZppvSrLPqc5AyHjY3Aw4+8S64P99J
         pG0W5LrpXnR4aWQpUdu3RgXjXY8mGDXAtGEkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771859403; x=1772464203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68+0GYjfNsF/v2lhskj0isLu8qOQzsFCvpehF7MPDUs=;
        b=HH6r3UN/gdp1dpfC1thLqWUd4ci9aE5miMdMNK7jVoQEtRenSIxBxDcFkkUbFqyOGs
         8czZN6cP6MqhCTEQsV/xqgJDMRRvHUIHFTpR8MnN4engcWJvHXtL2iHQ6TOFZgoAkqFE
         xG7YOBJmP5EpF5Xz83rM8qSTDRJvlc5pv7ph32b+JqfPs2HIXl8PtFysY6ZbwfkDPaK1
         r7cc55Cr6QhvuJBywPssXwaklwQ2HRgphR8YE38G6p6rGiRKUHwA95/TAnKRcw1HkN28
         QIODUHXzTbeor2pX+6MTV3gMOfZNCSHi9g3s0nj6+SsO7JcPS70CQqMg6feDYLR55WMD
         qqhA==
X-Forwarded-Encrypted: i=1; AJvYcCULAJqr5MZeXaInH8KXftVFkWBYArZeYTH3lvktg2HqhdHmq3BQ4AQW4OF6uQyKLZM7NLCKx7TWud6rHtHu@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYAON77hLp63vqPcNATXwaG8mfHC5wRpbA8oatZJcWF2NY7dE
	G+b9kKvqLUHyBEj5BNkp8LNNV22/nvv2h0rDQcvj2JWY4YohfBNE/XQg0W7TbGFPEJhmXvtGGPJ
	tTMYWCni0KcHIDG4npygBBlYqGngpkQ/tjWx5t404yA==
X-Gm-Gg: AZuq6aJGrc4LjoLxHSwxwpyGqMk2K2bB/evJ8bwMlTtmS7Tws/vT1yol8bofN2ysyd9
	qgu+AdcjhSUZsg1Lar8xFHsVSIvUdYEts/5P0+pgyl4DvwyiNiJ+oJjn7kZq04zX0gdbu5R8Jz9
	bkgQNZo/YWQWx471ray1cZiubReBu0JTJnrhXSpTDXmcvOi7+4TiCMWlI5PxfrsirBnbSvXPt29
	0IlQkqZLmYNpOjusmzWMOsqRGeakXSoBq2YSrM7E08fCKeJIUQV8FO74IiK9DPJ3bZBrhQ5+MGY
	hq7LdtLr1/gD45Jt
X-Received: by 2002:ac8:7dd4:0:b0:4ee:61f8:68d6 with SMTP id
 d75a77b69052e-5070bba6c0fmr127821951cf.6.1771859402774; Mon, 23 Feb 2026
 07:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220204102.21317-1-jiharris@nvidia.com> <aZnLtrqN3u8N66GU@fedora-2.fritz.box>
In-Reply-To: <aZnLtrqN3u8N66GU@fedora-2.fritz.box>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 Feb 2026 16:09:51 +0100
X-Gm-Features: AaiRm527IRq1INedIsxKmX4eSni2tfyOO910SOjsTolaI7BUafUkCU7DdsaB62k
Message-ID: <CAJfpegstf_hPN2+jyO_vNfjSqZpUZPJqNg59hGSqTYqyWx1VVg@mail.gmail.com>
Subject: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT is set
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Jim Harris <jim.harris@nvidia.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mgurtovoy@nvidia.com, ksztyber@nvidia.com, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Feb 2026 at 16:19, Horst Birthelmer <horst@birthelmer.de> wrote:

> I have been looking at that code lately a lot since I was planning to
> replace it with a compound.
> I'm not entirely convinced that your proposal is the right direction.
> I would involve O_EXCL as well, since that lookup could actually
> help in that case.
>
> Take a look at what Miklos wrote here:
> https://lore.kernel.org/linux-fsdevel/CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com/

Bernd had actual patches, that got sidetracked unfortunately:

https://lore.kernel.org/all/20231023183035.11035-1-bschubert@ddn.com/

Thanks,
Miklos
