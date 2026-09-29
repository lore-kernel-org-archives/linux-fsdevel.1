Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47934B44CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671814; cv=none; b=j4XrGFwFub/UIuZrreVlmezDDQfam2MMFBQabYuu86GnVvF/Qmlp44ZOVOjVCuHfKgltowjqs/GowzABR1t6nb+pRf86Ugto40MZufD3pm0MRFJUpekFqGXolTejU+x1Fypy7VM5waPLiQSKiBwG2aLUqT+xozV5/apX/yQROc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671814; c=relaxed/simple;
	bh=uxSCt0FV6gaua+FWWnEppijMyYUOY9i8SVsu0cEASms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p/FKEPNe5jXV89wdwnJmTqy2vlLJVfjCioWbjiwzh3KLqJwgHYyk92I9ktUWP1FIGrgxxvKmZBPNlBfZ8frudyoTe6nTOqBRqYmuqYdYONDZIkMK+XmVkxiijK+P/wXiARBPyKqcN+Ma4amGBSf9QlM1S1H2yHXwLTVUsq+tDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSg5KjJL; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSg5KjJL"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2d93b92937so216604566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790671797; x=1791276597; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Aobrvi+EUy84a4OEPy4ev1haJ3JzGtFESlBQNCRjoU=;
        b=fSg5KjJLQxm29mm+s/bVY/Vph7tovPU7SNDHdlZfb8vH1mDG2JLAdubsjafXtpvgWf
         uigPeQiBqhi+EADdw4M3Kx7mfc6vcvp8Vr+uSN5L+/4aAG/EUaBeXq727DjSil944MTC
         hyJxsVlU09G9Csg1FUAqVWnOpsy6y+CgP+xnRvwx84x06sQ9ekCkn8nbeXksX/r3cwa4
         5H5Ki6Sapwaguvdui0/0LUaVSQNkXerHJefTt7GjDb5OE+AXdCCzQQFWL0rP8PpTN0Qu
         caLafThIxPKtlEekm9olxNM6ZGzGoaZVkViJj9UnptxRYzHtO6FMwSdz5BF90hNnQ7cq
         tDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671797; x=1791276597;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Aobrvi+EUy84a4OEPy4ev1haJ3JzGtFESlBQNCRjoU=;
        b=zImb8Z0MDsPvCFtVoGcmqxT439/XtR+1Y4W/+9ETWkFTu0htlaZ5A9HdqksQ3AqLoH
         FzBZJ+gcDvIl+hbAdrwQpAq5RAJ3AUG1HNfqmNVO5GW2qxDTXseVCFAtt6fckKaHdSRR
         +x69kykZd5F8KXJPcwTBnWxc2bZBsL85zKAWCrOHIg3RKFI7wSeAyKg58CjYtaZHtEBt
         2LCQBPSdQQVCx0BjhYrR0jki2DXMNtWdiL13TnMFsY+wUtZLLauJxNdl/u85pwlBO4GY
         QExPlS4BN1V/wjPoUusRGGk+jVDIbRw4M0LckRKwE8Km+7ER36gOc8QeNV9YdbcIp2fC
         wpzA==
X-Forwarded-Encrypted: i=1; AKwUvBwYSqNutZz22MMWYMUpYHMbzQXFPgG/JgVgaT1QOhCsCpmCTlMlsCBqsRZWDYIwCUgqIEqnxOdJM/ZkWkE7@vger.kernel.org
X-Gm-Message-State: AFuF++nAhrluS4rOXEgiV+HeHemHzQb35d0/oyZTwwasBtbsTBYT2/Es
	sfsWxn0K/pLMX3Knk26EZlJ/jc4Hm6Mn7db8NpFKpydcp2BxNFc8kw7TT8nxAPA2+xiyCamrvTE
	admAtYFkRfCjTjPaW7Q==
X-Received: from ejmc17.prod.google.com ([2002:a17:906:5291:b0:c2a:b946:e518])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d08:b0:c25:2a78:15ed with SMTP id a640c23a62f3a-c2ac22db502mr1246008766b.6.1790671797146;
 Tue, 29 Sep 2026 01:49:57 -0700 (PDT)
Date: Tue, 29 Sep 2026 08:49:55 +0000
In-Reply-To: <20260929044843.GA3909609@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com> <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
 <20260929044843.GA3909609@ZenIV>
Message-ID: <art7swUNAa3AyUrL@google.com>
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
From: Alice Ryhl <aliceryhl@google.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, 
	Georgios Androutsopoulos <georgeandrout13@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Sep 29, 2026 at 05:48:43AM +0100, Al Viro wrote:
> On Fri, Sep 25, 2026 at 06:00:42PM +0200, Christian Brauner wrote:
> > On Thu, Sep 24, 2026 at 08:39:37AM +0000, Alice Ryhl wrote:
> 
> > > This looks like it should ideally be on the C side instead.
> > 
> > Where is this godforsaken broken code, that tries to fd_install() after
> > exit_files(). It is _a bug in the program_ that is not something the
> > apis need to work around.
> 
> 	More to the point, papering over that at runtime is wrong, and not
> just for modifying descriptor tables - fdget() is just as wrong in anything
> that can be called from tail of do_exit().
> 
> 	It's exactly the same as with "what if it gets called from an
> rcu callback?" - it's a bug, that's what.  Don't use these primitives
> in such context.
> 
> 	In particular, ->release() mentioned upthread should not be allowed
> to access _anything_ hanging off current, not just descriptor table.  Note
> that the last reference to an opened file might be sitting in an SCM_RIGHTS
> datagram pruned by AF_UNIX garbage collector; as far as the method is concerned,
> it might be called from random thread.
> 
> 	If it tries to access (let alone modify) the current descriptor table,
> you have no memory safety whatsoever and checking if current->files happens
> to be NULL is nowhere near enough to resolve that.
> 
> 	I don't know how to express that gracefully in terms of typechecking -
> sure, we could pass an empty token to each syscall, have fdget() et.al.
> require that as an argument and propagate the damn thing to all such callsites,
> but that would cause an insane amount of churn - if nothing else, ->ioctl()
> signature would have to be changed and there's a _lot_ of instances out there.
> And then there's the joy of dealing with ->sendmsg() and ->recvmsg(),
> thanks to SCM_RIGHTS datagrams, again (reading descriptor table on sendmsg()
> side, inserting into it on recvmsg()), especially when you consider the
> fact that ->sendmsg() and ->recvmsg() *are* callable from contexts where
> one shouldn't be allowed to access descriptor tables.  None of such
> call chains is going to trigger descriptor table access (e.g. knbd is
> not going to try and send SCM_RIGHTS datagrams, etc.), so it should be
> safe, but having compiler prove that without inflicting overhead on
> the code paths where it really wouldn't be welcome is not going to be trivial.

So, I previously wrote some code that could invoke filp_close() to close
a given fd ... from a workqueue. This was in the scenario where the
process dies and the usual cleanup function gets called deferred from a
workqueue instead of from the ioctl like usual.

In this case the correct behavior was just to do nothing.

It was a very easy mistake to make, and if such mistakes lead to null
ptr derefs or worse, then I think it's worth doing something to reduce
the bad consequences from this kind of mistake.

Alice
