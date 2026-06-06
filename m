Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99F3815ED
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780741377; cv=none; b=ZJzM2xEYJdjV3nobzaFTEJsG0tt1c1RTq89H/4Xmo67fRQ9u36kGUVEUe8T5W0i74Lt2ZRt5fbepRKje8mfZQJ8jZcYjKx9nhKZP96ImWutjt1aRaMMBaLL/Swj1z1E3Mk7NSjmJKa0npxjdHb8Dn5Nt72nssj4QuGXhuH2L/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780741377; c=relaxed/simple;
	bh=6ZCo5g5YBCheH6lxLHUPDkhAwohoDkXUQMyBGc7LXHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3g6hbLjSsPFUtfEry8c4UKwqhI6pD/3jMVpJM1MZu9KcF2sHhaw+Goq0bG/CstaWYgRY6Z90z04e1QVC712YHj9KCzKOFxZ+x4Jvp9Hn2SbDt8oTgI0RRdq8yy6xJ3vs+4H1eGXsmXxBsotqc2+IJ/L1KwM6ptLiuopp4LFe2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKtg9Daq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKtg9Daq"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4600ddc4017so2090061f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780741374; x=1781346174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PYftnEwTkOLQeoNu4nW8+o38nbEt2RMPyp6dfwToa0=;
        b=hKtg9DaqIzHht9h/SEID0icP61633FjrvmqTBmsAZc+rb3Xco+LhMeWPch3DMUAbAk
         hcZM2qcGxPM3XWviyLgvYy7mAvDsndr9Lz1n0ujQsJuFZSxRESfzlpAcK2CMJmYl1JYZ
         n8RBnwflPJti7i9pBZDIDjG6buA+ViQumBbw+iOt5kJH4S0PRJ+wodn8QgjXoKtuaONc
         8F2szrieZFskNupvhkMwOQi4eF4wGGJnyUG2NqenMFhWpyMALaet5dmcKNCFzw+7E+WL
         ZDGARKitTcWKzLeXlpTmHUi5EDrFSZn/4yYa8Z+kgvUxtWDTmOSz9tfjTwwUAirM/haW
         m5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780741374; x=1781346174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+PYftnEwTkOLQeoNu4nW8+o38nbEt2RMPyp6dfwToa0=;
        b=Gjk1k79vuNFUJdUuYWc1CshvDHGeirDjpi5eL3TkscDwNmQ1Sczl8QcpxsOro9DYrC
         R1/YmLIu9DUaQvlF5ryDF5KVFQALaKm1bGagjNybhLfBmRzDOWNCfHCX+ESlN6wkhSg9
         mtO5iXQls8rPuVwPB3e6Sji38yYAztf3hdUZJdgLcq/WjF/htQCT3DkZmhjhrmQkqHIJ
         1jPxMs2IH5bjllJ0zRIrRPTqKuAB4AHELn6taGPSXMm1ag7tWY2xOmw2usnR2o6hoan4
         fOlPcro/AfnZdpQCsjlNfWhMoCIU/13/gF79LjAwvJK1a5Vgbq9WGodk7CArw+QnrNxf
         dz4g==
X-Forwarded-Encrypted: i=1; AFNElJ+Tsfiqzrbi3rekXotsbA4d6aCR3l+FMKeyQ9AprF/to3pWmicC8O3oDPctqzvR5pyphkavlvfI78+13mUV@vger.kernel.org
X-Gm-Message-State: AOJu0YzibvpxAbWtJb0kyS37THCjzMmFABYionewHxFEcD6zwdcu5bzu
	CmaEwSdc5zhHn53UhpDmUs+IQuwTJyeRDR8HNK6CFXeG9Gii5iQd92Sk
X-Gm-Gg: Acq92OGYXwq3xkZzTNpuEtpqw2rY8d5sKB5hy6WX2/d04+Qgoucy8IQ15wGMJHJWn5y
	9gGboPN5WQyByrLKhg62hnTdVzhIBCC+5+3lE6dE07yVHGERmY6n+2JF7PdVUEYT6tRKf031TPN
	gm0myllnf84wx7eLE990rTPytOOhW79/+w30aNbzXfM/qPQ7IiCFd51gGUXKO8uuO9EdsDmL18y
	n36sJJHCdh33iIIMKK2pExo3E8r/zYX7Muh/p2Tm0PCfPWpNraSVHyUBG3+huyb5Mq1GbOmuwQB
	z/2UIGNxp1FYfhiQMlYjAS9niTARDiVGuaxXJ0Sek7znE0RysBjZncfI+JcgWOU7fsQHI7dMFHY
	PGHHRqismoi+WPPSUMOWHlTX14itgN15f8OI7YupwatHfgMOZiuhUbIyEtp0xuPxIiqLz1L40Vh
	SUP1IETQjRtOtW94QkRCDeT60u7dPiJpL0DHP6dRL028VQQTS/btl7G/oPxCurGCOgQdksGPuMG
	mWZHzLxQA==
X-Received: by 2002:a05:600c:35d4:b0:490:b8d3:5dcc with SMTP id 5b1f17b1804b1-490c25e4634mr128363515e9.19.1780741374229;
        Sat, 06 Jun 2026 03:22:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm35545066f8f.6.2026.06.06.03.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 03:22:53 -0700 (PDT)
Date: Sat, 6 Jun 2026 11:22:52 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski
 <luto@amacapital.net>, Askar Safin <safinaskar@gmail.com>,
 akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
 david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu,
 netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de,
 viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260606112252.3c70bad6@pumpkin>
In-Reply-To: <634c8ae2-3f1c-46b1-b002-1e2ac797dd80@samba.org>
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
	<20260602225426.122258-1-safinaskar@gmail.com>
	<CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
	<CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
	<CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
	<512d948f-7883-4d8c-b2c5-a777e70ca975@samba.org>
	<20260605131942.4584728e@pumpkin>
	<634c8ae2-3f1c-46b1-b002-1e2ac797dd80@samba.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 17:20:34 +0200
Stefan Metzmacher <metze@samba.org> wrote:

> Hi David,
> 
> >>> So sendfile() as a concept (whether you use combinations of splice()
> >>> system calls or the sendfile system call itsefl) isn't necessarily
> >>> only about the zero-copy, it's really also about avoiding the user
> >>> space memory management.  
> >>
> >> I don't think so. Ok, maybe for webservers just serving tiny
> >> html files, that's true. But for me with Samba it's really the
> >> copy_to/from_iter() that is the major factor.  
> > 
> > Is that copy also doing the ip checksum?  
> 
> Not in my tests. I guess there's offload in the network hardware
> for this.

There will be, it is just whether the syscall checksum is actually
being suppressed.

-- David

> 
> At least at the syscall layer of sendmsg() there's no checksuming
> happening.
> 
> metze
> 

