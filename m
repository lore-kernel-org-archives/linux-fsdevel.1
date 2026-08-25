Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694C3A63EF
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 04:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631932; cv=pass; b=coFTy9B9FEOB1/CBU0meRE5VOwHlG5wbadvZAcpzPIdRNWTUlpSAoKb/J5muksoBn3Fx3Ty05AA6VYfaudiT2PLya+RrmbHG5li4Raleo9kpw6t5ZS5ro39QJDOVx1wvWiiiaBS1hNirzYZiifJB6RZ97rCJoI1zKX9ThcHsygk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631932; c=relaxed/simple;
	bh=9M5owZU/Iz+HnaITb4DurTzse1Fzjh2hCNKz2xvi3ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pym11fD7QPZXu0IlLRhHgMLq8Zse18BqRdRddi0bHR9KFDSY+51j6+CtKrCr0zo0CZrCtdCuQS2nyI/auuBOs+NmGHpJlWkbUp1DmSsjIcjpmWADwQRKBBXGSqDFHTNS+UNYF+NPEY9Q+0TydbImOZ2asQKFdPX2xyWYvOxwfoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvFbC1Ea; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvFbC1Ea"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so4093587e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 21:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787631928; cv=none;
        d=google.com; s=arc-20260327;
        b=iUOy72u/Pr2rqUU0c05GGoEDVc6NKA4GdHxIvYDDu9DMjRUKyhslVg8kunuF1tdHff
         cyq0C05lVKcGS7nyOopPJt7RCCp3jdnkarbQY3sYioRFxyN9ERUlasIRft6ez296NnlO
         jei2MZPkHcNlOj5G6XA38VKUWlCQsWAwfo7wurOpKiyRve8PEFz/6isqVFYrrhRUSgJP
         FHOvMRNW2y7LQFzK+aVMR25RFIFlblaF2IMPVin7ikedIkvh0oRKRyiVWwXqRRE4lOqy
         qxvatLOm1upC9+9Ubdy+9LsItk42lbk6hHgXVrWkEv6hk5S71FkfFeDwz5GDlwqiKUEt
         xnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oeYG3qmrl7RlnEX75t/ab9QrDrzO3ftShEy2xBqwL2I=;
        fh=n9KUdgdgJ7PFkAQUpwxThs3MkfnyiDgaAturuWMhxrw=;
        b=Tyw5BpOvgrc7KhwmmF4KNMNeaeO4u+HPxZWSC07G7iMWOcMiUQB2vB8EUl6SEOjnYY
         /zDBJA/cU/IJzg0fq1VUELqjXOV8sIUDSh5RvzbrIl6FuErJaHFJrO6GSC+hlwY8/nbn
         7pHMJeLJKr0qAqOJDll1SRGQauQON+qTpFQ/nyodbwZi9XBhisObH1Prfsj31qT9GgTi
         SD1xdPSGwAcrYnkHrmWbIkjCVeHrifZlDOXNn8Wib1A+N51zfqKy+Fs6/Ce5cBtyyeW2
         oTtFVd8jYRZfOiPgj1YTUgqOZWH6pLlhar4Z94QdT/Ag8k9RbJduFXHpalB9V9GuRZ5j
         /HCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787631928; x=1788236728; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oeYG3qmrl7RlnEX75t/ab9QrDrzO3ftShEy2xBqwL2I=;
        b=pvFbC1EaTd+BBLrlhOFs7N5uWSJoHEEtsWfuYFRf8dUwDvPFlgd5srpj9LNTAu0yVW
         2RO39cEP3Uyi6VSAQB9JcjIywkjbHvwKiQxLk4oh9klubMDATDwMmripregEylyCBA14
         KPMmbMwrZ/Qrf+CeQXUF8cB2KY18cj9FjXFgsw2Op1MQ39A432enkfNsjEk2n9FOCqwJ
         P4hAqBtgZB/SDJmYSw+9AcwfrzzMEj/dmrPP47WHkwxNDhrlhIeTGs8rR43V8NHxr9ve
         KdBH/TeT4DWPm7l9tCKeuvG9Veoi+j9SbaD3uE+mnDI+PgclG5CbsQkR74abldW+51CI
         YilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787631928; x=1788236728;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oeYG3qmrl7RlnEX75t/ab9QrDrzO3ftShEy2xBqwL2I=;
        b=T6pRvGCthaCkQez6V1ylcky/pJiAR0RGqCTgaNkStkCZYX/ZcgsusWorsh6zIoKwTB
         sHoVichOVsocMTE7em5o+nXS8mz+oZKVpaE46/xD9IbAfzoLRr16/ywiZn5RaCQWDPJB
         xitoRAuyXKTLwfYBSTx3vwQ81J2UNd7X96a6fmQY/ZBUMBZwOCf8Q0MNg0e0zako222P
         JL1QLtDkRIpVdjytU+H8DoW9jaNKNtLn1kSsJcEgZ1wrSaXLdp45o4PvjxjEbyMnMvGO
         8zsD/LI/GaRFVa1NNaIgp8ni94V+YlT3vleNZ/oQxVMnxtDMLryp5kksiZqFHZOoNkP6
         +0Fw==
X-Forwarded-Encrypted: i=1; AHgh+RpyUvTBExvah40gpn3tKRbfpjD4sZl1Hz48MSG0lIkisVcqmvJspYhOhkn+2ePmB6YQnrA4nemYC8Nacfvk@vger.kernel.org
X-Gm-Message-State: AFuF++kYtbC7K9TbQFHmMIoD3RydfA2x/CfeGsRACkOzWjJAUW9Qe3ej
	dUWu0Ni0YDTeUxlSbWGWhRXcE4oLFpoZQ1KKcl+UqXONVo4/e90bFQnKIvkWCkktat7eQkeSaRX
	HY5RnA0QwIHbY94vWFwbqRM8t2p4DJ5B3+g==
X-Gm-Gg: AR+sD10Vn+Ozv2DajKC/QQVD4oBYpPVT8VNS7xggEEV1II2gIjeWyVRPVwoUoIIJm1b
	M8ZoaIeEC32F5mKyj5hfAAp4cKeh3HukUMn9r8Clgh0Rv0N3jFGyVmFj2wL9eWSJzb3sHAqRqPZ
	kqmg5jrx7nyXY0c83zINpciE+LgOObQu2y1EJOhT1Mfn3jWYegjDW6gtQvP6vYWnGrK9pDPZXWv
	B1AxhjHm6vq/0GmSKKP0yJL6/U3hHH+orobpYaRevh4O8jbYr/q6uHdcStM2oplFs/VQ0MqDgL6
	u6x/eOY69Inz8Hw0UrLU5mwQPXt6ECbvBwgirTsInK5NozULPGVSr8k=
X-Received: by 2002:a05:6512:110b:b0:5b1:5f28:2198 with SMTP id
 2adb3069b0e04-5b49cd679e4mr881271e87.3.1787631928024; Mon, 24 Aug 2026
 21:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a885f2d.d76d81af.1755f0.2cd9@mx.google.com>
In-Reply-To: <6a885f2d.d76d81af.1755f0.2cd9@mx.google.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 25 Aug 2026 13:25:15 +0900
X-Gm-Features: AcwNN1VdykwJe9JzMftHHsTmKQeCwTEgdB5qedJLBayHX7DTlXr8P8FwO8MvXNI
Message-ID: <CANFS6bbFx6vYuFV1e1wqNeSTua=aXkadxeQmbY9K+rXHf5=rUg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: reject zero sectors_per_cluster in the boot sector
To: Dennis Tighe <dennis.tighe@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dennis,

> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index d400fea32..48bea5ce1 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -557,8 +557,9 @@ static bool is_boot_sector_ntfs(const struct super_block *sb,
>          * Check sectors per cluster value is valid and the cluster size
>          * is not above the maximum (2MB).
>          */
> -       if (b->bpb.sectors_per_cluster > 0x80 &&
> -           b->bpb.sectors_per_cluster < 0xf4)
> +       if (!b->bpb.sectors_per_cluster ||
> +           (b->bpb.sectors_per_cluster > 0x80 &&
> +            b->bpb.sectors_per_cluster < 0xf4))
>                 goto not_ntfs;
>
>         /* Check reserved/unused fields are really zero. */

We need to check whether it is a power of two.

-- 
Thanks,
Hyunchul
