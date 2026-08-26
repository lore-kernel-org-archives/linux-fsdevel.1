Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7F3B14A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743933; cv=none; b=J2sM8cI1ssZEzbX2pyLh1fKtFmxpr0gYpszv6HkebzOT8+Jt/aMq9K31ZCgzAuULcqWlttxVkZk40gFVOfhwFgpWVaxfSFj58uuB3OnBl4K1bw+ssPGTaYoin71lNaudyMVidoLkiZfpY5dUA8X8Lv9kEtc/Ddg314F8gFp/p7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743933; c=relaxed/simple;
	bh=3oRxXcMTYV+an0NksEVhQODiArlz3DtaNAnU8wdD/6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VduCzneS1ahoa6i5gh6MEWdyYxhHhx5q/D5NvcCLuRayZqmGTDgowmANUZn/V8lO+VNiMHwVAwmSLnRzhbEvBpc5u8FpzwywvmIBKhvtizH7pFVeZ7GhwzE9tETz1qD2BHlrtIAr3n4xGBsn7S6gIRHm1iliwDornEtIG366vh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAMKhlRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAMKhlRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666A61F00A3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787743932;
	bh=B8v/tEjEGOf33yrvUVepcImS+WN0XeXcm7q5k/yl6IM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eAMKhlRc9A10AvuneMkd93gi4RUVjLUlDsylZC1RMybwnKtd/CojvFK4q2Xl+R4Nm
	 RtTz9pavOdMUQ8e/pJW1M+S+wKP+j7+DH4p6tA3HqySR2GoMmsr1/kPqvda6Mf7Pvk
	 AcUxYzMHbalZHj3/95aXICNk/w+Vh+EzwpZdJ3isOfSXW6bahfguJ+PtD4ITCVBr2D
	 J+yRlvCHyINsHy5Jz9pTacOWAC/9Bx5RWvJevdGeM1/yA7to17dL69C7ylA2zPZvkz
	 WXOpki0ExywVOJbNiHTYcKeLyzeulKTnv/amyDF/YM+1FN0cFCmWrU4gDw5kvWVFPQ
	 xu4XQWKsmKMcg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15cd3fd760so94297666b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 04:32:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp8LuF5S+gQI5K+J3tTqo6gLOksBRHm8aZ48dOK4sTj4hi4bb83qyVfELQQfzbNxOrLz5fqO4rATEBpHoQ3@vger.kernel.org
X-Gm-Message-State: AFuF++lSvxTXDCENEukxiLOkotrnLq5ZcwAqU0Lds11GmBoQOGVk1rnn
	xNd/jis+qpH05pJoCNfbb6/amJn/Xq/oLvnwLkxvpXL34FMQgWvBi6vuYGnVesYhraNbmq31Mih
	nhAoAZ4De1P09RdEhOEAOPOMVHuHc19g=
X-Received: by 2002:a17:907:c499:b0:c24:6390:decf with SMTP id
 a640c23a62f3a-c250c329353mr743711366b.16.1787743931075; Wed, 26 Aug 2026
 04:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a8e6f2c.8c92e5db.197682.4689@mx.google.com>
In-Reply-To: <6a8e6f2c.8c92e5db.197682.4689@mx.google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 26 Aug 2026 20:31:57 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8vej=_VqdrojYA0cL5uYz1T1GaWb-c3DG1gzqdkve_CA@mail.gmail.com>
X-Gm-Features: AcwNN1W8Oh5_xnGX7XomqFnFiYbxln9DeKSNnKwOxY3T5BFhXuQVioRPvmeqFO4
Message-ID: <CAKYAXd8vej=_VqdrojYA0cL5uYz1T1GaWb-c3DG1gzqdkve_CA@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: bound $AttrDef table walk to the loaded table size
To: Dennis Tighe <dennis.tighe@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 1:44=E2=80=AFPM Dennis Tighe <dennis.tighe@gmail.co=
m> wrote:
>
> ntfs_attr_find_in_attrdef() walks the in-memory $AttrDef table, but the
> loop condition bounds only the start of each entry, not the whole entry:
>
>         for (ad =3D vol->attrdef; (u8 *)ad - (u8 *)vol->attrdef <
>                         vol->attrdef_size && ad->type; ++ad)
>
> struct attr_def is 160 bytes; the guard reads ad->type at offset 128 and
> the loop body reads further fields. vol->attrdef is kvzalloc(i_size),
> where i_size is the on-disk $AttrDef data size, checked in
> load_and_init_attrdef() only as 0 < i_size <=3D 0x7fffffff. A volume whos=
e
> $AttrDef data size is smaller than one entry (e.g. 120 bytes) makes the
> read of ad->type run past the allocation. Creating a file reaches this
> through ntfs_attr_size_bounds_check() and reads out of bounds:
>
>   BUG: KASAN: slab-out-of-bounds in ntfs_attr_find_in_attrdef+0x66/0xa0
>   Read of size 4 at addr ffff888005833280 by task init/1
>    ntfs_attr_find_in_attrdef
>    ntfs_attr_size_bounds_check
>    ntfs_attr_can_be_non_resident
>    ntfs_attr_add
>
> Require the whole entry to lie within attrdef_size in the loop guard, and
> reject at mount a $AttrDef too small to hold one attr_def entry.
>
> Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
Applied it to #ntfs-next.
Thanks!
