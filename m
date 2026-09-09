Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FF39E17C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979019; cv=none; b=iD9H8IaQ6WentEh65rIg8QNIQ2isGJRdxLmZtDqBey6Ban4Cx7VpF/rNLivT0jURBxumZLBqfwimsnnxhujrvjPCyrXnCaRBR35sNn0Go6HKIohQdf+IpxcvR6IkfUP97yTWBXELP9k4Z4XqcWOnyfvJgV7rFqHlGl0yGz+kego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979019; c=relaxed/simple;
	bh=D0i10eU6R0guQqkbNqxy3VRaXtBFzNg73B8NlbhmR+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h2QfdT0BO9W7lI5soAHt7/YVaYUaoTA2EUG7/Zos++XAjdihSPafJBEumQEOm47NqSu8liEvmrK6IPcmKIuRmh29cpdBo1BcqonPfCB7hLxG/oeQ3GFdb01222dUqXdNfVX8QZprh1A6GzVAaZH55T/DxVe5YU/twd+mPC7744Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=qZB6sOaA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="qZB6sOaA"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8623b1e7cb2so44949747b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788979016; x=1789583816; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ztELjN8uO0T8KEevdMrbW3Q6EwKjlbpjwbjsPZRE1cg=;
        b=qZB6sOaAb+rWa4h146k+RlXv6qT/BPR9+mo6TC+CkoAeSWbSg48OA+eiW4dhDXdz86
         2kUpL7iUdnkxp2yor8tH1MbWKyTDeZnDhsYZTdGX9bYbYD0nO4Odol1Jd3SAy5q45tzc
         KtADIIQoHa0LXRa+fjToFV340elqYBr3rBmn6iDaJwD0LPSQAbkcEAY3noRw99Mjfnu6
         i/XEaA8fhyODw9uAYm4ody1dEJASfRlQ+1l/Rk4UTbyWEfmGwsH7utB8zCjIrzjOTFyk
         45WGjAaEt8jfwXig0O1n1bRyUqcNuwMUnBWsF7eOPZS+XBTsm+RLPnyx93QbgfeMbUVD
         Andw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788979016; x=1789583816;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ztELjN8uO0T8KEevdMrbW3Q6EwKjlbpjwbjsPZRE1cg=;
        b=j58S6l+/seqASz8kW3kBBl826FpjYjgPVFJgAF6D1Ir0qDlG/AIW3wdlUXBRK5mf7S
         7n2k1Vb/2AQU8+Ok2ZwpXUzIh2ZuYq4rxLUGs/1B62PkdALzSKZM27L1RS8sEk9Yzkmf
         kQK6ij91+cNzE1MRwPJS1DMg6rKM06ytqDXQmjxgSQ3xS7aRSGdMeE3ZWNkkxoS9wivs
         AlW5ZBY4zcR/+eLl5Ayz2oKZMsHDfUI7+jPCNc6m9vLV1Cbu3LdfkDunyWe9YMypz9YP
         4N+dL+P+XPfyFn3l4L1MdC1kv47Ndmp7KeRZ+MWAzPypfODkQ4qwVXnoBhpLKbS5IB77
         mgfg==
X-Forwarded-Encrypted: i=1; AKwUvBzHMQUH64mmPxZS05hKlwOC+vuGLv6cR/PHwAAvUJcXJ8H5PPHwOKon4xYj2dSrAnfT0syHiWnx936XlcA/@vger.kernel.org
X-Gm-Message-State: AFuF++kDt+LFSQZrILwFSb47gqSVcYOhmgVu6wMuON6FKOVNgD0pMlQ9
	Ksm3s5qPdbMNRMvkPlJugB23WP8M7DSHdg1YOYMseupVLZ6EJR0v+gLO81eDyUIs3TM=
X-Gm-Gg: AYBFou31i1DzJHbz1LkXSmbsMgPEstiVQiltFFI+yRvFkzdDjsTPuQ7NhW6qWPOHHVk
	YGsNlnBaCkL8ZBDfrmEhZgWWWZi1ChXCYt9YAfeP7IcLvMJIQCiL2i84HW6YZlvlvu5Ncv/67mf
	K1zdx//XovWFu/BSOjbGIfcEywE5zv+ykP8TEDOmdhtyIGAtEPhZj0wyYeU+DhsoLtuJO+LMWh4
	OTJprZQsAPbIgDLxQpOGL7e6TQHxfAppsz91930fg1or67bHIFRTo0uGdsPY+Rx4A0UeQlntIpG
	VFRypjNvfGdgqI3l4A4wU39Uxc2JVLl5guNdiUu/Mcr6Rb5sSC5npELe5X003awzbX8J0eJXiCc
	YVL+iZJa2HbB+GlPNAxrEscv8SvatgNzKRj7vaDdb9grZT8rllnDp12Eygyb86eEnGQWiZMxF1E
	98zdzuVVefpAoC9YoehgAd9/XQo787Exj4oLG5bob0T2Z+DrmfIX5SKl9Znz2cafREdG8mWukNS
	09+w23tV8jaV5/xqouSKBGgOvqtQ9NORREW8c9pD/WYdxzbbcRIR4aWBvRMc+c6UhoGMrXxnCDt
	T6tmX66WqxVsQUGv9nKWtPO5mmCd6Obue1Dgcrg1Ic6Az4LW0luaAOOBtC7+PK4AQK2RSQsWC2U
	=
X-Received: by 2002:a05:690c:f04:b0:84a:ffa1:8118 with SMTP id 00721157ae682-871288defc1mr147308857b3.31.1788979016000;
        Wed, 09 Sep 2026 11:36:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:bfe2:d67c:7903:eb5e? ([2600:1700:6476:1430:bfe2:d67c:7903:eb5e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-881575de059sm7230907b3.18.2026.09.09.11.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:36:54 -0700 (PDT)
Message-ID: <73cc2e394cc0269a62e2e6503aac5fef2a3ac65a.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fix recursive tree_lock in
 hfsplus_file_extend()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Date: Wed, 09 Sep 2026 11:36:53 -0700
In-Reply-To: <20260909162057.28071-1-ngocthang2710.1999@gmail.com>
References: <6adf8403f623448ffa8647b9b5e91397a8256315.camel@dubeyko.com>
	 <20260909162057.28071-1-ngocthang2710.1999@gmail.com>
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

On Wed, 2026-09-09 at 23:20 +0700, Nguyen Ngoc Thang wrote:
> Hi Slava,
>=20
> Agreed on all four points, and dropping the btree.c/super.c hunks --
> you're right on the specifics too: hfs_btree_open() is also called
> from xattr.c when an attributes tree is created lazily, mid-
> operation,
> so it has no business deciding sb->s_flags itself. And re-checking my
> own super.c hunk: it dereferences sbi->ext_tree/attr_tree
> unconditionally, which NULL-derefs on remount of a volume with no
> attributes file (attr_tree is NULL whenever vhdr-
> >attr_file.total_blocks
> =3D=3D 0). Glad that didn't go anywhere.
>=20
> One clarifying question before I attempt that piece: you wrote both
> "it needs to return the error code from this method" and "set the
> state of the btree as inconsistent". Those lead to different mounts:
>=20
> =C2=A0 (a) hfs_btree_open() returns ERR_PTR(-EIO) -> the tree never opens=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mount fails outright (same as every other =
check already in that
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 function).
> =C2=A0 (b) hfs_btree_open() still returns the tree, with a new
> inconsistency
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flag set on it -> mount can succeed read-o=
nly, existing (valid)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data stays reachable.
>=20
> I'd lean towards (b) -- read-only recovery only works if the tree
> actually opens -- but that's your call, not mine to assume. Which did
> you mean, or something else?

Technically speaking, if we have a corrupted fork, then we have no idea
where metadata structure is located on the volume. It means that we
cannot read it and we have nothing instead of metadata structure. So,
this is the situation when FSCK tool needs to work. It sounds like we
cannot construct the valid b-tree metadata structure anyway. We can
only return the error. And if it is the hfsplus_fill_super(), then we
cannot mount file system volume at all. However, we could have not so
severe issue with b-tree metadata structure. I think that if the first
extent looks consistent but the other extents contains garbage, then we
can try to construct the b-tree, mark b-tree as inconsistent, and mount
file system as READ-ONLY.=20

>=20
> For v2 I'm narrowing to just the recursion fix, changed per your
> ENOSPC
> point below:
>=20
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -458,6 +458,14 @@ int hfsplus_file_extend(struct inode *inode,
> bool zeroout)
> =C2=A0	if (hip->alloc_blocks =3D=3D hip->first_blocks)
> =C2=A0		goal =3D hfsplus_ext_lastblock(hip->first_extents);
> =C2=A0	else {
> +		/*
> +		 * The extents overflow file can't grow past its own
> fork
> +		 * extents: doing so would re-enter hfs_find_init()
> on the
> +		 * extents tree, whose tree_lock is already held
> here.
> +		 */
> +		if (inode->i_ino =3D=3D HFSPLUS_EXT_CNID) {
> +			res =3D -ENOSPC;
> +			goto out;
> +		}

Probably, hfs_bmap_reserve() is the proper place for checking
capability of growing Extents Overflow file. But it needs to take into
account that if fork has empty extents, then we can grow the b-tree. We
have -ENOSPC situation only if we already used all extents in the
fork.=C2=A0

Thanks,
Slava.=20

> =C2=A0		res =3D hfsplus_ext_read_extent(inode, hip-
> >alloc_blocks);
> =C2=A0		if (res)
> =C2=A0			goto out;
>=20
> > Another direction is that we exhausted the volume or volume is so
> > fragmented that we cannot extend the Extents Overflow file anymore.
> > [...] we need to check before extending [...] that we have free
> > extent slots or we can add some space into the latest extent. If
> > there is no such opportunity, then we need to report -ENOSPC.
>=20
> Right -- that's the same guard, just under a correct errno. It fires
> identically whether the fork is corrupted (this report) or the tree
> has genuinely run out of room to describe itself, without needing to
> tell those two apart at this call site. Sending this alone as v2 so
> the deadlock fix isn't blocked on the larger validator design; happy
> to follow up with the fork-bounds/consistency-flag work separately
> once (a)/(b) above is settled.
>=20
> Thanks,
> Thang
