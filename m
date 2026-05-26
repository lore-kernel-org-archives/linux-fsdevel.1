Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB4E3D904C
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803666; cv=pass; b=G/Yfb23ImUgK3VhhBKsAXJK69is5CvgHCpwttOFK4XgussPruoa1ruEnZcnfWY69v5e5cbNzfLjlWGbYEjuydYyOJrbICg9476PzRQH7CIdjMo/v9SqQGejEKn+NLZp71mitxOQFBLHX+moknsDrGnlf4hj0wPxHrfbIXcrNjnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803666; c=relaxed/simple;
	bh=2TU/HPcEgwxzGQTeQxAZwmkkDFE6M0PF19H0oFnmVzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmwmFavadq6494X7fu7nSq2abitoIY3U5oJGSv4ES86lxDK6aqBYMDj43POJ4uP0c/OBJu7q5ogO9laKbo4CvcdK2Sdq9PgE+GXCKv+EyTAdQ+wByXgZzKDxlQPdAP3hl2ePrADKCtyynXNKtOMrnjlviTwdtF7NMjZX4KzhkRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4Y2/jTR; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4Y2/jTR"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68852a4fc68so5890737a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 06:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779803663; cv=none;
        d=google.com; s=arc-20240605;
        b=c8SNgDkE5ciiuxIkvgEYASwNP3vXZeVHPdCNu67k6u5J92UlT6/w04VbKpoqrjNfz4
         uK+BBoLKDXrHyUnFml13BbdgIqmupJcnLzMJcQkx5p38ul22bKvDwMi8i3yBmjz0M3qg
         BpY38IpnmbxpTWyjB/h1Ojg/z5XJEDL07ZqCJvauZRBk4XhHgI4njTTJ+etpHNir7ZQZ
         1rUJSENGid7T3UqVVXdlk62SJZF+iSrRT6dOh7M7lL/4tvboOzUM5ET4k/p28oIVwGNr
         WDv+ZlqZuLRnZ4N0sbIN/tIK0UDR4DmypSZbQCUqfCYtmnDjLxqYtl+JkDRhspXaTqwA
         epAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BEx7uN02jNK0071tFe2UGZXPwPcQj21lMaC8f8ui6K0=;
        fh=XiNSbgtaTx6IYZHsr11ZW5ShFmm6g0cDC2F5DJrD3P4=;
        b=k0jlQDzyFUTa533WkkFbFYPqydKxVJUyjM1zyvme/EFl5MH5VnQFmtYQ3CgUWP23og
         FRYcpTrlekm8+Tx85jLYg1Wco3G5UbE36wVH4Wwv34tYnhntNrNXsAxN9cVD3jkK+k1+
         T4Y5PlVDJ7k6s9jDt/IqJmXCVSmHZWRLEqknis23BDIJAIc/NNMzqiMjENaYrAgy86eT
         RZXCObrIolmNg/s4vuAp7C17q+hCcD7pII/+1k8edue+pMrOuva6oE/JlgrD1thNIAQu
         PGhEvAEe09wu8VqQmMQhqOKcxc/RlkEQ1YnA+rPVQIT3C4aoHXHCDa/fs9X6r8DB77re
         hLuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779803663; x=1780408463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEx7uN02jNK0071tFe2UGZXPwPcQj21lMaC8f8ui6K0=;
        b=T4Y2/jTRyylmo9wqgpwlNbyboNQ2KXdcGEhN9X3P+RmcXKY1ZPCmL5+g+n7h1awslR
         XTWCH1VcCZDnJdtM84xWClR73PguD4RYJt2zf0D/upQYnz43swiT2/g/lchhLsr2OyGW
         E60QRzuh9T0oMFwEpXyWbWYx0l8yS1DHXwQ9Hi6JzGC+jA7w5lpRw+2Xo98rA1WFAPMS
         LNPrIIXWIxvYJGygvOfQ01yZZUvI/XraXHdZVF92GlnPKDop5SeMVhcqc75s8Hpm/f+T
         62rermOWRy1vxtMZHX9rZvJMiSFZsaTpgiGqWWaAnoBUhggXVaCB9vWGVsCd0KamBFEk
         1PKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803663; x=1780408463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BEx7uN02jNK0071tFe2UGZXPwPcQj21lMaC8f8ui6K0=;
        b=VjwD7IXl7by7jjwxb7A1QYv2cvVYa5pnfXWyBJno1JedR8SuKBFpydnGoEDs1FBBcT
         Gg5bPTnKFqbfnoaC8NRrCYBsALIwfnc++k4VfTweoLSvYCbmU2pcsFZmWhT31thywrHD
         3ZGmtI8Vj180PndGIr3xxay1o260ZdIscCjwng0kjH5hJxSTManMUAkXdSrUOyM/9AAP
         fE6S7V6/1r0Kh185BXSb/W8Du5pzYByWtqM0oRfbHJLPKxGUd4dh87fOQq81RGkf0Lb7
         wZJZ9RRj5UhAuXmM1VKEQmOq7lMVKDedRClzP8pWVOxJbzBJ6xOj013i9HEHfkPFzILI
         jE/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9pKDCm/V21wQSXJ8mxxFjpzsaDpfIVdgTVcE2nre5RlBMsgWzMgXfFfJWdMGU+gsozNFoIcdzn2KPfYJhY@vger.kernel.org
X-Gm-Message-State: AOJu0YxjcmGG7MZsYHoWq1lKePZoM2ec0kpNwY8MmJJNIfNq6NhUuyg2
	xDCLaUnn2rkVVaj+3qwJVEBwbu0VEtjahuRLZ/sUXqbS6FBWh/4f85Kbj/ES1KrBmGTiArwbTpg
	STNWI+dFDkYLA79TJVIUOEPK83vYm8tI=
X-Gm-Gg: Acq92OF0nmu8xoYjYxunWIIkjAXHEMnb3UpQmUOlAKwiPJBoFdJyvHHRWJka7M+66u7
	sLlglpJGawpv/ZGq8XZbUc4VVKRp91Wd+WBwme6y+cprkeUUyHGV0XHC/wGi2RDFRSZc+hHTA3a
	YLD4Q3A1Buqevgr368t+IdX4BgzicK6DGQMZPhWBKJu8libBou2I25RVpI+TIRX+ly3y6SwPKig
	WlrjlNQtVV+BAZxsknpGk73TZYYVdwJBgxLb6K5NP1eL0WflWTIWUJv6V/czkdtdggT01JTm7qJ
	PSzl3uhiZgr+Ko2h/pEC7Mip9oQXKxWfeXtN4/6lsPaP9EiHl2I=
X-Received: by 2002:a50:c8cb:0:b0:689:9706:cef6 with SMTP id
 4fb4d7f45d1cf-6899706d66bmr3424863a12.4.1779803663440; Tue, 26 May 2026
 06:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526085801.81187-1-liwang@kylinos.cn>
In-Reply-To: <20260526085801.81187-1-liwang@kylinos.cn>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 26 May 2026 15:54:12 +0200
X-Gm-Features: AVHnY4L62fcz3pAXF35UOsshoYtTDxjRAro6GJAMnrkVCJ_cwC0OIGhuqi7h6GM
Message-ID: <CAOQ4uxg_ODc1NLU95L4EAD5MT7ZqYfsFKKhgJ+YXud_zZZJCwg@mail.gmail.com>
Subject: Re: [PATCH] backing-file: fix backing_file_open() kerneldoc parameter
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 10:58=E2=80=AFAM Li Wang <liwang@kylinos.cn> wrote:
>
> The kerneldoc for backing_file_open() documented a @user_path argument,
> but the function takes const struct file *user_file. The user
> path is derived as &user_file->f_path.
>
> Update the @-tag to @user_file and adjust the description accordingly.
> Also fix the "reuqested" typo in the old comment.

typo: requested

>
> Signed-off-by: Li Wang <liwang@kylinos.cn>

> ---
>  fs/backing-file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 1f3bbfc75882..a530c2d19d20 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -18,13 +18,14 @@
>
>  /**
>   * backing_file_open - open a backing file for kernel internal use
> - * @user_path: path that the user reuqested to open
> + * @user_file: file the user opened on the stackable filesystem

@user_file: file the user requested to open

(It is not open yet)

>   * @flags:     open flags
>   * @real_path: path of the backing file
>   * @cred:      credentials for open
>   *
>   * Open a backing file for a stackable filesystem (e.g., overlayfs).
> - * @user_path may be on the stackable filesystem and @real_path on the
> + * The user_path (taken from @user_file->f_path) may be

@user_file->f_path may be on the stackable filesystem and...

> + * on the stackable filesystem and @real_path on the
>   * underlying filesystem.  In this case, we want to be able to return th=
e
>   * @user_path of the stackable filesystem. This is done by embedding the

the path of the stackable filesystem...

>   * returned file into a container structure that also stores the stacked

Thanks,
Amir.
