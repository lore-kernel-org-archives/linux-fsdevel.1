Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792672261;
	b=if52EUCrnCZkQyRKhkETN8x8smxaOGhD3pp3Sacx2Xaf+d39xayFX0AswK3ZoaLUlCg+
	 3UoNnuWHm4w06gyKnBahJmskWuewSDTmyBqjz2akMlOAEVqI2h1bu6mfFLy9W3Hf5XZID
	 LrF+luiLkke28I2tFxXWeYATBSBfpVZzxC5F8BID8vL10+64C2Cje6E45u6mngFAhFvV9
	 T0sQqBida8jxuwlLPXdubs7AnLGZLVBgUQMJNkQL4sktnu1vyPn7Ofhjj5X8xcRSQ0ojQ
	 LVhqbubfEiR1vf1EErs5Zi2+nk+oHv8s4bp3/DFKB6YXmxpSP9agDLGiLS4n0n01+Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lGYMsLv8l3p3TRmB4tMktTBQwkVWbogMS0TSWwwLKpM=;
	b=FMmodRUCLt4gZAkjdcloZiM/EWANJxNo7Kl0MOWi5iVIWmJnv4NFCDQcHiqFfRFrxrhm
	 eOCVEUXqWAcvp51HKZK26vi85ZAMzi6hPR5YU4pNmx7umudWXq+rr7sLLXUegnTe1yJDJ
	 QYbTVoapiM/ICBqdDZw/wwSrsfgGVDd7mpHTQb7fVlvuCmp3Ah15YXeKYijqUI8CLxFH2
	 c75h4QJCwFFOVN27D4a0ECVxzy77kgRtPCVpMP7cAj9BQx3UJzftfv7NwSGIUxk2CQKZq
	 frM7jQHDPS1848R48W4yNxLlUuKJME5MOGwyusugPMgWxE+LgnZX2O++Y+iaHpngABg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=Zy+M28iw;
	arc=fail smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5F606A319
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 12:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FA5F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=Zy+M28iw
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53648215f9dso14995041cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 05:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792672259; cv=none;
        d=google.com; s=arc-20260327;
        b=LM4DaMgMyDHjkA2r4qMCCjMHsor8IdhP0WIV83kNk2Dqp6UibVjuBvB3MrvDwQUECj
         urFgx8kGbP9zJmdekSvjpNVFBlJX+md54GwHF31D+z24sRIA1+Jmmdz/egqWCehJhi4j
         u+gM60BHzZR7HbTKKUK8NckL5xTQxI27qdR1BebJvGCCFnCJPvXPPgDki21gS33pyB18
         REwn1lDrZ7gm+OfdrOobdawd7BHMpx9X/Pn+6/u90eY0FIC88Y6pINCapHciq6DrGXOS
         vbFAL/cwF+SbkOet5QzORx2SmG98nrWdfWBiz4MwKrOqpHjeWCi10fthjewUxzv+oDWx
         qtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lGYMsLv8l3p3TRmB4tMktTBQwkVWbogMS0TSWwwLKpM=;
        fh=pDzwwmMxdOhvPrAlVtoTw17RmsjJ5ZjV47RIcw9cfFI=;
        b=Fu+ExRdhJqflliy9HBIfTuwCHA9uSxxBSdlLKkbpnLSSc0pIlGQvtJLk8VUf32gW4e
         ZFH6ppqc5u6CY7QImFDW0u2Rh9FAkLTOFZ/AF5gbgD3cOvzVtaBq8i3UbPV7z7rrHiKK
         pqLBa88F7xcT7udlnZ0b3iVSEO43F91QmskoppNvRDnhRU8tQTyiFXk63GSu4KWebpJi
         o+Itpi1k/YTa9IJWXiC9j4zpTZcbeFitGfrfIZ+JTf3pftmhp6nfozCcM5f3PCB9D7bV
         Iq/YKghHQ0CEGjZ00UqTdaaVHS5UMouTPPwbWeJlsya5PHMeCZHLuSHzKnqG0la4T5/J
         40lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792672259; x=1793277059; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGYMsLv8l3p3TRmB4tMktTBQwkVWbogMS0TSWwwLKpM=;
        b=Zy+M28iwJK07ER0cPasCm2TNbM+SqRw8NNjHRfPDKYbCthGDITArOYiFFI7ixQNJlA
         AiZ/laxHOe8IDLDbGAFraAcyTJUpBAVhYU3cXjiyaNKDih4qZddFP5eyx/sdta4yZTMm
         yh4QU9IlHi6W7zAvi5kyqis85p1XgATOqgwqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672259; x=1793277059;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lGYMsLv8l3p3TRmB4tMktTBQwkVWbogMS0TSWwwLKpM=;
        b=zvHeFexZYjOJjhRBdGHgi1NXUagS5R1rLS2cNn5T9iQkJCI58TqWT+HMRW0enflGnb
         E9thrVFrt4MhkVbgmS+k68tYNQpC+nMShB00MEPjX6qmluIsABzFSaW3sDC8XLLlwXEx
         uJowFEPCHqWHLlnl8K6Fg4aeXVMvhBAf3ck2E+jsj6fPbFebIpbR9a0TdPd5y81QTOpr
         +ot4Se+M6diSU4mAV+Q9SoAK0JsT1dMl0NhTrn86ZRog8YFbEQKlafPLfPF4Ge9r3+mA
         E+yr7A/fDWmhy2am3b80LPS70TlyaqFWUoyXr0BZHbQDlWiRzhi1QorZ75YtjxLdiEox
         3oEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBitfu4n6P2KOJlXhWmaVNGv+Z3Az41plVurb+Dp1ljLXKXFJjAFgVmqVpauKixOcYvL8TnZ8ZIhaNOD/M@vger.kernel.org
X-Gm-Message-State: AFq9FYKb19mDW0r+HfjS2vENi2ernN1/NpQMHZuwrR/K89oSWCHXuGxm
	ZyKs4BvA+gavz1SEHFlkZFh/LbwxtLDyi5YLwHZY2WvlJuD0NbgENP3kZFvGxozheRPgWDI4Zeb
	eMOoeYJB0IMQ3hvvi2nsvIYDYS1JoIrsMLDomeOWMCrmV5DhtnPZw
X-Gm-Gg: AYBFou0xMfMIKCBBQvDENRwqT+eYQIch6l+DXdkqDxQlgun1iV6iLFiyAT9qEHAawxH
	/EgB+jtzR3lMwf7REFm9P5Hdh7NO2UtEdKnot6fSJtsRUWwuejaX0CRAyH42v1EVX4YPMSreZmT
	q95RtVEaG6QsK0v6k5IUOBEMDDD6lV0V/0jwhO7hWlL+3UCE/ssgSFUTdhGzuNg/lXLsmCGrWgf
	75oKEBS57NOOD6i0BDAZ7HYcJCAYVOLGNFnQpQwa9jBiRBE86mbHb2DDd1sTy5SAX0bjSbby68A
	rotcB48qRihzW+p2983jFU+rvZs54OGZBNvJm4gouTzDDoDyPvdiA3mq3s+UV4j8g7/kzE2cstJ
	yLvekkrbhWQAe6NUfuv0ZgiUfYs/3dVYGRewr2X1gb1r7Yx5YrHluAv+nTUuxJ/yw6FrWo4w=
X-Received: by 2002:ac8:6f0e:0:b0:536:d47:257 with SMTP id d75a77b69052e-5369b82b7bcmr72708191cf.51.1792672258882;
 Thu, 22 Oct 2026 05:30:58 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019000810.1837917-1-neilb@ownmail.net> <f1c42d0bd125c6b1c39f1ebaee41340b5f6f03f6.camel@themaw.net>
 <179237697885.1724252.11956785709205194840@noble.neil.brown.name>
 <d0bc6eaac2fc84cb43b569f49ee503057784b45c.camel@themaw.net> <179254088039.1724252.11440960537426762855@noble.neil.brown.name>
In-Reply-To: <179254088039.1724252.11440960537426762855@noble.neil.brown.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Oct 2026 14:30:47 +0200
X-Gm-Features: AclHuK9MUQBIzy_P8SrOi74oPIimO0SpPERBXe2T3G_bWnQb__EV_qN3updqCD4
Message-ID: <CAJfpegtDffRgzd3GGBfk=fTae6R32pYyStXvucgQwVdr3MTT6A@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Fix easy bits of the negative dentry problem
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jake Edge <jake@lwn.net>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 02:01, NeilBrown <neilb@ownmail.net> wrote:
>
> On Tue, 20 Oct 2026, Ian Kent wrote:

> > The source of my concern was originally the traversal of the entire
> > list of child directory dentries in the notification code to set a
> > flag that depended on a parent dentry setting.
>
> And why this is a problem?

It's a latency issue  at umount and when the dentry list does need
shrinking.  Keeping perfectly useless dentries around does have a cost
in that respect.

> I think I can fix that, but I would like a report of "task X takes 5
> seconds which is a problem because ...."

I think we had that discussion at LSF, and as far as I remember it is
not theoretical, but I don't know where to dig that info out.

Maybe someone on the Cc list (Amir, Christian, Jan) can remember?

Thanks,
Miklos
