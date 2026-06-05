Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0AE25228D
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678584; cv=pass; b=tN2YDbtD5OENfEezM6Qu3sOY1lHe8oxTXjKDsyMAMMA8nm92h9/ojVJwYsyvJYG9XHfkXJhvAkVQ9e7a6tLXtyTytZFYtRKxCI2VvCb2fhZH/C1CqcBv9bSaS2DR7aGmevT3jvImIf0HUpmYoj/gO56PNcyfGn+ts7nXkVrQt1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678584; c=relaxed/simple;
	bh=lRJhQzwkfaYrurGJA+2BHiGqjhVOLsD9M1oQ+MQYHk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlzXe0voaqNslvuuw+oJ9wYmWInHMw46X4zCs5QAPMyNkqJiF9E3wmp1xuL1p43kUS+Hm44p0EmS50UDTLuZKQfhq8BnYLBUCzfg/np55lZi5XUBPX+v8IvMdRPXz19g3W0Gdr42UUJIzu9b+dpvw4zv01u343Ag8gPLlfnjoWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN0/aHJQ; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN0/aHJQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b9318997so16320035e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 09:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780678581; cv=none;
        d=google.com; s=arc-20240605;
        b=QOZqIiO6OlBRtvrIXZUmK7eOgJ/Tr/2Bt+U/51mw0mdk8HlW5qgpUltQKrIb3kBCeu
         TJBuPKYgKHxwTVx/vPLv7hU1mfqYe0MM1wzucQxS1eKHk9phqDUvx9I4X+TcvjZbe9VI
         8/JR9YGl9CnK9YtYnJDbgtAG1zeZ8qBsuovoOip9A9jtPGOZg10sxHIEItFiLXO9UEfF
         1HBr1YrCh9qhtwIEGGANlh0+KGcHedkaUZGdLsB+kPH2ptwmoMgXQS+7KTTHt9hCfTcM
         Hwx/Km090wa0nxj9YhGtI4Zqp6zcx91qXmjnaoxHZae7WVRi9WYrAQexXLQ0df2zAeLe
         5enA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EImzJsYV05pjesNEMZOO/uQn/Dz1lGb9i9aAN+v9i+8=;
        fh=qBwtPfvVx3YEIzAYUOZDZk4Kv1p87tyGoxPTMWaH58U=;
        b=K5tF8OoqX7Ef72aJTXYaobBnGDD5oyegCwdAhip03+ILJe6lfJrIBBQNTwunQPOm4r
         m+h0Og0mWtjdPio5YrZC4wkhFU0BBSfsF4NwvKsnBnYibFGybFa7yhAWFWcoH0RCRfBr
         r+Z8Ze47kUENn38F6HYaQdKBFwQOYwQ3MnoePqhpk1H/k0t+UwsB5Xdn5HgziHotF0LX
         a8Yk2+TZQdlT5A6ttk88oUStnjJafZqySaWDTATFFnb4AFV47vXXJUrOPQn01anx9XK4
         Jtcj7UIEAZsVh4PEX5gGaWga9yFnlx8WS3SBXYHBOtXnF9w8bf9ZjW9rmY4PI5znGFp+
         L2tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780678581; x=1781283381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EImzJsYV05pjesNEMZOO/uQn/Dz1lGb9i9aAN+v9i+8=;
        b=RN0/aHJQebbF7eFyjx8A+Kkxy7wUGykZWvDdtBoSyQUNWC+S1FWSY9gFp2haJ5aSkH
         hr9fNgA5rf9OCkSP0jA79RyoSpMzJ9QkmIRWHYRX4cjElrbNZ4WtAXxjvAmcnQ2WSzWA
         FkaBpgfoitmmgqQl9rLGi+EBWvSl/WaoUK2s5WVBzY3zfe32CfFqbj15Em7E2mv7Ygvt
         cuML9rTdEfMUkDmTyKf86P+ZL1pq52b2onpUo6SNktHomf+p2Z5yo3kEeLfWoMHONqhq
         YsQnceJWH1JHy5yZ8AKEz/Fc8qTBwKQCMs9Tz0lsPAKzvL7WCrJ7LMrTzHqf4xJvS7ry
         fQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780678581; x=1781283381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EImzJsYV05pjesNEMZOO/uQn/Dz1lGb9i9aAN+v9i+8=;
        b=A7dMthtoKEwsFBXZhc8FiIAGILxYDQiv7yj6FIFbmSCkPhiuvPaceddnxqK+R+y6+W
         B0yKKGMpixcES1bG4oC8swYMHtFWWIK48MIC03R/NGUWYTvn2+aBeyydI2tPG5JZ4F68
         l13HVIs+jdB6OyAvkLyPzFvwD/2DDBBti8mXznqYi6WMMQrGXazdkEoGpBoMAGNW2CSF
         nR4VKKo4wSWZY2xmvplh2PL1mgK6mRQXbrbVq86snUrfXhcIZS1jp9eAOePqe5eOeGSm
         Ab3tLVayX+8E8tHsYSarSf71amgnctG9eVnt58DJqoA7RkV2JbOajpkgfRBlXZGAskvl
         UXzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8y0Uffe/BmOWwGLayDcAAoG0FbLIClZB6ikjS8u/7WQ7tvW046HEG+i1nps/1HdhZN+hvNJZOdrT2k4AJY@vger.kernel.org
X-Gm-Message-State: AOJu0YzfTIdqhc9E2llQrs+tPZSrqXGxxenBjWycUobdBmWJTgy/3rEt
	Y/1hsb0XCCXcJ79G2q9lAtTuRYvKHdoB4OY7PN7lJfzkBrZLe4P6uJLhMkDBydIFusqnpLb56JF
	2mVicPUEGgXt3TlyB7fvbRLuCb5Sqz2U=
X-Gm-Gg: Acq92OFRlIpQIeb6YV3Ca3NU8lbg2Bsu+OyHldG0SFK+zaTku9dFSwQGcYaAAqijAOx
	3Nr9aTEjKqqI6WhD9VzX9J+tW7ghONp0Eh4UmqPtS/ooo9v6REsONT1Lazk1/QeCwsAxnAVpjgq
	R0N+Z0D71DMFqwOMeFekBUs5jwlA9dmYnR0i0kDG7WrTx5JtBiPxVRFOz1pwDYi+alMT0EY4kGL
	BAHL3G/BgV8Bkt5zuPFO61KT+V5WuROIvtzVHrSEXrnloWkZoAaBmwNlkqd+ppNVoqWoh3Iwz0x
	iv0vRojfJJt9Yief
X-Received: by 2002:a05:600c:4fc9:b0:490:c015:21 with SMTP id
 5b1f17b1804b1-490c25f1634mr72764995e9.20.1780678581230; Fri, 05 Jun 2026
 09:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
 <177922946329.2439242.17189876954349215664.stgit@frogsfrogsfrogs>
 <CAJnrk1bvmZ0htacx8sqZ+aBVVS_x+7kap77SEctwwB_F6ttsSw@mail.gmail.com> <20260604235304.GI6070@frogsfrogsfrogs>
In-Reply-To: <20260604235304.GI6070@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 5 Jun 2026 09:56:09 -0700
X-Gm-Features: AVVi8Cc7CvtLmSAsLsPgbFQJh3fhoENrv1QvAhnBDonpKbY8QJfsAGPKasyWKTE
Message-ID: <CAJnrk1Yvcet5rqUHLPxgf=YxMG9Lw_-eKkMdXak2-5jchnUq-g@mail.gmail.com>
Subject: Re: [PATCH 7/9] fuse: invalidate ranges of backing devices being used
 for iomap
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 4:53=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Fri, May 22, 2026 at 06:29:16PM -0700, Joanne Koong wrote:
> > On Tue, May 19, 2026 at 3:32=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Make it easier to invalidate the page cache for a block device that i=
s
> > > being used in conjunction with iomap.  This allows a fuse server to k=
ill
> > > all cached data for a block that is being freed, so that block reuse
> > > doesn't result in file corruption.  Right now, the only way to do thi=
s
> > > is with fadvise, which ignores and doesn't wait for pages undergoing
> > > writeback.

Rereading this patch... (or maybe just reading it correctly for the
first time now :P)

If I'm understanding it correctly, the problem it's trying to solve is
that the block device has its own page cache (separate from the fuse
inode page cache) and when the fuseblk server or fuse iomap server is
unmounted and done interacting with the block device, there's still
data in the block device's cache that lingers - is this correct?

Is userspace not able to handle this themselves by flushing +
invalidating the block device's cache with the BLKFLSBUF ioctl call?

> >
> > imo this would be cleaner going through the ioctl backing interface
> > instead of through notifications.
> >
> > I was thinking of something similar in idea for this for passthrough
> > where you're able to dynamically update or invalidate a mapping
> > corresponding to a backing id. It'd be great if we could both use the
> > same uapi.
>
> What do you mean by update a mapping?

I don't think my previous comment applies to your patch - I had
misinterpreted "invalidate ranges of backing devices" as meaning
invalidating the range of a file that is mapped to a backing
file/device.

Thanks,
Joanne

>
> FWIW the functionality here is a lot like POSIX_FADV_DONTNEED, except
> that we actually want to wait for writeback and tear down all the folios
> in the range because it's mandatory, not advisory.
>
> (TBH it's more like what filesystems do to the pagecache prior to a
> fallocate punch-hole operation).
