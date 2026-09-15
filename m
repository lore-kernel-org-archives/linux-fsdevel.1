Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7C437118
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789497274; cv=none; b=nPkwd7N8SArjPojiU3QtSi8czsaKV35ws8Py9lJDQNKhpwvpuSS0kdXe6ATluxgg5MbbAoh/Oo8REmoGzthlLAZQJ9fG17rTqEtEvH7wJOa8v7SYW12erTdJuO665Z2MKaYJbDn4xALacQvUNh5KjLhH5DYa7KjITU5o7GNkx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789497274; c=relaxed/simple;
	bh=Dl383+gwfUSGc4PAwfJvc7DWfGWBHHYOW6/Gk/X9wOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YwXOXEV8dQmlP6ApHxy8qLhv/CCkzsKVipWdE5P1vtKV+20Mcma2dggA+UGINx+vP1DIhRxX1shyW8VQiTtVs4SoRcu6USV5Lb3zY+fK54//2HnwsP5g3U4ShWWBh0TnFD2mHlFg2AmPN1AI7PCdXIU+OJ6KWUNusJpxsOqIvm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=OWXayniy; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="OWXayniy"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab1ef11so120673d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789497271; x=1790102071; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8QlMmtdkGhfw/o8eisLRP62kw5vy2CSDX7fgXKC+xlM=;
        b=OWXayniy+JoU18Hzq6L5SoWKvIf75xh0XYdvt0vQQ/CMRMFyjwUwH2GPFa+3TZwzJN
         UjL+pVuzr/SWbNhTbf/LSi4cR5qutgYFtuVQvDuradxMTMFRHvhM4GbSCEjEhjUjV5CI
         LNkikZ6/UvN+lhQEDBNyZpdLJhKG8kQxFwIbH3Yli3f/E7Vdm+yHt0bWYVxTaxlGBmok
         vNbVhxGROHMp0IBP6/kiKeogoMMHp35pO4roZkTQ1Epv69LQwGM0iQFxM3XvWE+CnAeh
         on6o1NK1GLKv00j15Kip9EteEoxzI4shYCGPmfg6J3iOr+qoaFuo0CQ46OesiLaADHOX
         rWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789497271; x=1790102071;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8QlMmtdkGhfw/o8eisLRP62kw5vy2CSDX7fgXKC+xlM=;
        b=xhJs7dxy/gv6gifs3iUFd5VkkGWgzA1ZQNCLpW+wlQWJYxmeVJzL/EZEocHELCVI8D
         X0bE2NljxT2qyODmWKjnz2FsRy1bYa1ktunHXCnyH5wX/tDKtBfZ2gDxFhfpZbTm8l08
         xxwSg6ZwS2a+X7KYLdwYeXRr/JZDOw0Sie+PKLDfRPqy+WYIQ9XICkCzGKnLa/RSy6Kr
         X4DhXB0buHfNb/LShms/QxZIb/4dcCYXksBMpU1fbDjMgs8W2izCFJ57s8f8EuIqhMhz
         S6hcIjtbtrUI0iFPrCZEe4LIaZZdbK2MmB4evR1vQjjDO0wYNPXukqb5iLdy2sDx64l9
         pvgQ==
X-Forwarded-Encrypted: i=1; AKwUvBymnkJhwpNwPvQPk2z2d9HD/BAPtrrV6gZL3421OwUpnCoxxN+1NfctF8nzX+JhPmZN3F9OejGC7rjJp7Bv@vger.kernel.org
X-Gm-Message-State: AFuF++nH1yLK0UwE7bKuWy8OwmMdyDQgG5nnWobClKERY2gwLBoX6uYW
	y2FweafxTK8Yo4Nrbif2ihBM1KQER/FA2izRBWrUomOYpG1h2F616wXcBgHEgk8l7oonY7N9Bx+
	SXyo/OJcsEw==
X-Gm-Gg: AYBFou1FpV3TR4FjzRK062xfcTTv4zCPhCyrmnUf8sXKS87RRQeCqcQNQLigR/2ZiLD
	YeKncd/Ge20tYeJ+CirioH1cnysyHBFLX1TMaLNRY5ThgFC3RBwQnlr7/TH/8ShJODMRb02Ja1B
	MgG3vPcS0Gn5fEhqNp2Ai4iOmunuqM2k4gYvmZlI8BBPkANxQ8AmGKRBkM/5bUQnyI1DFMivyEP
	1Jcq1ByNF1xro5+AzBAAktlyK49tbDvKjf5tXe8rpAiARoZYtsUNp4HDHdeq/F0ttOth10UM5Uk
	sZot3TiA9/kNWh4lATwR00pjDx5+z5fW61bCS7Z8CN/Lql1EzYvr7pxZj/VsqCXYqJqrdJ6ytqn
	fpmoG1Thi79dBIbg4XlkhC16rEVkZpS5qm/MbaaE5Lxgjjsq3pczU1PG/ubFX5NE1BOpHoQx758
	5jcRTbprdYS0S1dPwIQRIyxpwmVJtfhZUXlTTgGi/zdE3gAHv2p91fFZLY4fBEUvCGm/61CB1v/
	aqibiPOxlkZytmTixDl3Qmw/yTwpFS4aclylBNnyhjMEMTT8LTesp7wCuQ0CiDEKckWoT2pofMZ
	pLrFa3nll/NttUTAFEmUTZE/qI3AL7lyG4G1nWaQkRgwy0QBTakkSKJQFhw8OHQj
X-Received: by 2002:a05:690e:bc2:b0:66c:c7e4:2ff1 with SMTP id 956f58d0204a3-6715cac0600mr1020676d50.15.1789497271014;
        Tue, 15 Sep 2026 11:34:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:e9c6:4a77:70a9:9f1d? ([2600:1700:6476:1430:e9c6:4a77:70a9:9f1d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6715f6ba8eesm282519d50.6.2026.09.15.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 11:34:30 -0700 (PDT)
Message-ID: <c9235d30aab14ec6a9301e39da27a26a8162819e.camel@dubeyko.com>
Subject: Re: [PATCH v4 2/7] hfsplus: rework hfsplus_get_block() logic
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org
Date: Tue, 15 Sep 2026 11:34:24 -0700
In-Reply-To: <20260915023408.GD6244@frogsfrogsfrogs>
References: <20260914233941.2966421-1-slava@dubeyko.com>
	 <20260914233941.2966421-3-slava@dubeyko.com>
	 <20260915023408.GD6244@frogsfrogsfrogs>
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

On Mon, 2026-09-14 at 19:34 -0700, Darrick J. Wong wrote:
> On Mon, Sep 14, 2026 at 04:39:36PM -0700, Viacheslav Dubeyko wrote:
> > Split the extent-lookup/allocate logic out of hfsplus_get_block()
> > into
> > a new hfsplus_map_extent(), which reports the mapping as
> > (dblock, max_blocks, balloc) instead of filling in a buffer_head.
> > hfsplus_get_block() becomes a thin wrapper around it for the
> > buffer_head-based callers (B-tree metadata, symlinks).
> >=20
> > No functional change to the existing buffer_head path. This is
> > preparation for the iomap-based regular file I/O path added in a
> > later patch, which will call hfsplus_map_extent() directly.
> >=20
> > cc: Christoph Hellwig <hch@lst.de>
> > cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > cc: Yangtao Li <frank.li@vivo.com>
> > cc: linux-fsdevel@vger.kernel.org
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > ---
> > =C2=A0fs/hfsplus/extents.c=C2=A0=C2=A0=C2=A0 | 118 ++++++++++++++++++++=
+++++++++-------
> > ----
> > =C2=A0fs/hfsplus/hfsplus_fs.h |=C2=A0=C2=A0 2 +
> > =C2=A02 files changed, 87 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> > index eb7c11524d18..ffd52ad8867c 100644
> > --- a/fs/hfsplus/extents.c
> > +++ b/fs/hfsplus/extents.c
> > @@ -48,18 +48,29 @@ static void
> > hfsplus_ext_build_key(hfsplus_btree_key *key, u32 cnid,
> > =C2=A0	key->ext.pad =3D 0;
> > =C2=A0}
> > =C2=A0
> > -static u32 hfsplus_ext_find_block(struct hfsplus_extent *ext, u32
> > off)
> > +/*
> > + * hfsplus_ext_find_block() - find contiguous sequence of block
> > + *
> > + * Find the disk allocation block for 'off' within an 8-entry
> > + * extent record, and the number of further allocation blocks
> > + * that are contiguous with it in the same extent entry.
> > + */
> > +static u32 hfsplus_ext_find_block(struct hfsplus_extent *ext, u32
> > off,
> > +				 u32 *dblock)
>=20
> Hmm.=C2=A0 Does this function take an hfs+ extent and a file block offset
> within that extent as inputs?=C2=A0 And are its outputs the physical bloc=
k
> number in @dblock, and the block count as the return value?
>=20
> (Wow, TN1150 is still available!)
>=20
> It's sorta too bad that this code doesn't just return a mapping
> structure with some nice names to make the code easier to understand,
> but, eh, whatever.=C2=A0 Old fs code isn't always pretty. :)
>=20
> This took me a while to understand, but it seems reasonable to me so
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
>=20

Yeah, I agree that it requires to have more nice refactoring. :) But
it's too many places in HFS+ that requires of this. So, small step at
once. :)

Thanks,
Slava.
