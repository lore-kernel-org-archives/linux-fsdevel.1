Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1C30E0EC
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502409; cv=pass; b=V3T8H3DSv4K0I922QF3RyN30pXKYaY5srVQerTzakMoPnzQ9TfYFPBxyEmHWd7S/ZtKg3EkT0aRzCpnb7+C/6xGqdVAwwT55OIsMZEnZclRLzD/yWRmsivF0OYbw5x/F4kOigZecPrXFSLlHa0GboXBLi0+lfbm6Zf725y2e5aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502409; c=relaxed/simple;
	bh=K6zOyPbMHrzbswO+DzCLOtmuWWnKUgiPInGkXEL+YyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Om5dIhCu5Wkg2Ex3OgwPzHPk8uVqnqekmbap3euROqUh+mcq/hcJJoACuM83CWtUwfEXeBoNPUkhMZ4hAs3u4B8rVACpxUd1UcZCdbUe7ts+/1P67ZzCYyqUPQXpaOGJUvjO4wwnaA3GPdiDyaGEDNnSIiQ1pV23moHByfFUO8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi9EidBq; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi9EidBq"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a746f9c092so11502916e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 19:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779502405; cv=none;
        d=google.com; s=arc-20240605;
        b=Xu5AywM5Hjo7B1G/zN9DcpXvID0bbMqu+7t2/KUnfR20B9hNzFrqOlg1GWul1bI0S7
         sRIqRsCV+HKRY/7h35di6bXltDNMGDne1vFV4xvQePSZNWip853GY+zku/C+Uw8624v9
         xfGHejb4t4wFGu3H74TeGDtvBZE63NJDin4Bsxop34re1sYI1BjtlvHlREsQf4jfjxaC
         gTrXxqp2DrBC9uYL0fYkf/8utFSwiQj0QOXDXRJLG6mnQtJn6eTkftEhkBy63cXhYWul
         3yOKBzCZdqzD/gpc7QMEt3X17m8aZ5UYWqqc0H7FOUMw8KK16SfkX8c/SnRPlsPtGJgh
         q4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jaFVPAg2ctBS4C12z/JiOmG9FCxZWWE9UzTSIYLty0A=;
        fh=a1NJmGW2are8f5Rr/Yzzoc+iG7ylek1MqWCctytF0nU=;
        b=Rtotqk/A9v3j7qjvqXMOGdugJLPEWnT3BHdl4NENkO+3ca/tJHaaCKp1gea8RfymJA
         dSKxdVVRy3ezFSxp18pIkSz2XW1VFzLDJRAJMo7mAEy1HeWGULH4ZQ801lRr10QAMjWu
         xxvYzhOri5e8uQLqTCzhQqIccjfHxMTQwjFuFjnpbTQVYA9TTEJ9klbxMqKb4rhkcN8J
         BvC2fLdNCPE2EqZbpVK0ytHyo3tzwwbVFMDbUkRd4fdsZvVvy5Ewc3jqnMBiSz/VCJcI
         n/iWufHygn8ttiPQfA1IqhmP2Aom5hzRg23EWE0utNwM7xUQuzWlZdud53v7XeBItHko
         RBhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779502405; x=1780107205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaFVPAg2ctBS4C12z/JiOmG9FCxZWWE9UzTSIYLty0A=;
        b=Zi9EidBqarKxzNogzZsVqI3RxJVxFzjkzXzme2HpjhYXT5hUa9UHQTYHhgSHzPcu4D
         lLCFP5L+/JpwNsKISQurcQIWHYTPa5F1lJZ1DJUVeHxqk5ek2sjuAdSBBYtgivsrSNxK
         Cu4RGaETJ8clhlPXLGcRK2+hgK+bwkWA6pWsQXn4tgRPGweOmI994MOUiSGFWadBPY59
         YhbEyvpOGKN6Vd0KFvgmRPStJX/nFW6L8J9bTrhZykErqdnc9nSubdj4f6TzySvR9Fmi
         ELbPWuG/hXg5x/sO2qozdVAeSCRiQHS+0LiAK8NZkqO/rAtRpkE1m7NdcoKmatboEL9C
         pUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779502405; x=1780107205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jaFVPAg2ctBS4C12z/JiOmG9FCxZWWE9UzTSIYLty0A=;
        b=EZcdor/oYjxvqLlFMNrm21jSpVwkqaroCXYq3jkXvWUuYmoGa3nctTa7kpot8znoe0
         DxXnd4Q/7XALfL36Tq7paWaL5k0EJmUt1BQ6yNREuEawdoPn8zTnS4MbtUCcktc5HU+3
         yoTxoLj+CKNkecfbH2ryvzdn0+nOuV/1OVI0hF+Dyce+TSi8CT6HWRtKM39BoY4nWIPt
         4by5OIhQAma3lHDSYDVCKtExUvg6SqCjcmszpbzwpjshl1sckB6zEEUjwJzx8alAvli3
         v+kjkvp0zZfIWo6u5rg/IvPN0nMRRNfr4/RxwovPqJN4FMUkNc5ZwSCuiLKV8wcCR8Jq
         4udw==
X-Forwarded-Encrypted: i=1; AFNElJ9VW8IDvQepO9VcM0iZoORyTEYx2vYck6RK+ORpc55RMgg9ysTfndo89qZZ+XQXPBz5ikg8j8uUe4otZgbw@vger.kernel.org
X-Gm-Message-State: AOJu0YyyFh5xJOWEOr3mLv89YOjQ8dN2vfYfUgZJHRPOmxFihh9iBScf
	FxUyDyuYrItVaTgw45FBwtPzQB9/CZeCdj+EGLSJrw83TtAiYKkSu4hYANOVHaOm2FgTyUH4PnR
	WOzYju/fGYdCmvcPI1OQQMUy31CV1G5I=
X-Gm-Gg: Acq92OG70C1zb7+De7+V6mZtebpBHPsesHB9xpPyHiunaERgONoqRsWytAvizTbs3i9
	maUb1hxgbSfdplTepvqhFSRbR6GkNoPDM1U+ubeiZfzgSWZCany5pdZ91yeoM/JWUmo68HZImKR
	RFE6F9aYDMz8u8c+Mn1rkmcj33mVv7iIUGmoDtrAUlY2BWGboR3t1PIDCiePKXM8CFiwGb7C/yr
	bOw9dve/+8yfC0Jz8ZLvLsMRBID//GA4+N6Fkme5tn6Nsk3T00L9wn5flOMBx9bB38QMFbGsr+z
	CuX70sU7uQ==
X-Received: by 2002:ac2:5606:0:b0:5a8:6ee0:ff40 with SMTP id
 2adb3069b0e04-5aa322c9b4fmr1094669e87.7.1779502404509; Fri, 22 May 2026
 19:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com>
 <20260522-t-fix-oob-v2-v1-4-0bea6582a361@gmail.com> <CAMrLSE5RmLD0c7dgOmHRCRhhekV7U-2V_r0QgX2Q+MH0hy0SMA@mail.gmail.com>
In-Reply-To: <CAMrLSE5RmLD0c7dgOmHRCRhhekV7U-2V_r0QgX2Q+MH0hy0SMA@mail.gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Sat, 23 May 2026 11:13:12 +0900
X-Gm-Features: AVHnY4LjcmnBQ3KQ8GbFtSWJZB7MSPmV-a2_gMZ6_ufA4fCKIC3OAmHn_CpQ6uI
Message-ID: <CANFS6bYqijN2mf4kBnvAKi3uoVFGzaTvk5PEH1ceV0Zy3=X=oQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ntfs: add bounds check before accessing EA entries
To: CharSyam <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 10:16, =
CharSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi, Hyunchul.
>
>  Since the new in-loop check makes the pre-loop guard a duplicate
> condition, dropping it
> would be cleaner:
>
>   - ntfs_ea_lookup(): if (ea_buf_size < sizeof(struct ea_attr)) goto out;
>   - ntfs_listxattr(): if (ea_info_qsize < sizeof(struct ea_attr)) {
> err =3D -EIO; goto out; }
>
>  On the first iteration offset =3D=3D 0, so the new check evaluates the
> same condition and
> returns the same value =E2=80=94 the pre-loop guard is now redundant. The=
 OOB
> read fix itself looks
> good to me.
>

Okay, I will remove these conditions.

> Thanks.
> DaeMyung.
>
> 2026=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 9:51,=
 Hyunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > in ntfs_ea_lookup and ntfs_listxattr, this verifies that there is enoug=
h
> > space in the EA entry before accessing the next_entry_offset field of
> > the EA entry.
> >
> > Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> > ---
> >  fs/ntfs/ea.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
> > index c4a4a3e3e599..323caced77ea 100644
> > --- a/fs/ntfs/ea.c
> > +++ b/fs/ntfs/ea.c
> > @@ -58,6 +58,9 @@ static int ntfs_ea_lookup(char *ea_buf, s64 ea_buf_si=
ze, const char *name,
> >
> >         offset =3D 0;
> >         do {
> > +               if (ea_buf_size - offset < sizeof(struct ea_attr))
> > +                       break;
> > +
> >                 p_ea =3D (const struct ea_attr *)&ea_buf[offset];
> >                 next =3D le32_to_cpu(p_ea->next_entry_offset);
> >                 p_ea_size =3D next ? next : (ea_buf_size - offset);
> > @@ -486,6 +489,11 @@ ssize_t ntfs_listxattr(struct dentry *dentry, char=
 *buffer, size_t size)
> >
> >         offset =3D 0;
> >         do {
> > +               if (ea_info_qsize - offset < sizeof(struct ea_attr)) {
> > +                       err =3D -EIO;
> > +                       goto out;
> > +               }
> > +
> >                 p_ea =3D (const struct ea_attr *)&ea_buf[offset];
> >                 next =3D le32_to_cpu(p_ea->next_entry_offset);
> >                 ea_size =3D next ? next : (ea_info_qsize - offset);
> >
> > --
> > 2.43.0
> >
> >



--=20
Thanks,
Hyunchul
