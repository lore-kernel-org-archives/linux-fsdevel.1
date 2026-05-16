Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3747405C4B
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778947142; cv=pass; b=Z7rkujlNstj5O5cak+bmCyiYvX+U/L71TrSs78Fn+RTqjOkXlwZtNzNQk9Bre8X57BIukKRJfz4gbarrgaM3qjyA3eBRpa+dEjREMyI9RHMevsBoiNXWiEV1iOJ+3ix+XOPHuLhRbI1Yj/jKaoRY8LYuAGEIrvGiiz6w91EVLVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778947142; c=relaxed/simple;
	bh=rTEw6lhQEeWWRvy78R7rwNu7M9Te8VQNIHKucihppOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adIfidyvkKykHwVW9zg4WrFs3nEMZ94Sh5sY77vaU1XL/lEAhXr55W2P0IO//lorOTvdRSlPLaORpw7IEopPMyUgqq1rDEHun970/QZ65BBhjmSNJH6hlsmfAND3RkmBQ3MaV9+YED0Zjyl8MUAKuEpgEoWxRkgc+FhfwRtJ2tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVu1vtLG; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVu1vtLG"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7cac99f837bso492807b3.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 08:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778947140; cv=none;
        d=google.com; s=arc-20240605;
        b=JN5bHvRuni/819FWyXnuBsSJaKzyqrNgoUWWE0GYCFH+P2/nd6t7dD2H5kTznNZOJR
         xpWf4Nyiu/GXvuIQ9Ad/4G5T3pKgTFQ9wc+2ZD4eVsKo8O3Bo7hbOLkfMgmfYPO0bzg+
         6bZxKkkUtCW4c5wpfBXfBHau8Miv7j9YeFZSyAVSX2E3OMRlUCAjW16DZtbC9QIAxkxg
         5/ayUg1bFvir+KKIUEFPk2QZkj/CsXPa6l9BEezCfOvRkHIk8m1/sEqLMxrNIP6kAwhw
         5kNaVw39CRDa7fDUun8WNk7FP4tC5Q/dpYT1axxR2vf5bHyudFqRgEKGyD+lgX9Oc4zH
         FhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T+0NnhEuPKw1NILBCeE4vjRZ31fQmwEjLwiGyKn+NFg=;
        fh=moNTyEtuVnp2HTUxqZP1+0wu80ESplQua8hCXyWEFA0=;
        b=PzwmNeLGQGiSvJTZinqt7GRtgQaWd2WKQ9pfJ4knMo8U6/e4OL3OG444xt4VGjxnEY
         nIZV24HRiM+T7d7sR/AF32OORflgtm511qZHjVZR1eCwvzcuCgHWl6mqXCBqka92tpap
         A3K0xUwFkvIKR2PKrSA+FhTzFVgw5IlL1JLURGzB6A5LKq5AMlEvHpyGQz/uVP+XaZ5k
         hCiH/xIlBGul7axEm3zN6N1FWW5JPg4G3N4NzAH9hBtp/K0/E6bhmeaPiEd6BbvNtBR6
         m/6eECksIYQGyQjbMIuvkXjLaGhBiF8nC+6ztsw6ohLF4kW7L6c9syhq25r4yfePSdFn
         3iJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778947140; x=1779551940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+0NnhEuPKw1NILBCeE4vjRZ31fQmwEjLwiGyKn+NFg=;
        b=JVu1vtLGFb5CnXVkcy4zo1kC9xoWS5Y1Coei0nYboR+Qbp0QpNdh5AJVMHgXg9KLxn
         oyK1t0N/H94xIpD9+Bm04vyxN2/bkAt1HYhwB/QGYm4YzdmhNDQcjig7bIXZTM0kf0bz
         CKtn0uNGED47pa9NiTutV8hTZNA5w05IlF9BOzc1NGA8fCuD2Ntlg/6lbcl8IZVlVq9P
         xP3Rusd0BpRforwbOxD51+PdEwkHZMJmG+kOFKgG35oa1EtcwXDFsVvR+78tcmi9jZfv
         ceOrw6ReR/80T7oxx4jMp+grnS/lVmZd/9u5Q2zdXKnmd6lRqvhbBIdhzpe+JBUHRfyS
         TG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778947140; x=1779551940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T+0NnhEuPKw1NILBCeE4vjRZ31fQmwEjLwiGyKn+NFg=;
        b=lQubSdx27GBAtJHA5dvqvpeAUaSWOWV361TJZ0xX4F/VfcBRuJu4i8Ywu5G2bX4nKn
         EzpbxeyIA7HYw2ZKN+W5FO1AWYVrgxCMctMB3IPJ8PNuKi2Vlam8XhxMuVJS2ZZjTLUX
         AFgbsZa+3lc4mdh4gfH+ice3kktM7shtqxOtL5EU6FHS8AjzDSUulNpufln+dqM61syU
         Y0dWLzcT7OOPmcUH3AZvo4376KOTC4GxRmcGE7A97LMMBGA3U3Mc7US2K2SWlztslWCk
         s94coqtB2kQsA/u0QwYjQZ2OsjrY3lMHLu1YQikreNG2JYW0h3uNnMrnBQDVEKA9B7gn
         BM4w==
X-Forwarded-Encrypted: i=1; AFNElJ+gCP8S0Wkd0RXNzqOT7wo00BrirQby1HzvRwCVcgZ2bsgf0S4w8nD7jCd/VJgIWacycwf2jgoAubbVjwmg@vger.kernel.org
X-Gm-Message-State: AOJu0YwErU/rF1yNeY6TsL1PZJomCeLOiWIpNTJtzlb1+1EVpBJyzg5h
	0tciaGkJLNSP0D6o2mH0rdxOkchIcWeTFQaP5eWBWK47kAnnM4eBU+hxcRmBaDOgdtVCbR8Tffp
	K9BXjXMN7RXylEXLxA4/WY0q5q8hzs1s=
X-Gm-Gg: Acq92OE8fxpuSdpHkvDJ/TfWLvqPzTNI05jFQ8TULXqCFL8CYVQ1nfAy0nOVSNvjZbL
	RiSYgqbq/lA+3xnPRMWw6+G16/mKq9TDCvb1+lgxwz+ghN+/5PV1+fbG+z+wH+JNsNiwBD7wIH9
	493uoJrF5yH8vw7CaQ/4XWSWOKjBzFWwemCI+UbrS4poas7vhPKW9UInDuFNblAjSMvDzFZGMPk
	IJYLCD/rYDfLldPjuwngZT1Y6HkhpldPnXcCwFZXo1liGQcQc3G0PxnqYBSwsybid9SroOtFrDj
	meF/1wP6
X-Received: by 2002:a05:690e:1443:b0:651:bdff:db07 with SMTP id
 956f58d0204a3-65e228823d9mr5335705d50.7.1778947139777; Sat, 16 May 2026
 08:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511160626.1268612-1-charsyam@gmail.com> <20260511160626.1268612-4-charsyam@gmail.com>
 <CANFS6baeNEftv9Zwn7_tNxhH2B8kEhrWOT14RLyewr1_rhnrsw@mail.gmail.com>
 <CAMrLSE6ZwKd4cS0YnXuKRvYoRMfXTKz8_LH62uD7F-vVR1kGtg@mail.gmail.com>
 <CANFS6banT3Vc09bFNFTMP2UOjAhYK_EhHCNXPd2uZHX-dbWxNg@mail.gmail.com>
 <CAMrLSE7LpmBoLk1QBpmEZmXfbrJr5xvw20nYfbLaLpmHRWLs6g@mail.gmail.com> <CANFS6bYTzioqZjYt=51Kb9RdR3MKXaez_fh_WCLoym093VxFmg@mail.gmail.com>
In-Reply-To: <CANFS6bYTzioqZjYt=51Kb9RdR3MKXaez_fh_WCLoym093VxFmg@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Sun, 17 May 2026 00:58:48 +0900
X-Gm-Features: AVHnY4JfQlqQOUNvHifSYG9vhWj0qHQ1Hln2HVJmoGk40-9EokhFjReT08YkRTk
Message-ID: <CAMrLSE5Jx02vOOdwsORtzhNfwuaEoE==ndNAxcqEdAG5jMdzyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ntfs: mark quotas out of date on initial rw mount
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Thanks, I agree. I will drop this fix series and send a new standalone
patch removing the unsupported NTFS quota handling instead.

2026=EB=85=84 5=EC=9B=94 15=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 10:14, =
Hyunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 2026=EB=85=84 5=EC=9B=94 15=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 9:35,=
 CharSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > Hi. Hyunchul.
> >
> >   I agree that the out-of-date marking path looks questionable.
> >
> >  After re-checking the code, the current ntfs driver does not appear to
> >  implement quota accounting: new inodes get v1.2 $STANDARD_INFORMATION,=
 and
> >  the driver does not maintain the v3 owner_id/quota_charged fields or $=
Quota
> >  usage records. So fixing ntfs_mark_quotas_out_of_date() only makes an
> >  existing path set QUOTA_FLAG_OUT_OF_DATE, but that does not seem meani=
ngful
> >  without the metadata Windows would need to rescan.
> >
> >  Given that, I am wondering what removal scope you would prefer:
> >
> >  1. Drop only this patch and leave the existing broken remount-rw quota
> >      marking path as-is for now.
> >  2. Remove ntfs_mark_quotas_out_of_date() and its remount-rw call site.
> >  3. Remove the broader unused quota-loading state as well ($Quota/$Q in=
ode
> >      loading, quota_ino/quota_q_ino, NV_QuotaOutOfDate, quota.o), while=
 keeping
> >      the on-disk quota layout definitions.
> >
> > My current preference is option 3, because once the marking helper is g=
one,
> > the loaded $Quota inodes do not seem to have another user. But since th=
is
> > changes the series from a bug fix into removing unsupported quota handl=
ing,
> > I would like to confirm the intended direction first.
>
> I also think option 3 is the most appropriate. I would appreciate it
> if you could
> prepare a patch implementing option 3.
>
> >
> > Thanks.
> > DaeMyung.
> >
> > 2026=EB=85=84 5=EC=9B=94 15=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:5=
0, Hyunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > 2026=EB=85=84 5=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 1=
0:25, CharSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > > >
> > > >     Thanks for the review.
> > > >
> > > >     You're right that the driver does not maintain quota accounting=
: it
> > > >     creates v1.2 $STANDARD_INFORMATION for new inodes, and it does =
not update
> > > >     the v3 quota fields or $Quota usage accounting.
> > > >
> > > >     Given that I do not have modern Windows validation for the exac=
t quota
> > > >     rescan behavior, I'll drop 3/3 from v3 and resend just 1/3 and =
2/3.
> > >
> > > I think setting the out-of-date flag in patch 2/3 is also not meaning=
ful.
> > > How about removing ntfs_mark_quotas_out_of_date() related codes for n=
ow?
> > >
> > > >
> > > >     Thanks,
> > > >     DaeMyung
> > >
> > >
> > >
> > >
> > > --
> > > Thanks,
> > > Hyunchul
>
>
>
> --
> Thanks,
> Hyunchul
