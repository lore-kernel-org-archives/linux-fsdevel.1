Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EFC306D26
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194975; cv=none; b=LHedWIMbq/YYYil8YMF/B29i/nculrUCUbcNil0fCRMKvi5pJmlWUYKeQ8elLghpLMzvB7K0UrNzMhy6FW3cd3ZqN6CbNEhVVbqURYRKXH6T8ma6+RthQvEHnwExThyQMKWiGpk5+dlEKynNP/CBsqPnRujdLRI1VLV1wzQSm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194975; c=relaxed/simple;
	bh=18jf9Es9xLIQexRpw6/Q5wgPDX3/hTUkaWFr0fhigAg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X54JO3gdBiWBr7dbHT3/J1fu3aGcedIaxGNEse4IVGERBtcn8F+Ea9gBR6oCpwbbkgBQA6mLwM0nPvv4gadSvU0KYMCgJg6B7fLXCHAZW7F0sfpNY0Y8PZqyBa1Rs2M2krwarW3tmM8Dx8vZAK1jporQDwphj5NbBJROBuVDW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsvasi80; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eo8Cqcav; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsvasi80";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eo8Cqcav"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776194973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOyAxml64xkpl80S1+G1dwmhjQXPrpMGBGP1sr394fs=;
	b=hsvasi80fgMho2ZvwRmDOFd0atQ/s+vOnyXSjxj+lrK9l2auwO9iFciBWHyXedsJ6amH1B
	9z3AUrTEo6kHOEkfmNaEzPK04194/ob4zlihBimTkwmJRNCdpQXoMN+mVDOf44SoLxVlZH
	u+SCFcqzayblD3n0AgnYYOWAB3zQ6o8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-KkMl-KBPNvy8qoSpj2QWRA-1; Tue, 14 Apr 2026 15:29:32 -0400
X-MC-Unique: KkMl-KBPNvy8qoSpj2QWRA-1
X-Mimecast-MFC-AGG-ID: KkMl-KBPNvy8qoSpj2QWRA_1776194972
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7900fc7033bso162227167b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776194971; x=1776799771; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lOyAxml64xkpl80S1+G1dwmhjQXPrpMGBGP1sr394fs=;
        b=Eo8Cqcava6ln9yqOIPIQowHl3phMKEKAHcPyynACfC7flseBICv/L52u80yXmbSfo3
         TUNh2t2doO8XM86iBZCsvXNdo57YjGUvKtPb1t2t3YDMvlYsUtbCE4uRiQkM2kHxvmm8
         G9W8WKBkxRr2LcnUW2p9hxR0VvVS/C02GT9u1ejf58j9zN0/uK8t2Ig4InqrlpYHZRX5
         MAh8H2bihJ+oEbwLgl6ZDGjKTpUM8oZtrsFfYrjiU7Yw2wYkAoqReCrhAeu7VqYiIKQb
         I/HjS73Ic2Ifkc+qINnEyMWZKxyLpDpmhF45SqY1n8g+OFoV1y0FOZiZpFzSIQQREBmp
         42LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194971; x=1776799771;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOyAxml64xkpl80S1+G1dwmhjQXPrpMGBGP1sr394fs=;
        b=QnRp0IgC+Tc5MsXZ82kev++y2hkyGAQP38899eZiWywIJjJWaBOm9p56TYInFN7+LI
         XFJfpDH5xvu7aNvmP7/Bdjm7pZVa24+ncx3gEszgb9+uN9jHVWXJY2GTN9e8QEcfDQ0o
         PIzoUlJoprmw/80p/6Xqs0b4K68xclmqhLbOCA9AvOc1M0PL9OJimR7dfEYKxfbgbyY4
         Ycf2CX2vpiDlbpu+vg3Dyev/iMY8y9Aya5AErtZaENBpwSbHmUMN7IEIt6N7zS3128CD
         uTHS9MWXU37bGSzwpGECkSZ30LLV8E6bVfQRSr1o3RjYFqlUl+f4AWIBWAvNa2qZsNRc
         ttRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/X3FSd2WRDsCgbQciMOjY/PGHffxEK+YOK86JpKSuysU0zz962mKkARaycxWbljSSqqQQQ85lREN6SMC/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YykO+qE7r6voG34RWvijyi0VweUEizVxh8fLH/DTuRQQcZdd9B9
	RX3R9/igApwWMP6XFUWeb4zdsAH4lsqU4shyT2Hm2zY6RWQ1+7Ah4dmDwbTwIUE+TyKyb4QCkXJ
	lOvJi4Y59q7FIItJ8yi8z5TpTu31HyMtwGIJtGYEQURPNRNcztzhFLBFgRpg8ZRoQIzX5LZB6OU
	Y=
X-Gm-Gg: AeBDies41w/wzDwjHLUo1z7OlgyeVCgi4688fo+pIDp/etyWnRn8fHOhX5nTiE22W+K
	6m5mJg3XGvu/lat8g1CYsu4+nrL4OqfPBoxSo27QtJKzNY/5UEIBDPMH6fqgq02TyI6+UDLX90G
	Te9Hs9JBPPYwqz3mOGp77+V6Mficgg7mLJ8EnwXz1mF06hj2RfM2DUDOhLp3QAOn/7ugyeSKXEP
	Ng0kd9PebeZqeVyrz+Tffrp/xrmx0mnxVJ+qFiCe9gC65bVnnU+Oxhc7Tosm4e0oXVPdIzCggWx
	USMUOYs4cVZL92RiCab76yqp69w+mcHjpFoi7UtF43G4EKbKV/giL0uA7jDEg2wvLKqNhEFAVrn
	AKbTYnCxfPfIv5P6FM/602zkiiM4k2KKq6j7fnKKK5D/tmIGiAZsd6lhm6KWrBcw=
X-Received: by 2002:a05:690c:10d:b0:7b0:4bc1:d713 with SMTP id 00721157ae682-7b04bc1e0c3mr147975837b3.23.1776194971362;
        Tue, 14 Apr 2026 12:29:31 -0700 (PDT)
X-Received: by 2002:a05:690c:10d:b0:7b0:4bc1:d713 with SMTP id 00721157ae682-7b04bc1e0c3mr147975717b3.23.1776194970897;
        Tue, 14 Apr 2026 12:29:30 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fdff108sm71623247b3.42.2026.04.14.12.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:29:30 -0700 (PDT)
Message-ID: <f2707a743d06df045daa314bcd1564257b4f83a5.camel@redhat.com>
Subject: Re: [PATCH v2] hfsplus: fix ignored error return in
 hfsplus_delete_cat
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Date: Tue, 14 Apr 2026 12:29:29 -0700
In-Reply-To: <20260414015630.65081-1-kartikey406@gmail.com>
References: <20260414015630.65081-1-kartikey406@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-14 at 07:26 +0530, Deepanshu Kartikey wrote:
> hfsplus_delete_cat() calls hfsplus_delete_all_attrs() to remove all
> extended attributes associated with a catalog entry, but silently
> discards its return value.
>=20
> When the xattr deletion fails on a corrupt filesystem image (as
> triggered by syzbot), hfsplus_delete_cat() incorrectly returns 0
> (success) to its callers, allowing execution to continue with the
> filesystem in an inconsistent state and eventually triggering a
> general protection fault in hfsplus_cat_write_inode().
>=20
> Fix this by capturing the return value of hfsplus_delete_all_attrs()
> and propagating genuine errors back to the caller. -ENOENT is
> excluded since it signals normal loop termination (no more xattrs
> left to delete) and is not an error condition.
>=20

Frankly speaking, I don't quite follow how your fix relates to the initial
problem?

vfs_unlink+0x272/0x6d0 fs/namei.c:5476

error =3D dir->i_op->unlink(dir, dentry);

hfsplus_unlink+0x57a/0x930 fs/hfsplus/dir.c:435

res =3D hfsplus_cat_write_inode(sbi->hidden_dir);

RIP: 0010:hfsplus_cat_write_inode+0xbe/0x8f0 fs/hfsplus/inode.c:637

struct hfs_btree *tree =3D HFSPLUS_SB(inode->i_sb)->cat_tree;

It looks like that sbi->hidden_dir is NULL and this is why crash here.

But how have it happened at first place?


> Changes in v2:
>   - Fixed commit message: hfsplus_delete_cat() is called from multiple
>     callers (hfsplus_unlink, hfsplus_rmdir, hfsplus_rename,
>     hfsplus_evict_inode, hfsplus_fill_super), not just hfsplus_unlink()
>     as incorrectly stated in v1.
>=20
> Fixes: 324ef39a8a4f ("hfsplus: add support of manipulation by attributes =
file")
> Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc0ba772a362e70937dfb
> Tested-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/hfsplus/catalog.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 02c1eee4a4b8..adbaeabc06ab 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -421,8 +421,15 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, =
const struct qstr *str)
>  	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
> =20
>  	if (type =3D=3D HFSPLUS_FILE || type =3D=3D HFSPLUS_FOLDER) {
> -		if (HFSPLUS_SB(sb)->attr_tree)
> -			hfsplus_delete_all_attrs(dir, cnid);
> +		if (HFSPLUS_SB(sb)->attr_tree) {
> +			int attr_err =3D hfsplus_delete_all_attrs(dir, cnid);

It looks like that this code is generated by Claude AI or something like th=
is.

Thanks,
Slava.

> +
> +			if (attr_err && attr_err !=3D -ENOENT) {
> +				pr_err("hfsplus: failed to delete xattrs for cnid %u: %d\n",
> +				       cnid, attr_err);
> +				err =3D attr_err;
> +			}
> +		}
>  	}
> =20
>  out:

