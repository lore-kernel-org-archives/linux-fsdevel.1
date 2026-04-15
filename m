Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E91DE3B7
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289715; cv=none; b=pWMwDDIBr+JRWhCrRXZRp0af00A0eFfWh9G2O80GGj2RNzfBt85pawgo6vqphkO0cscAWzsaQ+txb/l1c6wzTWErxj+vdm4Wr9+CgIm432f3vVtFpkIXCrEO13MIENt9E+cjGO0uf4VBBjWxwlKwALlo557Vw8pc67TFMS5R8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289715; c=relaxed/simple;
	bh=HSbJ7b2GfHm7QF2U/lU2tID71YO60ldLPYeKB5OAhjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JgY4K8TUojx2iDXOYYsbC4H7i3TzU92bO0k4MIjlYLahDq7hvpUa4krrzmnsVnK5XGzCu4IvIxd/VOOoM/txurFqknQWyjx2qJdBQ3Qjaa+9hjaQS0pQsHD+1OQoVDJM2CpXW8lndCbu6IUQyPwLmWmoCE8wWgbXFFCUm7yweOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqijPFFw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fR06KltO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqijPFFw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fR06KltO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776289712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5Yjy3S3BFKJDNyOmnU55JSd5lC7QzocCDrnIK6I4+k=;
	b=IqijPFFwxr/PqB2+w1FZBIZZP8zOGu+Wl2CN41T6eyEZrCDKKzSdZCgh7mmVaDUiAY2OYI
	Qh4YDe3LY/Q5APLZf5p06EVfAqbvNPbOas4GXtWD+7352yoOj/RAwWq9oAM5NkzNpwI6oe
	gaGVQ6quLxvYhYexspsMACC05R1jC7k=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-_30SRp__OF-yFnom5VXLzA-1; Wed, 15 Apr 2026 17:48:30 -0400
X-MC-Unique: _30SRp__OF-yFnom5VXLzA-1
X-Mimecast-MFC-AGG-ID: _30SRp__OF-yFnom5VXLzA_1776289710
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79a670a5fe9so199045277b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776289710; x=1776894510; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5Yjy3S3BFKJDNyOmnU55JSd5lC7QzocCDrnIK6I4+k=;
        b=fR06KltOwwZ9gzxVFCG8A9rQmORe/38800H4s1IIAJKlc+WWvoakTK1a0Ncn+Xj7XF
         BblmlIT6nOYqPsEPdKrL2D5GccHSXNLVZuu2QWJdLfdi5enCc94rAH1+0lx9EEWkOY41
         UgDHX71EQIKGT7PZdJV8gnAOfHzjVdzDjeRqhvbI7n6VTReS/7WNQMlWq50KPVJ/Xl3q
         uLz7jNHptFdAiEuZCpTyqPA8pXiVF3w5CD/RsvaJMMTh9oVBnAjSI6g57SwhkC4qg953
         CFwTeMThfZN5S6Ba3UY3uCYZ2QJOmypIJ+RDaLtOg03ZKKVOkteSFsflTd9LSWXs/tmC
         oIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776289710; x=1776894510;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5Yjy3S3BFKJDNyOmnU55JSd5lC7QzocCDrnIK6I4+k=;
        b=pvAdGMHlV+LWoHZvxvromelbwdpiz/bo3l33KRY0E1510BDptvtgfVy8U/8NHlufTl
         wzZ7XdrwOw2FQZ2y637pdKmQoo4+f8fxcZbCGYucWaHy2vIwV5/hc9VbiELItQuegM9x
         +VZXxvKdn5Ml20+4AAiiAgnjKHJ6vVMHWvM+DLQwMBhAmDiXR0VJZLH3zA+9jUzGb2rU
         0DfVlZ3zYPARAqnUczcRjfW1lg0DtJgu6Nfe5WNYi8MuknhpgFoI/2Y+FXhgVjNfq2dv
         D+nAZuKgYi+w4iDgpaZLVn1chLlvV3N4j9eKiM7MoWmNTVEPt2naCPdp5eI7VwX3i5yM
         7+jw==
X-Gm-Message-State: AOJu0YzkTr7k5zxyMZXNK/vpGcsxWiUyzu85wrKi/5HMgAuO6ICBOw9h
	S43UyqGnQb9XGl1RgN6VvS+zR50vzF37qslwzcsmwKSLdveyJPR5LiWluf+sNDtjuATwUeW/LnI
	nA41vrzcWdCJZsVO8YRZIA+lYXgVw0nntVZFoVPuv8gqeVZBJv2D9p/ERV06DDQJxBUh1XUMrh/
	0=
X-Gm-Gg: AeBDiesFolxD7ow2LpwWf04z9QAHSavRpny59lPRbgPzwJNgcIf2tK1VMo+mu3gL64n
	+ZpjBhWGWrd1MEMkGNIZm42E5z746FHH1szYd5B+CZ3J9/h0QAcZz4o5lo52SMy94vRJPQS2pHb
	d5NiXtWGl5VlDekl0reNznujBeGFNbk40U5TR63faZt8c87VypD4suY1K8Pig84KY20UF4Drvm3
	uMVT5j6FavP5ltsFELROg6BI8i78DvaRLRAd/gFcY8sADppc2zKfcXYk/cgpoeD/6qsW+sKd+yl
	pNC+SQ1LmBWAI1nYWE6ZkGDtmeGWOMhZoIA/BtAlLF67ckrJbGP++OWhu8beAGESqXi8vjzXYCG
	l3Ukk89ziq0g3h8qdPlJdCG9Qf19JBbmPGC1CtPbfINZ7uL1uiuX0G6sRp3Re29U=
X-Received: by 2002:a05:690c:6983:b0:7b4:31cc:376d with SMTP id 00721157ae682-7b431cc3be3mr122199867b3.39.1776289709913;
        Wed, 15 Apr 2026 14:48:29 -0700 (PDT)
X-Received: by 2002:a05:690c:6983:b0:7b4:31cc:376d with SMTP id 00721157ae682-7b431cc3be3mr122199647b3.39.1776289709499;
        Wed, 15 Apr 2026 14:48:29 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b768d3a990sm14025537b3.26.2026.04.15.14.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 14:48:29 -0700 (PDT)
Message-ID: <1929bc40bee602937aac95a3d338614b5fe7e082.camel@redhat.com>
Subject: Re: [PATCH v3] hfsplus: fix null-ptr-deref in
 hfsplus_cat_write_inode
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Date: Wed, 15 Apr 2026 14:48:27 -0700
In-Reply-To: <20260415014345.77796-1-kartikey406@gmail.com>
References: <20260415014345.77796-1-kartikey406@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 07:13 +0530, Deepanshu Kartikey wrote:
> When a corrupt HFS+ image is mounted where the hidden directory is
> absent, hfsplus_fill_super() handles -ENOENT from
> hfsplus_get_hidden_dir_entry() silently and continues with
> sbi->hidden_dir left as NULL.
>=20
> hfsplus_link() and hfsplus_unlink() call
> hfsplus_cat_write_inode(sbi->hidden_dir) unconditionally without
> checking whether hidden_dir is NULL, triggering a general protection
> fault caught by KASAN as a null-ptr-deref at offset 0x28.
>=20
> Other call sites in dir.c already guard against this by checking
> hidden_dir for NULL before use. Apply the same guard to the two
> unprotected call sites in hfsplus_link() and hfsplus_unlink().
>=20
> Changes in v3:
>   - Correct fix location: guard sbi->hidden_dir before calling
>     hfsplus_cat_write_inode() in hfsplus_link() and hfsplus_unlink()
>     in dir.c, as suggested by Vyacheslav Dubeyko.
>=20
> Changes in v2:
>   - Fixed commit message: hfsplus_delete_cat() is called from
>     multiple callers, not just hfsplus_unlink() as incorrectly
>     stated in v1.
>=20
> Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc0ba772a362e70937dfb
> Tested-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/hfsplus/dir.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index d559bf8625f8..a7feef53d8cb 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -362,9 +362,11 @@ static int hfsplus_link(struct dentry *src_dentry, s=
truct inode *dst_dir,
>  	if (res)
>  		goto out;
> =20
> -	res =3D hfsplus_cat_write_inode(sbi->hidden_dir);
> -	if (res)
> -		goto out;
> +	if (sbi->hidden_dir) {
> +		res =3D hfsplus_cat_write_inode(sbi->hidden_dir);
> +		if (res)
> +			goto out;
> +	}
> =20
>  	res =3D hfsplus_cat_write_inode(inode);
> =20
> @@ -431,11 +433,10 @@ static int hfsplus_unlink(struct inode *dir, struct=
 dentry *dentry)
>  out:
>  	if (!res) {
>  		res =3D hfsplus_cat_write_inode(dir);
> -		if (!res) {
> +		if (!res && sbi->hidden_dir)
>  			res =3D hfsplus_cat_write_inode(sbi->hidden_dir);
> -			if (!res)
> -				res =3D hfsplus_cat_write_inode(inode);
> -		}
> +		if (!res)
> +			res =3D hfsplus_cat_write_inode(inode);
>  	}
> =20
>  	mutex_unlock(&sbi->vh_mutex);


As far as I can see, we have such logic in hfsplus_fill_super() [1]:

if (!sb_rdonly(sb)) {
<skipped>
    if (!sbi->hidden_dir) {
        <create hidden dir>
    }
<skipped>
}

So, I have two questions:
(1) If we mounted volume in READ-ONLY mode initially and we re-mount it int=
o
READ-WRITE mode, then we skip hidden directory creation. Should we process =
this
in hfsplus_reconfigure()?
(2) Should we create hidden directory if corrupted volume hasn't hidden
directory?

If we don't create the hidden dir, then we could have troubles in multiple
places: hfsplus_rename_cat() [2,3], hfsplus_delete_cat() [4,5]. It looks li=
ke
that we need to create the hidden dir. Otherwise, we could trigger the kern=
el
crash in multiple places.

Thanks,
Slava.

[1] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/super.c#L589
[2] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/dir.c#L326
[3] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/dir.c#L397
[4] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/dir.c#L418
[5] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/inode.c#L257

