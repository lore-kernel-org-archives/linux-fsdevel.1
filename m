Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A66466B57
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991345; cv=none; b=LFvhS0XJDfUmcGYTEcmqrUjsk/SfxF7ue1QOyQVa/koTUTiCLi9za3tU0J2+1nPX+Q5ozT2Az5xKZ0qIXrTyVEy1VPN8GxFsA06lDIJt5waLonQcYlBtWgZGjmbFVF3ON541Vr6J43RFn6FD0p8AW0OY4X0o30fqX40qQRdqqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991345; c=relaxed/simple;
	bh=0J7aCjBQeJH4hiqH/g0joTSLJGJl2xHMiwNoMN7HndQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=E0wuw1mtdpZTwSfGrBIKn7nN1gEQJQyBkhzC/jYgmdHyNEHRDVrsddYs4vl5PEWi4iDbDHYmI5nXPHIMZEQmjFXG49mn9Wyydc4SernaAe4RK5yvlcun8sAJ47T7fhHqhtpeMded/UkvlG7pSKroZKGJ0f426nY9/Cj6W/FnMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=MLE+WW8t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LyOpTP71; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="MLE+WW8t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LyOpTP71"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E2B0A1D0008D;
	Wed,  9 Sep 2026 18:02:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 18:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1788991337; x=1789077737; bh=CkiRcq0NS9g/U64cz8tbl3MSe35e2yW9xcN
	ea7Lg0kw=; b=MLE+WW8ty4WhBnvTjVVI+dpxm3mWBkrI7zks+n55WAj8GqcSgKc
	IdeyMZ5t2ENx7Dt0BJN6+tMXqV5wrUJOAjO/29hDnCzeanqKTqEc0Y5PGzAwIAii
	uKBFR9TMngaY+lJy1tEOT5dhiekzDDzaldBPhpUHyQtAakYpzx4RN744rvTpuqI0
	fxkljC+sBghPSDP7Qwbd6LyDNME/+5kfre7ap3UNYe3NtUY2vzqcVs0KKGkjpNAV
	dOTT2jHeGW18zQ7uhiZxyCicafFNsqEtcySaNnvTILBC6zLosuvKDy0lqSfhmSsb
	aVqj6bnGF/FimxEB/yyCz/luK/UVw8VAvgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788991337; x=
	1789077737; bh=CkiRcq0NS9g/U64cz8tbl3MSe35e2yW9xcNea7Lg0kw=; b=L
	yOpTP71ggZyvPLgpM37c+cl1slduDC+gNODelbo6dFhiyPRbMILF01Wmyc3HUxEc
	dUYuyegq/8f5tuJmhmzxxmIEcwUX8B79p1BWYW8DCS5K5TWmkt738OrlOegLPnQL
	riA7gYAUh40EuK6bl+xnLTs0pLTkOdTT0b6yAGFfFFFakeQbVY47LT2M83cMjuXH
	85ILd+HpOLegpWQGaLvlLhVilNwkwreebwxs7zm71t1L5UUPu97Tp0wZWQzqJkBY
	H5Zo3rlNXOHVu9YQ2A/sNt4kzqkpaAQCI2AeIQF4N0z6A3/+3XaAUnbzCujahYx9
	NxuZ+Y3t4xEyfozFl/CVQ==
X-ME-Sender: <xms:adehavN0YbfST6fEqyGd3yoWbVJPqMTlL6mncStgziFp7lwmaQ0mWQ>
    <xme:adehav-Ulwa6g2umscpV8p-ykv2J7keK7-SeTIqVFeLOK-EQ8k_zpMiRXj7TvLLjy
    Y1EfhPB-cETIlOL5nywQX22xIIqDLfAPSOcjOONG2rJyZMKbw8>
X-ME-Received: <xmr:adehapHzOw91JiizVyI40M1x_NSXqfiO_kllJvK5o08tAolBwBNZdxjOb8yNdtPLj1X64YJSpyc3z7TD3xAi89lF98bG-nA>
X-ME-Proxy-Cause: dmFkZTEXh5SqYZjqqm6H+pDUU8GpQMFNnS/iZ69+zjR7BZfotCoLN1lW33om7F3xk+0z87
    hBn6bACxHlTKSsfz1Nutw9LMPhGADLP+WuC+JDNWVCZ55vJttZpmPNngWGOzwrm1IWpgZg
    9eW+l0rmFzWpTnpDNwGR3X3CdluUXu7QRGvhdlI9pwJx7pt/6yNoA2mXJGI379DXTSD9Gs
    md3UgoFY2eRgkZpSv/YSNZwdtUQS+uhu1JbHv16lU153fs2oE13d8TGHBznvawVsrfWnrT
    1bvsR1exQ6ei5BW5OOX1VceTsqE7w3O2ld59ivUZLo0+yotmJmXS++reNl6j2JEgUcMIIT
    2VgLBhxvRu6mc79WYI/huFM+z44DBboORlN1uTwXiUsLvHIOXeROtUj9p6W55KVptm3vLU
    3DBLtdYN8bhpao+KeK1uVW1/D4BsGf3lStrM+SFGRd0tk+kSVHLKnulpCSiBq0a0TGAlH1
    LgomnmdpjOe8D4vZX+nUXYyUjnPOjZuew0fs/BntQuMbFpVZhVf2mCyXRzWjUKI4BZyQCC
    FpgbvcncDAV0iwM1aVc0fCf2ij3Ef14W4CmaBl+xYRNt+CCVaVGrzUVL5CEC1Xem5Z3sxT
    YlQZrZrGgHlhcZZXnfMQAGv5XVL9uKhn2RiJO8hJC2RUiHDBDeoFgu7ontzg
X-ME-Proxy: <xmx:adehamgLeWMUDzWxo6U_CR947FloAAqQUHbLIG0QIx6bXbMO7df4kQ>
    <xmx:adehamsNJFgFfS8t6IrZ5A9YmydGGOM6HmInRdCqJYc3UJ2WRDaNiw>
    <xmx:adehaptehHb3spr4sEqd0_PhRTJgWh414-0bhmDMiwOYInVwdHKY9g>
    <xmx:adeharHNjfvn3USh2REWkGL0NgfwKAwH2BDTDUiwBJvPIyuijSFY6A>
    <xmx:adehalY1KdT91IbwkZzLy1ZPMtnHE6qH7p-m1925jUNAPgY-IZTUvvpP>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 18:02:13 -0400 (EDT)
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
Subject: Re: [PATCH RFC v3 02/15] fs: add switch_files_struct()
In-reply-to: <20260909-work-coredump-unlock-self-v3-2-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
  <20260909-work-coredump-unlock-self-v3-2-04f907687563@kernel.org>
Date: Thu, 10 Sep 2026 08:02:09 +1000
Message-id: <178899132987.207413.16854456855943273597@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 10 Sep 2026, Christian Brauner wrote:
> Add switch_files_struct() to install another table on a task. It
> consumes the reference to the new table and hands the old one back for
> the caller to put. Convert every place that switches a descriptor table
> except unshare_files().
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/file.c               | 28 ++++++++++++++++------------
>  include/linux/fdtable.h |  2 ++
>  kernel/fork.c           |  6 ++----
>  3 files changed, 20 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/file.c b/fs/file.c
> index 59673547de90..fbc247bd7896 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -515,16 +515,23 @@ void put_files_struct(struct files_struct *files)
>  	}
>  }
> =20
> -void exit_files(struct task_struct *tsk)
> +/* Install @files on @tsk, consuming the reference; returns the old table.=
 */
> +struct files_struct *switch_files_struct(struct task_struct *tsk,
> +					 struct files_struct *files)
>  {
> -	struct files_struct * files =3D tsk->files;
> +	struct files_struct *old;
> =20
> -	if (files) {
> -		task_lock(tsk);
> -		tsk->files =3D NULL;
> -		task_unlock(tsk);
> -		put_files_struct(files);
> -	}
> +	task_lock(tsk);
> +	old =3D tsk->files;
> +	tsk->files =3D files;
> +	task_unlock(tsk);
> +	return old;

   guard(task_lock)(tsk);
   swap(tsk->files, files);
   return files;

???
I saw guard() and swap() in the code you were removing and thought they
were worth preserving :-)

NeilBrown


> +}
> +
> +void exit_files(struct task_struct *tsk)
> +{
> +	if (tsk->files)
> +		put_files_struct(switch_files_struct(tsk, NULL));
>  }
> =20
>  struct files_struct init_files =3D {
> @@ -855,10 +862,7 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigne=
d int, max_fd,
>  		 * We're done closing the files we were supposed to. Time to install
>  		 * the new file descriptor table and drop the old one.
>  		 */
> -		task_lock(me);
> -		me->files =3D cur_fds;
> -		task_unlock(me);
> -		put_files_struct(fds);
> +		put_files_struct(switch_files_struct(me, cur_fds));
>  	}
> =20
>  	return 0;
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index c45306a9f007..0f2edec45de0 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -100,6 +100,8 @@ static inline bool close_on_exec(unsigned int fd, const=
 struct files_struct *fil
>  struct task_struct;
> =20
>  void put_files_struct(struct files_struct *fs);
> +struct files_struct *switch_files_struct(struct task_struct *tsk,
> +					 struct files_struct *files);
>  int unshare_files(void);
>  struct fd_range {
>  	unsigned int from, to;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 416758c8a3d4..b959191edf52 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3320,10 +3320,8 @@ int ksys_unshare(unsigned long unshare_flags)
>  		if (new_fs)
>  			new_fs =3D switch_fs_struct(new_fs);
> =20
> -		if (new_fd) {
> -			guard(task_lock)(current);
> -			swap(current->files, new_fd);
> -		}
> +		if (new_fd)
> +			new_fd =3D switch_files_struct(current, new_fd);
> =20
>  		if (new_cred) {
>  			/* Install the new user namespace */
>=20
> --=20
> 2.53.0
>=20
>=20

