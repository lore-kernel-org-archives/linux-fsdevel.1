Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883A311C36
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355678; cv=pass; b=Ywpl9THLo41ZgtqC6c6Il3jQ7rpqrI1eBkgSrC+iietbdXcfkQZBA1me5+wriboaK2N7sZO+CVBI+/Zo1LQUP8s40Ym/uuOnFzA2bQ8hQmhAeD+Jv8hCPd6mnaGpF8ldFoZ7uvJAD8Xasg+GkvXsZw//G8vAa3ieYPNgsyTJeME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355678; c=relaxed/simple;
	bh=5r3JyqQ2DBLFlDYBRZC2KsaiyevYXDeDtmnIYAMTEJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVbiVLAKkuLFwg/E6T6cKxAvl4N7qGcpvmdcdWa6H2vUlY94ZrJgTFM2Ucyoq2JXn6lSzrTTGCpeDu91tkU5FbXB+aZWzc+NctDF5D61zpNKkn8kGZJnlGgbajpUF9o9ZWIGbNLpqXlc+qFB6pGfi3D5UBpdNunIO5LJMQAWYWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZULFj/RF; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZULFj/RF"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6870a365c77so3921785a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 02:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779355676; cv=none;
        d=google.com; s=arc-20240605;
        b=Uw3HcOHc9mvqprh5Hzh5A0ZkaHKFTWNBxC32d0QwmDoqb8miyJSjki+VW1S3boNvil
         1H3tik4y21Rj53g+CCtsP8m3tXBbkEge602oiv2QTWUzMUKb1ixCMXHvwdqiFtqWZgEy
         VHM5HNXqiqgb1rUprVF1kUKMYH8plGZUA+ZU936VzlYS+XQ5QpkBS/5S7KwUF91l+7N/
         on3nbgqZMf8kix+Ij+69nyGxyCMJvHQdAE4eFghLvcMj4/tfrL4cKtGao7RNy2vuyIgS
         oMlalcc1VF8NAWEiu7wLPL78PsrkYMl5v6LCWC49g2FlBrtNEhMN7KuSmWFcZdT5kZ/X
         Fndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5r3JyqQ2DBLFlDYBRZC2KsaiyevYXDeDtmnIYAMTEJw=;
        fh=giMhwl0FHtVL5ZmDwT03RfDB+1JaO8zS/dK04b6bGAw=;
        b=aS61UK9dXs7de4d4HQirO7L60AuorYeDsLn0rlErN5oaBinJlhOxWlJ0XH2ai/H5t8
         FzYdwjtJiVroCntAg3hRufsCbPVh2mUkAYqUItuPmX4wP+13Uh4033NlCZa5B+EBIS9Z
         XZ7EHiNPWCVUDxOLbYa2DWsb2qCaE1RONnlPmIwKiXaxXA/lwkeMdUGKOLWO9og/tw6Z
         JYS+p6u/3kwA88YUQ5WNY5JcFEmQDe+m1Gh8Z/kVIMOsNGW2zq/RC88NlgHCQzBlc3rn
         5igdI51XxkjNwqMr7heA5gUQwZtrrd7bPVcWeeWRs4tsUzD7kljxvRy/N5staNTUMLhl
         aRBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779355676; x=1779960476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r3JyqQ2DBLFlDYBRZC2KsaiyevYXDeDtmnIYAMTEJw=;
        b=ZULFj/RFS+5f3d0fO0mBvZ73qrhohsTV9V2sC+3jAUMw5RcqujcaY5zeke445HA22J
         k80vuD64TIQ3U1g5BPTCDG/NazCXVdbAdxmmliNmfErtRJWMgHYvb4NUDxtV309IHqFR
         xXXIhMUXLc+2rGv2oPffVcnKRkeLoQb1ZeUFHtNg3q/MhkbyF0pDGBXlw9p3bc40NCAM
         rui0UhrBGQNcKffXAKksjaHIghiC0+7sMjraE7PMsQ8UkrbFc+fIpPpwj8jJdGIHW5uA
         efetEYpS74sc0b9vpjOhLYjdWk7ifOMChP8uwf1AMqls7pZMUJRrKCRWtuStCO8sejyG
         bKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779355676; x=1779960476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5r3JyqQ2DBLFlDYBRZC2KsaiyevYXDeDtmnIYAMTEJw=;
        b=s396Ne2Ve9ox+j4efwjc9udjmhGN7hnGj0Q2wSHHnN7Fdd4We7XZzS8oe6aomRps1i
         Kkh/ZhtcP1QOQUytshrkGBF5/7bAqx1nPMFgU+/NfI5ybPMFm0mt4ZUEEEdRxuRVzVbL
         lRqiPywGfaRnR1mS3kkYUMQBIlTseYE2c5wn3oVRUHiZQzZM8RFbpIKJtDtlp5/iF+ub
         p1NIqCAKavaRq2AIFTSNdSsi6V9G6dcAWZLu1btJnMp1dk/ciRB0P9NJbXxedE1p79cq
         1meikXwWICURCbCqHyt1ZTCBBwIaNHYvFYtfMsqUIcP6IcJuTc190tqm6Ewpve1ifmrn
         LU4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8A6asXWBCvG/UXlWhUg+ux81mE3IoB8WMtDp8u1qAmzSQZi3MwjDWY4ACP5w9neBwfBzp9348/LpPvGLQ7@vger.kernel.org
X-Gm-Message-State: AOJu0YwghSnUQ/ZDZwfG6EsnryddX3jOQEcRIQ25HmYDPwkM5Qhn7QZO
	ZXQDPvcnqpa8P8Oxz78qSlkBjzWhZ//Zlksp6x+mQAc2M3ydT1xjcHbREXucDScE+9Hkf3xHD/N
	ApNXFz6Vci3afXKnbgIYNFzXY3wOZcfp0race
X-Gm-Gg: Acq92OEkgjRhWhIlr4CJGtaLEJgj426N4V3+VKBVt6XWNZpS+YoZB9yXb4WxFu2rRrl
	oVMF58+xUnZxZeI/xBKWjexmT3w7ITrGSUUiTYfOQq52BZBVNWH+pfnBdZB6BTi8K40O/icmBLX
	RXSsWR0f2WOKmdctaTzH/jaXZn5Oq5UT4c1XB6XeWaWROUi5loCHOEi8qNS7p9VV/rNpIdB/R78
	6vsd11Z9CTqIZ70Hdc6cl5A9NcLObXBgTQst5dfDXLW9/NSthZmiTqiV7vADcHsaeUEJ4RH8gvu
	DjJ7WiOGjlUXF5P0NEk0ePgXEQde595LvgN+F76Egg==
X-Received: by 2002:a05:6402:5017:b0:677:15b6:4d6b with SMTP id
 4fb4d7f45d1cf-688369ca689mr933762a12.26.1779355675390; Thu, 21 May 2026
 02:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
 <177922944866.2436629.1081840703046716342.stgit@frogsfrogsfrogs>
 <CAOQ4uxgnJbbTBup7UDh4R0AStx5hL0DYY09Fk7g9ETJehopMmA@mail.gmail.com> <20260520200136.GM9568@frogsfrogsfrogs>
In-Reply-To: <20260520200136.GM9568@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 May 2026 11:27:43 +0200
X-Gm-Features: AVHnY4LarLJOa9Aitnqdx661hv6mfV2CGj8oqgXWw5qclnUF50Ke7Cnxu6Pitb8
Message-ID: <CAOQ4uxhfy8if+u3o4KSkGOF-zmA=Ci5SYsdxGEY1DRNi79ZQtA@mail.gmail.com>
Subject: Re: [PATCH 2/4] fuse: store backing id in fuse_backing objects
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	bernd@bsbernd.com, joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 10:01=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, May 20, 2026 at 09:55:24PM +0200, Amir Goldstein wrote:
> > On Wed, May 20, 2026 at 12:28=E2=80=AFAM Darrick J. Wong <djwong@kernel=
.org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Make fuse_backing objects know their own id, it'll make tracing and
> > > recovery of backing ids easier later on.
> >
> > The problem is that in the context of fuse passthrough
> > backing_id is just a temporary integer name of a fuse_backing object,
> > but fuse_backing may outlive its backing_id (e.g. in fuse_inode_backing=
()
> > and in extreme recycle situation a backing_id can be reassigned a new
> > fuse_backing while the old fuse_backing object is still alive.
> >
> > This only makes sense if backing devs ids are never closed, so maybe
> > only if FUSE_IOMAP and FUSE_PASSTHROUGH are mutually
> > exclusive (did we do that??) and FUSE_IOMAP never closes backing ids.
>
> In iomap they're *nearly* uncloseable because we have no idea how many
> iomaps might be floating around (either in response to a
> FUSE_IOMAP_BEGIN; or in the mapping cache) the system.
>
> However, if you can knock the number of iomap inodes down to zero, then
> you can close them.
>
> <shrug> The self-contained id could be set to 0 on idr_free, so at least
> you'd see in the trace data that you were using an un-indexed
> fuse_backing.

sounds good.

Thanks,
Amir.
