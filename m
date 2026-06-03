Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33631326F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526981; cv=pass; b=p2q5/txUb5+PZJ3FEf2+KAOBZm6rCqvobAaO+19wdvhjHfYJBqX8hBgb+skQfQhecNxwkPsTsV6AHtmwin3rJi4zsQuU7x4x58AmpdTHXTvds5rOvDL1OOoqOf6qSFVN62ZwdJOsg52VJyB8GyiQ3OUv84YVJMT2id1p6PwQ9FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526981; c=relaxed/simple;
	bh=cIMAt4SxZf1p6upEqoxHSHb7RfP9hev2musbsbmwNuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUCbSImOVojeAatQBa1neDqwOCs/xSyLjWXkqt+gvkKha6lb+tuNReB4g9W9xIA6WjDBU5VF6MTo9g1cARbWPwdPpvsAEHTTJJurmcZFPiEOSkMEvz471p3xXmctEA6RB2pUc2qyBXNtRjt83EyFm8HhKkQRtmfV1lKRh8XcKNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Yvz/Dfr7; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="Yvz/Dfr7"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39666aac20cso153621fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 15:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780526979; cv=none;
        d=google.com; s=arc-20240605;
        b=Vy/8y1VOdWOIyX2ShHaUK4jX4b78Q1dcHql0BDOumVBmBcshVNrJAHvbJ73zaJqtU2
         jksYUkiR8uIFRhEBNxE4Oncd0MWxzkhkyN4yjeuugFZhuMOspcCZsGcU0bsWkPeryJJ8
         JslIJpKOenJ6pkeJdIZcZATvxZcOyXkELSeUYWRaqMDfHN9whhhdh6ioPDp9y3ets52k
         PnBObneVjjm+S1tAtKuk9/2oMGKZUG1rWXJd0foICjB7R3QUIAUTC0zmzXKJMu/Y5zeW
         w7IXoVbGtxXsIM8XHpTgifnIM5dTYkjRf6Yb6Nt/Wizpe4RqJVTl/voIKFilfbTF6p2w
         xgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nThpP6AT70OYHi5mSxqfquLQYax1sVYjIai5D2em8kM=;
        fh=KdyLyNh02LR9Lv4iQwfFqZ0LYwnlitUulmiaDAfN2UM=;
        b=f02B57mfbXCwCDtOBncwpl7L/jRnfunICqL/3dAeUyzPRXIvx95MelOO3yFuVbKA67
         kXJ7BFOZFbuwEaqcDO9+tc35DGVWdl9vmKITrDns9ivQpbuarQZOKiOyC2VbzPKvI8ue
         jC+O2KvakhS3SCZBQApwyB8cZ+T1cP/GpOl1AVHgGNSHchO1cZy81ZmBHXIISr1m6/ja
         76sym1mBRtFG8qEBNrr+JVBxqf1KO35utwtZtXMwJiEFP9pQR8ijGOv1pWdp2MsPPOzJ
         4Omr9SbP1GWMnwn0/5EbkHcihjkJiZ3Ocby0fv6mXaM1+fPpIgg447DyErD6wEpGxGtf
         WtwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780526979; x=1781131779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nThpP6AT70OYHi5mSxqfquLQYax1sVYjIai5D2em8kM=;
        b=Yvz/Dfr7RO2sXrSJP1+PBKZaWQbv9Yj1UZbDb9M5lVzXO46ZbxlWsqABai/NptWCvJ
         2mPWVoP7aGv7pBODDhXPHfWedwHWtbqBZ+guxAdmCp8fXyTXsQ38bg4qTnFsHK7XT7Y6
         mZnzWEE78oDQZalRDxNDO4d/Q3Mr0+Ct70i3g0WRV28ce5eZ8dIwoZxjj1uf1gSUnrBL
         rzID1BdWO/WpObQbZOmKyZ8hvA7ZWLT2ipdZuiBvjivU4fcitjtonrrTXAcoB1JWDNR5
         MT7hbf+dRXraXtbsg9npXobz9en89b+0inCLnP2Ls5xFDE2PlShcKSimWnecW+fd2eqG
         7JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526979; x=1781131779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nThpP6AT70OYHi5mSxqfquLQYax1sVYjIai5D2em8kM=;
        b=g5HqKnLqyFrbuYwdkTkqJmy+prbTxQZm2bnKW96CgavBGf3PKQ62iKQNFuCyh6DUeB
         UzcXf0iXG69hgFq9m8+bbXeDgC2ud8jqqDjBZviEs0GZkIE0uYlG4y1K8HV02VvehYns
         PqGGK8u6CRszZoDynbOVsF8VV2Gm8xREyRIv7klt5I7UGIjPpvwfwb3wACfUlyVgMAOI
         QolUfZf6CyE/jbt/RhkD8Q3LT31PEhnlRBtvP/U9IoehjBPnlTFqBu1oLNyF9XoORa7r
         s6UE1MLvZTE23jk9J4M1q6WTa5vPNbuRsdjgYPWzCveYefYq16KYaUSjDdiPbOFoExfG
         as1A==
X-Forwarded-Encrypted: i=1; AFNElJ8Ggsi7tnMWVduGXEMHOMDUqWxQkaxxx+2AO+LL7Up2Hk+o9wDbVARInVeQFUQsaxUlNwADBbl1UWrDrjxx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3HSAKIqbyrt2q/YfR1XS5a+//RUSp9VqD2hf72yiFkQE+r9B
	sj93qeEEvbikdfNHdi68C2ZKduWXIanaL+9vj9xUvW3kR2gfOtfr6thJ8pFo3t4rCxE7eIIFlo1
	/0nDABSH5TA390VQwRTprZrbTRlc4dLSRWycdU2Zf
X-Gm-Gg: Acq92OFzauLj080K1xynSVZoBcvfBiJ4kYvy9EVJWKz4cgvxfLCAn7D3PvhfzJKjiTj
	H7BhB66sCemsFi2wq03vjDqLDLF6sJawV/egxmn1aSGFGTUKME5Ba6qYtti/3u2hpoKliSO1tMn
	dDWD8QcpBzubZXN1lg55VijilaAtArBsmsbqtSldP8gvGNSfSbonwrCQSK/u+0WCaCUTWTK+YcU
	9MQ5HyFbD0bY+l7OW9v6uKBrMV+XS4HVHnBCWCOKd0UBJxQQ42PA0nQ9Bv42Fp4TMsH351w6TXi
	HtxvbNKiG3fMVtmVa0w=
X-Received: by 2002:a05:6512:a88:b0:5aa:7126:c661 with SMTP id
 2adb3069b0e04-5aa7c06347emr1703733e87.7.1780526978614; Wed, 03 Jun 2026
 15:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
 <20260603224311.834796-1-safinaskar@gmail.com>
In-Reply-To: <20260603224311.834796-1-safinaskar@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 3 Jun 2026 15:49:26 -0700
X-Gm-Features: AVHnY4LigDaMGEZAFdtnNoXIyXd96f1pywv43JDsz9J-Er1-wYhHVKm162Sc_xY
Message-ID: <CALCETrU94ja56CA5CRtXrm1v_7gBaPUNOHKQzS=JNF9JZ7Fznw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 3:43=E2=80=AFPM Askar Safin <safinaskar@gmail.com> w=
rote:
>
> Andy Lutomirski <luto@amacapital.net>:
> > Maybe we should keep an API that does an optimized copy, from one fd
> > to another, that can send from a file to the network with at most ONE
> > cpu-side copy.  Not aiming for zero like sendfile / splice.  Aiming
> > for one.
>
> Yes, this is what my hypothetical future patch will do.
>
> One copy from pagecache to pipe, and then network uses that buffer
> directly.
>
> > But splice_to_socket involves
> > MSG_SPLACE_PAGES, which I think is a part of the mess that you
> > dislike.  And the path where one does copy_splice_read and then
> > splice_to_socket has to be a bit complex because of tee and (I think)
> > because splice_to_socket cannot assume that the incoming data is just
> > ordinary unshared buffers.
>
> My future patch will provide new guarantee: pipe buffers are always
> stable, i. e. they will not be externally-modified.
>
> So hopefully network code will be adjusted to use this guarantee.
>
> But pipe buffers will not be "ordinary unshared buffers".
>
> They still may be shared with other things because of tee(2).
> (But they are still stable! They will not be randomly modified!)
>
> But network code can do "pipe_buf_try_steal" and thus ensure that
> these buffers are not shared with anything else.
>
> So, network code can be modified to use "pipe_buf_try_steal", and you
> will get "ordinary unshared buffers" exactly as you want. This will
> give you in total exactly one copy.
>
> Also: as well as I understand, previously, pipe_buf_try_steal was
> kind of lie. It may return true for buffers created via vmsplice with
> GIFT. (I did not check this, but I think so.) I. e. pipe_buf_try_steal wi=
ll
> return "true" in this case, but pages are still shared! But, thanks to my
> vmsplice patchset (which is already applied), this is no longer true!
> So now pipe_buf_try_steal is absolutely safe to use!
>
> Finally, we can degrade tee(2) to copy, and hopefully this will
> allow us to always be sure that pipe buffers are not shared with anything=
.
> This is possible future direction.

I'm a bit nervous that, if I've read the code correctly (a big if),
then iscsi and nvme will still send *shared* buffers via
MSG_SPLICE_PAGES, but that normal user code will not be able to do
this, and that something will bitrot.
