Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA013B8D5C;
	Mon, 14 Sep 2026 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429283; cv=none; b=dB9Jevy107feOxg6hGmHPssCxdCVQRljqkd7T/IbV1ZFfcmLYOAb/I+xC3ShmD9aLc8SkgiUvAdPpFn+usYk8AI7ryfs1t7dwG2RSln4jGrvRJ+WCdU1ufGGq/JZGb5P8dshTrRbiMp3afnLzPdEwtNkYfc7tznlHbueQ/zpcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429283; c=relaxed/simple;
	bh=ldLIC9PLx84Iio5D6KygoEfhgB4B7q9k56a/4V8IiMg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aNY6sXnvvbBBqs5OFyBw7tCga9BLJr8DkIE25HuNRjUYBi2OnPMk46EG7pu58NZpcIT0+M7fcaNbA+oZMlQc7l93VrVPrTbXW1w/MR4EIBXC1z6QC/uhBxUNgUb6S7d2drHjaVVd6H6Y6JWYYw4KLJXyGRqzH4W6xRBzmF3ZIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Vyo6KM3X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lYA17SpC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Vyo6KM3X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lYA17SpC"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E6D8B7A0101;
	Mon, 14 Sep 2026 19:41:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 14 Sep 2026 19:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789429274; x=1789515674; bh=Du6YtYnd/w6uKCQVlaLgeQqqw0haiKlnwIJ
	ANr+/fyg=; b=Vyo6KM3XAb12CQdtU7ZX74uCYiu/pdydLEWDYaJh1m1SoCUMWeP
	flkmU8n2S7J3UDJmFuPK2FDLtg2RyC0GDSzvawZYA93qW8icFjtzgWICzRLWiWW2
	eWIUTA2gO1vUZ6ZLEu1cRcPgk+tvKbvluR+s/IM+s3zsg5wn8s39J4Km+x/WZlCP
	+78lf1CYv3a23GwxFJ1UBNpQP+HW9ABBT1u9OyQ7hxhWzYDs+OVEUAugsqvgP/zx
	SV8hLp+JPzIxSoc03kFmX4BTI9O58Z6to61kUlRAe6oY9RqS+ru0hFun9XJtflmc
	+STlQocjgEUDGKQ1c2xfjmNRnc0P7PV5myg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789429274; x=
	1789515674; bh=Du6YtYnd/w6uKCQVlaLgeQqqw0haiKlnwIJANr+/fyg=; b=l
	YA17SpCkWBEYGC/H3B+fEa9oh4NGT4X9hjvyDQNOXDkeXY/J9azB+whKGdSFJvOv
	TLQXgYgcsqjkIH3hPXHUJ/uonS1oufU4hz5d8fpxlwjjeyc0LZyIyD2K1VB57ItY
	S99IErsMy4jjQ59SZSCYhW6OvBsRpn9dlfiZ35TECH0/KKH1KXNeSroSU2iSSD5w
	ReJ6jXapyQGq/8zh/JU5xwLTd/k3F+KL7DTi2AfRjC5ElUD7VQ99+DktjdWNTNmh
	jEesOVpJsxDKh4Fz++6NNuTTJlJBE1UiEZjV6owHnU4tLj9dHHP3XMEB1h5NvGwJ
	iwbKjGixcYHcRnZXNvlVA==
X-ME-Sender: <xms:GoaoaqFKKT7cXRfuB0vIXcNhjcW5Ue222O3pnHMxf8mnn8L38a3-Xg>
    <xme:Goaoatlw2_lHgg2XLhgnlKcShavWjwa1Bp9blUhb-ZV6quBeRgMXoe8e6JITodVQR
    Z_lP_9XiB8nopLEL0iiiwxmHN_abl3ieyBo5jNGxUxnCw4cHOA>
X-ME-Received: <xmr:GoaoambeIauqeeqFFLZIgJFfJe4sOPPyb7fZ-FK-V8p6wmDb3rjZau5JsEk6Qla8L79nPMUUnDiu5adCI3D8PQmf4gysrQQ>
X-ME-Proxy-Cause: dmFkZTGSrU8YE2+ca+nm9+sgcNX54zkCP2VqB6GhrlxbfqRYaToullAsHIKHO1Z4Am5IKj
    BZ7Go4ui0prXUXWyhqoDFYOq/KPdwnUj0ixWp95a8rrsQbG8MfcBEW6GM0Vh2AFaeNG39d
    9MqVnVsTxmkXrFWx9qGd5vUdRKHRH0Dxbp43YcO/hv9rLURWWM+1fvDrB3nfXdw84zOv0P
    FVNlI5tccPpqZlJCmW4yGkTBVX3eguxJIVEQgMHCULTpkaKF2JilkYIBtH0H7ABHBXDb2n
    CEjKE2fhFuuUULt01gAvqtOnr8WWIiksfN4JtbXppz4Su+JDoyYGMgDWA5oAPYgy19kFo+
    6SMYb9BwPW3fPUp4Fi5qG8BCg0P2hW1afoVaZi6PnN4y4yjZGMLEJb14xpzx2AKKHIwrG3
    tPeqMgfPXpg1IX17oLNqYIgRcXt0CfOm2lLez7AqNoV+TGMIEpt8DMAaL+RnjPlRK0F7wG
    NbCpVEbRW23VV+287V7Hd1vPTZh2HrVghzTeeNTSyBf3PL6D8K47tYe2noU84LeuuR6xxx
    VQJye+w2V8gNdGmNaM3HCPEMcvLhP07imAGGmFvqhf0tTyPdzXFmRjM1QjxJeqFXh8pYn6
    mja0umXb4OA3+3Vj5m+PDdyfleWHrcDhCe1aTLiqU3Z2CQkcZT0jACjgLZlg
X-ME-Proxy: <xmx:GoaoaqHD8lPEWNdKzLUPK-ZWswM08JO0bEhbj0uPqv5OJ6NlEDVyMA>
    <xmx:GoaoavLFQBgJS1RYwH38tCgBaiTbQi1o4rHjiFICg4Zv9sCSK_JNiQ>
    <xmx:GoaoatMT0S7xrPK7RHnlAKpGcOhs0o6R5AgFpTyXeXHsl7t2UJbucA>
    <xmx:GoaoanleM3uyqhuPpdJbDDPtN-wtAJlBVSZH9Z6oAGG-TL5bwsUx4w>
    <xmx:Goaoaq90mr6I8wNfGpD-egCpHsdSgjTwe8JUZmwKBVtmi-Vb-ULZ4tAK>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 19:41:12 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Mateusz Guzik" <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Mateusz Guzik" <mjguzik@gmail.com>
Subject: Re: [PATCH 01/10] fs: unexport backing_file_set_user_path() and make
 it take the ref on its own
In-reply-to: <20260913144918.1606123-2-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
  <20260913144918.1606123-2-mjguzik@gmail.com>
Date: Tue, 15 Sep 2026 09:41:10 +1000
Message-id: <178942927008.207413.8922017151367199344@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 14 Sep 2026, Mateusz Guzik wrote:
> Prep for path_* API changes, which will force the ref change.
>=20
> There are likely no users outside of the tree, but should there be some they
> will no longer be caught by surprise.

It is encouraged to update Documentation/filesystems/porting.rst which
making externally visible changed to the VFS api.

It really looks like backing_file_set_user_path() should never have been
exported, and your change is a clear win.

Thanks,
NeilBrown


>=20
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/backing-file.c | 2 --
>  fs/file_table.c   | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index cc101143f921..e92410a27982 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -43,7 +43,6 @@ struct file *backing_file_open(const struct file *user_fi=
le, int flags,
>  	if (IS_ERR(f))
>  		return f;
> =20
> -	path_get(user_path);
>  	backing_file_set_user_path(f, user_path);
>  	error =3D vfs_open(real_path, f);
>  	if (error) {
> @@ -68,7 +67,6 @@ struct file *backing_tmpfile_open(const struct file *user=
_file, int flags,
>  	if (IS_ERR(f))
>  		return f;
> =20
> -	path_get(user_path);
>  	backing_file_set_user_path(f, user_path);
>  	error =3D vfs_tmpfile(real_idmap, real_parentpath, f, mode);
>  	if (error) {
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 8dcd213c0251..f9d1b5edd6ae 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -71,8 +71,8 @@ EXPORT_SYMBOL_GPL(backing_file_user_path);
>  void backing_file_set_user_path(struct file *f, const struct path *path)
>  {
>  	backing_file(f)->user_path =3D *path;
> +	path_get(path);
>  }
> -EXPORT_SYMBOL_GPL(backing_file_set_user_path);
> =20
>  #ifdef CONFIG_SECURITY
>  void *backing_file_security(const struct file *f)
> --=20
> 2.53.0
>=20
>=20
>=20

