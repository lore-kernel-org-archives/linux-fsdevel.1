Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D4212D86;
	Mon,  1 Jun 2026 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780281290; cv=none; b=eQq2qQ/cGgwF2Q6AU+o10wTq7Evi25LeTcZpcs3CnVeHvh7ItK6KDx30Jz+tOZTJMuEC/k9drakwx7rEb6CYaJQ8ENzyJ9t/8ODOwcttm9jPdoxDXgiHP7SJPq2vyH2qtHV7JBrl2YdCq+8V5KuC9smYke+wbvWVQ6Ts7b/kqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780281290; c=relaxed/simple;
	bh=JC52Mp/gQWdBWmMv3Le4kTDOvcoMA7USWUX0tZ8B7ok=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Pe3QpP4q1spoqV0x4N31MyjIHe7dai1pkcR1o5AoC38is5ppfZoa9Ug3ZSqXXpBPsB6t+akngvHvpzEHNoPEulc4YF/KPJJG0NdIdwnegYs+8rGeX/FiH4E+7ZB8cB7zIux3RqMo+yOgEwnojKFF1JIXX6jTsIYpfIuU2+0KE88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Txq89YvV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eNuD0mS1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Txq89YvV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eNuD0mS1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B9E97A01AB;
	Sun, 31 May 2026 22:34:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 31 May 2026 22:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1780281286; x=1780367686; bh=pErd6CGPCYHnA39ZPy1QgUnBtI0eozkrTcN
	3ipukNYA=; b=Txq89YvVDCZRe4ZCPsnVyj45AzpsyGD+cBDbYzaAw84jNblTDuG
	9YerLQJ6drehM06lqKCm+5T0qQSv+8t4MEmiskVXz4/1GE6svtrhNH8Bu9VoNYeL
	w5Hy41+XULHlGfVmOdOLxspS/XJZiS8WWqrhdCUoI4UQZ722iub2v0SV0PmwaUv8
	iHXGyAfNlIEN+K32NH+Z8pAx2s0iQ4HrqNLHBNulzaFt5JnN7wUz8tygVfpMpGPx
	7jnZPV5RBoRiE7ypkU7Ke4RgXlTUWX4pxMe3+MFH32/P2OPU0Pq/8uQKJRjJaP5P
	X5jszEI2SiyKq+EG8iKw6hbEGwn6zmTfkMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780281286; x=
	1780367686; bh=pErd6CGPCYHnA39ZPy1QgUnBtI0eozkrTcN3ipukNYA=; b=e
	NuD0mS1oAGr1mgjdktwny1pVyBz1rU6C15JTudebdZHZVmFv8p7fW59yCjQxlF8K
	k5WiCy3VX4j09yGSdiaacFwSAn5CpC9KAeLxUQ5HOtNS4isXPctsLVYaPjkXdQPi
	XnacG7m/CUaVb9dGxMUckMFT4bV9y1xCzEhfkVXd6KgyhYD3CtWPuBXXOnOHN8W+
	T3XM2Cjz1pizkhZJARQLe/msEU00ZvSsgTKddXrmOU5SSNrtsKScdXjsJlSZjI9s
	VcZfxxZ0DqzDNfr8NSjP88dZJdIoPZ5xK1GAdcsEw5YuG9MFrBwhXc1LI1NdKifd
	0Q8cVTeSOZOgn3574SxIA==
X-ME-Sender: <xms:xu8cau3-EkTpsIR0Dn5W1TaNGh-yUdy9Qu7-a-vbakJ2eiJOB71rNg>
    <xme:xu8capSJDVhz-ounx6wWwLTkt-DYa7SbKqv2uPs6_v08XyxJiedOfihCOQxOegDks
    Lytk5KoHiIp7_d5wTm4OQW_-OWW0b38N7qToX3TAEi05_cptQ>
X-ME-Received: <xmr:xu8caidOSV1q0Ik_N8ewEfkpRyiy0Rz9yQvRcLk7itSkzDvLUB7rGmRpk9MWGtRjBg>
X-ME-Proxy-Cause: dmFkZTFkwrSGRPs7eL8WcEJOFlDdH7SQtmmJ2Jfsi4I+cf9xDYxOTP2GwON5ToDtOCLSs3
    M8Bi+e4SLcwDW9/KMScbCOmVm4dzep6A91EXs024MrG2UUje+ig+PXJoYoDCtNBGbjmUVl
    CucsL6bFOdCMf9zll44T65CsvDIFK8j2T7E9CXlXFRIewejJg8dodfDuVgUp0CHrU0msG3
    FaYctF3/8VfJ5uf3nNwLkZryeJAahwIiEHbaC05XascPguC/IXPfICGPpZSq80MU17soAo
    8jnPJrtGz88ReX5VAi4gpcyofhOAc3S4KHemKrKpcX7K6ZvPP7cuEV5t/gBxpebk8kldWj
    AKKwJeT9VdhlGQuclwJ89dwmDnda3KSlb1PXuxrAui7o7ujEcePbLO6Jxp3uAS2RZN51Ql
    3bJdW5T08CbQo6hqvXW7PhZLz4de/SvOlc/a+pljnpSLJMKySASx9hjXhcJXaFQKfrf44P
    2Cs3PS98/A9LQRWrwrwnyK6ncRawt+m25b5YGBV1yHfhzQy7PB73IKj07K35VQaJqif6O7
    DQv/ICMToMbpu2BiApM3I+P60TWyx6OzVa/KMz2aImXNePpG+q2Y8COxXELiq7KlwvJkUg
    r5rSlKyum1kiLwHeFDnvbXoTUzvPIJhKeKxNjZx2s/nZ0yBHB4G45OQ+s/gA
X-ME-Proxy: <xmx:xu8caqfW2dSw2oH7JsIciNP-ehYyneqOdqgPREgtTxTEuWu0herzaQ>
    <xmx:xu8cas2y3ALdLhpHHowfJiWfBi9nahirMv9iiBaF_fWwe7QTiKYpQA>
    <xmx:xu8cai8ifRJ23b4a1x9o07hF16xjcEH8mmMXJtOlrinNRkxxMlyVyA>
    <xmx:xu8cah7jHGFFU2a4RHXubEAlP5az0EqX-3I8zU6VIxbDCo-Y4w1Srw>
    <xmx:xu8cam8BIOE7nKLm4W_GTtPgt3vCs5ce__0sttOLqD2t1Ge7PdVpLG7w>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 22:34:43 -0400 (EDT)
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
Subject: Re: [RFC PATCH v6 4/9] vfs: lookup_open(): move setting FMODE_CREATED
 up when calling create()
In-reply-to: <20260531182045.171711-5-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
  <20260531182045.171711-5-jkoolstra@xs4all.nl>
Date: Mon, 01 Jun 2026 12:34:40 +1000
Message-id: <178028128000.2923901.7917758563328454041@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 01 Jun 2026, Jori Koolstra wrote:
> In preparation for using vfs_create_no_perm() in lookup_open() we need
> to move setting FMODE_CREATED on the file mode to either before or after
> that call, as currently it is in the middle. If try_break_deleg() fails
> it is currently not set, but vfs_create_no_perm() includes a
> try_break_deleg().
>=20
> Going up the call chain of lookup_open() we see that it is only used in
> open_last_lookups() if no error is returned from lookup_open(), so we
> can safely move it to after the filesystem create() call. This also
> makes more sense when reading the code as you don't have to wonder what
> the implications are of setting FMODE_CREATED before the create() call.

It seemed a bit odd to me that we set FMODE_CREATED before actually
creating.
It doesn't matter as FMODE_CREATED is only meaningful if no error has
been reported, and if create doesn't end up happening, then there must
be an error.

So I like this improvement.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 2a35dd72ee96..16dcf537db87 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4531,7 +4531,6 @@ static struct dentry *lookup_open(struct nameidata *n=
d, struct file *file,
>  		if (error)
>  			goto out_dput;
> =20
> -		file->f_mode |=3D FMODE_CREATED;
>  		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
>  		if (!dir_inode->i_op->create) {
>  			error =3D -EACCES;
> @@ -4544,6 +4543,7 @@ static struct dentry *lookup_open(struct nameidata *n=
d, struct file *file,
>  			goto out_dput;
> =20
>  		fsnotify_create(dir_inode, dentry);
> +		file->f_mode |=3D FMODE_CREATED;
>  	}
> =20
>  	return dentry;
> --=20
> 2.54.0
>=20
>=20

