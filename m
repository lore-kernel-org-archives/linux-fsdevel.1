Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DBA2FDC30
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824390; cv=none; b=OcTSswQx/oGd3dN1u+kVVCXDS0A3SIIy/rBSSGKxr5yh01ghx8Jfu7vrTSLCCfoNiiVycAoyixj6m2c8STvyO49c/Q4Djl3EWnNQzEJUzSBLcQlxmCIuixFTzooRwsQ1b0G6KKXDSOAk2GV3IyHCMCJAZu1ncFTEfQq3onSJleU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824390; c=relaxed/simple;
	bh=15vDqZFOWlAL11AtBsnYSpdj8UILyATPS7hLP/3MJqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idsl1e0J9IMobOFMsCnc+v3f2vCDNQOz4aSikRTA3cJwKpR3Ir6yhwFcGbrIjl06y5jUIEugqQ9SWEzthPWbw7Xv+2+Bne8Q3y7IntHkVkqTHfUY2PzzXlSsqHj8eKJMt6vz+iUdFj8Dpfji6+DA3WKIWwAjFNWrdLD0TyZxVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCWaBRt/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCWaBRt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76391C2BCFC
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 05:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778824390;
	bh=15vDqZFOWlAL11AtBsnYSpdj8UILyATPS7hLP/3MJqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vCWaBRt/UATa57hS3Iy2g5ec3z7HBIjr8p/tlnLV7ezLfWQrYZdp+Ls4e7ScAYpis
	 ezBqPjmEdGF5Jm/Z2xnv1SFQuelvgVTnFEVAeri33SJRiqtwLR6bod3wr2EWl1ByQB
	 lTX3Vkbykf6YxwVCZItGROGLbYYSa71p8Q6G+HCalKvx21PDrObP2DOPfYcgL0JbLJ
	 upxb46WI4A3NHe5TOBOR9d+cORfKfoOLJOzpHoUz4VfZOSyzVNfSjyStah1xmLa7a7
	 yyuDi1sl5Tb+swhSOqksVeCQ7RHTj37U8JCZZDYXyZSiqVIfk+97OxSN5u+MRDGscZ
	 OyhDzBKdlLsRQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6802f9c5debso8233525a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 22:53:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Af8hEqdJuOGlZH0+xYDWiWqGd31j01j3n2o3z6B7QFz7xXo4LaUT5SLTwjqrx81lkGdr2yqhint1/IcRP@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4SEjdBYxeSV5HDDdAiejxvYpP4zdykhcKN7DC4gbkFAflLac
	ZUbsBx03T/k68w6rIrb/pA9VfRmjur7UWEKcGVXKENXTwQYla3kZMMnlzlsXyR63GlYqP7nWSOm
	jV9FKp0oIuxh9Y2/3xRojCMpbG7hT88s=
X-Received: by 2002:a05:6402:26d0:b0:67c:1ed6:2793 with SMTP id
 4fb4d7f45d1cf-683bd19552dmr1159158a12.22.1778824389031; Thu, 14 May 2026
 22:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513112156.9122-1-linkinjeon@kernel.org> <20260513112156.9122-2-linkinjeon@kernel.org>
 <20260515044840.GA4059@lst.de>
In-Reply-To: <20260515044840.GA4059@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 15 May 2026 14:52:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8_v1gzC=bP0Mn-+iLVeq=8fb-zXxo=g1qaA5iaWMwtyA@mail.gmail.com>
X-Gm-Features: AVHnY4Iulh5i0U4P2J7IMhUVj7oPzyVMKUK-EuWMNvP-UJToPgB2xQ5C0b7EK1I
Message-ID: <CAKYAXd8_v1gzC=bP0Mn-+iLVeq=8fb-zXxo=g1qaA5iaWMwtyA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] iomap: introduce IOMAP_F_ZERO_TAIL flag
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, 
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 1:48=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > +++ b/fs/iomap/buffered-io.c
> > @@ -837,6 +837,7 @@ static int __iomap_write_begin(const struct iomap_i=
ter *iter,
> >                       folio_zero_segments(folio, poff, from, to, poff +=
 plen);
> >               } else {
> >                       int status;
> > +                     const struct iomap *iomap =3D iomap_iter_srcmap(i=
ter);
>
> Please keep variables initialized at declaration time above those that
> are not.
Okay, I will fix it in the next version.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks for the review!
