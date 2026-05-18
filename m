Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43923C8A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121377; cv=pass; b=ZscXff45Rsf5Q/uvbY9KzW1J0Oa282Q45/F6lRLkQmEYQg7mxHaT3vt5McwOyppZuqDLOojCwB0U0uS2NA1HoqGdX+kRELXb7uxVUN4AAxKkOcU+WoAxxGodBHxiTlbISs9giZGM0U7RXhAnc9sQC49JWYgSExip/rw57RdnBCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121377; c=relaxed/simple;
	bh=XTFNVsqBQzn+UexOBPiyxjDehU0C6sH67ZUr5pWq79U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McWCgfuxuudL9633e1DWQurSAoHxUNArPy6uE1K4QSUtiPfDROKEzQGFqCnyPJ9FFeF8d7pwDVXa5L8nLl/zjSe5ym8MRCtxap9qDMOUBSgw92pRr1NTM1Tzru8hhtK301ehaoKf9YtPX/jHv15c5aTfpceZP++KeK1lrIAonlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=sDzmeIi8; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="sDzmeIi8"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39389398838so26253851fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 09:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779121374; cv=none;
        d=google.com; s=arc-20240605;
        b=Rhm5l2KQ2ra0/oQ+JOCTy21ym/cve8AUS+JtC4r666oXPvYPDWOz+ICQxa4mydjIR5
         1aSD73XSIzB+2i79kWZ/8CtCLl3t2wRVRDR19iAUV4GCIiDfe+scvSf+ods/dH+feTYc
         eQQYK+71hFj92Vufec2z2V09mHmftJb4TLhYwj+0HU/5I9GpOb1/G6nN1doPp2RpBYaj
         TOXjy3q+7loTg/KwGyj3i0yELg/Jgx0MwX5UdbYpZYfR0pkoI15CCO1mds3E6oxiygQ+
         GcPVNQuzZDv7peBisFfveQIgLoraD/f6Qkke3uPAft43uR9xZvle/8J9wo/iFaPUeUmu
         Xptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GBfJSJU2PEERmOqNyTzsxNh3P380LCp5dFjg7jcTh8w=;
        fh=qNp2h3YWY7o+85xcpd6hgVRtM7XC5/LvQmuZqoO3G0w=;
        b=EgEuUCqVoPdWjJ6DJstqovKhm9m4iiFvH3THt3iM7skqAWcvmq8ZmVB6hUqT9vsjLp
         a9scUIHQ67TIMr5lGzmR4EKYPttX8Rdtrp6BHiebAD+x4vGiCRvx+I4VqGxhRdOjeeXw
         vFvUm1sPk/N9UcuWKBeuB2dmHcZNS2Jj4nwrJ07yk40hte96Z32Z5vyFR31XqxkwmTVW
         AtoM/sfywITANETT0zZhKY4QfCppmtM79OYr1D80a7N7/JWci70E6K5Nl4RGTfOt97XR
         LvonLUeHavUTKf8HWVrehqqnsIcrhme+EjFR/ADO8tT9QDAjSycFDqDuo+p8j98Ej6Wd
         hFkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1779121374; x=1779726174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBfJSJU2PEERmOqNyTzsxNh3P380LCp5dFjg7jcTh8w=;
        b=sDzmeIi86sejOQvOoxvX4DWMLk3RAsUAuuCOsTHhu1w08vWk2Y1buzve/Nxd/EaOpX
         RQlGqsceYvjNqtC2SUoc396Y/EnJUmezIyWvEoSFpBk7a23Jf/hBVDB88mb1ChJf2r0X
         OEft0J+QmQ70qyR2bH6J8vL63B8KyYOTD6XZKJzL4eDxnOMRI9xP0E57cNx2evjRKTRQ
         TjbxfaXdei73OBPGe40uaTLvVP5ddWvT5cQc/hZLQvJG9rBED9mFYB2GZoAO8KxmOuwd
         TE1bMb7cOltQ+tUu9kTVNG7ciUrE74SZKrLR4jhiXTh9Z6oJzZX8sgp3+thJkMsJgSP+
         HV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779121374; x=1779726174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GBfJSJU2PEERmOqNyTzsxNh3P380LCp5dFjg7jcTh8w=;
        b=UjSC5JC5d47TlwLdtqRpamiVEQ+gSmKudLx4V9hMsaTfSRh5Ip3TglP62xEVhZZsjP
         t7wUYunEAVQeN1pJwTc+IDuzr/i/05W1sY3+5v6hs7+GZ6IRrFjmI76ICnp8pYFyrDAi
         y77SQjsl6LihbI+1IsowUokNmA93QXkJPOggNxForeee6+0A7TJFhIM7MhG00g2ywMOV
         8u9gwzRhmllbdH8t2RpBWoSo5gT72PI/opgqNMyDOQPtKgYWl7ChwkKClnChxXnu0dKf
         GSmGqSWazthnwShTZNhwvxf+ms/xPllqmlUEu/djaCYbgMBFwJxUvKRqm4H9mk489LhB
         ni6A==
X-Forwarded-Encrypted: i=1; AFNElJ9S+gwI71HXZa7GK6IQ0iQccZXt/0moaU6owNPFJj0p0KJMO+HGpZBta38ffd+R8hYTxVDLJwx6hjt0i1x3@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZhaP/cgBPNz+RmAy9cNZK4w7fMADhT06sq3aP7HRJmRnQ90s
	ImoGRIkLzOJF2ZOvzaD67OoNFMD7bjqzxkAhZwDWbiSDD8qSSaz6gq5Pv33jFpCM3TIBgkLdc5l
	uU4Vf3b9zNofsq6oUnxL4yQPTtGjiPkgIq3s384Li
X-Gm-Gg: Acq92OEOkwkY5Lh6psXIBbYVXCTUxjKOzJtcTwudYsBgApQGWxIhEIsyrwwQadhlDbJ
	Fc1xgOlvPnVnjch7dNOpaK7fSCfhPSW/CYjrXt4NA8TvL9Ga7FzVck6rKiZyYsRueJcLDA3n2Nh
	D0t9atcO0kCxluCo62ld3A10vjuysJXcd5nQsTTr8xofuFLpNxVbcqX4lhn/4j6FERUmvSaafiW
	L7ebYpE2H+f+IfBGQzu3CEoLwmJHgFEixlZl/99fETIWKpa8Zmi5mI0WwxJkPbwQcq4WLA1SLdp
	HhQa46Zv5Q3WOQg=
X-Received: by 2002:a05:6512:401e:b0:5a4:74e:5f75 with SMTP id
 2adb3069b0e04-5aa0e60b1bfmr4415283e87.1.1779121373933; Mon, 18 May 2026
 09:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org> <20260518162048.GC9531@frogsfrogsfrogs>
In-Reply-To: <20260518162048.GC9531@frogsfrogsfrogs>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 18 May 2026 09:22:42 -0700
X-Gm-Features: AVHnY4LPlnFdM4Ytr497DHglr7id-JLbay6wfSP_dcQx5-R5dh4Wh_ZPGa6qlGc
Message-ID: <CALCETrUFMFNnJ6FLd9SkzS5E1q3x+cqGvOvo5PzU2V_+moSEJw@mail.gmail.com>
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Cyber_black <Cyberblackk@proton.me>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Mark Fasheh <mark@fasheh.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 9:21=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sun, May 17, 2026 at 10:08:13PM -0700, Christoph Hellwig wrote:
> > On Fri, May 15, 2026 at 05:36:45PM +0000, Cyber_black wrote:
> > > Option B) Add a capability check to ioctl_fiemap() to match FIBMAP.
> > > This restores the intended restriction, at the cost of breaking
> > > unprivileged use of FIEMAP (e.g. filefrag, btrfs tools, e2freefrag).
> > > This option is a larger ABI impact and likely undesirable.
> > >
> > > The preferred fix is Option A, since FIEMAP has been available
> > > unprivileged since 2008 with no reported security issues, and read
> > > access to physical block layout is already implicitly available
> > > through open() permission on the file.
> >
> > No, FIEMAP really should not be available unprivileged.  So I think B i=
s
> > the right thing.  Can you send a proper patch with a proper signoff?
>
> For anyone who might be relying on FIEMAP output to find sparse regions
> -- don't.  FIEMAP is a lowlevel fs debugging interface; it won't tell
> you about dirty pagecache backed by unwritten disk space.  cp was burned
> by that a decade and a half ago.
>

The only way that I'm personally aware of to determine whether ranges
in two files are reflinked to each other (and the only efficient way
to find identical blocks to, say, archive a large directory without
reading all the contents) is FIEMAP.  I wrote some code to do this
awhile back (not in production use).  Yes, I realize that it might
have issues with dirty page cache.

Is there some other way to do this?  Could an API be added that
efficiently answers the actual question without revealing information
that shouldn't be revealed?

--Andy
