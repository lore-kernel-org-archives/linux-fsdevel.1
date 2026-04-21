Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8E3AEF5D
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764770; cv=pass; b=ACmIr5sbkeuB/Eltt2sI3DnJ3UIZlqfNNl2916TJ0I5YFb5JI8QwNn3TB865UTGq73WtCtC2s93zFf53NlYQSuKNqZWciAxb3FC8K3D0eTr1SOQpR5UDMWCwCr6uc6YF9UEA6KoAmAXvEov/55u4lwKfjimUHGDk+LfOsYuMf8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764770; c=relaxed/simple;
	bh=znvspuC1zpa83aqAkhzFcDOyqVdZBRrdnEBNSBvSWzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LULDD4c96frG+z92Kmq5Ilap+mGQNzqEaPOHmBKwpzrWaAsEPpJeTEc91aL6L8hR8+io5NXcZ741Zv1WKZoHnTxcAQmYfodxkIQv5BKUac/RkOIA7pPiUZQOhkXVbWcUWHf0Z0nTFqHyN0kXgzYTJrjNlHmUFDAAJ2Hd6BnkC/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsiqrTdE; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsiqrTdE"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ba699316b42so362438366b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 02:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776764768; cv=none;
        d=google.com; s=arc-20240605;
        b=j4Gl1KL5KOZ+S0S/I7oa9BT8Wq9vY2M4r0N3FFihqt4SQWePaVB4VBgGMRqQeoETbT
         E7WBKBA85QS3O91rLLSW/+U+D7SDHUPoLt+xVtt2N/DBtTkrRuPSevxdX1/UgzMSZaec
         sW/rItgPUfKuruY4bghihiDolFaU/qu8+1RXrXoICUQDPv4qK5uDtPOgxerMmWp+B+Fc
         R4vZHFCNL7RgDFfuyWxmJplos769gn2dTFiRxGR5/RuUo2FMGwuvDqBz1f0eTAxSNxS0
         G7FIDGQSXTRbK4htClT5fC9aovVTxg+LJ0fyw0VEx4+CZP6T6YLbUBQUMP9Yxou5rWtU
         jJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kcDf9Uq4J7samVRSXfkiUIHDySbB8vtyfJm5UY5edZQ=;
        fh=JjTpT/SMw8I5NCe3YleqEAT3BFmibqRq3JVjQ1QFhNQ=;
        b=C+qB/aEjGVEBclUv5FJfR5bHX8C2y/zJVkiXO0+AQXdY1CiyCXWdZhyM5JZ1BlLw/A
         xuT1Olmg1Zt/D0oAMqkklAAYrXRTiWPiyQETV7XwHu7Pn3QFqcdwfU2BM8wLFfBKa5Fr
         I3nHczv62e8mXQhAsgfVtzMfZMVSSPLb6AzHAztJj56qvFADcV/r4rhYTZAgkSQ/8j7q
         gopXuu3bnbZ8eaUX/E/fZSOTI8iVTZqCq/64G3jpzAEFTgd7p9meE+doFg0JtyfD5/iU
         XT3iA1RWny6RMUIDRYEYcu4SuK2s3xKdnW6vDIHgsqeDB79IAUXLJV07z8AQjOwETlpN
         Nu9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776764768; x=1777369568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcDf9Uq4J7samVRSXfkiUIHDySbB8vtyfJm5UY5edZQ=;
        b=hsiqrTdEAxweHdyE4mjSxvmgPcA209c9YvJykBUMtL6fXCbbIiIqWg6JQTDnndFLCI
         ylCi3ibCPzbyr41K9uVuSXvO3TDzHMl1z5rbqXJMi2OnYBhHGJxatuRf1+SoqM9+GEs3
         PwRqBR2ipCCZfK+++iuYHgiliEBB57tbIVq8/BLdqEA5NMFzsEXf04r6cPA4atUwHeNt
         YVpwYGPomTqUVopNNRHY8FKsTek81G7iHqvcSi4BV+PfLoEH6NQnFE9pyf5BvoKJClf8
         7W5Rs+5v4HsAfof3xd2/T87eXDuI6Q0C3U7gNK5ZhbJXj2d5P4EAiWUZDsBAwp17eAE4
         VM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776764768; x=1777369568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kcDf9Uq4J7samVRSXfkiUIHDySbB8vtyfJm5UY5edZQ=;
        b=WC3Pfz4SdB+JvaV+OP5xNKHAXoy8eqUO3yOPzL6JJXQ7muS+OV0RmUV3MO3XfoTdl+
         4HDIARi0gJXO7Wc7xigk19eSYrLyYeGffXsPF1f0sScN+ktNAToLATIVsXK9aj3H6mf8
         jWzjNl4nuQULoYmcsP/GxE3+Vq85nRSZTQIbSZ4Q8MBnUwFse8q4i5iT9zGOjMMEqKlt
         Sb2VUiK/Lj3TA9899T+9SKd/0gdZtCwBnjMwCzZYJBWrDFyFdi5VCTTXpWYM/2soBA0o
         9EVJHvqAGzfdFTGXBqRXJt6WTc/k+rxI/XYoHfR77QawiRMY8t5CCzvMgruhsso4LPxY
         KFeQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vwt5PlvGcXdrhLIXgQ3elhNUnDb0J7cvKWdxAD9yeDyK2HMjwe6oS4uGOy7RpkTxlB3XvkZCMjNXXrncn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91khL9savxxk0DQdgL/43PzRerFLLWYNLuRcvYYPdasC1rMhA
	YxoP+8dNWqbu45MFiJpRn8wikNyS2Y7MxQHHLw2C2NOJ3PRGp6vrefYyAP8M977gNpb0SPBsih4
	iw9yoKSBrDhRmNuE/W1oz2bKCDapKrVdn5/Q4XtY=
X-Gm-Gg: AeBDieuhf5dICzO16YNt4ilI2x0NUQaZiwWcD6xanNwEmN3Ws3d0GcisvGjNfYTouHQ
	10YVYhNWhljhTeyFwpUIhkreXD/5+dGZzClvTw/FxxEjxizeLf3Cbs0YT7jP6RnfbOwOVwF+4Y8
	0J0XgiXLHHTaapD5ttEoPSEp3MgkDweoCIfXbKJR51z3fsFcLyHFpkJYLCqGa1q+BGTcEsY1Yhk
	5/ZmKYbb+v4tVQ8mGh+0bYKcd3D/lJhjFuu93vA8ekHHPCF9UilPcz/HaEZM5avhfAJU8e40EWx
	VSJedYtakalUgRXfCtbCYYUmXXQRZn2c5gLVqwSe0G5IVoQYyGoGXiX8ev84LE8=
X-Received: by 2002:a17:907:3c8a:b0:ba8:2ebd:dfb6 with SMTP id
 a640c23a62f3a-ba82ebde295mr347876566b.23.1776764767533; Tue, 21 Apr 2026
 02:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421092349.148002-1-sunliming@linux.dev>
In-Reply-To: <20260421092349.148002-1-sunliming@linux.dev>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Apr 2026 11:45:56 +0200
X-Gm-Features: AQROBzCUUgt_denQzi9xXeQRG2Pgax1LQtiTZ7pxr_LNcQbDYchqD_XRKg7Vpcs
Message-ID: <CAOQ4uxg8TdvtqE69cmizFh1OV-EBJYcJ9PMxDkYFXEPWZd_=JQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: Fix possible NULL pointer dereference in ovl_destroy_inode
To: sunliming@linux.dev
Cc: miklos@szeredi.hu, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sunliming <sunliming@kylinos.cn>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 11:24=E2=80=AFAM <sunliming@linux.dev> wrote:
>
> From: sunliming <sunliming@kylinos.cn>
>
> In the ovl_destroy_inode function, a variable reference oi->lowerdata_red=
irect
> that might be NULL is directly freed. Add a non-null check, and only free
> the space when it is not NULL.

Sunliming,

This is nonsense.
kfree() is not a dereference and kfree(NULL) is allowed.

Please be more considerate of my time and the time of other
volunteer maintainers and do not post patches that you do not
understand yourself.

Thanks,
Amir.

>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  fs/overlayfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 60f0b7ceef0a..4b8b5fd4ab59 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -218,7 +218,7 @@ static void ovl_destroy_inode(struct inode *inode)
>         ovl_stack_put(ovl_lowerstack(oi->oe), ovl_numlower(oi->oe));
>         if (S_ISDIR(inode->i_mode))
>                 ovl_dir_cache_free(inode);
> -       else
> +       else if (oi->lowerdata_redirect)
>                 kfree(oi->lowerdata_redirect);
>  }
>
> --
> 2.25.1
>
