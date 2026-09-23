Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832725A640
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205578; cv=none; b=S3qG5S7zExbm7kfvNzlNMV2NLDKUXEepBZSfNiM594/HMTIvRTmhQaJ+BGUrsRkmhPZZ/wqMKAVNJiiVHkGvG2bykrlTualcq5qcciea0A4TFkpX9EyUooOJ6FKKMhDmobraTt6ARtHkf3w5PH4ag4+ySDI1NvpBWIlp8nz1WgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205578; c=relaxed/simple;
	bh=apA0t8EACzOVzdTLj5A4drmVuPmvi7Wy6pDMnhKnGsI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2BbmXqJYc7PRuFZA7FnviTaUcesqjxDukgfi1eH3s/Czc8HbDcAIfNFZy0TzkYEt7FTNAAkXbEP0MekFR/Evpoc+af/asgtHApr8Yv09AC7CEgoG1uhREt+u/tmLo3J1b0ipL7n8S/R7/SjflC4TZv9RCOFdbOmvuqGvWTmGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=uXSWYDRY; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="uXSWYDRY"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43ac6089so22782597b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 16:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790205576; x=1790810376; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=23UHJNEzdtkuLO0UgWG+W4Z2VEKTMkyMhtDcKRiNdnM=;
        b=uXSWYDRY+Dtef0dmiwcaLZqL3eCFqAYRj1CA3oXRidqaH2OVwOEpDeIV004YYmztqJ
         A2An4Y+FqKRmO/npfuRPemwvY/1iTHoxmFlvP4u/63zCfOc2/khKIRH0cRGyFuNb5DqJ
         MNrlfe2P+AYxUQjI61zECnIloYAHix5B7tjlKtxA5xyafPcopTLQb0WvtEkjUFp2efx2
         ytr7GcqhmQ9lnpACW2+UldFAh+bKPNAZ48+qIrFnHvA/Vpmccy+rP1gBmiLHXFc6+r+l
         8nzOlWCaEati2qjeE8fa6Lh6+YAHHd0DelRMtxYviiCxVM2wNNv659PNQM46r6dwXv9x
         oSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790205576; x=1790810376;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=23UHJNEzdtkuLO0UgWG+W4Z2VEKTMkyMhtDcKRiNdnM=;
        b=zmm2+KCdPjiZ3udVjGMV9zf7GuzCiG2sxsxwxZZYPDipu17GOkMb7zf7XG1+rcQ1Ec
         /AYSjJ/ndxJZ+69hUHw1LZbX/k6GyeuKmnec84MltZ3sKTmpRujkasS/IQbmLjl7EdTp
         hm8kWIPdMGMeC+dMcINaHFMVnLwS20TmltWU0NhDkSsL+KmYOa4THZdX8mMQh5snGvoX
         kfezEKAH+EPyz6r87ZuPqfB3btczzLKzRofIcVa9WNRunwSUltJQsuTNF44Xp0Ga++Au
         yBQCbbz10S34/cNmZYwHICZBICa0+/5TsSWO+F2TCYlSA76DknHy+Cp5euFl+FmheElD
         NyxA==
X-Forwarded-Encrypted: i=1; AKwUvByDhNztlXj05EeFYVmyYEQh06QQ/IMXQ8zMcctEjDdDexuezMADE3OUGIC/buJxen2VeA53tUeHrPc+/oD1@vger.kernel.org
X-Gm-Message-State: AFuF++nghlWntA9c8N8Spu5eyLy/zvXW/qCFvgY3ZcrZoNpVY5FP5m7G
	uFYzuLcITSlYeu+h0tA8xHm2Xsb32uPTsGR+5JuTo/n7Eza0X5fkost2/EXzcVZWV/m4aQmFE6A
	Oxcu6uHs=
X-Gm-Gg: AYBFou2p4A/auAEQPxmuuH6/GLqnrh7+x5edxVWs/Timj46u1sG/6ha6+FLPy5S/EsR
	vO0lshwYCaHTvETfruM9Wys6387X/wHX4o9/V4MAiPwgNFIy4SHqSKauM1Kyu2ku7e70dn0lqXp
	NpHmy4SRYFGB4CAOZ4k/Jpz9EpbU3rBu8wWsGV3L32PmiZIXP8xHKRMP4W9+Vkw4/gKHf7h8Zqx
	GBG3fXPg8vrgUBKXYxC9Y1l4bw2C2U5bRskQxmj8fDSp+5/aGXUFwjPxMIs1iWueEOHiSpzvW+y
	y4tGK9H/KAZgYb8rg4KeXtObG9Q22AqaKS8ShUvnugz1fcVBElmi8fUrJqo41gJT9IFefiyAEuJ
	jfO33eQQMsz22rsYbrGUc7zBVR9PsPwovTPlFdwNpIKHPVZRWCe1WZO03IpLkCfPG4RN+EtZvRH
	wn57K0I8KPzIdKi5w4TRqEo4ZmsOUZQGTeJyGaWoV+VajBSGsMRZVybDE2XFtl5KpPYLNDtaUCh
	AbVO1PyNG67e2+97QITe2GXExXwofRxO5EfsSN1fFsyixNPCEBxUGXyFjw7RA2nRYZwEAoSDoK/
	tqKdtIG5wwOjzP60jTRVaB6QXSWggC0gB43Hn8dRZyCPl/BNntLhYTB/k0OjO9VyQzHfX51lpkE
	=
X-Received: by 2002:a05:690c:e147:20b0:883:768:7430 with SMTP id 00721157ae682-8a64af5758amr4329187b3.34.1790205576169;
        Wed, 23 Sep 2026 16:19:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:25ba:d67b:9196:e10c? ([2600:1700:6476:1430:25ba:d67b:9196:e10c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a651615f7asm2216677b3.17.2026.09.23.16.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:19:34 -0700 (PDT)
Message-ID: <24b1208913946d6146ad6b6e03050d60ef939ea9.camel@dubeyko.com>
Subject: Re: [PATCH v4 4/7] hfsplus: add iomap operations for regular file
 data
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@lst.de>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org,
 djwong@kernel.org
Date: Wed, 23 Sep 2026 16:19:32 -0700
In-Reply-To: <20260918133649.GE18107@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com>
	 <20260914233941.2966421-5-slava@dubeyko.com>
	 <20260918133649.GE18107@lst.de>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-18 at 15:36 +0200, Christoph Hellwig wrote:
> On Mon, Sep 14, 2026 at 04:39:38PM -0700, Viacheslav Dubeyko wrote:
> > This patch adds iomap.h and iomap.c files. The iomap.h contains
> > declarations of hfsplus_iomap_ops, hfsplus_write_iomap_ops,
> > hfsplus_writeback_ops, and hfsplus_write_dio_ops operations.
> > The iomap.c implements __hfsplus_iomap_begin(),
> > hfsplus_write_iomap_end(), hfsplus_iomap_cont_expand(),
> > hfsplus_writeback_range() methods that become the basis of
> > HFS+ iomap operations.
>=20
> Adding this without the users in the last two patches is odd, as this
> isn't really the kind of atomic change we're usually doing in Linux.
>=20
> I'd vote for merging this and the last two patches into one.

OK. Sounds good.

>=20
> > index 000000000000..5723e854e58e
> > --- /dev/null
> > +++ b/fs/hfsplus/iomap.c
> > @@ -0,0 +1,192 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * iomap callback functions for the hfsplus filesystem
>=20
> In Linux terminology these are methods, not callbacks.=C2=A0 I'd probably
> just
> drop this comment entirely, as it doesn't really add value, though.
>=20
> > +static int hfsplus_iomap_begin(struct inode *inode, loff_t offset,
> > +				loff_t length, unsigned int flags,
> > +				struct iomap *iomap, struct iomap
> > *srcmap)
> > +{
> > +	return __hfsplus_iomap_begin(inode,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 offset, length, flags,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 iomap, false);
>=20
> Odd formatting.=C2=A0 Why not:
>=20
> 	return __hfsplus_iomap_begin(inode, offset, length, flags,
> iomap,
> 				=C2=A0=C2=A0=C2=A0=C2=A0 false);
>=20
> ?
>=20
> Also may_alloc as flags with a readable flag name might be nicer
> here.

I like the suggestion.

>=20
> > +}
> > +
> > +static int hfsplus_write_iomap_begin(struct inode *inode, loff_t
> > offset,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 loff_t length, unsigned int
> > flags,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 struct iomap *iomap, struct
> > iomap *srcmap)
> > +{
> > +	return __hfsplus_iomap_begin(inode,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 offset, length, flags,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 iomap, true);
> > +}
>=20
> Same.

Agreed.

>=20
> > +const struct iomap_ops hfsplus_iomap_ops =3D {
> > +	.iomap_begin =3D hfsplus_iomap_begin,
> > +};
>=20
> Please use the new iomap next scheme merged in 7.3-rc.=C2=A0 In fact
> the old begin/end methods were supposed to be removed after -rc1,
> but someone they managed to still stay around.

Let me take a look into the concept and rework the current code.

Thanks,
Slava.

>=20
> > +
> > +/*
> > + * hfsplus_write_iomap_end()
>=20
> Duplicating the function name adds no value.
> Same for the other functions.
>=20
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * iomap callback declarations for the hfsplus filesystem
> > + */
>=20
> Same comment as for iomap.c.
>=20
> > +static inline
> > +int iomap_dio_end_io(struct kiocb *iocb, ssize_t size,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0 int error, unsigned int flags)
>=20
> Odd formatting, normally we'd do:
>=20
> static inline int iomap_dio_end_io(struct kiocb *iocb, ssize_t size,
> int error,
> 		unsigned int flags)
>=20
> or:
>=20
> static inline int
> iomap_dio_end_io(struct kiocb *iocb, ssize_t size, int error,
> 		unsigned int flags)
