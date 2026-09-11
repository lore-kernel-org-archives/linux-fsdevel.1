Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A74AF149
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151202; cv=none; b=NI8M84nyZCkyKVVNITeL9OG6nky/BbErRlkVtBj2GUU7SDZ4ach+SpOxqvftnhrt00YWqxw4EDGId2gm6OQE7WRgBjODC7/+9I2fAzAv/fXEkIw6drj1xDefAqM6N5rxK3I6JgzYUqjs1yDJTCBAue20nm7fKsPmA0yjriSstwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151202; c=relaxed/simple;
	bh=bE7wwMidmT9R8eqUkF6tr+g+BqGaONNxXcJJhQR4KKc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dymv3ay8a/jxWgAwG7UGx4u7mr24fvr2CXTcENKwgFlU8x9XvXjrWzKbW+3IL4MvcKbpAtA5m5DALP+UyY1sQ5kvJYjtyXDc8Kmix17aa/+86LEhZNaXmJMGDVJvk1dzs0JvGDR5MhvJsJ2rWvYCrF6rOSI+3LiM8uGVdd51l3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=aQ6+E3Ue; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="aQ6+E3Ue"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67132afbb82so276798d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789151193; x=1789755993; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NDvlXaMCJsh2QNJy7DQqmcJX8WeN5u/dgm3TW20tj1s=;
        b=aQ6+E3UedJhXHReFfmePeolz7TtfkRGqondPIeem52vYJ+YDvVP5IaNCSuA5XODc8K
         NUC+BxzjVRMEmwehM6607T8sH+PJzvIHSnyaPpd3bwoVJlmFD6+orchfdWWp5F6l53uX
         p8knniYiW4wOMZWSw+1tnl99xaWGhD5Bys8NFVNYeRjjJYKn8zqloGlhF4UgTpVrl0el
         Ne0ogfheQjXhOlp/jVN66uits5geYtRV3y1C471oyxQ/oKgrjKhBQR3SLZbwmWRdM167
         3j8vpWEq7w+WJqglMn2isqd2Ae+kVYhSvNWnPTUmDn+M1J/A0ZkDMauPdkJQyHmp3w03
         3LnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151193; x=1789755993;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NDvlXaMCJsh2QNJy7DQqmcJX8WeN5u/dgm3TW20tj1s=;
        b=IHzcQhqrtDFRmpyPNaP5mXqgqmrAtLurJx3yVyuvO7xb7asL9tgOyCrudxqgV+8P+D
         sE0qJY75UjJfdOYZ/t542+plgjNW2MHpWaBm1zRkgDShc6FzO681dJaujxRCK1fWiH9/
         S8nHCICpUBO5KaCBxA6y9C3oRK7z4asFdoJSzJ+mu6Qi1XXA4KfCQczsJqcZUwwuyurU
         93ewVdv/7Wm+d6Vi+7c1p/k+1ghdEla+MQYuBybwgztnEZYZOkGwaZQZYr2CVjh+smeD
         GyrsTsTYwEOERyWHv0iZqlcFQFLvZKDsGXNEAYS8z1ifSAwEF5HWJS7dHnbh+2IKKaJY
         YPxA==
X-Forwarded-Encrypted: i=1; AKwUvBxJq8ycTbjksqUoSI5pOjpH4S42YxgPZTHXYLJcFoeG584Pl87Wpi84J28YKBhEPpJF1DOiG/ZzJk7CUpFj@vger.kernel.org
X-Gm-Message-State: AFuF++nOiTeUXonGWLN9NBmiA33vfkK9qMkBND2/WGjlFdpjJ9JhVyuD
	n/fTMqPXAgLdZ63txCMzGSGMwLDMOFuHDnTeYHKoNeKS9M8UAvRodE257JoW+wYRp2DhuboCgjO
	AZ0voGTQ=
X-Gm-Gg: AYBFou3gS6DVzwdEIv9Wu+cLy0Y0NkNtDlGSmom9ejoPbdWJXFqmWIS5QFrvv4KH4H9
	snqMHEdoxWvkAohl2hGBePX1FKp5lbI+0z4f8zW6NyEzstN24yMTpm/XaqVqWuBrT9tsUjB/wwb
	imvrcIGVWkCvS7m55QuDfU9ij78g94Ns6WC83wuKwBLwSY+iOzF2pdEkZ0yAwVDIdspqyRtZpyC
	yXWOcCUN8G7kg7dDid/HOEyll9YSPxHD0nMuZDyD72ptlMqwtVsjZmx6lMiNLRY+GxFIeRGpG4J
	ekXssZ7ayCTypc7IhyuFp9I+iMc+Wlm/cCz8oy3Vq5xnAnmql76OBUiybvyjetlQnFXWv7jqns+
	dU3mBHVHu0o834pkQfjqD3Imn1o8IDSqYqNQNl8w9bcuxndczjRbzygd5d45ZPAeMMbbLwdND/2
	R9rAPOIR6c9YSmTwRiC/R3i6SgeazCQuEKJzrJyD5Ei+j+FFip8/m0+sWwpoldNl6LuQ7bzsK4P
	o1eJ8MW4su1Rq4abU0PMjmIdY25S4K1i2iUJfbXeVmuVD9D2P1uOmT8v3xRazfAy/JcIBX4Aupg
	ksWYxcKLbJm2vKHoA1XLaNVbdME3k/FgOy6aLASYOmbpFZobKlyQzOAnsfju6w==
X-Received: by 2002:a05:690e:d43:b0:66f:c1bc:4023 with SMTP id 956f58d0204a3-671246e4cc3mr2151137d50.80.1789151193385;
        Fri, 11 Sep 2026 11:26:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:e98e:2339:978:31e0? ([2600:1700:6476:1430:e98e:2339:978:31e0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125df80e6sm1361413d50.10.2026.09.11.11.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:26:32 -0700 (PDT)
Message-ID: <c6b841becc5b1709a9f54a1c0efd0a14f02ad97b.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fix recursive tree_lock in
 hfsplus_file_extend()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Date: Fri, 11 Sep 2026 11:26:28 -0700
In-Reply-To: <20260911114628.10349-1-ngocthang2710.1999@gmail.com>
References: <28f33649277ca654e66c36aea1bd4f2bfd6abbf6.camel@dubeyko.com>
	 <20260911114628.10349-1-ngocthang2710.1999@gmail.com>
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

On Fri, 2026-09-11 at 18:46 +0700, Nguyen Ngoc Thang wrote:
> Hi Slava,
>=20
> > I assume that if we are here, then we already allocated the blocks
> > for the extent. And if we simply return the error here, then we've
> > lost these allocated blocks from the free space. Am I right? I
> > think we need to prevent the blocks allocation, then.
>=20
> You're right, that was a real bug -- hfsplus_block_allocate() already
> ran by the time we reach insert_extent, so returning straight from
> there leaked start..start+len from the free space permanently. Fixed
> by freeing them back before returning:
>=20
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -537,6 +537,15 @@ int hfsplus_file_extend(struct inode *inode,
> bool zeroout)
> =C2=A0	return res;
>=20
> =C2=A0insert_extent:
> +	/*
> +	 * Getting here means the fork's eight extents are exhausted
> (see
> +	 * hfsplus_add_extent()). The extents overflow file can't
> record
> +	 * an overflow extent of its own, so it cannot grow any
> further;
> +	 * give back the blocks just allocated for it above.
> +	 */
> +	if (inode->i_ino =3D=3D HFSPLUS_EXT_CNID) {
> +		if (hfsplus_block_free(sb, start, len))
> +			pr_err("can't free extent: start %u, count
> %u\n",
> +				start, len);
> +		res =3D -ENOSPC;
> +		goto out;
> +	}
> +
> =C2=A0	hfs_dbg("insert new extent\n");
> =C2=A0	res =3D hfsplus_ext_write_extent_locked(inode);


Frankly speaking, I would prefer not to try to allocate at all but to
test the capability to allocate for the case of Extents Overflow file.
If we have free extent slots in the fork, then we can allocate and add
the extent. However, if we already used all extents in the fork, then
probability to find the necessary space is very low. So, we can the
method that tests the fork, something like hfsplus_add_extent() is
doing by without adding anything. If we can see that fork is full of
extents, then we need to be sure that we can extend the latest extent.
And we can simply test that the next adjacent block is free. And only
in this case it makes sense to try to allocate something. Does this
logic makes sense for you?

>=20
> > I think your logic here that if we try to read the extent from the
> > Extents Overflow file's content for the file itself, then something
> > is going wrong. In this case, we need to place this check into
> > hfsplus_ext_read_extent().
>=20
> Agreed, moved it there -- it's the one place that actually calls
> hfs_find_init() again, so this is now the single point enforcing the
> invariant instead of duplicating it at each caller:
>=20
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -216,6 +216,14 @@ static int hfsplus_ext_read_extent(struct inode
> *inode, u32 block)
> =C2=A0	=C2=A0=C2=A0=C2=A0 block < hip->cached_start + hip->cached_blocks)
> =C2=A0		return 0;
>=20
> +	/*
> +	 * The extents overflow file is fully described by its own
> fork
> +	 * extents; looking up an overflow extent for it would re-
> enter
> +	 * hfs_find_init() on the extents tree, whose tree_lock may
> already
> +	 * be held by the caller.
> +	 */
> +	if (inode->i_ino =3D=3D HFSPLUS_EXT_CNID)
> +		return -ENOSPC;
> +
> =C2=A0	res =3D hfs_find_init(HFSPLUS_SB(inode->i_sb)->ext_tree, &fd);
>=20
> This retires the guard I'd put in hfsplus_file_extend()'s else branch
> (same check, called from the one place that mattered) -- v3 is net
> smaller than v2. hfsplus_get_block()'s existing check at
> extents.c:261
> (-EIO, before extents_lock is even taken) stays as-is; different
> errno, different purpose -- fast rejection of a read, not an
> allocation failure -- not an oversight.
>=20
> > But I still don't see how we will check the fork itself because it
> > could be corrupted even without be completely full? And how could
> > we check the forks of other b-trees?
>=20
> Fair, you've asked this three times now and I keep pushing it to
> "follow-up" without saying what's in it, so concretely: a
> hfsplus_check_fork(sb, fork, cnid) called from hfsplus_fill_super()
> for ext_file/cat_file/attr_file, rejecting a fork where, for any of
> the eight extents, block_count =3D=3D 0 but start_block !=3D 0 (garbage
> in a slot that should be blank -- exactly what's in the syzbot image,
> slots 3 and 6), or start_block + block_count > sbi->total_blocks
> (extent points outside the volume), or a non-zero extent follows a
> zero one (a hole in the middle of the used range). Wired into your
> severity split: first extent fails those checks -> hfs_btree_open()
> returns an error, mount fails; only later extents fail -> open the
> tree, mark it inconsistent, force read-only. I'll send that as a
> separate patch once this one lands, since it touches mount-time
> behavior for all three trees and deserves review on its own.

The bug can be treated as fixed only if the whole solution is in place.
So, please, send the whole pathset at once.

Thanks,
Slava.

>=20
> Both hunks above build cleanly here.
>=20
> Thanks,
> Thang
