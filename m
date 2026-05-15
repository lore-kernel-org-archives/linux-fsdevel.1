Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B430BB8A
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805363; cv=pass; b=taJijJ6tNkq06rQLz7aFJN++cCaHDRFxOOi0BpDrXMp69l4T12ZBD3G+8cPDyTsqxyXgKtibSkUE71gkzzsSm7XTJUIWWRRS8E3W2HIxcNn+KHjsnjKyVCBzG/dv6iL0KE8Rq0EwZek19CnnBYmAzClcf6hG1vTEWAKLKoJ4xtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805363; c=relaxed/simple;
	bh=f3Wo6ZaEWoHRR8MjOVNgre0DOHmAKc/MbZIRIOvz5j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6IAHUmkdbLrmNKGtGClP9Kok5EvjepZGw9GP81uUR0d1yvI0w0mSn/u76scLhDtHbXJyVOzHtZWNizD3xXxmabwDIQ33DRCHo/67dAVubX9Tgtmr2B3gfbdq5Kt1DzWxJPt/Xt6K2vRrXE+onkKA92WlYcOw1sSuxc5kYg0joM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wk9zCSpK; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk9zCSpK"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c2e7ff1acso987333d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 17:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778805359; cv=none;
        d=google.com; s=arc-20240605;
        b=X6iLxFhpX5I7+Ch9QDza03eIYrGUOwZzstIDWvKZx/teWl0aDBiGpLTCewUciiF9NT
         qBkgWNawpvXM5spZugRS0R9mATIY8Z/mq1EwxuFtI6ppxiNUmrmRcAUBVPY8AvvqPiuB
         TATSqxLmxE3+J0UjOKdRUdA8a4uLezmo9zdKDbRgDLnu9UT0B3ZWNy5rCnkSVOgo6p6t
         +jpirk1bgbKINXu9r88VwYwOoix8QPqM/jn/CwJfcxgcbELUj50VeZgXAG6LbIdcbwMg
         OXiluOmc0QzdZTQ+Y0ggoaGXEtl1QwAkF18sxI5r6ohQDYxdPT3TCa4EFDcr/MU51i5P
         OC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4bpGsgjMFUDruJ2LVPeG/YU6NXVCV1PrEsM7cLDNHAM=;
        fh=3ik8Qf8VcTIn+2kY8XwO1Rd4NRzUnbBMOmi7YaxzI3w=;
        b=ZISS3Yc3CVSKK9ETBfQ3tnMmZmZlm3j82YeHfQQu+IjWBFE7eLvU3y83IuPl6OHKCQ
         IHWSCjmnqVFAi9Owo5wcHdCvUGlpNmW300tBqD2q6RzbW1k6BDtHspZ0EE4Rkqs5zubD
         IGL2jv4Lrd7sez6yNHmCOy+FP9pgAAs4SPfO1qYQbwNfoRsTvK0ff9eo1++FriREDgL+
         WnWewy505FTD3QfMfWOLb3Z5ge8J6oT2kw5MyknSywrkAiqFqlvJJ3Um+41lTyRMLHTU
         eEP0kcO35zqkSYudxxRHcUAebMDrN6ypudsCVeFBijUQ09ktx0nzZ7MrBjvLeAugk/mY
         ELeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778805359; x=1779410159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bpGsgjMFUDruJ2LVPeG/YU6NXVCV1PrEsM7cLDNHAM=;
        b=Wk9zCSpKJfAp/U3EDDsDgRXX6WIO1YY9tCp3ivektRTSVJtWnpqaaxwF8Y74DHbi+r
         0Kh0XS7H9Z0kncQZANcPpSjFlNaCt687CqqEwNq7smSTcXg1zVQSCCyXHGLwwBeO8tLU
         rAuV+ZrjaahIq2X518GnFk/9IPAVNXgkPCDGeTTHiVQ3CQmFO09SYViY8Dy7pPveiFmR
         zXuO5M8r5mdAO5EPxzFlgSXRx+pxMBALH1FGkSUx7GzkHLs3l9vEkjWZmhHGS+iv6/ZM
         swsTDZXFcvfIHJ1kQx23oM2jhXC67umh/P0IALM54fW0wZmT+89AQr3NLrCGX2q2mYzh
         9eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778805359; x=1779410159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4bpGsgjMFUDruJ2LVPeG/YU6NXVCV1PrEsM7cLDNHAM=;
        b=BaWDh5opbpvpoDpOt0NDP7b8HJI73GjI68xOdbQgLe+MQmpve4kswbqear6PZHrZK0
         xUOEwfTtL8a/53ZmRwOs3BfcXfHZ8c6mO6eO5Gp8A91SissnIG4T85q0yv08VHQtdPeJ
         bTexK7Ja2JPkuJUaOxTnJgNU4Nufao+YnewR1IQLkrAVHmdvVy51QaC9uV3x58gjI/XU
         7KKWu/XI6/x00sJb7izJksg4nEJOG9BfRZt5R2dppWAhW6Fwggt0tXZiem/q0u7Mp27Q
         lixDy5GZcGWWQKWuPay7imbCe9s74STLQ8iUx0Apt0sbBb+OP4Yk3k8UHi19u5sMlOz8
         uOGw==
X-Forwarded-Encrypted: i=1; AFNElJ/e8vheF3B69moQJU5DiskXcZUp2CveMaYDg+YhSJARtm05oGGTTAK6HsfoTW/6TGSnef9al5FI+dtI3rC2@vger.kernel.org
X-Gm-Message-State: AOJu0YxlHcNXrI9KJC12TgDPUB6+WZ9iywpJ/+oqhyrFNRtZG2xgfKm9
	ruStRy8ksfZQq+Q7oliew1KVprelAksOyeuDVqOE7a2z9AsQpsMOCyk/Tp8DLOrM+S3IKdPie92
	31xzmEuuCbjQUpYx/RClhXnkGmeLfNGI=
X-Gm-Gg: Acq92OEIQGPtlkXpHZ4a7LBNjwWHEJ6W2Hd/ldjb/fD8j9UvGHzPw3GJ3JjpOy8WuVv
	FvY8A/TtfLb/ES8lDEUNMxnAW3D8yGNIz3pVvhbUxCGKub2w+pPiRggbfdAhIAr3JJtZ9Ok6EDP
	fyaVyegQuYeS+MtZ4s6sOw2LBAP8jYE9aQcm5rqGAPaS4AO0qbtFStCINKVFkpWT0jFFPTJjhf9
	LMxU96+78kr2CYs6KxhBpW10oyEu4WytU+le+5hRmXyzHmPfsmzrKWbSiBt+C/fuGpRxQ4dKGHr
	JswYfng=
X-Received: by 2002:a05:690e:484a:b0:656:30a1:70ef with SMTP id
 956f58d0204a3-65e2284faf6mr730797d50.6.1778805358982; Thu, 14 May 2026
 17:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511160626.1268612-1-charsyam@gmail.com> <20260511160626.1268612-4-charsyam@gmail.com>
 <CANFS6baeNEftv9Zwn7_tNxhH2B8kEhrWOT14RLyewr1_rhnrsw@mail.gmail.com>
 <CAMrLSE6ZwKd4cS0YnXuKRvYoRMfXTKz8_LH62uD7F-vVR1kGtg@mail.gmail.com> <CANFS6banT3Vc09bFNFTMP2UOjAhYK_EhHCNXPd2uZHX-dbWxNg@mail.gmail.com>
In-Reply-To: <CANFS6banT3Vc09bFNFTMP2UOjAhYK_EhHCNXPd2uZHX-dbWxNg@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Fri, 15 May 2026 09:35:47 +0900
X-Gm-Features: AVHnY4KfToXHrGQhvcD4n-tEuxLnCd4bTsOGYIwGBrW7iCkMH0IRbeotSflO9sI
Message-ID: <CAMrLSE7LpmBoLk1QBpmEZmXfbrJr5xvw20nYfbLaLpmHRWLs6g@mail.gmail.com>
Subject: Re: [PATCH 3/3] ntfs: mark quotas out of date on initial rw mount
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi. Hyunchul.

  I agree that the out-of-date marking path looks questionable.

 After re-checking the code, the current ntfs driver does not appear to
 implement quota accounting: new inodes get v1.2 $STANDARD_INFORMATION, and
 the driver does not maintain the v3 owner_id/quota_charged fields or $Quot=
a
 usage records. So fixing ntfs_mark_quotas_out_of_date() only makes an
 existing path set QUOTA_FLAG_OUT_OF_DATE, but that does not seem meaningfu=
l
 without the metadata Windows would need to rescan.

 Given that, I am wondering what removal scope you would prefer:

 1. Drop only this patch and leave the existing broken remount-rw quota
     marking path as-is for now.
 2. Remove ntfs_mark_quotas_out_of_date() and its remount-rw call site.
 3. Remove the broader unused quota-loading state as well ($Quota/$Q inode
     loading, quota_ino/quota_q_ino, NV_QuotaOutOfDate, quota.o), while kee=
ping
     the on-disk quota layout definitions.

My current preference is option 3, because once the marking helper is gone,
the loaded $Quota inodes do not seem to have another user. But since this
changes the series from a bug fix into removing unsupported quota handling,
I would like to confirm the intended direction first.

Thanks.
DaeMyung.

2026=EB=85=84 5=EC=9B=94 15=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:50, H=
yunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 2026=EB=85=84 5=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:25=
, CharSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> >     Thanks for the review.
> >
> >     You're right that the driver does not maintain quota accounting: it
> >     creates v1.2 $STANDARD_INFORMATION for new inodes, and it does not =
update
> >     the v3 quota fields or $Quota usage accounting.
> >
> >     Given that I do not have modern Windows validation for the exact qu=
ota
> >     rescan behavior, I'll drop 3/3 from v3 and resend just 1/3 and 2/3.
>
> I think setting the out-of-date flag in patch 2/3 is also not meaningful.
> How about removing ntfs_mark_quotas_out_of_date() related codes for now?
>
> >
> >     Thanks,
> >     DaeMyung
>
>
>
>
> --
> Thanks,
> Hyunchul
