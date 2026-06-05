Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0692D5A01
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661989; cv=none; b=PuJ0mYW9805Qbt2B9HwBN8pX1TCAQk9nIH4/AvhatnGtWQAs9dJJyImqjcUQwl6QJttlckMnow75U6QGiB4UnlfIrEkZkn9hE8RJu55ksN5DSdkaIH2ngcXX1JQPTbXdLva0zkCqP6zsxKZsQFs1z1KffGiqJ636xnEinjeiJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661989; c=relaxed/simple;
	bh=fG5cj9E2nMxzrFq+XWzFsnTRtUdYT3n82TzWC2ntc84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVFDoUvoPJWuAhKf9aGAZI756XbT+X71kU/cxJZxqNWbDKCsna2zjAfIaZm5vydHtMNVJM+2ZTJtaKLeb7ReoFahPZ5br3YIZGY4R7zq7aZZaUqovhjkqcTnMG6lHqrBZugTchzaBYrDwn10Xs3+hX2D5+c4V9PlbmDLHKIGC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5IBHMk2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5IBHMk2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b12270b3so11428245e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780661987; x=1781266787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz+VtwQhYk3ng5JxyiUgLQa8oImJtLVBwaLlzEeVzFo=;
        b=U5IBHMk2+rOzS/if0P1kHBKhHO1E+Ya49eQCQst9eVyKYrNqaV/ILHIswx3k/Ya6cH
         uI/Mkj15UuGVafXE+YyfybWXy/xkKIInZpK6pfGSTpv+QymV2+wwfKUmIYjaXlERXnxm
         77xU7BFQ07n8mdMkNY3AlGELiR6XSktldPtw6Y/m2xAzRkqWUu+XCkzUhmgw2vpaELtr
         Lpezyfi7gwsgLU57oqpIBv5A8Vryff8AgqJRoWoybSdb0UY3cA2opYUA+qVE0WrXcR89
         5jpz/98fNXaBTt1hYIX1P8e0rugg6WZ2MlNpbU0QiHlwGKXKS42vNN6OaT420/og3ZdI
         j61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780661987; x=1781266787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gz+VtwQhYk3ng5JxyiUgLQa8oImJtLVBwaLlzEeVzFo=;
        b=jERGyyZCvWNCK35c081sRFdUoWorYkRTxL6deCLMUHZJM+tagLAzf+lRskB07dCUvf
         CB7J+UvIxriuLvP1OED32KPtuAhIc5NlhXdX3P3kK19aK53vGBILoamd5naEZ8aZVE1v
         +iukTB4pou5oUHiGPIGerAQMNRTDyXjiJL664ksvu0fTVd7cAd+NdTYGdyvW5EhXDElD
         JZIYqVH1Vx+zP5Zs2zzIcmGsQu9vF7Ua3Ro9/0CPOuTZEcAXgg7fOQ1R2BQu/ef9Bi3/
         SdEhX11Ot0ubUy7Z9nljcDI1wQKm1c+GdES4OBFU25akM3+M+Y+mdNuW0VM8ykgdXz/G
         KkZA==
X-Forwarded-Encrypted: i=1; AFNElJ+C9+x5ra8dzMqQUjUeXVDKx8rXdkw4gJQQqz3dOGDzS++m476v37ofBNrdjbJsbJHFhD+bUxoNJEWjndYk@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAjJTfQEnX+oDQec4LCNLoxDbTejy/uNgUt+c0u2OsuCRy857
	EIH4gkJxfJQRPzr55Bru0virExQqZ+KEvp24/PVK7tTnz35/hzFBI6Uw
X-Gm-Gg: Acq92OFSFiGJVzwllMUqcLCbbjoRIRPLoNSuuF0Cbe0yAGhNfPpShSHBjDQLqLRcq0P
	JFnvBqRqIQkeq3LK7+MVPuSYwuMXQRhT19gwdTu5LF8s8tJ7V2OL917f/MwPcEy8FKuJSGoxgpX
	C6K5pAC3W5zVKYDgV6xDHoreVDXLBii9hAnRKi31+gUG0EFU7WQSxgdN+Zm14+rQ2geDy3R7mdO
	J2gajAlPwREFBbe73IXqE0LKPAOQqHj7TTodvudnWfZkXocrx46zhpOqupzfdyXDOHmIiayHukj
	crMY0FYbLfdOXCiujcml+jEELlAczpiDsOjD0nlEtgStdvusBPuw3gOx6MrNcYRs4gAspdtxs5b
	y/nCUbf4aKDBj2NeEw+w7qZEEPsH9IrMKsqAfoPT5JETKlACrITcpCyvfOZ1RCEjyRwL/hKGaZs
	iOhkuOtCYTgY86uP6oELhN2LhprSvfZ+rgf/NZZrHRR9RbAMGeQRtQib/w9RG/8JU+E7xmnxtSM
	BViiVjmGw==
X-Received: by 2002:a05:600c:1d12:b0:490:7227:100 with SMTP id 5b1f17b1804b1-490c26049a0mr52430315e9.18.1780661986468;
        Fri, 05 Jun 2026 05:19:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm152016275e9.7.2026.06.05.05.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:19:46 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:19:42 +0100
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
Message-ID: <20260605131942.4584728e@pumpkin>
In-Reply-To: <512d948f-7883-4d8c-b2c5-a777e70ca975@samba.org>
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
	<20260602225426.122258-1-safinaskar@gmail.com>
	<CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
	<CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
	<CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
	<512d948f-7883-4d8c-b2c5-a777e70ca975@samba.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 11:43:45 +0200
Stefan Metzmacher <metze@samba.org> wrote:

> Hi Linus,
> 
> >> Am I understanding correctly that this will completely break zerocopy
> >> sendfile?  
> > 
> > Very much, yes.
> > 
> > And it's worth making it very very clear that ABSOLUTELY NONE of the
> > recent big security bugs were in splice.
> > 
> > They were all in the networking and crypto code that just didn't deal
> > with shared data correctly.
> > 
> > So in that sense, it's a bit sad to discuss castrating splice.
> > 
> > But it's probably still the right thing to at least try.
> > 
> > I've seen very impressive benchmark numbers over the years, but
> > they've often smelled more like benchmarketing than actual real work.
> > 
> > There's also a real possibility that a lot of the sendfile / splice
> > advantage has little to do with zero-copy, and more to do with the
> > cost of mapping and maintaining buffers in user space.
> > 
> > If you are sending file data using plain reads and writes, it's not
> > just the "copy from user space to socket data structures".
> > 
> > There's also the cost of populating user space in the first place:
> > page faults for mmap made *that* historical copy avoidance basically a
> > fairy tale.
> > 
> > And not using mmap means that you have the cost of double caching in
> > the kernel _and_ user space etc.
> > 
> > So sendfile() as a concept (whether you use combinations of splice()
> > system calls or the sendfile system call itsefl) isn't necessarily
> > only about the zero-copy, it's really also about avoiding the user
> > space memory management.  
> 
> I don't think so. Ok, maybe for webservers just serving tiny
> html files, that's true. But for me with Samba it's really the
> copy_to/from_iter() that is the major factor.

Is that copy also doing the ip checksum?
I really can't tell from the code (it does sometimes, even for tcp).
But I can't help feeling that optimisation is well past its sell by date.

-- David

> 
> We can use io_uring with IOSQE_ASYNC in order to offload
> the memcpy cpu wasting to different cores, but it's still
> wasting a lot of resources.
> 
> For the case of filesystem => socket, we can use
> IORING_OP_SENDMSG_ZC and that at least removes the
> copy_from_iter() in the sendmsg path, but the
> IORING_OP_READV of buffers in the sizes up to 8MBytes
> is wasting cpu in copy_to_iter().
> 
> For the case with smbdirect and RDMA offload with 2x200GBit/s links
> changes from only ~33GBytes/s are used (and the server cpu even if using multiple cores)
> is the limit. Without the memcpy waste ~46GByte/s is easily reached
> and the limit is just the network link.
> 
> Maybe another solution could be having a version of
> copy_to/from_iter that uses async_memcpy(), but didn't
> have the time to experiment with that yet. Maybe a new flag
> to preadv2/pwritev2 could control that, so that the
> application can decide what's better.
> 
> But without an alternative please don't kill splice.
> 
> A lot of people are frustrated because they bought hardware
> that is able to handle a lot of throughput, but
> e.g. with the default of smb over tcp they get no
> higher than 3.5GByte/s on a 100GBit/s link that's able
> to handle ~11GBytes/s. And io_uring and splice are
> a key factor to fix that.
> 
> Thanks!
> metze
> 

