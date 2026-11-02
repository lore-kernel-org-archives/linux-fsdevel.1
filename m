Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657611;
	b=5sgI1aKwmwoGUjSbUs6m6MFQwJGw813ETpFtL2dM/StxrK71gIuLlhJqIZL23n0Zn40m
	 DjP1QEqEA78/oFwLU+NalvRwww280oNtZdXZHJ6+HrF7OhdLrDh60GzE4rMAChFkvxu/m
	 WWg0gOW7Yd68vE2u3mxdRtvc8wNe8clncOmgGY5Ge14OA6gAlT2AwT3KeP4lO+z9yOyoL
	 8nTEsbYQFICzcoABfi76XIWSfSOwHj2WVLk50ZkaM61bgevCS2gORoujIrAd9HCvWQIqL
	 tNNt0kh9uXDpf6Qc50mDh8bCLTWUmyela8gHRM28M0Oaf75aC+WXm1XRYtFlzqp0TEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=v4BmZuWiHx0Rl4kjelsiqmQf1Hb7QwnreUWudT7/uTY=;
	b=m319xh3v9dM5vm9e+qBuD6Mw/tF22/J1gjBwGqydPEl3/IkTAM9MLxTH50RIKwvXAe28
	 uiX3MmXgh/9lHVY40ZE30MrZJ2nFlmW/fo18eblhRTp6fpD/Y4mhsneFELYJi8gtR47ni
	 0QKuK66PnwAoO0jDIe3ubEMsfa+QqsPpu321OMYkGRKhP6aNqX0siicIYcWmHmmRkwaNe
	 Top2gKJqoX5aPq3Jidfq+LVHNp1pTW9p3QJaWXw2v4OKzDLHxRU+v9QKY/dA5V7f8QTmM
	 D4ufIHAPzMFiH+X4P07rtVdY81MMJV1iiHRQ0Q0YdF5DvC+pOInnNiMHvSkAfvgEqjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Cc0cOTHc;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E2606A324
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D2E2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Cc0cOTHc
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0a921ee46so30510957b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793657609; x=1794262409; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v4BmZuWiHx0Rl4kjelsiqmQf1Hb7QwnreUWudT7/uTY=;
        b=Cc0cOTHc+/eb2bci7+FGVWlQ7sSuL7reQBhV6GypDHg91AcIXSlcufAN65IKE0oPXc
         /cUEgIR0pand+a0Z380iozt3Ikh+hCByjnqEDXV+IvBuSgSto5DCf4FMg+kl392Aa7es
         EJHgWZ+Msc4LRZYE++9Y20RIDfdSR98WUl3a6deh2rNj5YGAcgDFnBaKhwWVtw2WyrVQ
         N5NpnptIH/tbOkFljzc5wBLP9w9p6RpH8Tqu2g/HqGGzqPTyvV4Zy2MR+1+Mzf80PUXl
         EuUkQH5BbKquYgeQXrSRVFdJN3O3yPHo/rUX4fntIO+QSF5jf+ytqfK08rhs/IcindTX
         9gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657609; x=1794262409;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v4BmZuWiHx0Rl4kjelsiqmQf1Hb7QwnreUWudT7/uTY=;
        b=qTqKVZEmW1hbOhGJJBmKapFY2HbvFfVhgjcz+FdqfysJAqtFfEpoXELsMW5V++TIxt
         hsvS99U/cKJsAyhzk3Eg5RtRjm8dobBFu7CHitb8MsncSfHv/oAqIGiv9/GgCCECZefa
         mi/3czG8kKwdyFOIt6M4ueGYG6w0UdeezL9NyzRM55sA07QFnV3Wpr8BKqr89uCxMmL/
         ez9ZXghAwluBljS480WspM75xj8z1590uD4vomvDJBgxypH1mHU5X88kbGWk4UU6Jd2G
         /OtLM3/xMJ4JCvG9DIuXbh8fqnuORIBVYn8lgkYywd2BUb8v5NX5ZgVcK4W6wx3/0iBV
         fvQg==
X-Forwarded-Encrypted: i=1; AKwUvBzqiTGEWYhx9TPA18aO5YU5yl88V4+uRhOYrPuAonRmdqspZb9LMjYbwoBmEAb6WmvGJhVxTXjmDTvl9Xnh@vger.kernel.org
X-Gm-Message-State: APuU4Z8b5hla9xVBn9SpXJpAm4mbRVKUY0QmYKb6q4KKnyYgEHynhUOh
	1TEB6TdsYFiBBEGgfSua2iXfkl2bKkhfuXZCV87JIBMO809KpEh0KitMfkT6Ein4YDI=
X-Gm-Gg: AYBFou1kP836/Os0bKPxqyK0kJ6C4dZaIa3FFgNpsyaecf2ro+C03zO+35pyvxGC/2R
	XZ0RYaLvoNRg0i9MS5K//o7c0cGaZyp5Dap46ffWu4LPYKcxAOl+sIBF/lcP7fkZYvLraxwAC/t
	IVkNeq3u6/g7qyLn4MkFyRzaCnWCJ5+W07W/Rg2n3LvP7xw8zQ26dLkoFmxSbmmFPuEjztUz5bO
	RllO4ZdkCmjbPPUkRsYhxG9i1Y1uwK3FSKx15ssaMdmK+DFrEicQtP6tB1lQCCobkjxjSWkzRMc
	koK/HcVgKoZHRP0NZ8TyasUrCve2gP26HxhKn5rJl/ggN86QNQ4I6bhuglyeU5YFCBPxpn5hLqK
	m7TiJT2cjFE8JBq6+Xt2Dnrf+MLjtjf5wdtr1ICEyaRBM+3aVAj9ZjcpJo2xuaFb8OOzEcR/OGx
	Dzn0NFSLsgQ5cPt4+41TrRbCtSkQHdjTG9fKLkS8ZFD8RL0oLQpIC2jLRKcp5Hh6N7xxEIYQjXl
	7FC50IQyYVGl1+PfDFSQal6a3kBb+8mLNpYl39jvsNwXBkeVlgshptmBH6VVoASib9kYlDAIi/y
	rVvg4e0+xifWn39UT/m/i06ROJ2kNPVUYgdRCoyVmsR9q+sZOIatkph3U+OfzzAuPVdMdMu2Btw
	Jc7nKYvdxj7r2XcgCjvzTgmOngxEV7LfyYFTOBxzrntgJK3VUc3COayod5QQPxfoxvcPzvJ/GVb
	fJsYFzzpDTvrKY8rGR
X-Received: by 2002:a05:690c:a:b0:8b0:7900:1405 with SMTP id 00721157ae682-8b2b676b88dmr74523687b3.81.1793657609069;
        Mon, 02 Nov 2026 14:13:29 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:2f9f:a96f:bcb:6021? ([2600:1700:6476:1430:2f9f:a96f:bcb:6021])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b71240bcsm59820517b3.9.2026.11.02.14.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:13:28 -0800 (PST)
Message-ID: <fe42fc7c1a7b357d614947b844698c5a0abb78f4.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fall back to buffered I/O for direct writes
 past phys_size
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 02 Nov 2026 14:13:26 -0800
In-Reply-To: <20261030043252.4163173-1-hengyul@cs.unc.edu>
References: <20261030043252.4163173-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-10-30 at 00:32 -0400, Hengyu Liang wrote:
> hfsplus_direct_IO() passes direct writes to blockdev_direct_IO(),
> which
> does not go through hfsplus_write_begin(). phys_size only grows by
> the
> block size when hfsplus_get_block() allocates a new block. It starts
> at
> i_size when the inode is read, which does not have to be block
> aligned,
> so after a direct write past the end of the file phys_size is smaller
> than i_size.
>=20
> However, at the last close, hfsplus_file_truncate() sees i_size
> larger
> than phys_size and calls hfsplus_write_begin() at i_size, which
> zeroes
> the file from phys_size up to i_size. As of now, part of the data
> that
> a direct write has just written past the old end of the file is lost,
> and fsck reports no error. Commit 5f63ac80aef2 ("hfsplus: fix issue
> of
> direct writes beyond end-of-file") avoids this only for writes that
> start past the end of the file.
>=20
> The issue can be reproduced with:
>=20
> =C2=A0=C2=A0=C2=A0 truncate -s 32M hfsplus.img
> =C2=A0=C2=A0=C2=A0 mkfs.hfsplus hfsplus.img
> =C2=A0=C2=A0=C2=A0 mount -o loop hfsplus.img /mnt
> =C2=A0=C2=A0=C2=A0 printf 'A%.0s' $(seq 100) > /mnt/f
> =C2=A0=C2=A0=C2=A0 umount /mnt
> =C2=A0=C2=A0=C2=A0 mount -o loop hfsplus.img /mnt
> =C2=A0=C2=A0=C2=A0 xfs_io -d -c 'pwrite -S 0x42 0 1024' /mnt/f
> =C2=A0=C2=A0=C2=A0 umount /mnt
> =C2=A0=C2=A0=C2=A0 mount -o loop hfsplus.img /mnt
> =C2=A0=C2=A0=C2=A0 od -An -tx1 -j 100 -N 924 /mnt/f
>=20
> Bytes 100 to 1023 read back as zeros instead of 0x42.
>=20
> This patch will make the other direct writes that end past phys_size
> fall back to a buffered write, as fat_direct_IO() and
> affs_direct_IO()
> do.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Slava, you mentioned that you are rebuilding the HFS+ direct I/O path
> [1]. This patch fixes the current code, also for stable, and may
> conflict with that work.
>=20
> Writes that start past EOF still expand the file first, as in
> 5f63ac80aef2. Only the other writes that end past phys_size fall
> back.
>=20
> Tested in KVM with KASAN: the reproducer above, and all 805 fstests
> on
> HFS+: 10 failures without the patch, 7 with it (generic/521, 617 and
> 760 now pass), no new failures.
>=20
> [1]
> https://lore.kernel.org/linux-fsdevel/161fab786f919adb384fbf22dc19f3289bf=
5f24d.camel@dubeyko.com/
>=20
> =C2=A0fs/hfsplus/inode.c | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index aed0866499b2..70c13dcdcd8e 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -169,6 +169,15 @@ static ssize_t hfsplus_direct_IO(struct kiocb
> *iocb, struct iov_iter *iter)
> =C2=A0		end_page =3D end_off >> PAGE_SHIFT;
> =C2=A0
> =C2=A0		invalidate_inode_pages2_range(mapping, start_page,
> end_page);
> +	} else if (iov_iter_rw(iter) =3D=3D WRITE &&
> +		=C2=A0=C2=A0 end > HFSPLUS_I(inode)->phys_size) {
> +		/*
> +		 * blockdev_direct_IO() does not go through -
> >write_begin(),
> +		 * so it neither zeroes the file from phys_size up
> to the
> +		 * write nor keeps phys_size in step with i_size.
> Return 0,
> +		 * so that the write falls back to a buffered write.
> +		 */
> +		return 0;
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D blockdev_direct_IO(iocb, inode, iter,
> hfsplus_get_block);
>=20
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b

I think this modification will be wiped out by my pathset [1] because
hfsplus_direct_IO() will be completely removed. I am going to renew my
work on this pathset now because 7.4-rc1 has been released already. So,
thanks a lot for the patch but I assume that this issue is already
fixed in the patchset. If not, then let's double check it after my
pathset has been finished.

Thanks,
Slava.

[1]
https://lore.kernel.org/linux-fsdevel/20260914233941.2966421-1-slava@dubeyk=
o.com/
