Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A03A63F8
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907127; cv=none; b=IBlHyeaXR1t4BR6S0hzYtAbBiH9Y/8tefofJdliFI00o/v0byM1goFjSvWLHLY/O3CudN9mn9Ze5a2SmygG7ONIZRL1RStkjfRvXHMEek9R5IZVw0XsEPmBwuyxaCISYJ0KfE6WDipWuN1XgTxtKcJICfjdAwGhubh2wPr73FmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907127; c=relaxed/simple;
	bh=u5CMhJnDSjk9w+7QYWtL0MZbrITE4DBVIwmC6Nf6O8w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oFhwsZhYIka2UG62E1ualqOzSM+MQ5yHgOHV5uDp++aMN85Akb0FNGJVHg/2j+uB2LQdQJYT2ZlnbTHaVgYFFYecN+yBVAm3W6t0wUlePRnOJXrjFdbOSY8Z7Bg0Y8ONASkmOE0rzFNUxoiepHKOkTTQBb/SNX82rJI5ePDyO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSUwZfmH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVWZAwdz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSUwZfmH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVWZAwdz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774907124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RGzN+VbSyaJFwChFUr/Hnqf6cRBio09qiiLj25Xf/o=;
	b=PSUwZfmH3C8NRre6fbDvLS27WGpQBw/j0vpkNm05wKbXXjIwDibFWZkQNrR43N+NFELArN
	08iqYqsPJ1yys1b0MimNfX7TIyR1RJ34tuxpd+s1awsB1gqF9KZK3qgabVLG3BZb2tP3BR
	XLZVYjjBXd31emehvwNy18Zn5JgrZ2o=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-0x85ANMrN9a5TxWXA2qKQQ-1; Mon, 30 Mar 2026 17:45:20 -0400
X-MC-Unique: 0x85ANMrN9a5TxWXA2qKQQ-1
X-Mimecast-MFC-AGG-ID: 0x85ANMrN9a5TxWXA2qKQQ_1774907119
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-649f0d26e5eso11857804d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774907119; x=1775511919; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RGzN+VbSyaJFwChFUr/Hnqf6cRBio09qiiLj25Xf/o=;
        b=RVWZAwdz4iiCebmpErENRKeOA77dxpQoENrS3oSa9KXW0nntC+W85Ql1wOjN0C50aG
         ZgqTkb7X4AcD9NpPtoOxFt789Ckgk9GLDweu8kV0LSlt7t/mjjrm6BWn7zRlaj+aowZT
         J08ltDWqUKCltFIs8XkBbABERFM5bok2HTG/FHuYD4h8Q8ArG5g+vrwoggiPWYLsaRXO
         703RHEaR4kn+gyu3IGTvv+fqxi5pk+8hc2aN6ZfHABOgtiN1iuhstLh/8RlO14m4fVtr
         HjXg4NkKUNUzNEZtjSi61i03IrOWP+PWCvd5mjdZJRJBzTHhXwA6gIzgEzIkL/QW/iqP
         lscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907119; x=1775511919;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RGzN+VbSyaJFwChFUr/Hnqf6cRBio09qiiLj25Xf/o=;
        b=My+Gs8fnJiRWY8RDCP4T+gzVZ54iOq85npmkAj03wp8qm+JQYxn6zwEOiiFGQZTyjP
         f3v6pHWeunaABSp1fbGChVH5r25bromf1CdlxhktTYNe+GbZIFCRi52rpK0nrmASJXLz
         gcQVnEKj8le0xZi3oQRtn4n8QUwDjkAPgTsIJQFs76FC3x2O6haZ56cP8pvrHh0uFILu
         +mfOpvGNaZgdJ+m6drgN5Ak60IhTj2U+Aium/q+wL2eNezwLoJeyxR66dVpOqctROPMe
         +4EgR58vw8UxX5/CvRdaR0JGIxDQaBEwOYE7O390tJwWNWhF6bQXUq1iHk2vre5V7jf2
         JD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpARejZylLa/gNDVXVS4qxk9Bjr436oUY+Dg604tm/fJGCGcSYwMjx9PF4YKngwS2hNZqaZcf2BI5Zxcx/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5LSK1m5Xd7e36Ut7UXpXCFi7R6GLGttOum74xcMl2ABXykTgX
	WlRpIZPSllVnUUxgCa76k4BlIMh8Lx7yTBIfNlTruczHb5exY/MCW1KtBaGzT5J2Zt/haIkRlta
	ATfmX0utfJnXfSxUFnqVSBzRH0fPFTJsQFXpGCc5a5tx8cvrRMflbn0rZF4Qi44GZhPs=
X-Gm-Gg: ATEYQzwjnq7Db/KQOK0yf8K/H77g33MLNHV3U6ZyNrCNu04sGRYlZuMdxw15cTXdhpk
	VKOEGhZHG31DyhrsLK0mn33l7rweI+3MSE1oEitfHKRv4zgGkatMr6LM5WQskjLXkZrl52OE5yu
	pRQwL3BiqxMUjMwZu+m3447yMNTHZGKQd0NAUZIvLPi8hPJDJmVeSMxxVM55OE+6xj9iaJvPUue
	tgZIJocL8vpwTR40DU2gqBu54erw08RecP0pl5AhELwTYhJ0REQHwRtXHrdhcy1DuF/9X+zxh5q
	0kqzpuyXeHZ0nd1lvO0RYIpqcEyjzTN1emEWkS3T/3ErWllW9x0chm8HqZKMXNJD8odL4Gzd1+Y
	9HHvXoukA4sMO6+XCZTLPWOo3HGMQn1FGid0eVky0ARQpcj/WTAQW
X-Received: by 2002:a05:690c:38b:b0:79b:ccb6:a837 with SMTP id 00721157ae682-79bddcbf65bmr139233677b3.5.1774907117855;
        Mon, 30 Mar 2026 14:45:17 -0700 (PDT)
X-Received: by 2002:a05:690c:38b:b0:79b:ccb6:a837 with SMTP id 00721157ae682-79bddcbf65bmr139233397b3.5.1774907117373;
        Mon, 30 Mar 2026 14:45:17 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-650093816fesm4570921d50.21.2026.03.30.14.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:45:16 -0700 (PDT)
Message-ID: <e5c4f20159d3661984888add9c6da684623af3ad.camel@redhat.com>
Subject: Re: [PATCH v5] hfs: update sanity check of the root record
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Andrew Morton	
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>,  Jan Kara <jack@suse.cz>, Leo Stone
 <leocstone@gmail.com>, Christian Brauner <brauner@kernel.org>,  Viacheslav
 Dubeyko	 <slava@dubeyko.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  George Anthony Vernon	
 <contact@gvernon.com>, Yangtao Li <frank.li@vivo.com>, linux-fsdevel	
 <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Date: Mon, 30 Mar 2026 14:45:15 -0700
In-Reply-To: <21e7ebfd-d35d-4682-b553-6996cc8c3a8e@I-love.SAKURA.ne.jp>
References: <21e7ebfd-d35d-4682-b553-6996cc8c3a8e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-28 at 16:12 +0900, Tetsuo Handa wrote:
> syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
> operation when the inode number of the record retrieved as a result of
> hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for the inode
> number is assigned using 32bits integer retrieved from relevant offset of
> the file system image.
>=20
> Since commit b905bafdea21 ("hfs: Sanity check the root record") checks on=
ly
> the record size and the record type, let's also check the inode number.
>=20
> Since hfs_cat_find_brec() is called by only hfs_fill_super() with cnid =
=3D=3D
> HFS_ROOT_CNID, we could move hfs_bnode_read() and related validations to
> inside hfs_cat_find_brec(). But such change is a matter of preference
> while this 3+ years old bug is effectively the top crasher for syzbot.
> Let me immediately stop wasting syzbot's computation resource.
>=20
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21b
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> George Anthony Vernon is trying to fix this bug without my patch
> ( https://lkml.kernel.org/r/20260311211309.27856-1-contact@gvernon.com ).
> But it was proven that George's patch cannot fix this bug. Therefore,
> I believe that we came to a conclusion that applying my patch is
> the way to go. We can apply George's patch as a further improvement.
> But unfortunately Viacheslav Dubeyko (the maintainer of HFS) is not
> responding. Therefore, I'm sending this patch to more developers who
> might accept this patch, instead of waiting for Viacheslav.

It's completely not correct. I am reviewing patches in time when I have eno=
ugh
free time for it.=20

>=20
>  fs/hfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index a4f2a2bfa6d3..2e52acf282b0 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -361,7 +361,7 @@ static int hfs_fill_super(struct super_block *sb, str=
uct fs_context *fc)
>  			goto bail_hfs_find;
>  		}
>  		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
> -		if (rec.type !=3D HFS_CDR_DIR)
> +		if (rec.type !=3D HFS_CDR_DIR || rec.dir.DirID !=3D cpu_to_be32(HFS_RO=
OT_CNID))

I've already reviewed this patch. And I am not agree with this suggestion.

We prepare the key with HFSPLUS_ROOT_CNID [1]:

err =3D hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);

The hfs_brec_read() executes the search of the record [2]:

	res =3D hfs_brec_find(fd);
	if (res)
		return res;

The hfs_brec_find() should found the record for requested key. And if the f=
ound
thread record contains not correct CNID, then we can check the found thread
record and return error as the result of the search.

Thanks,
Slava.

[1] https://elixir.bootlin.com/linux/v7.0-rc6/source/fs/hfsplus/super.c#L57=
1
[2] https://elixir.bootlin.com/linux/v7.0-rc6/source/fs/hfs/bfind.c#L174


