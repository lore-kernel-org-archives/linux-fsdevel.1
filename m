Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6D21CA13
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776213605; cv=pass; b=iuE+zyhVLVFGm1ERw7e8SpjG2w5hxnhkLkmO19fUZ793fLk4tsn5VUKBXkb+zvpUAJzmmt/dAln8CZlJ3poheQ5GRuQ7t8GXYu1qL8rgPVK3j0RMA+PQ9r/XA0FnQohkNsN5oP435dCg2bPz6Vj0mArg4JRDk9vkwaqRVryOsGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776213605; c=relaxed/simple;
	bh=CDyfaVUGzZpc+vQYHS9Ivprbt7YHf207dxxCKRNX2s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMrOjZaobLnqLAdZTVpMZFhm/8OkfrqWcOygWNrjIjw9djIAQGrseLOUxt/Gs8g/Hesb15OeoRomRQpwO01vwOlg2+leYGe7Bj9M5iqXSP3L4NHkdro31v3z8m8cewBKIabatTz984eHh8kLD5B6OwQGkubzv6xDf/xTxLcM080=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni0g8Nym; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni0g8Nym"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7650202fso2201792f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 17:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776213601; cv=none;
        d=google.com; s=arc-20240605;
        b=XgeLcIwFHTMZKVgKGhLOjoyICbGnzwWWy0BX7LkK9QLBRzvG5lsFvcJOCP3hATDpK3
         bcWG0PlwtOWgZcAfnLWU14wMdgAdGdQVb9l3p1MHXE6hGl1sxrdtxRSFwSyU/m6Rmmy4
         lkXO984T5whCsqGDPH5dnM4eAt5gHEQaKmD89MBMyTGicQrQzBBM22fD0n/5zGVZlYFM
         rRnhwqYv3FPkX5e4OKHal2xc+7be/+lSAoIIuSQc9hFlIqnr8uWZtP//WB64HDKtlptC
         nTxkAv6OvMTa3+JkwijYnvAnCA7dD2IEz7ae9wUET51gDSbQ3zlgfw3AuL4DLqjqp75z
         nYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xDF5hd94gi41sBgsV8b3i2x12XxD7MEttCA2Ebev224=;
        fh=s+BGW+Bjm3YU4i1nFHBQ1alZ+schWzmggpT8IL+YWTY=;
        b=jUGMTWbBl5oAIdQ29ySmZhTacWaSO5jOoO9FF1y/meI0b5u+TaCcB1yI0KeTr0pQN5
         mgH+LNHPyz10l4QS1kyKu/MrESkvdcfOopFGeR4hjwscGxgOLd9MluDUVxtC0smqJAg0
         nDIA69tQRxVqj3K9pkfXl2WU42cyLi2V2WWKqBzlTBedcExruFfuPuhw/Boo6OFFQHLl
         pT7ZBkKJKoSc8FYQpmASM5bXYYIrJkoZUxOycEGbN9rome+pkYMZm6raKq83MD/Awq87
         7Y8ZYezaqaFG8nMRJv5HFr0gJhqELTuK1b8h9mr6ZksM67AhjInxu/g35KtZDjM3fnoI
         skdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776213601; x=1776818401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDF5hd94gi41sBgsV8b3i2x12XxD7MEttCA2Ebev224=;
        b=Ni0g8Nym7MjpfnsTZQcakEdWWByHnpvoXu/eEt4Zbreco7dyigz2ZxpLaVgDqVYazO
         OdtVAHKvzU0olknT4+cs0KjeGcHjEp6W4+6okrjT2Dx5CUaJx+2V2MdmgSRgbn0zYR7X
         01PqapNLE8XwtAZv73saV6stgLYFlqMUhAcXe18feGrIektS0hBiDd1vYtCPvaML/Pdk
         9w6iok51mRD+QKQS2IppbnpikqSLGQ23pzWXdvVf9ZhlzPU4DuajnRVuPj8/kX/o6Mka
         KdwsQFwWHj4kpq2schOdLjV8quB9kTOFdLcQgcZSfbK855V8aQOZz6vli6fpyOk4UR9n
         BvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776213601; x=1776818401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDF5hd94gi41sBgsV8b3i2x12XxD7MEttCA2Ebev224=;
        b=UtLbAdfb7QrxopOzttKKCYgjPpmKwhaU7f840H9+56g/dWwpK0YZbYNNYMQdaBK4AV
         J5gbPhswdsdxI5h5BDwmZMAb2SHr0uc7lOBwOJ4EERphKqdXjfiH/NzfhGqMGaWo/gRB
         6/k/xZeR0qQCJ9Cnsbr/EPG1lfuXSvXSG7RdSDAjbsdVeIWfAIeFSAwjw2LT9xWKkDDO
         E8HWrZXeSb6ojYVn+PberJTPs+mfVaxAHMRmbgiQiUBpm5PzuSKekjbL0Y937dnQENU7
         MgUuOap5F69RhsCoSdU4LsuPJV6X3e4pDnFfUFJmbji0FhOz9PyG32VjGslICuqkuPgh
         E+NQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jeufKPyFwgFhgCIk0b0123i9qAJnR7ztguUug/jx8ThJQoAhs3/GD+wCaQ1RSlyOy7UNWPlrX39Wv78u8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QEsO2Hj4vs55ajwJb/pRu/yQyYiuekDdB5/2sNWau7PK2SVH
	uSE/EAtdL22djnYFdl4MnT+8yrTbbOGPMzxrlZXksiATzqMZrsS5uwiutt72tWLMDVQbh7gapAn
	EX5Vie/wdjgT3Vz/SsZDx4TetPhJly6U=
X-Gm-Gg: AeBDievdU7fTiXOg3gIHycnQIJpkM3quIQi3y0y2gca0JFag0lMHeLF19Wdmr+yTl9W
	wKbIE+RY6MWiCyb1P7RAUCXNoM2dQv8Dr4nVWd4WvojzZmxBR+PYbvR7CTUq3rcCYdhVoq6BF/j
	zDsWxdg7wWgAi8af9fh1cDM+Sw8Zw7b9nbB5mRZbb2AebK12a2IAFau7MX4mjrDr3a9xMa4pSkJ
	qftgMq0psNup77dro+ql57NmTy2gUsglKNCoNcqaWz9mwkKPN+31tyNvLK5+/dx4wbiXLoXSeur
	CSnAr8SPgPOFDtUV
X-Received: by 2002:a05:6000:2211:b0:43d:1deb:a5db with SMTP id
 ffacd0b85a97d-43d642008bcmr25548116f8f.0.1776213600463; Tue, 14 Apr 2026
 17:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409030457.4632-1-liwang@kylinos.cn> <20260410023433.18969-1-liwang@kylinos.cn>
In-Reply-To: <20260410023433.18969-1-liwang@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Apr 2026 17:39:48 -0700
X-Gm-Features: AQROBzDY0FJ2G1alviJPztTGfPRpeL4eaJfwqcRounsKQxzsGBGYJdcnoWKwlIA
Message-ID: <CAJnrk1Z7hmvuoG6yoeEKMieLJJA55_vdG48=-ktxVEhoFmN-6A@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: drop redundant err assignment in fuse_create_open()
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 7:35=E2=80=AFPM Li Wang <liwang@kylinos.cn> wrote:
>
> In fuse_create_open(), err is initialized to -ENOMEM immediately before
> the fuse_alloc_forget() NULL check. If forget allocation fails,
> it branches to out_err with that value. If it succeeds, it falls through
> without modifying err, so err is still -ENOMEM at the point where
> fuse_file_alloc() is called. The second err =3D -ENOMEM before
> fuse_file_alloc() therefore is redundant.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks for making the change to the commit message.

> ---
> Changes since v1:
> - Per review, removed the second paragraph of the commit message.
>
>
>  fs/fuse/dir.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f7443ca37e35..b118cf23d41a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -838,7 +838,6 @@ static int fuse_create_open(struct mnt_idmap *idmap, =
struct inode *dir,
>         if (!forget)
>                 goto out_err;
>
> -       err =3D -ENOMEM;
>         ff =3D fuse_file_alloc(fm, true);
>         if (!ff)
>                 goto out_put_forget_req;
> --
> 2.34.1
>
>
