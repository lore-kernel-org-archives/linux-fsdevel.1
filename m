Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9503F54B4
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161939; cv=pass; b=NNll1uuV5NbTvXiywrDotB+NMDeyIMqU5DYsgDMdfgzx1TA0Do6ujJABaS5/Mq0DnjYVWtVb2eJi0kP4Qxzo+yiLIXXeCcgt1QKCTnYAvpLNJNAjgbrpqYBevzZcwxqbVU2yjLBs6e6Xqf+Xz3LTAS/YFhnt19NnwL/rGsqNFYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161939; c=relaxed/simple;
	bh=N+/6BGtSqy+rDxrhfNX9GC1VVT97qBJY8f2fbuDOAFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPTfC57Qv1X2W3i9caXSU0cFY5e5ENU9WARxUqaIPCQbaYXgkYYf2REV+RuZPEEk6KkOKp6o22PxcZ3JfQwBstEhwkCKw8hJE9aVnzd8ZVzYTTMHEdJpxUzq6IHUSAshy1KZleihXjOmGfstFXq/CzMKqWu6lUhw6OfZu29mmDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYXosJ60; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYXosJ60"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65c2e7ff1acso112659d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 06:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778161937; cv=none;
        d=google.com; s=arc-20240605;
        b=Bnh6gcCDYUYuZRsdbsltM5UBbp5sZ2kUKZIZSOYxbQBbTk0PRfnXlGhK+2jXuTqtGP
         q1omYsMJrMEmxEeX+NyUEp/MNTQNquMuFEu+J50+1iZZ4hQs/JznJQqZ1SZz330p8KJZ
         Q2TxV7860abNn+eaci7glz/UoFFJfpdMhZgFg3mdZ8vsNWTmc2TJt9nE3Ht8rcOj8blR
         ZSJLHEqS26+UMpsmnqbQoGHA0x/FXvCYycEQ67qsBO/1RiEUPQ0Xym2lM/tHTKtWQmTz
         pywU55D9qJyFwYzBOw+5BbXvoTGqDYqShzV5eqe5HPrGwzOHTGeGJ0PIVmHRJd9qCFBf
         W+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jlJOeuL8AUn3zh4DygdpxRKJ+UZPkBpq8vVzH7H79qQ=;
        fh=YnhMySj9pnmn5GXh8RpDBRo3z3Z6skB0wuWDOQ1LGZ0=;
        b=NImFVlwtvRnH9hpzjqnjz7GT5qMAYeA9ZQSEzVoDAPkmj8LtkJPF1m+m3Rz5zkjfDM
         B21reSxEftKGvrH3O3W7kA1ENCqd0PhPbBkpV6V2PnIo0uFkpPixd5Tsd/+tEScP/K1W
         tOsLiRy9c7neHsEpdZCVeQzEUhdEEG8Cei/bJVCHQDLRK8tgXWwqfsebQtNQSX2NJ8TH
         Zk0RixpbJaUETdDQQRfBvrRL40zOW1OyC7owJ6ql5/DEYPnPNEK1u6JuLiclMZc6dsuD
         71AqUYDaYFeVfyPPagdidKced6XK6QZ7q1B+cnYTg386NDTnBWPA79kHOTvjYLT64QDN
         lU4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161937; x=1778766737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlJOeuL8AUn3zh4DygdpxRKJ+UZPkBpq8vVzH7H79qQ=;
        b=jYXosJ60Q6HDnucLlsj9OOEOTCosW723P0S9vThkf7YcezN2t9B7O0Y+m6mMihjZux
         DRFlZVHBN+64tzTJwjI6ppqUdPfCJe96jo+g7SoqWb4TTYrfiBfUrb5TWn97kysCcX9j
         5K8sckMbLQl02rSy2DeNVy8q6ngKo16r5FEvWM/1t0tNxN2p1lPs0K3tgpSzUiKqZHMV
         wicJJSzTG3oJ9zZCwa1zRhRZy8Hvr5/bbX3Dwla3otTJ/IXEJhn+PDJHqfx2hfILRruU
         gq9QPf3B/nPonQprhnr8W8EWDaVGnVUVUTP17tXR4jbC80qSt5yrgVrxxNGtorSXCTo3
         Gbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161937; x=1778766737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jlJOeuL8AUn3zh4DygdpxRKJ+UZPkBpq8vVzH7H79qQ=;
        b=oOsRHDEVaQd/Dj+0M2lSyrUDdcuSOQDyEZnwccARdZRzTvv4xk4lnCsxyJMcLzKX48
         Vddc0BQoEFDATzB+B2nG4v9J0XVWpkQmRRoB8uLwXhOevaH3QETyD4FY9HWvVlCct6kH
         0rqfeCcNQ/6dToxlQJ6DC3T+mRTlUhj4Y4cM3ZIVNzlPQrFHT/zhbe9G5r81rKS4my2q
         ZoDMrta3vw1+tvvG1cYjF1v+XnKB5dUEMTF9DyIAU+iU6P0RUvOVMQEZNHeVavrNbEzm
         Mv39Vf/lrHbeHJRHGb2iu+PCqXR7ksW4dndJAso5JFzqxLxfPbrVGVrOQOxgvL5GAeF+
         36CA==
X-Forwarded-Encrypted: i=1; AFNElJ8gb/Sk32P6CjALJVLag446jqJotOXc4wyctLZxNLVi3zoovjkIzu4CsrdcEcn4P+zrV4waa863KqpI/HnJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx20PlnMGDmfenxRzepJPp4O8UcTBup+fsvM7kA11s4cXH/j7El
	igyRgZze+DpfRLWSEC/2WIkjitr2MoGfCkPNlMiN9CO7leaozLzVbVzHBtTXYw3/GsYNAl8E/c/
	TQT8ap2ZAaAqoi3JwGcIZijrhxbgzRNs=
X-Gm-Gg: Acq92OGwOFX7eb1GeGYRI6SCzxDsF3FQEOZh9ae8h9HqnbX/4QsZUvD9I59yagfwL8s
	f4qO23bGzzO3IHBOYTPX76kjKwcA0ZkYiI7c2vAlavBSxQo/xdLliz5EjEffwU33oW8Qn+WAU6o
	0on62jM+3pBzTr2ajoZcDwqvrcoL8C08VOFXfjxZW/zE50xi+RREPsI5ddtzxDn27hPVnwkIaya
	VRhJvi7qYGkuD4nfr1w+BT5ZVPAjDBQc8HpMhoiMP6ccAP93o+MRJrzdy9KAueVQREXzfW2Ga5e
	XoVfTn9dSJqoLGk3T8Ws1vxCI0K26lo=
X-Received: by 2002:a53:accb:0:20b0:65d:30fa:3360 with SMTP id
 956f58d0204a3-65d30fa35e0mr2157930d50.2.1778161937398; Thu, 07 May 2026
 06:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-4-linkinjeon@kernel.org>
In-Reply-To: <20260507124238.7313-4-linkinjeon@kernel.org>
From: CharSyam <charsyam@gmail.com>
Date: Thu, 7 May 2026 22:52:06 +0900
X-Gm-Features: AVHnY4JxAGvWvRko4byupp0uOGhojRYPJ4u8Y2EoScKOwbQf_odFYbetP5eKpH0
Message-ID: <CAMrLSE41=jUxnzAHve5WSVg4Vbx-Xp2QU+UdX9PFLdkY3Y9OHA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] exfat: add exfat_file_open()
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, namjae.

How about this? I think err is not needed.

  static int exfat_file_open(struct inode *inode, struct file *filp)
  {
      if (unlikely(exfat_forced_shutdown(inode->i_sb)))
          return -EIO;

      return generic_file_open(inode, filp);
  }

2026=EB=85=84 5=EC=9B=94 7=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:45, Na=
mjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Add exfat_file_open() to handle file open operation for exFAT.
> This change is a preparation step before introducing iomap-based direct
> IO support.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/exfat/file.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 29a36a80e29b..b7a4964631a0 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -800,7 +800,22 @@ static ssize_t exfat_splice_read(struct file *in, lo=
ff_t *ppos,
>         return filemap_splice_read(in, ppos, pipe, len, flags);
>  }
>
> +static int exfat_file_open(struct inode *inode, struct file *filp)
> +{
> +       int err;
> +
> +       if (unlikely(exfat_forced_shutdown(inode->i_sb)))
> +               return -EIO;
> +
> +       err =3D generic_file_open(inode, filp);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
>  const struct file_operations exfat_file_operations =3D {
> +       .open           =3D exfat_file_open,
>         .llseek         =3D generic_file_llseek,
>         .read_iter      =3D exfat_file_read_iter,
>         .write_iter     =3D exfat_file_write_iter,
> --
> 2.25.1
>
>
