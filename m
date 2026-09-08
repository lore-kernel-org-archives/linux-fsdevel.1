Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC165908BB
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889145; cv=none; b=Xuk6WgnKfai3AV8fIbM2fHjP1xe6YaGvr2D6SvIFT7RUClbzb4+n5GQsgts4ig1L/4hL3P+X/lvLiGoE9PkaLED5KIni8ZVdJZScNNpoj1WO3OCI0Y87l+xLd8gf40xyWghnygusndX4Kee8FTAdrg9MAerYGeE2T7BzGM3462o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889145; c=relaxed/simple;
	bh=PxZxjZnH3Fu5RJuoEFm5S4TNYQPHVSv1IRHoRAyCejA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGWPBosCLlPJFlzSkU/3IHbl5PXRrkYL+h29uXs+5VmG2GeRmC+6Y3LHiZYOohjQ+7cLgqjg9+V9dPaVaZ+C2KQPhjug73e2O/aBvo2y2X+9s+GsD3kgCfLdScZN5T9RbgIoYfcDyU/UVl5uoNEInYMqS/yRkRVnnFxViEp5SKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=pjSE1dmu; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="pjSE1dmu"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-855c26cf490so35763737b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 10:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788889142; x=1789493942; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6nEL0DadX+rSHFMkWXnl4tXNb4oVjnKflLQzV86C/do=;
        b=pjSE1dmuslM99oCUkqFwD3aQ3K6i1OX/P12RAej4Uhv7VqQFUWROusLbO0bKjbW2CQ
         H0lAvURFSRZ9oN47rPd8mevEjgvu1xFO+z9bCOoHNgdQ4qwgJ0LCJUZ208erg+X0U6ky
         Gk+f4wgN/WOwYazzAwbOCsaEPq66YhBbm1T7pRMQ8BSACp5ZhUV4UwMILC4vV6wYFnYE
         2q4pVQU9vBjG6tg3irdgG58XBkj4H9HEzeH5QcC9tsEGMuhvQN7uoat9+A9QN1DIRj5/
         t3zrkvPasxiGr9lKjk1KlJWwUs5TViAk9OUmeCLKkVSCbze5+gPGw/xieXgKT3zllX6m
         eU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889142; x=1789493942;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6nEL0DadX+rSHFMkWXnl4tXNb4oVjnKflLQzV86C/do=;
        b=PupO7LAM5SdbE6GseygG8IZT3dsTrUO6o3xroi6fsGem7IDon7M9zuvSjutSXc7q2v
         8csL9jgTARI9KxUhGG0/xoaC8fJYFapBdcombZ2FWOlm+9zbrOv8jw3TykpyikMtKzf1
         OtyIr7lX0VEeHB7w+B/7JQxXeMSYUmrDOuHNDIlYQK8mUrfFG251NPgNpsVsdDffbHFn
         iwRgye3BCEBjb/GYPqbHpeiTkkIQgg7Mmn8Z2wujzFuBMNLYWMuKy6E1GqS4o9x2wtCu
         eJ+K0LWPgNP7Sg6zO3GE7wu1T9bJ0v+3eOskyWDGhdlsbG3Kl0ZL2yB9xsaRXE7eEFZ3
         sEng==
X-Forwarded-Encrypted: i=1; AKwUvBwtjBpqJeW6avAkk9C1KZ8qv3uu3VvSqR4FMVsL1yfu+Jm8Gf3F8216H0Fdx2kcIjL/oVbVX8ZrXm7us6M1@vger.kernel.org
X-Gm-Message-State: AFuF++m2x39cJ7o19RNYFb6pMgoJFxvkq4LWh8diSSPU4iTEdXQmjT0L
	K6irxqiz0Dn3bMbBVh4eChzoeZt6qn5ykihnJqZNvaajt/OMgUnOJ4WCfjLOJreQU9c=
X-Gm-Gg: AYBFou30lpVqBOOd/byGd8uNYhNwrw5fF7UFK8zLs9B9G/mXgnQ1ABI7z+q0P2by7Ce
	zbX7Cyid9gh4u/n7VaHKEM/7BydZ1fSoc1c2OlMW/NnrM3vHDJ73298NcejknT11apy/YukahpD
	F5gffCMLHkSf/t1I5LoiIHGDSyVQ25wFSCL+pjVp+ULRppAA9YjGgjp9urSNAtBDPFaQhT2gPXW
	46ptzUuLn9eZ7K2ePPiVs9kNeV25D92FRzUnHg3/+0NHeP/hJvWQtfbMZ0IFnyM5bDwJnjVcznm
	i+GWAm87hTacv78uvT37m3pgYVN2IhCFainXBsCY39oJFIh3fT+REnlJfTQdhik9O+E0wvd76o5
	pX0K1MnKsk9kvog7UO4+QqRFJsFRvlsAPSJUiJdOe+cPru3BtBsAvd6+WUwrl2Lb1/ERIxvJSlH
	z9h1tKoToKo+pv1qBah20J56Arvff8t4sUjega/DfQBQStQERM94IYjENPdUGXR5S3rPfpeUrwg
	/SabdVYBzgiPAV9tLYfFSoMLzJ1aMgSnJGCifCs5xmSBi5+cmPH21oHttuz3U2oJ5n8hr+9ocl6
	g/3Baq0ZQdcxeEJz
X-Received: by 2002:a05:690c:e18c:10b0:873:5ddf:d86c with SMTP id 00721157ae682-8735ddfda19mr69532217b3.55.1788889142179;
        Tue, 08 Sep 2026 10:39:02 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1eca:212:86d0:4e87])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714a0ae915sm94670727b3.24.2026.09.08.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:39:01 -0700 (PDT)
Message-ID: <6adf8403f623448ffa8647b9b5e91397a8256315.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fix recursive tree_lock in
 hfsplus_file_extend()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ThangNN99 <ngocthang2710.1999@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Date: Tue, 08 Sep 2026 10:39:00 -0700
In-Reply-To: <20260908115409.9818-1-ngocthang2710.1999@gmail.com>
References: <1b3ba7f7afc3509720cad69ba8c7c17a9276ecd1.camel@dubeyko.com>
	 <20260908115409.9818-1-ngocthang2710.1999@gmail.com>
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

On Tue, 2026-09-08 at 18:54 +0700, ThangNN99 wrote:
> Hi Slava,
>=20
> > Could you share the dump/content of the Extents Overflow file's
> > fork?
>=20
> Decoded the volume header from the syzbot image. The Extents Overflow
> fork (offset 192 in the header):
>=20
> =C2=A0 logicalSize=3D32768 clumpSize=3D32768 totalBlocks=3D32
> =C2=A0 extents[0]=3D(start=3D3,=C2=A0=C2=A0 count=3D32)
> =C2=A0 extents[1]=3D(start=3D0,=C2=A0=C2=A0 count=3D0)
> =C2=A0 extents[2]=3D(start=3D0,=C2=A0=C2=A0 count=3D0)
> =C2=A0 extents[3]=3D(start=3D0,=C2=A0=C2=A0 count=3D134217728)=C2=A0=C2=
=A0 <- garbage
> =C2=A0 extents[4]=3D(start=3D0,=C2=A0=C2=A0 count=3D0)
> =C2=A0 extents[5]=3D(start=3D0,=C2=A0=C2=A0 count=3D0)
> =C2=A0 extents[6]=3D(start=3D0,=C2=A0=C2=A0 count=3D11796736)=C2=A0=C2=A0=
=C2=A0 <- garbage
> =C2=A0 extents[7]=3D(start=3D0,=C2=A0=C2=A0 count=3D0)
>=20
> Correction to my last mail: it's not totalBlocks exceeding the fork's
> extents, it's the reverse and messier. hfsplus_inode_read_fork() sums
> all 8 extents' block_count into hip->first_blocks with no validation
> (inode.c:569). Slots 3 and 6 have start_block=3D0 (i.e. "unused") but
> garbage non-zero block_count, so first_blocks comes out to 146014496
> against a real totalBlocks (hip->alloc_blocks) of 32. Either
> direction
> of that mismatch takes hfsplus_file_extend() down the same
> hfsplus_ext_read_extent() path, since the code only tests
> alloc_blocks =3D=3D first_blocks.

I think we need to have more precise fork check. Because, corruption
could be more severe. The start block of extents could be out of
volume. The total number of block could be not consistent with
calculated one and be bigger than volume itself. Also, we need to check
the fork for all types of btrees (Catalog, Extents, Extended
attributes).

>=20
> > Could we detect the corruption of the fork during the mount phase?
> > If we can then we need to mount in Read-Only mode the corrupted
> > volume.
>=20
> Yes. Proposed v2, forcing read-only instead of touching extents.c:
>=20
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -293,6 +293,14 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id)
> =C2=A0		goto free_inode;
> =C2=A0	}
>=20
> +	/* Per TN1150, the extents file can't have overflow extents
> of its own. */
> +	if (id =3D=3D HFSPLUS_EXT_CNID &&
> +	=C2=A0=C2=A0=C2=A0 HFSPLUS_I(tree->inode)->first_blocks !=3D
> +	=C2=A0=C2=A0=C2=A0 HFSPLUS_I(tree->inode)->alloc_blocks) {
> +		pr_warn("extents overflow file has overflow extents
> of its own, forcing read-only.\n");
> +		sb->s_flags |=3D SB_RDONLY;
> +	}
> +

The hfs_btree_open() could be called not only during mount or re-mount.
So, I think that it needs to return the error code from this method.
Finally, caller could make decision if it is a proper place to set sb-
>s_flags |=3D SB_RDONLY. And, again, we need to check not only Extents
Overflow file.

> =C2=A0	mapping =3D tree->inode->i_mapping;
> =C2=A0	page =3D read_mapping_page(mapping, 0, NULL);
> =C2=A0	if (IS_ERR(page))
>=20
> One catch: the reproducer mounts MS_RDONLY, then remounts rw via a
> bare MS_REMOUNT|MS_MOVE. hfsplus_reconfigure() only re-checks
> VOL_UNMNT/SOFTLOCK/JOURNALED before allowing that, and this image
> sets
> VOL_UNMNT, so a read-only-only fix in hfs_btree_open() gets undone by
> that remount. Same check needs to go in hfsplus_reconfigure() too:
>=20
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -400,6 +400,12 @@ static int hfsplus_reconfigure(struct fs_context
> *fc)
> =C2=A0			pr_warn("filesystem is marked journaled,
> leaving read-only.\n");
> =C2=A0			sb->s_flags |=3D SB_RDONLY;
> =C2=A0			fc->sb_flags |=3D SB_RDONLY;
> +		} else if (HFSPLUS_I(sbi->ext_tree->inode)-
> >first_blocks !=3D
> +				HFSPLUS_I(sbi->ext_tree->inode)-
> >alloc_blocks) {
> +			/* Per TN1150, the extents file can't have
> overflow extents of its own. */
> +			pr_warn("extents overflow file has overflow
> extents of its own, leaving read-only.\n");
> +			sb->s_flags |=3D SB_RDONLY;
> +			fc->sb_flags |=3D SB_RDONLY;

Frankly speaking, I would like to introduce some method(s) that can
check the btree consistency.

Do we really need to repeat the check on remount? If we detected that
btree is corrupted during mount, then we should set the state of the
btree as inconsistent and simply check such flag(s). Do we have
something like this now? If it is not, then we can simply introduce
one.

> =C2=A0		}
> =C2=A0	}
> =C2=A0	return 0;
>=20
> Both hunks build cleanly here. Want me to send this as v2 replacing
> the extents.c hunk, or keep the extents.c guard too as a second line
> of defense (it's independent of mount-time state and free)?

The checking inconsistency is one direction. Another direction is that
we exhausted the volume or volume is so fragmented that we cannot
extend the Extents Overflow file anymore. I think we need to check
before extending the Extents Overflow file that we have free extent
slots or we can add some space into the latest extent. If there is no
such opportunity, then we need to report -ENOSPC. Because, we cannot
add any new data on the volume. The main question here how to add or
modify the logic in safe way.

Thanks,
Slava.

