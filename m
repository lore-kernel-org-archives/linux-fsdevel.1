Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720A2248A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296439; cv=none; b=upIE+oncj0P57ZK3sqjSaEMfcEXiMq1lXrb9BbexHwjS9w9detcm0jwLXRdArouzrmxHbRX7+udfNoHO4e8jAuPzZ/SAY5SjI6/QebHHVLrKPOUhBmVpmGrJ3r+SXEQndVQzPW10PZShTlTkquw2t6wmcINq3Y0EuXVs84DwNnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296439; c=relaxed/simple;
	bh=Obc9wd2jPawQkjEjm3DG24wgiSd/HZowv02EK7FPh10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIznjJ6SbP1VeKApxMmK7cl4Jm5T5+66faMPBAXk5OU/hLJG9aIZrkSopomorV1StVK9+ajsGqKyK1cN+MvEXxJ9F+AhGkfiBromF1MPbWNRtmYnmD0o5BEX7I0RgYGCH0n/YpS2znq1PAkVMST8fHNtl7FK1LuwXZrjJkMTdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bODD95r7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bODD95r7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8ECC19425
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 13:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777296439;
	bh=Obc9wd2jPawQkjEjm3DG24wgiSd/HZowv02EK7FPh10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bODD95r7culuxRDdpkdfxUJXE02kZy/1qprkQpPSOMWVQscB6rOjkCTizcNX5bwv+
	 fY1KupvnRF5Id9Ns/8lxAO5+ANzlmEvyT0X7pnwWXkkcfQkrMu2W0hgYe3v4wd+t8v
	 4kQKs9C9O2FD2ZPp9AurJFqNXgyzdXbZCfYc2/vMtdSTLCozw6CqrQMaS0onxxcZy3
	 aMUu4hpfQQ9Ah2iYMhpWJq0R4vXYWEfjAHGJ2+T5ehWzDUIMRCX8J1DS8RPmW0Tf2P
	 OAF0Mg36btI4m1STCo3vDfjMq50juUzn/XmHIbJeQd9owyK1EB3mAWHrxiOgAXXi3K
	 CS0aRnBjSvzwA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9358bc9c50so1353882666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 06:27:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+vjlKDwu60L/B5YkGGULwch3AHNMn7SjKFCeTE6asy6feScbaUzo/G32d4tVAIhZmR4B96YpomNkSs5A0e@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEHYzDal9PuGDLf+k0Lnn8h99f9NqW0qAdvZu4QtL4RkWhO/L
	8OkSdV33/W+uDeCjjxpz07U8FyrBZtB21kb+tUybNOJn7WEpEfKHJB0LXUQRt3ZJjHbMoE2Mblw
	xOgPX+95OF/USn4wlaqRLAxS0C8cT5w8=
X-Received: by 2002:a17:907:cb0a:b0:b9d:4301:be37 with SMTP id
 a640c23a62f3a-ba419077368mr1467054566b.5.1777296438049; Mon, 27 Apr 2026
 06:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227224826.GG2023217@ZenIV> <CAKYAXd_-v601SX44WZ970LyZjsCH3L3HFjJXxZH960r1PXo+Bw@mail.gmail.com>
 <CGME20250228160332epcas1p2b177def4195cedc4c122a5f09bb29d2a@epcas1p2.samsung.com>
 <394ca686-a45a-e71c-bc45-33794463b5fc@samsung.com> <29a2901db9414$fcacee50$f606caf0$@samsung.com>
 <20260403195408.GM3836593@ZenIV> <21c1e01dcd3b9$546fb610$fd4f2230$@samsung.com>
In-Reply-To: <21c1e01dcd3b9$546fb610$fd4f2230$@samsung.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 27 Apr 2026 22:27:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_C+1_4z5PoHNbqcAMoE5++pEJC80O5=XRmeZjngFE0ZA@mail.gmail.com>
X-Gm-Features: AVHnY4LYYab6OBaslm8BzQ_YwG-v_eDzevEvAv9KNXMGng3WejTS-0mDOIs5iGA
Message-ID: <CAKYAXd_C+1_4z5PoHNbqcAMoE5++pEJC80O5=XRmeZjngFE0ZA@mail.gmail.com>
Subject: Re: [RFC] weird stuff in exfat_lookup()
To: Sungjong Seo <sj1557.seo@samsung.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	sjdev.seo@gmail.com, cpgs@samsung.com
Content-Type: text/plain; charset="UTF-8"

> > > [PATCH] simplify exfat_lookup()
> > >
> > > 1) d_splice_alias() handles ERR_PTR() for inode just fine
> > > 2) no need to even look for existing aliases in case of directory
> > > inodes; just punt to d_splice_alias(), it'll do the right thing
> > > 3) no need to bother with 'd_unhashed(alias)' case - d_find_alias()
> > > would've returned that only in case of a directory, and
> > > d_splice_alias() will handle that just fine on its own.
> > > 4) exfat_d_anon_disconn() is entirely pointless now - we only get to
> > > evaluating it in case dentry->d_parent == alias->d_parent and alias
> > > being a non-directory.  But in that case IS_ROOT(alias) can't possibly
> > > be true - that would've reqiured alias == alias->d_parent, i.e alias
> > > == dentry->d_parent and dentry->d_parent is guaranteed to be a
> > > directory.  So exfat_d_anon_disconn() would always return false when
> > > it's called, which makes && !exfat_d_anon_disconn(alias) a no-op.
> > >
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> The patch looks good to me and seems to be working as intended.
> Thank you for your efforts!
>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied it to #dev.
Thanks!
