Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564919;
	b=ATvW34ymFS14X72LH6OkGWVK+G583Foce05wect6d8m1MfwVhW5ddRtUeqQKnAWQAchV
	 lvhNh/YuKY1q8lFkIssT5AZYCPL7mF0W+/2JMSX7AOKbDzh0D1CZU5V9gRtSfXWivSZ34
	 9Xr5zG8r5Q5K87YrcIxcZIGi70fZ1iUJeEFR+vYSfCCUf1LsdZ1kHQHWuMUOOERfJ1sz7
	 gSnpm/DWr2PxpwDcJnZPMHdyi0tL+xWQtkX0O/NKo4SvUipszKot4nTIokvnnzfF5Pzpd
	 PI6j8R5LkjJ5p7QGcwfnulGvMUUHh1dri/aKOIjdt/n90vprG8UIqZ86+f1pK9br43w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
	b=M0BNud3+lIGHdTDiVBOcn2zo6jyTp+7nx2PAabKET4ZNXLQDjzK6H2/as51Q6tX1JQO4
	 AAw9M9QDi24wEHn2TCHO/Y9xUMW7U/XBbCVdEc5rU1gbY1oH7ZDQlIrPfm8xjSI9nbOZ3
	 IfawkW0fI/SyIXU3XeXEsjCPjRjYu2cMsJVUx/vpMSqznav7R8efkvGwAY+Y9BAdoYAcy
	 LtfWVcJvLJSzVQxq8nQ8YCQfnKru5YePr43J3Xz0wHADSk+Igf37pvQMbGt+SEHGzgHKH
	 zbm1zZm6p8n10puDb4yaxlOkJZS/Eec7oHZMlhhv4Hd4VSWvMwY43xJGAarD4F05gcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XokUN4uh;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD7D60A2600
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFD7D60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XokUN4uh
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so5469205e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564917; x=1795169717; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
        b=XokUN4uhZ5cnIDNPS9kLjfaPp8ZSmyDY7nHz3ffF9uftFGQzzc0NaUd0CPxl6tmm/G
         EB2bqVZrrrQULKzHfxmMlarOF7+NP4G1EuGLp1x7hwkFzcf5DKQIlYH5+zTWTg0qLXK8
         Q27+pu7matN83z4kFimCCYFY9EtcVBpSYh+f+WbPWczzC82gi2dU1+IxENiNgIvD4ssI
         1POQJndyP8zOY9I/drEtHc8Rir/wcokVwFCL8xkdsULqRcKqvw/m2pftg5e6OYSufYMA
         FPm06vn59Z5lYx4UA2FpKr0UjB0BBdejlJLIE+RKFWt9/d0/clXrD3SuYpmwDbHdW+74
         JQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564917; x=1795169717;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
        b=DKTAYbJcVAfQt5g4Ejcc3rC7ivRR0Z+KnL36waz7lQIi5AwdoBuXj7Wkat29wcxHc6
         1JWwUc3CygmL9glbXmYzNK/yTrbZVCOJsVSfxIs7kQwwIdQe2NS5ityoiqqwq+Qj5wJY
         hZIkgDiKaBljVIItbAPKQB/b/8dB/aw4czetejqFr6WrRLA8lbiO52AW7MvGA68+gDfb
         pTQKnVIetrtk5XGHqF5P8xp0DBkb3LQdW6METaLvFlFQcRSQS10VLWQNwiCSriGfjcZ9
         bplzVIg54UODwxMrMjqJW7mb/M5WE5QB4qDgoAS/qp/vuR9Mvtt201dfnFWyDUTk6fW7
         8/hA==
X-Forwarded-Encrypted: i=1; AL+hErFpf89chTfTVDiyAnHwVPhjjgzu+XbIgBoPg+hGK08/ZNOdmB2hcZsSBUzKPij5azTUwn8QKaEfYB5oLhow@vger.kernel.org
X-Gm-Message-State: APuU4Z8znq0p3gTTrYukODGHRyxEHePhLXtbVNxtur9KyI7kEoIDQyoP
	sNN4LFvH4mYMIttUbiOmMk3rjOyKkgpPFilaV4NpE/uia/IkxMG24xXEErefZeUOfG1X
X-Gm-Gg: AYBFou0ygIGhsYcz7jV/6N3w2+DROKPgyQokWZZmnBhX7iazs9pUQgfS5PletfoiH3e
	roWYLpQ00yOBMMRSo7BXPDFSqiAWR10reDGUuvsbmt4OpvLigIrQHmGheKaweCBoihhWujQwozU
	Rdu8oGdcTN5tc/+BBsR4Rr8GkS4qUTuNTTOccm6j6jrN+z+M9K+v04rssDIkiJCGZBWYZkIWCx5
	b4yJpHbIKxPk0EoRbw5xq8f7M7wP4stmNlqn1jUbk79KiS9qbfLNSD8feR+bhoRjVcJfUHsk3JE
	LacOEY/UghkeQMBsmm/xhx8Ifr/rLGwsANxsIqu+KepMEfKSiA9I5aepwci9osZDTtKm4lASmrv
	ht8/Jr1lddmbbLm8S9hFBXDVjnRrcb8tHv5yR39Yi+T2YoWYtKKPKrqSxR3PaQdUNktx5Hn96FF
	T6x2PVTjIapoNxaysov8fSbHEuWU2p42MfhxYHGjkjskMkR2a60DfJN8fdyvhAihgd2DcbCAFJW
	Lhy9utvEYNFNELJTA/z9tuvoKDJBRthe/SJaFv+FcqlYlfEmc31aXF5jG6lnvsghxUenT8+AtAs
	vOA7htvbwSX3ryzkgQAHNd/BJQ0nKuX4ZNe5aZATUNbDhZgDbXDNqbtJ6LE2P9E=
X-Received: by 2002:a05:600c:4f84:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4bb5599ade1mr43492835e9.0.1794564916955;
        Fri, 13 Nov 2026 02:15:16 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56680ea9sm31982365e9.0.2026.11.13.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:15:16 -0800 (PST)
Message-ID: <e2edfa06d185acd86b46945622b6eb6dff97b307.camel@amutable.com>
Subject: Re: [PATCH RFC 33/41] fs: add file_is_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:15:14 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Add a helper to check whether a file is a regular file on a pseudo
> filesystem. Only regular files count. Device nodes on pseudo
> filesystems
> such as devpts, binderfs or the block devices on bdevfs are what they
> are.
>=20
> Look at the inode that actually provides the data via d_real_inode().
> overlayfs accepts sysfs, cgroup2, debugfs, tracefs, configfs and
> securityfs as lower layers and reads of such an overlayfs file are
> served by the file on the pseudo filesystem. Checking the overlayfs
> inode would miss that.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0include/linux/fs.h | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 99caef43ff3c..407ffb6342ec 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2553,6 +2553,18 @@ static inline const struct inode
> *file_user_inode(const struct file *f)
> =C2=A0	return file_inode(f);
> =C2=A0}
> =C2=A0
> +/*
> + * Regular files on pseudo filesystems are kernel interfaces and
> must not be
> + * used as storage. Look through stacking filesystems at the inode
> that
> + * provides the data.
> + */
> +static inline bool file_is_pseudo(const struct file *file)
> +{
> +	const struct inode *inode =3D d_real_inode(file-
> >f_path.dentry);
> +
> +	return S_ISREG(inode->i_mode) && (inode->i_sb->s_iflags &
> SB_I_PSEUDO);
> +}
> +
> =C2=A0static inline struct file *file_clone_open(struct file *file)
> =C2=A0{
> =C2=A0	return dentry_open(&file->f_path, file->f_flags, file-
> >f_cred);
