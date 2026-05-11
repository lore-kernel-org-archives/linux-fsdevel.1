Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38593195811
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778458857; cv=none; b=WvzHX9vaOgW2ZAiT3lVQ82TNptkGJ8o3BDHrte/SOag3NQILnm679Rk1YCBxvMKozQjPVOzlatSKf4gECWZAcLHtRVFNv0HSdi6K11AZ089y44D1xFpzIOTue93cLCx31vqIMaOAvnDxMnON7KvbCIGMWNvaDJgJHRry8sgzx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778458857; c=relaxed/simple;
	bh=9RLVx0mI+VDur2YBH74LKFmKUv3dyU9REgIciUgJFTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kwiai74FUZreRx0xC0yVcfEcms1o6w/WwGWJLNaXjQO2/gppGxPEs30MIi8pspA7rP2qnQZ4c6NaiA7cPBu0aYLBVuFZg0tzkJ/Ra7sANHVDRKWpx7U4UhoWD06S9aYJ9fMPLUkq4/9WJ9QcF30V/N0y6hpgClIrSZdpzRhfEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtknJR2v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtknJR2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB76DC2BCF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 00:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778458857;
	bh=9RLVx0mI+VDur2YBH74LKFmKUv3dyU9REgIciUgJFTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LtknJR2vkS0+5vJpDYW+sLExvHbMfJJG6HvZ/UTDLcS46uStWK/9no0Y6TMe1tNvB
	 rlTBTwJ3LpMcLT5DoJ02A8eH9FTLjAzQBKRUR67y0wgrtXgRfYrfFUO93CXsMP9Vib
	 SvyHG8brH5mX0Vc9NrznzSl0Pfpqe4jSOwnN+19rfEViUvQqEVSUXK4phpT+RspZuj
	 Abfxvzoq4z6vCbVTacdCFE78KreHEyiJI6GYjHwsx/yLYIRJCNRpixXtQ/zEXDsF+Q
	 HHHVbGfS1GeVq3xLSW2fSJqJ9fFPajhbK1sPKWkFsbKcCh4y2dcye5zTVYkRPovjOr
	 N2nG7HiUfS1iw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so6033383a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 17:20:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ98bY312BN5P7PbDMUgK2gcGJzTdDmPX7qp4fPl5sttsxEe8zaHIqBfSzdTx7PJmvd8QtlsUJgvWU0QswSZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEFpTr1XSE7O1cKABsmls84aYHw1To79D8zQGtdhyyAco4FvZ
	kD+CWkKml7z8fRzWl6p0YnfXl42s/Bu/xG2XEz7B4cUe7xCOBvnXmumbHp1bvfUBUK9Vc4VvfGN
	fskkhD5kERo2RWwydexfLvERdvRp1+IU=
X-Received: by 2002:a17:907:9304:b0:bc5:111d:3c96 with SMTP id
 a640c23a62f3a-bc56b41dd69mr1107530366b.10.1778458855548; Sun, 10 May 2026
 17:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-5-linkinjeon@kernel.org>
 <ef3f055d-1d3e-4467-a835-37c52585fcad@163.com>
In-Reply-To: <ef3f055d-1d3e-4467-a835-37c52585fcad@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 11 May 2026 09:20:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8fSPP3w=Ec-ffXf6uiJkFQsfA9OhAQsjz-QZCZXSd7VA@mail.gmail.com>
X-Gm-Features: AVHnY4Lwejx21p89_k-Frh1X-1zKEODgXPNq1a3W7bBFTy-kuySyBQDy1f-6F-I
Message-ID: <CAKYAXd8fSPP3w=Ec-ffXf6uiJkFQsfA9OhAQsjz-QZCZXSd7VA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] exfat: add support for multi-cluster allocation
To: Chi Zhiling <chizhiling@163.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> > index 1246713567a5..7b09d94ac464 100644
> > --- a/fs/exfat/inode.c
> > +++ b/fs/exfat/inode.c
> > @@ -137,9 +137,9 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
> >       unsigned int num_to_be_allocated = 0, num_clusters;
> >
> >       num_clusters = exfat_bytes_to_cluster(sbi, exfat_ondisk_size(inode));
> > -
> > -     if (clu_offset >= num_clusters)
> > -             num_to_be_allocated = clu_offset - num_clusters + 1;
> > +     if (clu_offset > num_clusters ||
> > +         *count > num_clusters - clu_offset)
> > +             num_to_be_allocated = clu_offset + *count - num_clusters;
>
> We need to truncate *count for read operations so that it does not
> extend beyond EOF. Otherwise, xfstests generic/003 will fail.
I'm not seeing this failure... Can you elaborate more why it was
failing on your side ?
