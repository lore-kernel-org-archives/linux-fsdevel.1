Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8032E2DDD
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226297; cv=none; b=JdifWSNSDhjMDZYgje3GaGUKYcfesMhjB+/HlUrzyumOIiwtEEEjNiXZWioVoC5C9+6owQeIxGERTv4O5qPP2+PSRfxfxyJKeA6gP8NSK3/wmRjPhHEbMYElU2DBLALitwRL6/kEuJguVZI+F7rCfh3xZYpmLkoZWiXZ9kcK90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226297; c=relaxed/simple;
	bh=afabLY0tEyzNyvF7E/amUEefhxyzemzRLp0nd+BLF78=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NQzX13GGJVRZmuYuSg305XMZS/l4cZgVTYdNeSJ8TFAUuSDoxUP41uHaAAnQOh6OPplthSxri9FKHGlUUxe8MpoB2WF7PByqrOR/d8dasu6AzooR3w4bqhz6KQEesIS3p5jWQryegboSyHT/tg3WvEExeiINYqqHN+IoA1eDHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=BPpmITV8; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="BPpmITV8"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ace0741488so19611717b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791226295; x=1791831095; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=afabLY0tEyzNyvF7E/amUEefhxyzemzRLp0nd+BLF78=;
        b=BPpmITV830HSNjFjfGXS2zB7QKPE8QAxdtXrcwm705MOgv0FstrE7cu4IcMyzkfLtB
         ewFfti/NAoSVFjviHegXUC/MDTvgJS8SzsH3no+i3A2Apafy+X3H0WYqK+aHhs+Vd2x6
         GVZa4RVuXqbXP/Pvgd2oZrYrFwS5S8izEik7KDQeww87GKqqTz1aYQJjvyeKDWsAVyHq
         36n8kL9lB2VkdDJDj5j8H6JfEWa11NZ09BfiHC+e0j/8mtLC44q75hEC4kGIkt9KBVU8
         mRGlQpkWi+40Ocb8JgJF9Qbv3WhjSraRu95n+l7Zuk6J/hVFNuxUZb+O+TAjoIjG14dj
         RWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226295; x=1791831095;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=afabLY0tEyzNyvF7E/amUEefhxyzemzRLp0nd+BLF78=;
        b=KXgqyit4TgEAyIiY6XcMXCazFoZgm5S1TecBoS7khRrCc3Uh+6ecrADn80DRv6Rwfn
         9mtqZBvYQkCHd8hK+o0p0lkpv0NKAWni0uudAXhivGy1/pcOyDFtskYOJvMr0w1ThcFJ
         bNpznQUtYbeiYt4XACDh+Zxj96sCQ2vYQnTt60UkGWmOPKtDBMyWHV8gaZ69f9OdKFUr
         JTJzFyXb5MZq8h15D5sPbl2koqY4Q++kGTxpRa3k0znFPMK1mN7SAXUc3VQbSs0Mg2m1
         jwb97wMuDYdrrJlsySHGdbKV8+Zhy3e3S7kG241fhDZCnvIjkuLCKlAhACk1q+8xVvF+
         Ma3g==
X-Forwarded-Encrypted: i=1; AKwUvByz5V+b/8cRVVSbrfhInm8pyI2pEJhIYPpmbGKcr7PVz8D2habSuTq22RhZkZVvuxHKExcCY9xjFtv20Zt1@vger.kernel.org
X-Gm-Message-State: AFq9FYKByoku9Yja+SRnpHicJaFx1bIZV1JRzHAMJ0IWbMOzM+lSdHzv
	KJl1wHlhdO8FzUk7MWbrWMIYh85COag+jLPWqcyM4DjjUA6wBsvVxGPKD29g4m08IKEzh8UN9Y3
	zI4XEGws=
X-Gm-Gg: AYBFou1mA8I0/htnqL/YVk6UQk6RY/xEevSSrI/FgkOmY5pGnftNWnlHd4giA9froGZ
	xYLh174kXsxRTf9DecxXbQzoX/Ywbb80ui3cwlbNF9lzNpnDfP8HspvJjQUmFHA16Oe5/nN5FXZ
	7Z40sXOB2X+vHOVPDeih385VojuSnh5jd3hEtwldsYOquMfht72MlB0x/cyVea4BQb8ITh5b/qv
	bmUo9AsUI1T403QTS/8pp1+pZWLo9QC/CcrErtAnJ7UWkYlsVJpt2hhwvJdS+ly40zzG39Qpy3o
	tgLulRjUOnBhvD8qYTXFzBBdlYBh6r9+mMMH0dXPe9ZwYpZ/I7cmrz+SJ8FxPYeU1PskEs1FvO1
	n83/E7dLhUWKtp0fa2++hrkpmN82zs6RSwE/mbDeohTOPnP1pUuB9cVOA/jGmNcy7cHmGwO6Aja
	LrRTV92er38325Z9Vs5kfV1TJy59N9DBzVr2fseYWoduIaloRl5JunBbXeEPCVVZLm1fufa+JAG
	T2+jei8VcYw2eRTsOC/lQTy/gSMp5qXxjgleueEWZIwsToUjhIyh7e/BDR1UYqZRBj87Codkbnq
	y9z4Ufcw//G0brZFPX9M8RXpJMH/huZq/O9cZzI9jLAkCd/jT5OQVCtHcjmu86FF
X-Received: by 2002:a05:690c:3:b0:873:5ddf:d861 with SMTP id 00721157ae682-8ae958d401cmr29228537b3.44.1791226294666;
        Mon, 05 Oct 2026 11:51:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:3aa0:911f:4e09:b45d? ([2600:1700:6476:1430:3aa0:911f:4e09:b45d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8af20ecce9bsm18488247b3.41.2026.10.05.11.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:51:34 -0700 (PDT)
Message-ID: <17c099490060e40254ef25dacdad713d5356c2b7.camel@dubeyko.com>
Subject: Re: [PATCH v3 0/2] hfsplus, hfs: fix B-tree node leak on
 hfs_btree_open() error path
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Mahmut Emin Kurhan <guvenlik@noroxi.com>, linux-fsdevel@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 11:51:32 -0700
In-Reply-To: <e03cec7e17be27fde6b51957c61fb6958b9832ad.camel@dubeyko.com>
References: <0de056179e3e0a7c4ef525cdb143647b7493dc71.camel@dubeyko.com>
		 <20261001213807.1519745-1-guvenlik@noroxi.com>
	 <e03cec7e17be27fde6b51957c61fb6958b9832ad.camel@dubeyko.com>
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

On Fri, 2026-10-02 at 11:18 -0700, Viacheslav Dubeyko wrote:
> On Thu, 2026-10-01 at 23:38 +0200, Mahmut Emin Kurhan wrote:
> > This is v3 of the hfsplus/hfs B-tree node leak fix, rebased onto
> > the
> > for-next branch of the HFS/HFS+ tree as requested.
> >=20
> > The leak is unchanged: hfs_btree_open() can fail after the head
> > node
> > has
> > been inserted into tree->node_hash, and the error path does a bare
> > kfree(tree) without freeing the hashed nodes. The fix factors the
> > node-hash freeing out of hfs_btree_close() into
> > hfs_bnode_hash_free()
> > and
> > calls it from both hfs_btree_close() and the hfs_btree_open() error
> > path.
> >=20
> > Changes since v2:
> > =C2=A0- rebased on for-next; the extracted helper now wraps the
> > hash_lock
> > =C2=A0=C2=A0 serialized close loop introduced by commit dce0e0248205
> > ("hfs/hfsplus:
> > =C2=A0=C2=A0 serialize B-tree close against folio release") (Slava Dube=
yko)
> > =C2=A0- on the open error path the tree is not published yet, so the
> > lock
> > is
> > =C2=A0=C2=A0 uncontended but kept for consistency
> > =C2=A0- no functional change to the leak fix itself
> >=20
> > v2:
> > https://lore.kernel.org/linux-fsdevel/20260930232312.1405042-1-guvenlik=
@noroxi.com
> >=20
> > Mahmut Emin Kurhan (2):
> > =C2=A0 hfsplus: free cached B-tree nodes on hfs_btree_open() error path
> > =C2=A0 hfs: free cached B-tree nodes on hfs_btree_open() error path
> >=20
> > =C2=A0fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0 | 40 +++++++++++++++++++++=
++-----------------
> > =C2=A0fs/hfsplus/btree.c | 41 +++++++++++++++++++++++------------------
> > =C2=A02 files changed, 46 insertions(+), 35 deletions(-)
>=20
> The patchset looks reasonable to me. Let me run xfstests for the
> patchset. I'll share the results ASAP.
>=20

The xfstests HFS+ run hadn't reveal degradation or new issues.

Thanks,
Slava.
