Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C993B27DF
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087448; cv=none; b=lHCORkR8w0BdraV7wLpGsF6eKd2iCkHuM7VfL0bBgqenlXnn7xFxowqunrwofTaPRB1TaT0WJHPcZrk6TaQ3cCirW5el2CqZSc2Lt5CvYf4uh/uZ13cVvlje2XlIX8gANKMYO/zWgfJKR2nt+FprVOTmUIeXCXpx9dRDI5Spy8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087448; c=relaxed/simple;
	bh=2gun9awslWmnOUk7vHHg7+tSvXxlTpwhwFgI0Ta3SS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJ53gaeNNRPPprCnMaC7ay3igHB2PDsiZ23Ndz+i4cfG1bVJadz2uV0l5npFOmoTu8gDVraDmmWEysTenMlVTwChdhL7j8ouxSYqkRX1cPXB2KeWT2W857LGBrhiE2Tfs82VyLttPfBKFMqEkbAV11F4zRxcJLNo6bWaCpKa27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdF23cCx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdF23cCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79979C2BCF6
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 06:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779087448;
	bh=2gun9awslWmnOUk7vHHg7+tSvXxlTpwhwFgI0Ta3SS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MdF23cCx3hg+kOp9rWKFNL1CpxXwApZFSZMxNjgg4WaVrQkvU2q5fpTK5UvFVUPJK
	 5ocxf5AegNWQX5UHHX0RY1ySR3YrSJeUpJBP5ti19gXiUKVkTX3EN6xUywhUx4pwrR
	 rkqEAtQ2uwinczTicY4jb32tx0yjFVuNcwwZlbTIY5MVxStdqNPbnqwlyiXD90ePp+
	 hPw/b8y9juwSHNMWfv9wHGarNECpfDECbsfcmwziHc46u29Vtt7zN5hEabF74l2KKq
	 KuoXFkkktrPPl3bUSArsHl4WP7DApax31k3Mcf+It5XYfxkbQZa4LC64QZJVzxtN4p
	 +5xaloszQ/zrQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso2288156a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 23:57:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ998tknXqFIllAIJ34j/iH23NSRONVzXQCbiQEcc6wTQx+v9ebrV1RyLjTh/nfAxRhzbkHvN5FR8YqpiOEe@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0iZdWE/0QKYpKDnaWLFRi2NQpn69I9BJwKUuTsOiAfNLA3R3
	e9wJYIOgpCURNeuH2wI5SaOfmA72TRqi9KHAjgRHgEGh6oXIkNo0wK69wO416vTG8tYY0/JXvft
	V9c3qC6kIMGAH4Ex7v2NG7UnYZjgj09s=
X-Received: by 2002:a05:6402:13c1:b0:67c:d93d:89ce with SMTP id
 4fb4d7f45d1cf-683bd99e2cfmr6424731a12.23.1779087447125; Sun, 17 May 2026
 23:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd8z00CwRgbQbU8U15svgyOT6RK4XH-xcaq7k3dBbsRqew@mail.gmail.com>
 <20260517184141.21939-1-rochan.avlur@skydio.com> <CAKYAXd_PUKHpL4xtkcS+5iDGwf+WgEOFvM4T_XZ4SRtk8-jCyQ@mail.gmail.com>
 <CAG7tbBX6O2x148dDbrHs+=c0LSdw=8CKXEWZ9TniyxFYy5Ln0g@mail.gmail.com>
In-Reply-To: <CAG7tbBX6O2x148dDbrHs+=c0LSdw=8CKXEWZ9TniyxFYy5Ln0g@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 18 May 2026 15:57:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-1P-bPV5PuUa-cePaObUzmQ+9qTA48mriivEeFeRcvWw@mail.gmail.com>
X-Gm-Features: AVHnY4IIRukBj12dN-8DMP9TMWcRu2QctAPa1FFSCdn6m_3TduMgZO6_a0r7-uA
Message-ID: <CAKYAXd-1P-bPV5PuUa-cePaObUzmQ+9qTA48mriivEeFeRcvWw@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: preserve benign secondary entries during rename
 and move
To: Rochan Avlur <rochan.avlur@skydio.com>
Cc: Rochan Avlur <rochan.avlur@gmail.com>, linux-fsdevel@vger.kernel.org, 
	sj1557.seo@samsung.com, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

> > > @@ -1056,11 +1117,15 @@ static int exfat_rename_file(struct inode *parent_inode,
> > >
> > >                 exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
> > >
> > > +               ret = exfat_copy_trailing_entries(&old_es, &new_es);
> > > +               if (ret)
> > > +                       goto put_old_es;
> > > +
> > >                 ret = exfat_put_dentry_set(&new_es, sync);
> > >                 if (ret)
> > >                         goto put_old_es;
> > If exfat_put_dentry_set(&new_es) fails, It return without marking the
> > new extra entries as deleted. This can result in duplicate entries.
>
> I noticed the same issue. However, this is a pre-existing issue in the
> original code and my patch doesn't change the error handling semantics here.
>
> Would you prefer I fix the error path cleanup in this patch, or send it
> as a separate follow-up?
I think it would be fine to just fix that in this patch.
Thanks.
