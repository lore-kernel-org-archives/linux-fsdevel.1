Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99EB3D6CB6
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992065; cv=none; b=nvuqUgOPQtK1B8ggGNexklc1gcDyxwpmvvZhpAyJsvjrYb+J60uQLs97FPsYfN0Psd+aDW6JXL8Zb+neeg4YHyvACxzJrF3RNo6NWQyLewQ9x/OmwSpRZKXGzE++IaMcgzFmgo52vHiSgbB4XGFxpW6GO2B1hXifxgAeCdGUsz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992065; c=relaxed/simple;
	bh=UkK7Mei584GUU91pk3duuvFcu9KfF47mi2kekK2DR7w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oKZRN3BA1TvvFnidgNpKLOqnWlB69s1qxqY6FVaJuFwESYqncw1ESqAzaePFlHdLVBOExj5c6ZdAJFchtE1Xg83DaLRkm5HEpobikriTng38dlbmPdlNwN5CQTKJzUmBP+uZ6k/Qs26UZJsE3rY75KiNVmOd2orD7ZBv4tD99T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=f+JmRWQF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vuB4+CQd; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="f+JmRWQF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vuB4+CQd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C95191D00091;
	Wed,  9 Sep 2026 18:14:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 18:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1788992062; x=1789078462; bh=NkiVDIyQrBvmrF3ZbGvXusv8aBbs11ZMyvB
	etnZiCMw=; b=f+JmRWQFrFzcDGRGPFIOD5QdDuxvU7NL7b43ClKgDWxbqHGF3z1
	QkSd+jWEUn7kTdEpVPhHTV66ArD34iE1bvpg8n+vTMUUsdI+YHWt47/5KY+VvKjx
	A36SatRnGLCEtcks0zlKo1Qy/WdiJRaozkHvx5jzkalNbkeHxOiVageAlkLh0sF+
	VmTBmXivsj1hFuO7CsvKFjRMaV8q4itKY9erpVJoW+YKZJ2PB7aZ7eVT1ldPBeHE
	JXJRV19Tqht8CIMEGwPGEwiDbo4UK/tdXS7W8RrYXX00JCjhdATp9U3zYRbFbcU9
	4MKkUVBOi383rKzhsx0j6Z6ZuZoJT6nOJew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788992062; x=
	1789078462; bh=NkiVDIyQrBvmrF3ZbGvXusv8aBbs11ZMyvBetnZiCMw=; b=v
	uB4+CQdwbhxNI4bRaKzANscEdgjPlph4w5iFHx7+4yBvRMuqpx6/Mz7L2dhvdS90
	SwzbMbktWRSRV7li99ZbTmI85cSlFUYn43Dche2Q0PazfWZlOEUn2/zABmCmNzmc
	Fre1OQFouGNabMbM7QPlJgFGX5sm3hIHRM+OGYX2ERDN/vgjoAXqQ2+PXK+N0UfQ
	0T2EbiLE3wplyjSFTb+Ix+oz3GpGc8suQYuEx0NnTWwzGapYRr3xCQBm45gafkYo
	4MTTl0IRNLf9HmWkClu8REIwU3ugxd7ydmrxCZSgQ8WAkoyBhDlYrMHa/eiLRa0o
	OSZSbE3OjpYAW1B/4YpcA==
X-ME-Sender: <xms:PtqhanPwkYwSAxTm1KXBIGW--a9FCfdY2d2HjuQ0DxXeSyLtm91SXg>
    <xme:Ptqhan8qMTW0-FmBVYvzlCoBUCGvdBt_qef9B5ezw1s_8_qKcu5RBsRLORRvFNIk3
    C-HvqzFbvRndNsj-DflL2vyJUULRSsFjiXqU5Py2TunGnEHZA>
X-ME-Received: <xmr:PtqhahGb8bQaMwH1PUlFGtM7F-o_pyCbjLCGHyxhxckg67-_5avPXyt94I2YcjwycxEJn4hwE0CFmpNSNKZUe65MSVu5bLU>
X-ME-Proxy-Cause: dmFkZTEH2XqQVLDuJmWbX5wTFPgaN3RgOTYLzkI1Pg4zcqCerWPFk8aa2ZDThQswSH53cZ
    GjBLaZwfNL7T24TN/hqXQF6gLr/mrHVYpzjPYjuY/IBj9Ocg/8EcJ9yqfJEQjDnVGD8DLE
    xQ17ZH3wcxMY7acvbXhdC2WIqvXh12d5/JCYlIGBFP+8T7hMmA18XqkQ6SfugkqIJ2+2Y3
    VMXH03jGOXjxQ0BRsT6u894/dM+kmIGU9QGvArqjBxnhUNHnJS6Q+g++bxzE6kCyD5+Zqy
    5FdFH3pfBpsa0ANcALfONI4x3AN5hso11hqMer8ecP55W6RmaWyqhPEYYtkpO4Xfvc8sGt
    5BU2POc9Q4uMPAEURD7eW8SZqb/yZOXy3YgoUF6XYDZbeKlCOjgCf6k5hD4iyF3bP+3+Yw
    HPP4EBCNCElFXP7JOpInCcnJkItD7eo8HZq6HqktzyM1a/w3JPKl4rjN4axsPOcCKyrnEh
    QMecAFrWshr/S8HI+nFbMhaTAifn6h8F5a0M5mvqsVApw9lB5UirLTG9/YclnMer5pjPQ8
    ZJi2twUdBZ1v1fJ5ud61Ed5yAJOtIqhOsLlyLR1D2zGVG2ICh7dXbd1sgXwO4h0E3iriQs
    GKmbfa8yXYgD8s3yrip88tlp0753wHUvWrIB/429OW7i4zII6vFdxwf/fkCg
X-ME-Proxy: <xmx:PtqhauhcTpAYVX0yOqsEO6qfMVvj5Yv0saa2VMwGMqnNmpv23i-JXA>
    <xmx:PtqhauvAMDjCBe2aHxjPyJH5kHp6PBq29cV8qwFtOWomUFexBonGfQ>
    <xmx:PtqhahvMMb_Mvi7dXZ7Njl1zwKRoTLtLmO8gdLF3HJXrcLwSdfuG0A>
    <xmx:PtqhajFtxq905lvDrfkPq7BlfCFzdvQIuZFSmwA4-kjZalWwsAUOTg>
    <xmx:PtqhatZUJH5WQMzJfe71fIITwhuK5aR3SeqXFq_sw0qQPS6LbsikRt1Z>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 18:14:19 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Oleg Nesterov" <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
 "Jann Horn" <jannh@google.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>, "Xin Zhao" <jackzxcui1989@163.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH RFC v3 05/15] fs: move filp_flush() to other file helpers
In-reply-to: <20260909-work-coredump-unlock-self-v3-5-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
  <20260909-work-coredump-unlock-self-v3-5-04f907687563@kernel.org>
Date: Thu, 10 Sep 2026 08:14:16 +1000
Message-id: <178899205692.207413.14714923974362266730@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 10 Sep 2026, Christian Brauner wrote:
> Various functions will flush and put each file inline the
> way close(2) does in follow-up patches. Drop the static and add a
> prototype next to file_close_fd_locked().

As every caller of fput_close_sync() will be preceded by a call to
filp_flush(), would it not make more sense to hav fput_close_sync() call
filp_flush() itself?  And keep it static.
Less room for error that way.

Thanks,
NeilBrown


>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/internal.h | 1 +
>  fs/open.c     | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/internal.h b/fs/internal.h
> index c658c8a5ebd5..b1ca3320cb21 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -198,6 +198,7 @@ extern struct file *do_file_open_root(const struct path=
 *,
>  extern struct open_how build_open_how(int flags, umode_t mode);
>  extern int build_open_flags(const struct open_how *how, struct open_flags =
*op);
>  struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
> +int filp_flush(struct file *filp, fl_owner_t id);
> =20
>  int do_ftruncate(struct file *file, loff_t length, unsigned int flags);
>  int chmod_common(const struct path *path, umode_t mode);
> diff --git a/fs/open.c b/fs/open.c
> index 6b1c14e684a9..7181665c3af5 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1506,7 +1506,7 @@ SYSCALL_DEFINE2(creat, const char __user *, pathname,=
 umode_t, mode)
>   * "id" is the POSIX thread ID. We use the
>   * files pointer for this..
>   */
> -static int filp_flush(struct file *filp, fl_owner_t id)
> +int filp_flush(struct file *filp, fl_owner_t id)
>  {
>  	int retval =3D 0;
> =20
>=20
> --=20
> 2.53.0
>=20
>=20

