Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E963346FC3
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807645; cv=pass; b=KmpC6EcdVE+t5awHFerdmOMpEiKSneBseZ8qCuQpj+83QylwOe3E85becUjKQwc/bx5YJylVwDSj0plhk7dNKy7fFcUMws47NlIWxm5rkqC83iKVkQg54sGPJriaxsDD08Z3Mm1Ox0cmRb4qa4vZOiHa1sLYFlpcsX4CdACt3i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807645; c=relaxed/simple;
	bh=DwMZN6cEH/U5Ugaz9o+OHjAR8MhU1V3JrQ73fihSPs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rY9pWSqT5WPM8Vctzw2ine1/sSKAi88RDrsV8AYgOXJNiWD7kzOn5x6dpLOh4vTMag/UPDjgHK9+bbT6I10iSwvGky0mNImYZ0YxsyJlvBukBJv8gpwgD9Sx8NTKtBW8opNVD8Bk/1l2s3h3YN7FmfuFDpjAfGL6ZkMc5W+BFuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pl3zCJ2Q; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pl3zCJ2Q"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a8891f0c88so5165643e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 18:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778807643; cv=none;
        d=google.com; s=arc-20240605;
        b=D31rE/CzcxHXJvB+8gPJqN2ZjlQxRAFdmwmztMbW4oyBSTBHT2orxlr3qyFtKC5UPI
         6xgkYdPurOekc951qteFMgj3DxvP0cbr3IOQKXiozq4iaQOED6oo+PfTs4AL/oFju/yh
         u3YHY6LZ8U/quAQUIHyjdBfydGppu7Zm7ONYomQl+gmjZJ6cY1DmjD785fYQ5/pgu/Zy
         C5/IBJP/+sGgTLO5p061jbLb11hY1ZV+Lf2Rl/b63WzWaogKNuf8qQ7yG+tVMDfXc8h4
         Q0ZGy++mJFV3eYu+3tps7hiI3pGgA0J7H/v8LUwwLRfyzZcDwYD37IHV5ac/SlfoOMxP
         bmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8e8oGE/qck2zu6KRQiaiqmKPtMaYysZJXDGkoLn1hu4=;
        fh=UKBmweBHFIzyl/4LFxcpd+vwR2AYhG3J8YhiMSxqIHw=;
        b=eMkDedu3t+6BoE/BQaTZ7Cy/AMK81lM3HO2a4GIEgjViuTIZ7fLqX9wbonek9hzcrs
         Yx5hYTSwiii4oNHUEJq7GPNC+rC82whzSB01Dh9JyU8fQ7Cu/LzzdHTGrXtXf0oNaKAW
         DoqfkH/RzW6syz8Zfcybi9exoIxPykE+MuzcME51SDKiKq7e50ycLzc2fSxCTaYLs2bg
         MMVXIaXstUr8ruRtDpFIyIQ5vNgUryBkhXUtH7FONztbRYTYZPXUUUksJ4yt21XDOpv4
         au9opZcmr1kPXsdOccDn6QDD0IaK5e0MUAQqRXO3EH1YnvtEQUl+73Zpmr3n3FD6WsOg
         Dy5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778807643; x=1779412443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8e8oGE/qck2zu6KRQiaiqmKPtMaYysZJXDGkoLn1hu4=;
        b=pl3zCJ2QPaD3hdK9DvaGk9oXM6tdpnMdRmt/zgxDvnDiEIxVQ4nneNpzocNRsBFvvj
         zHX4WtG1zewr4HY+yZYRG9wnl/w2X/sChr+KdS2PIsY8hfBIaWW+zsUY7Iv0Jdi9Zdxy
         QzGWb3JmCc30db+G4/nm786zM9tBfSY3SZEfGU4JsRETTTVD2yS5AvMYdvq0sy6sjvu9
         m5S62yhLXOH1iCzPNyOIl2L9+Y9tgMP6GFh7PamYGEX/9u2tHJ5gZPJsFS+zJmb/OIv+
         XXhdMXar25yK6B4LrEmB65SPD4JoEMLPHOwfldggB5/ax3vJscDxIpsBerTmiJ5ZH21p
         GhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778807643; x=1779412443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8e8oGE/qck2zu6KRQiaiqmKPtMaYysZJXDGkoLn1hu4=;
        b=i3GFMASO7Rr2FdwbMvkxo8VCfY1BBdnHlw8DQBQ43PcEi6+m5A3rHzJ4xrtEPyEtgg
         aW1GCCPmMYjf2KXgmf/+/7w5oOkV+eamPDMCg6VYNJqQ8J5BBi8kjSNwZBUeSsK2ogZs
         kB8Kk0z4nM1Vt7wsiy/wF75NHST5kwdLjXW2Dfr6Sm8FAoWCf6HPQ8ZejYnktLw7xtx6
         Paef6CHgLW0td4Js2vuvg2Xj7hGryxhonGsEKCjDfz2JgTL2eHT4lG1cV5dY9FLP87mn
         B8wj0Mtera14x/TaEv42MKVmEQQz3DzeIE2Fhm/GtG6dHOTxADWgbOFTWnyAA0AjjO92
         0t+A==
X-Forwarded-Encrypted: i=1; AFNElJ8cZNB3lRxnY1FFNthjbIe79V1DpffXH3hUNuFIboLHuIfUvaUa5+1P/jG4SvB1GnVCcQQHxRALsksM0hi9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2t1b/IQH80QIurjCwM6XoYsG3sWsFQOg3vmIoqel6PV6iy2xj
	o/cQ/p/jqQR7XxSLU0lt1MlDH4zZ5BKbNRSPB8vpIsHMcOYf+WzwXbOdtjqQ7vOvpEPcwcS1Qny
	1upAE4X+4UpjuwwCvD/IkLaJlKsyi7Yc=
X-Gm-Gg: Acq92OHVKdf661m+exiCkF3YmhInGj0MNyB/K93/t3vdrB9TGhnkoHEPoIDrHW880ZP
	RQW2m4RucEUSe4bP/4aJC9WpfyfrH4iE7oqMsWxJC/bxJ5zO10fUaROy38WGatSXP+uS8x4V2gU
	SxkPEm4tpvIzWLDPTL73Qcn/qOWgdShfHSkFXpIdNgySLy8jWP9kkq3rvgOfro45vPZNrZONEOO
	gb8tJHnWnHuzl9O71TmEuxIj6vH/MdzjE8LNHXRlSkqPIsvBXbKWKf7nGhwmaPYxQ22rqCo0Anc
	GiOd1IE=
X-Received: by 2002:a05:6512:ba1:b0:5a7:477f:41db with SMTP id
 2adb3069b0e04-5aa0e60a8f8mr390662e87.10.1778807642375; Thu, 14 May 2026
 18:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511160626.1268612-1-charsyam@gmail.com> <20260511160626.1268612-4-charsyam@gmail.com>
 <CANFS6baeNEftv9Zwn7_tNxhH2B8kEhrWOT14RLyewr1_rhnrsw@mail.gmail.com>
 <CAMrLSE6ZwKd4cS0YnXuKRvYoRMfXTKz8_LH62uD7F-vVR1kGtg@mail.gmail.com>
 <CANFS6banT3Vc09bFNFTMP2UOjAhYK_EhHCNXPd2uZHX-dbWxNg@mail.gmail.com> <CAMrLSE7LpmBoLk1QBpmEZmXfbrJr5xvw20nYfbLaLpmHRWLs6g@mail.gmail.com>
In-Reply-To: <CAMrLSE7LpmBoLk1QBpmEZmXfbrJr5xvw20nYfbLaLpmHRWLs6g@mail.gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 15 May 2026 10:13:50 +0900
X-Gm-Features: AVHnY4KcRtUF5ejIiwB5Vc1zcT-DuGvD__nXqgR6UBd91fu4ZwrmEa0v7v5D-uc
Message-ID: <CANFS6bYTzioqZjYt=51Kb9RdR3MKXaez_fh_WCLoym093VxFmg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ntfs: mark quotas out of date on initial rw mount
To: CharSyam <charsyam@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 15=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 9:35, C=
harSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi. Hyunchul.
>
>   I agree that the out-of-date marking path looks questionable.
>
>  After re-checking the code, the current ntfs driver does not appear to
>  implement quota accounting: new inodes get v1.2 $STANDARD_INFORMATION, a=
nd
>  the driver does not maintain the v3 owner_id/quota_charged fields or $Qu=
ota
>  usage records. So fixing ntfs_mark_quotas_out_of_date() only makes an
>  existing path set QUOTA_FLAG_OUT_OF_DATE, but that does not seem meaning=
ful
>  without the metadata Windows would need to rescan.
>
>  Given that, I am wondering what removal scope you would prefer:
>
>  1. Drop only this patch and leave the existing broken remount-rw quota
>      marking path as-is for now.
>  2. Remove ntfs_mark_quotas_out_of_date() and its remount-rw call site.
>  3. Remove the broader unused quota-loading state as well ($Quota/$Q inod=
e
>      loading, quota_ino/quota_q_ino, NV_QuotaOutOfDate, quota.o), while k=
eeping
>      the on-disk quota layout definitions.
>
> My current preference is option 3, because once the marking helper is gon=
e,
> the loaded $Quota inodes do not seem to have another user. But since this
> changes the series from a bug fix into removing unsupported quota handlin=
g,
> I would like to confirm the intended direction first.

I also think option 3 is the most appropriate. I would appreciate it
if you could
prepare a patch implementing option 3.

>
> Thanks.
> DaeMyung.
>
> 2026=EB=85=84 5=EC=9B=94 15=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:50,=
 Hyunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > 2026=EB=85=84 5=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:=
25, CharSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > >     Thanks for the review.
> > >
> > >     You're right that the driver does not maintain quota accounting: =
it
> > >     creates v1.2 $STANDARD_INFORMATION for new inodes, and it does no=
t update
> > >     the v3 quota fields or $Quota usage accounting.
> > >
> > >     Given that I do not have modern Windows validation for the exact =
quota
> > >     rescan behavior, I'll drop 3/3 from v3 and resend just 1/3 and 2/=
3.
> >
> > I think setting the out-of-date flag in patch 2/3 is also not meaningfu=
l.
> > How about removing ntfs_mark_quotas_out_of_date() related codes for now=
?
> >
> > >
> > >     Thanks,
> > >     DaeMyung
> >
> >
> >
> >
> > --
> > Thanks,
> > Hyunchul



--=20
Thanks,
Hyunchul
