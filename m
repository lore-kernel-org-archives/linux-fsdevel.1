Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCFF47CC97
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572220; cv=none; b=Puj+ycTUd08nxnW97JwgprD6+XBbxoCU5ABwR3dbECko6WQxGL3uz0umZdHLX8coAudhnpvXEVCsipUkebD3ofqTe2KIt5VOggni+/NNFDbdNi5pSNQJu60nv7yYPKLW34PljgTUeE15QXrF1nE4L1k1rExHNeRZriJp2GCQYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572220; c=relaxed/simple;
	bh=JykxKmtvax8c44lfo1uzfu3WGhK+/rHJkXVIx/jRPu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jezT7iYpIqNnDX0hE2+uqSZPELVAyfvSwgG+QshWJPBvUfOYvu9i/dWsdF+pl6YWWwN+TS4T12zEJ9CFbF9yGS/aikv9F33vyzKPe9PQj9kV4A5vxDxVtZIkb9qSU53UHXK2vMe0kp/L+l8PC3Ob4baP+GLjx68NP3HEJjd2zuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSt5n3iy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSt5n3iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD54C4AF0B
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778572220;
	bh=JykxKmtvax8c44lfo1uzfu3WGhK+/rHJkXVIx/jRPu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mSt5n3iyxeXAec+yUsRmfK1p9VXxxyRx8dVmzmnpLCc/3DtzJL9x0N1kYBgezymjV
	 pUHY9sXXo8bJ+cS4ndZuYJ8jM5DpF9XgKOqT+BWCNqg68WUriB22nQXVTGBZQbkQAs
	 Vk4EL+eXVnMMyFmUDdEzm+8OF5ftDDrsJ2oyu020JeGPsHL7mDNeDjGfaRAUlxjM4S
	 ZN0X1VGpXVrTGOXQrs9c0vSF41BGlcznUDvgcT/EFPxwSpqEUdO6v3286JeteSg9gG
	 DWfSMr92FIKelEdpN96w1Auyi3XDu6v7s2zV1emjncjWH1+bglQq2UrAqul1L3UVra
	 m/FTNslbyQzRQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67c3cb1433cso9108571a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 00:50:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+istQyQf8Kks0Wh3oR2G+peO47ruAfxj4bdnBdBU1cfgPg1KiHwyn2ixe63ocbAkIx1Budzma8xRSVyLbA@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGZrDGJ4PMm7eGPaoYyT1IZKnZa7znHkPTH03ifv6OQ+ySnZb
	M7P9ZsHebouhjaUvAjI/QoXvlnjsaJy3nEKg+5ZDszbiKAhoDyUCs3dis+TyG7lrCaBrvud8jAo
	vSOdOWElZx428oWliWyB8SzlCveBP79M=
X-Received: by 2002:a05:6402:3488:b0:67e:2498:dc7b with SMTP id
 4fb4d7f45d1cf-67e2498de0bmr12092483a12.10.1778572218470; Tue, 12 May 2026
 00:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-10-linkinjeon@kernel.org>
 <20260512064027.GB31640@lst.de>
In-Reply-To: <20260512064027.GB31640@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 12 May 2026 16:50:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-eiMOdKRZG8CLUe1sJChD_+6Tpj02FoeGWL14TnqVd_A@mail.gmail.com>
X-Gm-Features: AVHnY4JWv7kuZB2xGTgBVACTl3prqTnjwSqMsUPMXOAdzP5S0kUHYuKL9ilqjm8
Message-ID: <CAKYAXd-eiMOdKRZG8CLUe1sJChD_+6Tpj02FoeGWL14TnqVd_A@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] exfat: add support for SEEK_HOLE and SEEK_DATA in llseek
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, 
	dxdt@dev.snart.me, chizhiling@kylinos.cn, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:41=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> >       } else {
> > +             /*
> > +              * valid_size is tracked in byte granularity and
> > +              * marks the exact boundary between valid data and
> > +              * holes (or unwritten space).
> > +              *
> > +              * When IOMAP_REPORT is set (used by lseek(SEEK_HOLE)
> > +              * and SEEK_DATA), we return IOMAP_HOLE. This allows
> > +              * iomap_seek_hole_iter() to directly return the
> > +              * precise byte position.
> > +              *
> > +              * For normal I/O paths (without IOMAP_REPORT) we
> > +              * return IOMAP_UNWRITTEN so the write path can
> > +              * distinguish it from a real hole.
> > +              */
>
> Ahhm this mostly has what I asked for earlier.  But maybe also
> describe the IOMAP_F_ZERO_TAIL handling a bit above?
Okay, I'll add the comment for IOMAP_F_ZERO_TAIL.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks!
>
