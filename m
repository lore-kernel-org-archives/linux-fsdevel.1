Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB3F4F68B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025547; cv=none; b=YzRVvFLTRB5tAUQaUOoG0suZkO4Qxv2U2cl/GcJJst8M3yafsaEN9P8+AmnMiBq+uJClSb1NhQMvzufxVa4jtqcsfxVifVakL2LJ5nsz/60t5QwJbHpOqCqWdRv1QgmXBJMA5eGwxAt9Mc756ssMIasuWLJexwrvlQFycCuhxzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025547; c=relaxed/simple;
	bh=daI+uoJTwAJNPFsiYNIKF4nGANBOMqaEr2zEXBBJpic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IHka8iR7PSezVO4w2LM9MMbM0UpEkIaMDL2TtPJJFDGaW9fNVwDs51IUyL8cOdH6mnlZ6bRSjHOBck4wTah9L8yvkOT426my1s5vy6yUDMgwbN5zjZ8ZjAvyqREGYPt7YRkPkhr3ZkqlYvXDzeyLxyOvDOgdtDh4GbfQZCpEM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=q/4q9lll; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="q/4q9lll"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43ac6072so35123147b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790025545; x=1790630345; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWxX95kFbMSLZvLmrVlSWvwPBFxFPw+F25Fx/dZ/knc=;
        b=q/4q9lll0ka7ayWEjV1wpKXUF8cQSFYIDbaVQClQNOaOXBADCMb0EVDqluz70nT3qJ
         H6KwT7EZSpHrBNf92pkQvB4SEnxYCXf/w47WbSJo6Vq+Q+Fip3hWD64jPYfPZnZ+41Tl
         p+0arIFtsfaWj0iogRivxXDhcwgbviK57x/84QlHyIZxMbu1gTqUVfIDydhvHJQE+ff/
         b23CCnXjZ85koD5uxQ0Gdh04DOUU735+/evdAoV/qNsl4EtQ78iy2swNUnX6v7I2brdF
         KjPkZxGIh6lXq0ln1WRetGk5n8pqyDWweWGFoWaz+0iP057Ln/r+0mRfWHBzHB3Sfnqp
         2BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790025545; x=1790630345;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jWxX95kFbMSLZvLmrVlSWvwPBFxFPw+F25Fx/dZ/knc=;
        b=0CnCTEeLijfRhqiz6gukqimMu7aONALqPXIhRxSCLaOc+AqlC3qNcngm6/Wwt4i60h
         EnrWBMJTQ9sk3ZP5oxCh4cErq7aAjKzQHnfNO/gB4jjadJHd4jceH9Ho5BKDLB1v06j/
         Mry8sNU61GIHmsrSBGFXGf245xgnvFcznaLHs2/njJx2kVox+8KyMjGGqp+GjnbxHP2e
         KHp41tfTqVV6BPGicIeHtHspNpoP9AlVWfYHBr0kGoK8xPFc/Xx4booFJ3aKZ//A6iXl
         bKo9CHS87UKShXEp5eClV6IeU+3BZFSc0AKsPou+KiiY8I/6e+AjnKYpLhDXSWThqQH+
         s09Q==
X-Gm-Message-State: AFuF++meqqE2W6y+k1uuTm/ROHrfnSIJ9wdPCJXDgyKBa+/cz1u9CzHm
	6WPo74bu1h97VzBuMrj8IYIwtFFpVwi7B/08sBu7Xu6BgdBAQ+bPUbzsxULoolXC8do=
X-Gm-Gg: AYBFou1vwwR/4UPxxQKtPtzaP03NeUSOOk53UtcMiAyA4X63yYlYkkwF6iPJe0WYBtJ
	AgjEMVXGOtl8bWRN+PUCqDkEYKL4vySKeqbBH3E95EVitgnWPzzntzRGyfkKT4WAEmfhgrCq62D
	ZLFCrAt859ljn7J92kkFY8hV8+tScPPmRwysL68fknoUVPOjW2N0TKIpL9FDRzyCpFoShxdfa0J
	dIYBLDBNJEkFSEZw4X1sK+B5w6uG29U8rVxUNj4ARexbnw+IGrmWAEsbRDycQMtEeMGpgUHgaV4
	4r5pO3mApFs47kxd4pHf7vQ4Thn8EVKcTQ1+oj+Fc4GhYPddjh7W87qIp8Z/Pt7WjDMD/uIo5pD
	oFtJsMTwC70lT6gQCqUvsu9eOX1rlwsW8vqw8Zv9rHTGOnKiI7l9Fsl+T57tlkOR5j9nQYCG3oQ
	mPHVZ9L/BvraqzYIbgFyYskjJ7GnVJrc996qFO6thut/IBGLk7T+4da8icrfwGv8KlIQDQME+yS
	0TmcgDHv9U3gN9l1e4Y5SxCoAUagzk7NcD5yqr0UH2X5lXVrcOh2/ST3iTzigyA373hBBJnOPFM
	9to05OgQd7zvfjI3ETtyzYPLiZG7vqU6Tp8uLBals4McUACWGi96hdz/sS0UHhiT
X-Received: by 2002:a05:690c:560d:b0:890:659e:3c84 with SMTP id 00721157ae682-897363672ffmr39041997b3.57.1790025544875;
        Mon, 21 Sep 2026 14:19:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:8475:e6ce:2d2c:ddc2? ([2600:1700:6476:1430:8475:e6ce:2d2c:ddc2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a23c738beasm1587077b3.13.2026.09.21.14.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:19:03 -0700 (PDT)
Message-ID: <4fdba50ccb0327d7dedaa937774d0c6ae7b77919.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: propagate extent B-tree insertion errors
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Davy Felipe <davyfelipe34@gmail.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 14:19:02 -0700
In-Reply-To: <20260920160213.285316-1-davyfelipe34@gmail.com>
References: <20260920160213.285316-1-davyfelipe34@gmail.com>
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

On Sun, 2026-09-20 at 13:02 -0300, Davy Felipe wrote:
> hfs_brec_insert() may fail while inserting a new extent record, but
> __hfs_ext_write_extent() currently ignores its return value and
> clears
> HFS_FLG_EXT_DIRTY and HFS_FLG_EXT_NEW as if the insertion had
> succeeded.
>=20
> Propagate the error returned by hfs_brec_insert() and only clear the
> extent flags after a successful insertion.
>=20
> Fault injection of -EIO into the extent B-tree insertion path
> confirmed
> that __hfs_ext_write_extent() returned success despite the insertion
> failure. With the error propagated, the failure is returned to the
> caller instead.

How HFS driver behaves when we return error from hfs_brec_insert()? Are
we capable to properly process it? I assume that everything should work
well. But have you tested failure use-case?=20

>=20
> Signed-off-by: Davy Felipe <davyfelipe34@gmail.com>
> ---
> =C2=A0fs/hfs/extent.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
> index f066a99a863b..77ba0f63fcb9 100644
> --- a/fs/hfs/extent.c
> +++ b/fs/hfs/extent.c
> @@ -121,7 +121,10 @@ static int __hfs_ext_write_extent(struct inode
> *inode, struct hfs_find_data *fd)
> =C2=A0		res =3D hfs_bmap_reserve(fd->tree, fd->tree->depth +
> 1);
> =C2=A0		if (res)
> =C2=A0			return res;
> -		hfs_brec_insert(fd, HFS_I(inode)->cached_extents,
> sizeof(hfs_extent_rec));
> +		res =3D hfs_brec_insert(fd, HFS_I(inode)-
> >cached_extents,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(hfs_extent_rec));
> +		if (res)
> +			return res;
> =C2=A0		HFS_I(inode)->flags &=3D
> ~(HFS_FLG_EXT_DIRTY|HFS_FLG_EXT_NEW);
> =C2=A0	} else {
> =C2=A0		if (res)

We ignore potential errors from hfs_bnode_write(). Should we start
processing it too?

	} else {
		if (res)
			return res;
		hfs_bnode_write(fd->bnode, HFS_I(inode)-
>cached_extents, fd->entryoffset, fd->entrylength);
		HFS_I(inode)->flags &=3D ~HFS_FLG_EXT_DIRTY;
	}

Thanks,
Slava.
