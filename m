Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C124F175A77
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783297920; cv=pass; b=ODh8aobn6lskDTfPx818r5zs0QzDnv/ASDDWy6FIcFCDseQ+rqPBkKcgSrNgCMhjycRcPanHs6As8/folb0nJh5+OsFU22hJ4Ivr+zHQxcEuRDmBz7vUrN1N8lwJY33jXXUCXEoVx0FRb05S7eDUKd3LCWiG6Z7H2loPsVGO9dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783297920; c=relaxed/simple;
	bh=y3f1svFKw+Kgy0mYgEhFfHt/AwtAjzzSJYmqT3xqd8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQKIUykyOG6lNicaPrGYiQsSsPTnZRrFE8NXmA7emofz5MEpOuGCQaV/ptFVe3XU31LleThj3u0ZgFJmwWoHgFmJd8lMdWrnRxBhcci7CI6KOIRDnWrKxgX8/YiGS1d56aAAPUC7UGw4+eDtGA0bgnEyFOXLrjUCmGB1zwgP/g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3TWtMtd; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3TWtMtd"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb17c2564so2250285e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 17:31:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783297917; cv=none;
        d=google.com; s=arc-20260327;
        b=dqfeR5442/PyFRgD0MTHIV+0RZ8IdCPc6B/2+xBcHWDXrwQ/BosS3TIXwKb35wzEZF
         UCNBtCAKY2BlzVM8ENfqsxw/c6N0jhj4GIswC7o1VJ0V3R2asdOQihq+WIKWPrQT3uBL
         XKice0o8/pELzCXyta6aTOuYQlIyOpRAr8QWUi/PHwCJz8IUTOjMjK0JJR2Nsaw9CUZz
         XtzyTUP9s+aSt1KWpdsx5oDaGFLI3R7kxsXVE+fQrPn0HnXbVeJMggCAW5kfUcmVXTUp
         yD+PP316sXwVO2ylPMrsQVxbImQ1j0b0HuW1HhBkyUhS8E+ZmAAjsZaw0I41gfACpVxY
         I0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5S9slGOq3M34qjRS1GHHsN8qBngvrnb+tbkgpwyl9ZQ=;
        fh=QfyiQWA0Y0qYvg4xKjq2GWgeKmi7EjHfFKIq0Aziojc=;
        b=biVXmvY+Iy0Vb0mQ1f0ASegQ73k3dTPJTUul3mGfAfSCiEiNxw9xevfpcnM448brmf
         ooMjy1hsLBwP3fwc14hP173v+bXCnn1O6afXyWfjghRx5VKWuSKRprQlkC+kxV4rvNGm
         w6qk4Mb1UVoWcw2J4FduqO3N64LWOyAns4oV4AAXu30HunKhfljaGOMGu3GGhpAqjkjM
         mcZ4n8wTU3OwHYYPy3Xzge1a5r68v4X5SjZUkaH01E+8nc/JfgObvbe/SeWZcTEArgI1
         QQ9DcWOiT4Agn/vtcnCZsrVi33SqYgeZxZE/WNYAz/bZAxENdPgjjmpkvuvlcDO+PpBO
         JLNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783297917; x=1783902717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5S9slGOq3M34qjRS1GHHsN8qBngvrnb+tbkgpwyl9ZQ=;
        b=H3TWtMtdzdYVlP6t0kAHk1UUKD8wR9La+v992Che/frhNET4zo4iTubVd4djjNBh/O
         0nEdGAnQNjiv6YOFtswYcR0LEj7qkYtIt3TQNzJjs3GYWIkWOCrx4mVuDHMMLOpbO7Vf
         9EFwH/LI6fpKIAKLtsPCQ52AmEBy5j6D3yIKjxM3l87TEDxeXjzzZ2oBIWg/va6Bnyl8
         QQap+d6NfGftb+FWiZI9Rwlb4sOgikEomtpHAgfuyJh9fKalvPxrUI4qy6KUmNF0ywc5
         +JjJ3K1vpAyik92Z+tQUPP/UQap8ImobCKgRZEfUwvZ7I1O8Y2g5QCQmJDPMSXiadp2d
         w0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783297917; x=1783902717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5S9slGOq3M34qjRS1GHHsN8qBngvrnb+tbkgpwyl9ZQ=;
        b=NKdFRRWufu7nYs3bQEQWt//eOR9rH/djWCxpQEveUwSLpCSHZXcj+MCQ0N+KGG9S/3
         hpvftEbh7WQAjuKZp3WUgbf7DmJCJwsWKRzm06nBN5M6AeZvhEen8LcckIb/WZzpHqD0
         1LCM187jDMio4B/o2BGqbZ6HncSQI0T6cCr8HZKMBx2h1RKKYQE0dKqtIYn0v2ue1NFf
         7d+RRUEMYvh0gStoeD8K1Fd6hDC0YH5uD0HJKlDnEycybEEF55YwGHFAIDEVXfgz9OKh
         Iq39ndgWbk4Fs6HyftwB74VtQGpJhXgDBxnUVCv4gOAaWIqwuAO3ny7wH6sWDctHipWe
         4Mgw==
X-Forwarded-Encrypted: i=1; AHgh+RptirIfJcLPwEgQkYR04vYoD7qPsLF6dyvZdkdnFefX2DvWPW+OW//Z1KsQ/0A3PCNSbiEM2RfkTnslaLlV@vger.kernel.org
X-Gm-Message-State: AOJu0YxryK65Bei8MMzVNQ/vOt4dQliaGaUXTtzrb62qfHi0ZGfGvxSn
	cslE2gDTZZGkhLqTkLqW1xCgTefu6heSdSYP5ieXRMp/uLKZzgxuKpc9DMXG/yWVQ0RNdAPLV9J
	UeDe4Y3hlMPGWwrlLJCKslERD2gqYFCOgJw==
X-Gm-Gg: AfdE7clBA0bw3LmJU14WHo2++dsjcgq+WbJZdR9WxPKEqyzabsrOW3iU0CWF81GML5q
	3V75ATcglz6eqbijfpW0WFddjQBDQVCkE0OIYX/i2hLMk19Buzwbpop4rckl3iY6FBP15gkjCKl
	qGUC0jTTgJ5aV712ac1P5Y6yeGLNcFr2AiAi66hFNXUyjyNcCpGqWdyRcq59gyUUHRqMfRJw72C
	861D3vpKWX7eVPqn04W5hwv1toOEeRjd9fth0c7nh5NKgCZ4JspT5VFxnZmuHtjb23UQ+Jl
X-Received: by 2002:a05:6512:230f:b0:5ae:ad92:e9c9 with SMTP id
 2adb3069b0e04-5aed50af51emr1638670e87.47.1783297917049; Sun, 05 Jul 2026
 17:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703173301.89289-1-mdshahid03@gmail.com>
In-Reply-To: <20260703173301.89289-1-mdshahid03@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 6 Jul 2026 09:31:45 +0900
X-Gm-Features: AVVi8CfNR-zYahH3rN-GVVr_Z-ciS9mcUyC1Zl3g8RYkbKwAlwg3SPH7Bduhj34
Message-ID: <CANFS6bbR5=4vEU7MRhRh7Q0R=c7Y8NGgXEuUO4adseqOpuM9_Q@mail.gmail.com>
Subject: Re: [PATCH] ntfs: reparse: remove redundant NULL checks before kvfree()
To: mdshahid03@gmail.com
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 4=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 2:33, <m=
dshahid03@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> kvfree() safely handles NULL pointers, so the explicit NULL checks
> before calling kvfree() are unnecessary.
>
> This issue was reported by ifnullfree.cocci.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/reparse.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
> index fa523dc3691e..ced4c675d91f 100644
> --- a/fs/ntfs/reparse.c
> +++ b/fs/ntfs/reparse.c
> @@ -317,8 +317,7 @@ unsigned int ntfs_make_symlink(struct ntfs_inode *ni)
>         } else
>                 ni->flags &=3D ~FILE_ATTR_REPARSE_POINT;
>
> -       if (reparse_attr)
> -               kvfree(reparse_attr);
> +       kvfree(reparse_attr);
>
>         return mode;
>  }
> @@ -358,8 +357,7 @@ unsigned int ntfs_reparse_tag_dt_types(struct ntfs_vo=
lume *vol, unsigned long mr
>                 }
>         }
>
> -       if (reparse_attr)
> -               kvfree(reparse_attr);
> +       kvfree(reparse_attr);
>
>         iput(vi);
>         return dt_type;
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
