Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F63E024D
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840636; cv=none; b=QrAAUJlHPyg+SyyKm7frtrFpyGIP+sSbyhjqT5oz1JndLPD1UGzfqlfwQ6YP/kBGwlt8FTYx/aiMWX4iiVkAi0TWIv6hA+mnLbF17UXd2jcDdcZUkH9vSTo2/AmEnVD+3J+IIvqYKFE+V7QWfWq6biNmrG2aFMb4MEJRiT+gBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840636; c=relaxed/simple;
	bh=1bvqcGLbqTOKT9Uj4h9VH5GpdwlqT/k7C4itqD5rZQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jB4jFK+TM3g5hoiR3mTA1Yhj1//lXsuuzyS1sA5XjEdNAmb/sMl2SmAxo2bvKuDpJmM49qNsMHGbTQ4vmUDDPLFfsY2KjhD0Epq5wWYkpYInrWCdIQ+WwSAeRQneoof51cGCSBDlPgz1M04eZezMZHKqQ0YqBYOvWi1EwmsB8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=VB0Tw4FO; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="VB0Tw4FO"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6756a01fa01so2077472d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791840634; x=1792445434; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7oYyPazLOsYoXwJEX5UknWibd9Y3NklOLVSLMkeaRo=;
        b=VB0Tw4FOyzaRyzSjUr+VvVLwZzdXqWHpkzgxdt5Z5BpRXDCMt0ibjMSn5ARUiFxQNw
         gj2uKqei1sAn2Of3k66kHTyQ9AkNW+ZRel/XQJ6L9RHdG8DaogUYWniSuoZ2ZUVdOSO4
         7FzCR1gc+up+xjRWCUqvOih6OAkSHWi8x4LDOJ5cmjYL+GbsF2oo7dDAy4mTRV2UvPh7
         sQtGf1fKn6nxzI5OiBk4wPwzwputaV0UjzwVhpIS8RXT55h70l10ari94ry7Fa9yWgO2
         b/nnbwZH1LvefM3TS5dkxrKNfcE3ARQk9uMUFBKVY3H/mtYh8TtOvJLamRWyo6Ap0Kgj
         htKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840634; x=1792445434;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r7oYyPazLOsYoXwJEX5UknWibd9Y3NklOLVSLMkeaRo=;
        b=VCNLO2A+PMBKwddI6R6f0YwJPeCvNJLbfghYLFyOa6ogqem0ziFQOLKPDKiCl5mG+j
         GkCg5/TsKdu9PCRw4CmxDifbIvBw42DP0JYV+BzqzWL1C4i+i2tNC6nFHSHVKquTqYHt
         YBGJjc3ZEHXlIGNfP8wuEy+ugWEEW+024TthXyjJwPIL/+SV+/5dhfXAzDmt769v2JlK
         YeGSzZEx3t7M/fAVszlRtvcgrcHmjgiVVqkmrGRPObHOjnh98Ff0TG/Br/ck18hsH23z
         KDTBXvBdbWrNYoEVDCCYyCMvbwnUkoo+Iqo+I/Y9IumyUEXC06p8H1++nsvUPwdr0RK8
         aaFQ==
X-Gm-Message-State: AFq9FYLx1GxgaFAwWsr2PS4lqlGAAkoOVNLTWkC6G6iJDznc+QtUlywj
	OBzaRTQQGJN2af9605waQxhPx1Y1qzKgTm5gPDPhMoakBl17GNOJ1dJGl/qAkpB7JTrzSWLXQbL
	vSzGtSpY=
X-Gm-Gg: AYBFou11NlxP3Y9p5ZBPR+4M2umzi1knTiO3y2tD+LKo6lfVtpsZjG2hcPg3nGT5cru
	IThx1c03nPlj4QV87F8HhtpNDkae8KcooAbieGw0dQvxwar6tKwQkz5DSxO7Hk/RTt5sXbnile2
	IVt7C3dMSU+ngP2yF9fROKYhMhVooXP/hg2L5fogUUyKsaEwHgwXgxT7l/wRjn6tnpl2UhIUntE
	PNFsd2/hP7d/+wyihBYSlkudGkZmlmCXRjOVcuclnf18teSyZOiDWKJw/MnZBvZbi6WGyuF+fha
	/lcQJdun7H+Q6tDgW+vshsDfiODKapRLfLNsWdX+Y12yHlIZgoN+rpmkXiFfirIDGVkvoaxaKF9
	Jj7MUJjdTmEhbDybrAwooKbRJwIid4D0rWuHpM6EltlnKoSQIks5PaUWi9qbf/6iOIliQCib/74
	dR1YWUVpTXzWGXpMad1tn9TYJG/NloRiU4J54e/2ePj8X0mViD2DL9729kbUFNcsFHuI4j6H+Yn
	6gi8wxS7q6JpHbBXztXxxfAh67KwxtD0GPSXaTJI6YJqXSfLwe4UzUr2gqLnKRUQvKFb+mPBodE
	cfAyzOnoxC5vL5IUorRjHA==
X-Received: by 2002:a05:690e:168f:b0:676:2898:e43e with SMTP id 956f58d0204a3-679369db16amr3563572d50.58.1791840633856;
        Mon, 12 Oct 2026 14:30:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430::48? ([2600:1700:6476:1430::48])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679356e0017sm4173365d50.19.2026.10.12.14.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:30:33 -0700 (PDT)
Message-ID: <abe509bc80fe0f4e83f49af87aaa74fb95888aff.camel@dubeyko.com>
Subject: Re: [PATCH v2 2/2] hfs: refuse catalog records that address the
 reserved B-tree CNIDs
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: 1sh1ro <yangguikun19@qq.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 14:30:30 -0700
In-Reply-To: <tencent_5E46DC9CA04DCFA2DE7C8AA3C8532FBE1709@qq.com>
References: <fb6a6e2ff419fc197c793d9a98fccd2d1332e49d.camel@dubeyko.com>
	 <20261012154438.6396-1-yangguikun19@qq.com>
	 <tencent_5E46DC9CA04DCFA2DE7C8AA3C8532FBE1709@qq.com>
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

On Mon, 2026-10-12 at 15:44 +0800, 1sh1ro wrote:
> The extent and catalog B-tree inodes are described by the MDB, not by
> catalog records, but they are hashed by CNID like any other inode and
> hfs_test_inode() compares i_ino only.=C2=A0 A crafted image with a catalo=
g
> record whose FlNum (or DirID) is HFS_EXT_CNID or HFS_CAT_CNID
> therefore
> makes hfs_lookup() hand out the internal B-tree inode as a regular
> dentry,
> bypassing the CNID validation that hfs_read_inode() performs: a read
> exposes the B-tree file's contents, and a write would go through
> hfs_write_inode(), which tries to update a catalog record that does
> not
> exist.
>=20
> Refuse such records in hfs_iget() by returning NULL for the reserved
> B-tree CNIDs.=C2=A0 hfs_lookup() reports that as -EACCES and
> hfs_fill_super() as a mount failure, the same as for any other
> unaddressable record.
>=20
> This is hardening on top of the file-type fix, not required for the
> panic; it can be dropped if hfs_is_valid_cnid()'s acceptance of
> HFS_CDR_FIL records for CNID 3/4 is intentional.

Please, combine both patches into one. First patch doesn't fix the
issue alone.

>=20
> Signed-off-by: 1sh1ro <yangguikun19@qq.com>

Please, provide the real name.

> ---
> =C2=A0 fs/hfs/inode.c |=C2=A0 11 +++++++++++
> =C2=A01 file changed, 11 insertions(+), 0 deletions(-)
>=20
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 4316d75..5190856 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -520,6 +520,17 @@ struct inode *hfs_iget(struct super_block *sb,
> struct hfs_cat_key *key, hfs_cat_
> =C2=A0	default:
> =C2=A0		return NULL;
> =C2=A0	}
> +
> +	/*
> +	 * Never let a catalog record address one of the internal B-
> tree
> +	 * objects.=C2=A0 hfs_test_inode() matches on i_ino alone, so
> such a
> +	 * record would make hfs_lookup() hand out the cached B-tree
> inode as
> +	 * a regular dentry, bypassing the CNID validation done by
> +	 * hfs_read_inode().
> +	 */

Please, rework or remove the comment. Currently, it's long and not
informative.

> +	if (cnid =3D=3D HFS_EXT_CNID || cnid =3D=3D HFS_CAT_CNID)

I think we can reject all cnid that lower than HFS_FIRSTUSER_CNID.

Thanks,
Slava.

> +		return NULL;
> +
> =C2=A0	inode =3D iget5_locked(sb, cnid, hfs_test_inode,
> hfs_read_inode, &data);
> =C2=A0	if (inode && (inode_state_read_once(inode) & I_NEW))
> =C2=A0		unlock_new_inode(inode);
