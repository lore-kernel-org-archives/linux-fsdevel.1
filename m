Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794926135;
	b=yBzZ9GmrT80V6mQoNZCeKKzR19JFxREKkBJxjKo1vGeHHChayuUt7966lCfWB8vJGTkL
	 j3u40cg5pD5NqfpUYwaesovrdLD77L69MqX/gQtGN9hyRSaUn7bbdttyANwUVWo9mc+MV
	 rdA8Zrt1wM1YtKTub8a0iNw4E5idBS1O698XNTRJ/MHWLw9HzRfFmpGxTcloW7NxaHeFA
	 FYM8PXXRiYsVhY3Qcnt1y0B4tiL1Uxp9usLFPzCNyvO9/Tewt+NpCF1Iw3cVIktc8pJEO
	 ftqqxX0YAV/jSZ9DeGJUc6rZesa2x5PCwhSiZrIhbgljVCJv3W9Q+CGc4dT73RqMKFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z8Nm8FHzKmIfnRj5B6yPP5eTVD3vNbmx6rL+eezv180=;
	b=pvhsVyYAbh6QSq7bCOuhqD825TmCDHj1rZivF5o4XAutl7zZ0qOmrjldlMsbqWGR1cmN
	 EWMn3QffOAd5m/oDeLldYZjNRPVc5TCz1Gq3Jh9I/7fO6RrIT1f4+xwPN1Ws8uQ46M03G
	 6PKejkE3wQQUwQqo5RqVLygEWQQ50RzBb0lev1cScjyuDsOaPmyJn/Y6EgrCmqKrjFpM8
	 xdqwqVkqjZTaUfMvNJSHOUZaJVyAbsvx4PWqO0yACJT5M57Jq7+6QFqDpSA0paQUjoynU
	 1SWuXdH8xQoMsCfyxoIhic8WurYX4yEWSwTnzjqPzHbYJ9n2XtKyBMp9Si05r1do9hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URmfsKnN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977ED606A88B
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 977ED606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URmfsKnN
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso725324a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:35:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794926134; cv=none;
        d=google.com; s=arc-20260327;
        b=DRH6BhJwXCX9hyKLR5fPCYtXugn7cfvtoy48HHohy9LioZR03w0tFGuWCim0cfUEbg
         l8iCWjIEwHQjcBcBWrj63QgHaxpaKZgKn/83eWS8E7Kt/2wxUopEL9II2b1qEe1QOEsq
         ZxNlSa7oH5TNmoLf80wXBttaz0b2zjaARPYZ48Q+zeD+rgnoii5hvGhmb8DxUFEWcrtx
         LqWPSTDRn5RpivyF7ey1B81mpj/F2j8Ta/ZqBnNQlfb1MYr/emBRc3Zt2PEYZi68GTbD
         eIzbHkuC+COUH9N96lc4hrBcXytcudN2n96Ln2zAAcD5VtkChg35BBsfUNUPdUZQatS9
         L6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z8Nm8FHzKmIfnRj5B6yPP5eTVD3vNbmx6rL+eezv180=;
        fh=g/O+DDzxojmeXidacHG+QmREwowF2QblWsD85w0zC8A=;
        b=c5XUBdiGAYY/SW6PoQn0tad0usT+uPScXgLHjxBVkP/66T8ST6YHqQfMzK0ohS5zev
         HidlnppA58TKLBUn5qHFKf9XxozJpB53amWx9vLxnQhCAVXAdvUPHoSzff9xXe4E1TRd
         HObu8iBZilK3xSxKGY7fbsI49AaaRtotIynap0pJYuqtWDvyAnxdzc8Ue1I8pqDN+9uT
         zA9CLhP+c0JKZphj0ApbxXAMb3qiCUx02Y5jDHkKsY0pAFc/aGVIF0L0beLSNqfoDk/9
         mQzj45WyfujU4hriS38f6Jjx/JPCqtcJg+mS1Z06m8BKmjukdyt4O0yAeZ37j7UWa3I2
         VPLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794926134; x=1795530934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z8Nm8FHzKmIfnRj5B6yPP5eTVD3vNbmx6rL+eezv180=;
        b=URmfsKnNWJSODYZrfj3c/NpMWLpE9pLm6rNI2X3ysZ7qIqhaoJiC5GieCaPi82mGtn
         cmALgIGRweZqbcX/4nSU9t5Sd7yGAyeSwUC00OBDXLEMsXK09GQO8t4Zo29ULjvYi6Al
         HK6l+S+GA+7vyo/WpBUEBAjaR3tv2GRNzV7JewrMFxQAevi0dZe9mFKoopmgsdpdOVGU
         BnOFpK0SUSQoJLXkIya5t79OX3bvHHrYXeIbSXVVmE8Dm5fXT2Z3W+RyHevDV30pL6oY
         ZhwD+uuaXvPO8SrEnbM11zfysNQhVTeKAJQ3IsfySXy0eu306VggRaS6EYvoJLP0BY6B
         sIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794926134; x=1795530934;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8Nm8FHzKmIfnRj5B6yPP5eTVD3vNbmx6rL+eezv180=;
        b=LQaPVau6Iw0CuTNP3C2nyTsX7D4Cj/RVo0+e9GYnE3AMixAIi/pL9U2nAt7Wu4bi+8
         AnJX9nGPZF41LPL7iC4yqqu6jWN0hTXh8sEDOgxw/9L4GAtlMqr8mMjwEZ8gAzWbqo4h
         peCgznYpCnHlsgmLvlH8qLxbgVN0/zbg9g+Ig+GHEk3+1bQZbH/Io/JCt6WcCfv4MGl4
         QSJUchsO/1dp+lIlba2+4gxzQXq8glSvY+zzyGFxo6mqPOA6qL7CCxk1jgxkkYDvuomL
         swBZWbdSZIc+kwS5E2IlpJgtckB9QoEwca8OP6nIos3MaKqbXdqFZviL0KRsgh7iCOui
         6bvw==
X-Forwarded-Encrypted: i=1; AL+hErFXQPjtH6wlMaUjxjy8VMiTmdxDRq75MXQW3k1VBOfEArwpYaHvx6uDf7Dyxrjnbm7ubKgzOCei6P9YFsZ0@vger.kernel.org
X-Gm-Message-State: APuU4Z/SEkyQi96xgCH97YagBAEFofWqJyc7TlXVKt7yr/ccytuhIk8B
	MWn0bsFypcJaMcP/cxmMP+FAyxin2yz3AwxeA2RcUB+xKezvbg/v0x2p++4fNnpBWKhdYnSzDnI
	dIwt4VzoUREhCAWWZbV819+hKhp3/bzM=
X-Gm-Gg: AYBFou2Mso9hMFlmkEAmnKxzCfCsN+dw0ad4Vzv29dddUB8pJ0KRScEs4WvXXudDb+B
	hhr8hfMJLjpzisAH0oECjFpoexQcMXEbiLM4lI3o5PqkbZvsKlp4s0sjlhqTpMemhQNztmexkDq
	Dsv+l6bgTWjxpVNqs2yJR4R3TtyVnmdY2m9ruTdhzMqLpzbNjrH5luIdt+idWNFDXHG/c45qeLk
	XvG3inWaAsn5SNbb+QNSpbkL5ZPduhi8K+zfaH/mpu1Gt0xrkIPds9H/gkrbG19RFtkt2IlWqGz
	QaQ6iCGMlkAa/p27mjmah9pWrVUrCBnecs6wGrkJUT1ahhb/WJyR4FR5zU69h9k11iDdYsgPD2W
	3cZIy7EkR9uCn40ZV9s4vO9+mCIuod5TIx+OpcUEQNOpCJZHdmrRrWCxlfmjqtHivaY4U9vXkaw
	E/31oqTHiVoUvNupE=
X-Received: by 2002:a05:6402:2b91:b0:6b4:1eed:b9f2 with SMTP id
 4fb4d7f45d1cf-6b859739689mr2260195a12.10.1794926133831; Tue, 17 Nov 2026
 06:35:33 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com> <20261117135146.3174252-2-graypanda.inzag@gmail.com>
In-Reply-To: <20261117135146.3174252-2-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Nov 2026 15:35:22 +0100
X-Gm-Features: AclHuK8C4CURJWV2PAqKHkl0J2MOz_Ngu3IxgsUB1ZW-CuNtY3L1YeTqpgF395s
Message-ID: <CAOQ4uxjMNxS-jtBt7w4nwJpMQXFraec2UFDRoiXoQqs9eoq2gw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fuse: skip dcache instantiation for readdirplus
 names with embedded NUL
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 2:52=E2=80=AFPM Junyoung Jang <graypanda.inzag@gmai=
l.com> wrote:
>
> FUSE READDIRPLUS can pass a length-bearing qstr with an embedded NUL to
> d_splice_alias().  Unlike verify_dirent_name() in fs/readdir.c, this
> path can create a dentry whose d_name.len extends past the NUL.
>
> For such a name, strscpy() in inotify_handle_inode_event() and the
> fanotify name-copy helpers stop early.  The kmalloc() and kvmalloc()
> event-name buffers retain uninitialized bytes within the recorded name
> length, which copy_event_to_user() and copy_fid_info_to_user() can expose=
.
>
> Some FUSE servers include a terminating NUL in namelen.  Follow
> nfs_prime_dcache() in commit 78d04af4995a1 ("NFS: nfs_prime_dcache must
> validate the filename") by skipping dcache instantiation without
> failing getdents().  Return -EIO from fuse_direntplus_link() so
> parse_dirplusfile() sends FUSE_FORGET for the unused lookup reference
> and continues readdir.
>
> Fixes: 0b05b18381ee ("fuse: implement NFS-like readdirplus support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes in v2:
> - Keep FUSE READDIR and READDIRPLUS getdents() behavior unchanged.
> - Skip dcache instantiation only in fuse_direntplus_link(), following
>   Amir Goldstein's NFS precedent; forget the unused lookup reference.
>
>  fs/fuse/readdir.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 1f6cf565477f..6b2468b575d9 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -191,6 +191,8 @@ static int fuse_direntplus_link(struct file *file,
>                 return -EIO;
>         if (fuse_invalid_attr(&o->attr))
>                 return -EIO;
> +       if (memchr(name.name, '\0', name.len))
> +               return -EIO;
>
>         fc =3D get_fuse_conn(dir);
>         epoch =3D atomic_read(&fc->epoch);
