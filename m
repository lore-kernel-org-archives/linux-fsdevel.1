Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79938656D;
	Tue,  2 Jun 2026 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441221; cv=none; b=qK+MYgTTxA0Xa8T80NKEuAHzU6g4JvvLRR1GGw54h72r5O4up71ljLIiK81i0TBgTiWaoKGhB3oNGzK9dHKH7x4Wf8hO9I0TuUNpt/Z6TGUc4xfcp2axbbqvnE5pkajuzR6fLAya5i7o73bmf1lhOMMu6LeZz4zltQM0Y1e7njU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441221; c=relaxed/simple;
	bh=Yjizqz5uimQ7YHEMoGu7QonsO5YxJ09Tfx54YQHnWZM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hsyX3fQly0oNvITrJdYQS7ptU1iDJI9KvyVbTtkPx1ypvAZHK0ixnXY81I/jC/7jesLFoOpzlkvAhK1Xe6iq3L+5jiodj0gMGREAt1B9MBh5s9BIrjqi0Y2Ppdyp1gqKIDFyCGsyCJWcvYxyrfNGhDd4vpeTOMO14ny4GLMDz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PxjCWP6K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NMYwca3u; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PxjCWP6K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NMYwca3u"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7624E1D00097;
	Tue,  2 Jun 2026 19:00:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 19:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1780441218; x=1780527618; bh=2XoA/FjqB/erdhiWHhe5XpG4Kcr6mHjgZ1n
	WDmcsRCY=; b=PxjCWP6Kx6Rsk0VnlAthdsicnaRSFe9TMGCg7ZarZt3HGkOmsDj
	jmnZnqFGgLyK/bADvKVpVWIYcrbk8uANmJBHTH9iArj3pXt9G2Py3Ljzj2QyleKn
	A+qAuxijfEkKNAAKKnqN/zb6JM0TIYnJlkKuyPc6zNaAjur/QVIzy+WGUU19kE08
	OUeptof1QZOHW4zHljlzjTMZSH2wI93YIDTfc5kqrcDSei+y2tH66hy+nbM8+DnO
	rAUMkibgoNtnLptYsosmfgFZRPaTzReMG1exFRlHRi0kV5VoWM2RyS5XQ+mv2qVg
	2m3JWB02+3H6FuGVnfk2mENFwFkSU6Vqtgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780441218; x=
	1780527618; bh=2XoA/FjqB/erdhiWHhe5XpG4Kcr6mHjgZ1nWDmcsRCY=; b=N
	MYwca3u39v/EpPoZngxWiyNqvMH3MEmTIw5EJTdqYJNn6Z4vIXci4ggvEEqVqjPR
	a3ckdP1zRDZmVzqjZr6MEDcyGEQSUE9NLPbEmrhphJJFP3v9DMGdRT8aMQ88ULQJ
	y7AIKZQxoQLQvXuoPJo7zYxXz0u9980inO+yQwqWn6+VvbvCGRXZgFxMwGIkaJUS
	O+iR83TiQzxDkrqRQZvQ4vDRKbFmXlCNTt3nu1lKyqnSKKUTtWiS2VJWdvReZnyf
	ZFe3dewxuas9cndwNHOuWarbij3WrcXXae84yHvl0iZohrcfo4iuRRDGgWwFVa8i
	XBn1kNKtLQCnAo+vBriMA==
X-ME-Sender: <xms:gWAfak5zmBcTBlDaxzj9-8C69KBl-YEte3FDYg1dYXIAGA9DONQnow>
    <xme:gWAfauE827Uq8ktz0k3a1YntgFV6b23BRj1NVQBdBnAVrDDuzyXf1OsV4ljfHiGG3
    L-eTSGtR7SoiYUAMZwEymwdK4a-G0sKjxWj9zxWn3aRZ0_Vgg>
X-ME-Received: <xmr:gWAfavDT8S08BCAUtCidjLgCT4ObPp4Ay4F9ITcbxdnxsH3wh3YOJ5oNP3el7m4T05qd986c4UdyA0K-TlfiP0lHYf_yB6M>
X-ME-Proxy-Cause: dmFkZTFFg8OyK0zdeyMHqSvOzVCwr8wXcMDfAwkCLB+a4Rp5mQGvRuCjqXfiunFZMNqbxe
    UJFCMpEbHY8wVdl4+NrPK1v+xGPVVtwJMjhb/vdpcIYX9GXB2Wd13FJmc45OZHdbiwNlcB
    2lIey8dUmP8xKKRAnbj7TkqvlqNimMZDqT5PRQE3mfKgRpgO80INNtamerbGRPyr+eXLEW
    TgTelX3JM2p3oGhqz5pckor26XAiiZ9az2K3KGqQoDmZWYkRvFmpz1016vqWwa0YiPzTGS
    99VWaaootX0sbfxx99B5P2AuD7zC+MNBzeKy9N6BxqaBXdYAftEilURVtCudKfoBS/pUV6
    qICGtVh1XZvFaiz8t7wknhOsVgyKXyVe1cOVjHd6p/xN5pZT3heHj8cCPzRsyn+sMZjCGn
    Q0TtEc1i31tSIBhs1dIYEJJB5mFm47lBKfRqio7XlnDNjL1Mvtt6ugkNrJ9wTMrHW1z6cR
    gKJQdX3YpZ9pXRpmoSk0X9dh4YqOCyva4AvZHQ6lDrIhYYnI6JgVr9mpCjyAVyeV/2mGQ9
    s9envbhXa/8v9G28ihvmAZHlvKMVMUVVKyMaGodffIycSSZqcDIRg5+yd2oUQ/ZvWuO3SJ
    usjPcdRKsCLNmTr8KA9iDYs6FphoKE+8fbjYu9E6yLx8HtKpm6Ax1M0EOmgw
X-ME-Proxy: <xmx:gWAfajxjGbgx32K9JItD5O84oIXJrrw6ZzX7vfNwpEleHRdaMW_gyw>
    <xmx:gWAfaj5slawdaMlrJjecWMpBOdIy3xQWi8lr1untJc1HoMkf9v0Igg>
    <xmx:gWAfakyd6z6accU6t0b_yjN4BKoxx9Jk7WzxEwi2ZbR6ZBVizZ_o0A>
    <xmx:gWAfandcfzNFfTp_hveddB7h6TsBMH9yiAj1HCCGQxyxqAYLsaPvLg>
    <xmx:gmAfapNwCHSsORCs41zkEfGkQ7NpxoFtP-lZL01gjdVyDjefenxfKx_K>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 19:00:14 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>, "Aleksa Sarai" <cyphar@cyphar.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Mateusz Guzik" <mjguzik@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Charles Mirabile" <cmirabil@redhat.com>
Subject: Re: [RFC PATCH v6 3/9] vfs: prepare vfs_creat|mkdir_no_perm for reuse
 in lookup_open()
In-reply-to: <20260531182045.171711-4-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
  <20260531182045.171711-4-jkoolstra@xs4all.nl>
Date: Wed, 03 Jun 2026 09:00:02 +1000
Message-id: <178044120271.2082204.8038449401223306061@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 01 Jun 2026, Jori Koolstra wrote:
> To implement O_CREAT|O_DIRECTORY we will have to repeat some of the
> logic that is now in vfs_mkdir() (e.g. do error checks in the same
> order). Separate this out in vfs_mkdir_no_perm(), which does all the
> non-permission related work of vfs_mkdir(). Permission checking for the
> lookup_open() path is timed differently because we may just be doing an
> open and no create. Similar considerations give rise to
> vfs_create_no_perm().
>=20
> Moving the fsnotify_* calls also allows us to deal with this in one
> place for each type of operation. This does mean that we also need
> to move the fsnotify_* calls into atomic_open() for the atomic open
> case, but this actually reduces duplicate code in open_last_lookups()
> and dentry_create().
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 105 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 68 insertions(+), 37 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 4cd132fe3981..2a35dd72ee96 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4171,6 +4171,24 @@ static inline umode_t vfs_prepare_mode(struct mnt_id=
map *idmap,
>  	return mode;
>  }
> =20
> +static inline
> +int vfs_create_no_perm(struct mnt_idmap *idmap, struct dentry *dentry,
> +		       umode_t mode, struct delegated_inode *di, bool excl)
>

I meant to mention this on my first review but got distracted.

I would rather this function didn't have the "bool excl" arg, not
because it is "bool", but because it is not needed.
The 'excl' flag to ->create is not needed and I would like to get rid of
it.  We don't have to do that immediately, but I'd rather not perpetuate
it.

There are two sort of fileystems - local and cluster.
cluster filesystems support ->atomic_open and so ->create is *never*
called with 'excl' false.  All vfs_create() calls (which are either mknod or
internal) are exclusive.

local filesystems do not support ->atomic_open but *always* ignore the
excl flag.  The only time ->create is called with 'excl' being false is
after VFS has already checked that the file doesn't exist, and is
holding a lock so that the there cannot be a concurrent create.

So we can change all filesystems that currently notice 'excl' to assume
that it is always 'true' and we can deprecate the flag.

Maybe I should post some patches, but for you could leave the 'bool
excl' out of this patch, that would be great.

Thanks,
NeilBrown
