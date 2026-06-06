Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20D4071E4
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780789480; cv=pass; b=p9whgIcggRlz6mznd6RZUViGMwEbXBDcEPu00hmOC7O1MeWqvxwUIzZhT4TMQkrWLcc33pMm7L8/220z+zCCr2eV9aS6IOWBsNIfGPJ/OLh3orKAUZYAFEDGi5avbkJkJSp5YVzUcXhEYYUayt1/hSjDX6j/TL55D2UfVWZBn6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780789480; c=relaxed/simple;
	bh=iMvB60fAOMvOHRu4X7RwieJvpWBgUHZlMrvvRQWQISw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBlJcm/rQ36cVfLRx4eHRe9fV6Y3wObtlTZKrpfW0ANxZS+53VVHmAsFtro2zE3doKjpsb6f7Rxt8e52tKQtBj4Hzg3CdQ0QY+RJODszZDGXqJhIeP2lI1OBEioSEVUY0q82/MXhz8QSUZWBbkD3D6VkAOGIMwSFddAP0hdGcks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMkeLSsT; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMkeLSsT"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7e2cb01a974so35005097b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 16:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780789478; cv=none;
        d=google.com; s=arc-20240605;
        b=h8bJLJzgRgquYj8arlZyEFSkSv2Gzqfs4N25Csbg1YyXxErqJZta1cTA5/hCYB7kbE
         Y9DUD4B0LCZdbFSH2o8bHiF1f3ar/5LKtBmsXvDfXJrqVPItxHpeXQWeHsKa0V6LrUW3
         i5wKh5GTc/LMZWTD1bSlnG383U1fMtSHBIonCgroIhG7RuznASjijyKaB9U6s7+yNK5N
         7ILR0qYrwSnq1KEFYa3yReG8FKjjUX37KM/FKd8bteTjwdPmNXO9QBeLxmBwt+mzvH4a
         0+F5QlotIY2tUrKjw0uVSBrMWAuu9joURutRpNpdJ7fchFsL6Voz3UQNJF1sluoL6UJx
         AU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuZ1FvI1Asub+qX8HcYJreGLJSMw3rCglkCCQXzHxLo=;
        fh=w4811Ozaw/s2PAEqCYpz2JnbLsLF8ai2CKDPYX0ww8Y=;
        b=fl92S2p2KX0eiL2iLisIl5eabw16uQyS48E+vuSlJL84MYMhcKxrHy1Ubqr7jBGVco
         26AZh5adpvRzj9/A6dzJd1sx1a0gDVhVMe7fWVlES5g3CsWhKHxCwAfrHFkhZbpA58KX
         gihLlYUBdWJ+XardE+YgYiER3quPFSaxKs2d5f/fOQWvWLevGOs1Vs3jEJwfbM9V9OC2
         +qmTvRxQj5uOiyLRgJiLfUJ/gg5g+NnoSnWO05e3l2VcOCYmMbyZ4tBPQ8ojzwHuJmwQ
         s8Fnkun9NiAB6IJgaKLkFc31TT/h82y5c2eugOFAUpdxL+9wywFw4ePikbF4OXj9zsxb
         E0WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780789478; x=1781394278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuZ1FvI1Asub+qX8HcYJreGLJSMw3rCglkCCQXzHxLo=;
        b=YMkeLSsTwL+cBLcFdSZ453DKO2Dg/HciU2OVIK5VFoE6HjMCtSlNmg2kzwGvo9SiyR
         0a3HccIb4JqnscVCp9rJHeBsKuxiJp5BlU0VhutVLZHKKwBsxM1ca1yFWlM/aravHrPN
         keFPLpdbVo5I/1uE+G84NEIadU5bToN+faGJQ3DkGXzQNfEtRP0ptetzwC+IgQlAmwGV
         1A7lHwr57kMtFETE7KN9LVy1ilGdeRDc0aBxUeRRygnfjHxCb88wNakakG30tplQw5mz
         v6YruQbMNxFuF4S1ZSuKxxkZdu/HSad1OviWjywJEqIY3Blxq8ZsROr0+6ro/J5LDnLt
         yNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780789478; x=1781394278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuZ1FvI1Asub+qX8HcYJreGLJSMw3rCglkCCQXzHxLo=;
        b=eXkKMt6KzcAGNB/fLAJ5zYZWRf3flnJMAndvFjsFlgJF3P87nJ+DJfakx4yUiNPigB
         qndBgAr1dnjb3PD3mz6uxy0LGarQ4Sc6NrlMmCEn1uwy6G7/Ou0Rxo9x0vCSvUNt+RPr
         M5tLryaHNbhh95TZUz4xcpDUVUXcZIBBAIiLo2hbewsQrWbCHhkF9l/+uvtJe7oqZgg0
         WwHhZnamtwVuuhxWbYBmR+/fg6jAn8o2wR+PinyXvBc8tvYHiOP/8dAG0YPrQvh8pzi4
         qSjq+f3/P5Ao1u3Se2qBGxbLO8Jy0kiQcKE83ixQb5QxKuIi6BTwNAPXSbacHnLxSlOZ
         NdDg==
X-Forwarded-Encrypted: i=1; AFNElJ+bG6wFJcRawDZjS47XdVbv1tQeMXm0cICIPrFj+aL0/7ELP2SzbSPzrKjHTZUNpOYpY/a7brKDcdgRkxo6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy5cuDj3Q5VBLNylKXwMHTkik5j2O/KHuJmR0nHrZO+lyeTyZT
	u9uWuofZLmHGdCliroelUJz2Efe5VF2bLZs8gKRHMPCrodS2XUqzwosCthbLl89S2o7aA1if07D
	PoFmEMjHps9U5eKHdL5uuDJMXdTjSwI8=
X-Gm-Gg: Acq92OFV4KTp3LHDyb+9oDP2jAKshYX/itN/Z1Q6JPqZHE2hrnNL3hwI7JVmXawrvLf
	14PVn3oKgUc9FxnUxnDEXNkXM2ANwMZQelCc1VUJ6uWp6epa5pXiohVCVMvg/XkTB+7f57+mkfo
	HK0VPp+By4tJ4JcT7lxQBbOkZ2bc3SzIPIhF5Y+POKpKsQVEuJV7wvoIWQ+8XaTbUhY0ovn8akG
	kOQZa3IKu5kgXqmMHTnET+4KylE4su/RFCV6QdSXPAvV1Iz/MKvJ/UPw34UQTqu4YPtgWkCATCg
	Od/dGmkzOo3Lthix4qJRMWvrpej1CWOvJwkHdmsX9WS1CBY=
X-Received: by 2002:a05:690e:4842:b0:65e:b05:7679 with SMTP id
 956f58d0204a3-66106e04597mr5557213d50.3.1780789478449; Sat, 06 Jun 2026
 16:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606222857.193818-1-hexlabsecurity@proton.me>
In-Reply-To: <20260606222857.193818-1-hexlabsecurity@proton.me>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 6 Jun 2026 19:44:26 -0400
X-Gm-Features: AVVi8CeGzEtVSWhzXeLQiOzWY7eFPYTqNZxYhZX4Txi2-KLfM3pV5PxxbNgax6E
Message-ID: <CAJJ9bXzdj6Xxa6wXApV_TtCni1sgEryHmV+=iy8yECGNYeMSvw@mail.gmail.com>
Subject: Re: [PATCH] isofs: bound Rock Ridge symlink components to the SL record
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 6:29=E2=80=AFPM Bryam Vargas <hexlabsecurity@proton.=
me> wrote:
> diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
> index 1232fab59a4e..0fe781381e66 100644
> --- a/fs/isofs/rock.c
> +++ b/fs/isofs/rock.c
> @@ -466,6 +466,9 @@ parse_rock_ridge_inode_internal(struct iso_directory_=
record *de,
>                                 inode->i_size =3D symlink_len;
>                                 while (slen > 1) {
>                                         rootflag =3D 0;
> +                                       /* keep the component within the =
SL record */
> +                                       if (slp->len + 2 > slen)
> +                                               break;

Thanks for the CC.  You beat me to filing this one!

Your patch is better than the one I never got around to submitting,
but one note I'd mention is that I returned NULL here instead of
breaking so that readlink() would fail with -EIO downstream.  Maybe
I'm missing something elsewhere, but I think this design results in
silent truncation and a potentially confused caller who thinks the
symlink was successful.

Thanks,
Mike
