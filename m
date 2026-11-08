Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142255;
	b=naFBjngzLlGR5cKjdzKpvu4U3nol/EdrO6K0Gyzd4qBaGLjeNDsDjru0k1aQGmeI88t8
	 y5BPMiAPp4I8wLJ+8vojdFPjxWkpLUzJ5AUs3tExa0t2jYj2z0T1qckfKvBK5TStTlb+f
	 H6C3IE8pHUsVbEWbLODGrOUq29C8SjViMsEorshflQgwYcUNLwki9LmIu8+pqFr169/VR
	 vif3o/nu9Ub6wdnEWZXDz3lDy2x4O5If8tf9ByKCVWVQITPhxXONPxT42L/zNZuZnasJX
	 bvHPsNXBLT3zWBbY1JOQdmbSivNmDM9G6ey+aFbwiJ9Vevu+ySFzGT1l6+aM8FkUCMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142255;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hitSk203Z3MDehzTSnWVcqfGrv0NFSDEbEoJVDBHWNE=;
	b=CicS52Z9t35pYuz40uvRx0fy5Ns6osJkZrUFoYlDrdDbwT67b1tuTeHLCFTV/hxhT1Pa
	 XJHbtN5tjqoUed82s3p6kKTLa+l1+y20VMHBz0BFQBeTS1QaJ8Df43qFKZOzTdR0jTptF
	 qlwSA21Rr+tFVq7Geju3hnD74w/eCczsoJIqvWpLkQgCAUWpbFjJN8RjVt1LxFSJ1mD58
	 +/ms2WRsIuVanURGAV8/Cdb9sKjqV3LKd3Etu57cxUalU6qA+0aiGztRIH4Q7umdP60LG
	 /NakmpsEmzYjprw7ZFWoqlWSoVpZsCISWIu3Tk1CcNYoIfqJUsk8lgzQVjkTxVPA+zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGei4xjN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B2606A321
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGei4xjN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2521F0089F
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794142253;
	bh=hitSk203Z3MDehzTSnWVcqfGrv0NFSDEbEoJVDBHWNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AGei4xjNLRaUPimc4nH7X8n1Z4Xf2LB0U2cjSsWsnXVDMQ8qDK+kKyex1fFyrFDs3
	 5+Ax3fhz5HaAsUih/bbiaOAt8uK69JrscOKg9+1toClqsetiE3h8f+v4Ju9qn/tS4a
	 waFOLUfgzqXwaweUeDB2s906WCfVuDTiMC0qhBfqHLVCd3vb9VP6FuQmbKBobs2cz/
	 Lg9etFfqaJxfy0dEwMvU4aGUpQtNVIWK0E0wN9EB3V/v8FALzZbyy6I5IgS8PCy6e7
	 3tGfNu9lyUZLqi7bu5hy2EJE9CfmydtWbE/SGN3t8ybLLzDh7GOpKldGrGAUnE/aRW
	 h4kxDXjd1VKfQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so90783a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 04:50:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFq/Ge79YIeUWYhUzRM2TCzx+UgvJCNILZnabOE8vyC4caCL+g2qm4aowOvKWaaViRD8UkmbcGYJVHX9NMC@vger.kernel.org
X-Gm-Message-State: APuU4Z/ytiibHAxcxEgqH5166YYtY3aXDGMkwz3t+9n+N4hri978wfaV
	NAK5wa31EmjGr3hkLi2WuV9EBtXWyIBM05PGDVDFGq8EgB2dAiy98487Mo6E5sIlIrFu/hj5wVw
	CLYf3Sd9Mfa2maMKz0hk4E4HhA7FNpA4=
X-Received: by 2002:a05:6402:1e91:b0:6b7:170:bd17 with SMTP id
 4fb4d7f45d1cf-6b7224624bcmr864837a12.33.1794142252407; Sun, 08 Nov 2026
 04:50:52 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
 <20261108080323.468892-1-wahidzk0091@gmail.com>
In-Reply-To: <20261108080323.468892-1-wahidzk0091@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 8 Nov 2026 21:50:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9=crUmmGbO1vcPsdz-GmWoHxD_W_bRv2PQ_Db3Q+EkCQ@mail.gmail.com>
X-Gm-Features: AclHuK-VpXbvUoIWbOObTZtRbEASwgLKvE2W7SQOC2nRaKVoxuPrbaCZOAMIEcE
Message-ID: <CAKYAXd9=crUmmGbO1vcPsdz-GmWoHxD_W_bRv2PQ_Db3Q+EkCQ@mail.gmail.com>
Subject: Re: [PATCH v4] ntfs: convert a named $DATA stream safely when making
 room in a record
To: Wahid Khan <wahidzk0091@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 5:03=E2=80=AFPM Wahid Khan <wahidzk0091@gmail.com> w=
rote:
>
> When an attribute has to grow and the mft record is full,
> ntfs_resident_attr_resize() walks the other resident attributes and
> converts them to non-resident ones. For $DATA it always opens the
> unnamed data inode of the base inode, even if the attribute found is a
> named stream:
>
>   tvi =3D ntfs_iget(sb, base_ni->mft_no);
>   ntfs_attr_make_non_resident(NTFS_I(tvi), value_len);
>
> value_len is the length of the stream, so it does not match the
> attribute that ntfs_attr_make_non_resident() looks up for the unnamed
> inode, and the WARN_ON() on entry fires:
>
>   WARNING: fs/ntfs/attrib.c:2115 at ntfs_attr_make_non_resident
>    ntfs_resident_attr_resize
>    ntfs_attr_expand_locked
>    ntfs_expand_for_write
>    ntfs_file_write_iter
>    vfs_write
>
> It does not need a damaged volume. A file with an alternate data stream
> whose record has no room left is enough.
>
> Open a named stream by name with ntfs_attr_iget(), as is done for the
> other attribute types in this loop, and keep ntfs_iget() for the
> unnamed one. The loop runs with the mft record lock held and takes no
> lock of the stream inode, so converting a stream from here needs more
> care than the plain lookup gives:
>
> - A reader of the stream holds the folio lock and then takes the mft
>   record lock in ntfs_read_iomap_begin_resident(), the conversion takes
>   them the other way round and waits for folio 0. Take the folio with
>   FGP_NOWAIT in this loop and skip the attribute if it is busy. The loop
>   only tries to free space.
>
> - A stream that is in the inode cache can be open, being written, being
>   removed or already unlinked. A write that passed its residency check
>   before the conversion carries on with a non-resident attribute, and
>   a stream in the middle of ntfs_stream_finish_remove() is converted
>   under its feet. Convert only a stream that is not cached, and none of
>   a file that is being deleted or has no links left.
>
> - The lookup of a stream ignores case, so a stream whose name differs
>   only in case from an earlier one resolves to that one and the length
>   does not match again. Compare the names exactly.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
> ---
> v4: v3 (convert a named stream via ntfs_attr_iget()) can deadlock against
>     a reader of the stream and has other races with an open or removed
>     stream. Each is reproduced with a forced make-room pass and a debug
>     delay, fails on v3 and passes here: reader/converter deadlock
>     (hung task), write continuing on a converted attribute (iomap_iter
>     WARNINGs, recursive locking), unlinked file with an open stream (mft
>     record reported corrupt), stream converted during its own removal,
>     and a stream pair that differs only in case (WARN in
>     ntfs_attr_make_non_resident).
> v3: use ntfs_attr_iget() for a named stream instead of skipping it (v2).
>
>  fs/ntfs/attrib.c | 57 +++++++++++++++++++++++++++++++++++++++++-------
>  fs/ntfs/inode.c  | 19 ++++++++++++++++
>  fs/ntfs/inode.h  |  2 ++
>  3 files changed, 70 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index ce7c1b524180..c824bd3ea9fa 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -1975,7 +1975,21 @@ int ntfs_resident_attr_value_resize(struct mft_rec=
ord *m, struct attr_record *a,
>   * inode i_size is that this is not necessarily uptodate.  This happens =
when
>   * ntfs_attr_make_non_resident() is called in the ->truncate call path(s=
).
>   */
> +static int __ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u3=
2 data_size,
> +               bool nowait);
> +
>  int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_si=
ze)
> +{
> +       return __ntfs_attr_make_non_resident(ni, data_size, false);
> +}
> +
> +/*
> + * With @nowait the folio lock is only tried: a caller that holds mrec_l=
ock
> + * must not wait for a folio lock, the read path takes them the other wa=
y
> + * round. Fails with -EAGAIN if the folio is locked.
> + */
> +static int __ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u3=
2 data_size,
> +               bool nowait)
>  {
>         s64 new_size;
>         struct inode *vi =3D VFS_I(ni);
> @@ -2056,10 +2070,11 @@ int ntfs_attr_make_non_resident(struct ntfs_inode=
 *ni, const u32 data_size)
>                  * outside all ntfs locks, we need to get the folio now.
>                  */
>                 folio =3D __filemap_get_folio(vi->i_mapping, 0,
> -                                           FGP_CREAT | FGP_LOCK,
> +                                           FGP_CREAT | FGP_LOCK |
> +                                           (nowait ? FGP_NOWAIT : 0),
>                                             mapping_gfp_mask(vi->i_mappin=
g));
>                 if (IS_ERR(folio)) {
> -                       err =3D -ENOMEM;
> +                       err =3D nowait ? -EAGAIN : -ENOMEM;
>                         goto err_out;
>                 }
>
> @@ -4933,18 +4948,44 @@ static int ntfs_resident_attr_resize(struct ntfs_=
inode *attr_ni, const s64 newsi
>                 if (a->type =3D=3D AT_DATA && !value_len)
>                         continue;
>
> -               if (a->type =3D=3D AT_DATA)
> +               if (a->type =3D=3D AT_DATA && !a->name_length) {
>                         tvi =3D ntfs_iget(sb, base_ni->mft_no);
> -               else
> -                       tvi =3D ntfs_attr_iget(VFS_I(base_ni), a->type,
> -                               (__le16 *)((u8 *)a + le16_to_cpu(a->name_=
offset)),
> -                               a->name_length);
> +               } else {
> +                       __le16 *name =3D (__le16 *)((u8 *)a +
> +                                       le16_to_cpu(a->name_offset));
> +
> +                       /*
> +                        * A named $DATA stream is converted only if nobo=
dy has
> +                        * it open: an open one can be unlinked, being re=
moved
> +                        * or in use. Its file must not be going away eit=
her.
> +                        */
> +                       if (a->type =3D=3D AT_DATA) {
> +                               if (NInoBeingDeleted(base_ni) ||
> +                                   !VFS_I(base_ni)->i_nlink)
> +                                       continue;
> +                               tvi =3D ntfs_attr_ilookup(VFS_I(base_ni),=
 a->type,
> +                                               name, a->name_length);
> +                               if (tvi) {
> +                                       iput(tvi);
> +                                       continue;
> +                               }
> +                       }
> +                       tvi =3D ntfs_attr_iget(VFS_I(base_ni), a->type, n=
ame,
> +                                       a->name_length);
> +                       /* the lookup ignores case for streams, ours does=
 not */
> +                       if (!IS_ERR(tvi) && a->type =3D=3D AT_DATA &&
> +                           memcmp(NTFS_I(tvi)->name, name,
> +                                  a->name_length * sizeof(__le16))) {
> +                               iput(tvi);
> +                               continue;
> +                       }
> +               }
>                 if (IS_ERR(tvi)) {
>                         ntfs_error(sb, "Couldn't open attribute");
>                         continue;
>                 }
>
> -               if (ntfs_attr_make_non_resident(NTFS_I(tvi), value_len)) =
{
> +               if (__ntfs_attr_make_non_resident(NTFS_I(tvi), value_len,=
 true)) {
Can you check Sashiko's review comments?

https://sashiko.dev/#/patchset/20261108080323.468892-1-wahidzk0091%40gmail.=
com

Thanks.
