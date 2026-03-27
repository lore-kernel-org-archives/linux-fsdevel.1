Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1664204E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774652861; cv=none; b=rR4B7AxVLqC7KqU3FNjK3YCd/KdDB5kBxu4T8wndz0QOWbka7QgUbfxJdljRKvEaA1xeQIgtOkUzWYZgQfOyoTa0dFs2r6ouY8HWLTNAtYHamlNOGt8YVKGgOX28DkajatJpqpDEu3DeNjIacSYkhKiP+4V2FrN9ENMEfDt4SEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774652861; c=relaxed/simple;
	bh=xiGdQa3FqpPK22tmcS1FAxYsr87beRM4sIdjxG13Nyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2MM6OUXpyTOiKSHZeGMJ2V9/AeYKr8ArShBjsRgl1vNzb/Akh3xlEFp5yopB0EB0OmAE6lMc4EL9JXUlZOoPscvk4iJ3Dom8PLoedoASH84UicEx/6ZMHI0njNx4gnI+sRCoMGn+KOP/bvdxt0Qv0k2t5g+RQT+Z8P6yYiEC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=XSfaMnUN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCCUzWeD; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="XSfaMnUN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCCUzWeD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A8C37A0076;
	Fri, 27 Mar 2026 19:07:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 27 Mar 2026 19:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774652858;
	 x=1774739258; bh=BjhUfA4o6yw8lesqJjlkLGaLuAPL/0+OR4DYwo+3gRE=; b=
	XSfaMnUNIl5LezjZAw0ff2cArEhcR5MFcrGCN9vQGfVPVq8nOlwLqHCSfUaKfbCK
	mOpqBW6aCI2wk9pVHn0HYMUlGir18QL/qHeeEY1FALCAm/HROq2VBr42gV4+jcKT
	gjgVjBMNjJgYDYi03F3T+D9NoLaayo/NIgScybN3mUYB0XIt3CpqGGbTZihzbHft
	WOjF+V9q5a366i26teIdMHoxvDU7gNRbVtVpiO0+6eaw11zaiXU6PfA/njl+85+d
	Q9zR96FhaPwuWjcvSb77CALM53bU74/hWJYa4L2NOmfW2fXRJBK7Cy0RmBtDLUpk
	x+A31MVUY4WXy+N0794NCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774652858; x=
	1774739258; bh=BjhUfA4o6yw8lesqJjlkLGaLuAPL/0+OR4DYwo+3gRE=; b=e
	CCUzWeDkjNnMHWeVhzM2ow5m3Q8FPoaFXF/ev2GVA5rEbwDNJI2dsmcmzuwvRIQ+
	vo8OzzRJD2QMLCZU/+GlolgqQ4Jy5PZHkCw49Y6KMAzpxs0Hh1y1czkgWS4cVpW5
	vyWGa1dLb+cH1gZIPVxrY1hi/gzqOCNyH0OFDWPHiZe3cjlsmYaew34ow2+b73cE
	UX4xvoMZAOTK9PAzmAWJ4So8Pu8isq3NDOaoWUQmlHivUbdZGDE/r9eLxe2XuPbq
	QCXlB1wnRXpowcBHlXt3TDovxzE0Xdo2pU+COXT4uPOIQc5d6t+zZMeHwWBT8DEE
	VNtDX2FDEJulVyYjkwPmA==
X-ME-Sender: <xms:uQ3HacVytCOl45Gfj7dhzbzLUprIML2AqoccDlb12c_Hez42lJxIiQ>
    <xme:uQ3HaXfCuhFKL4uMzTc3HX_vcaZKhIIcgVsbsr5anO2qeOEd-b7MLYh7exjlFhDVJ
    5-nbIlAAdL9qXQAheupJndosW9plcmsbgflyF9iRz8ylEGEEpo>
X-ME-Received: <xmr:uQ3HaYtJAnIKKK6ihmGo_WZT3u1OnK9cDTRw09sjem5eeVECukIOywIoKYdSx1oscGbz5PHEG3ueHkgaQyCJH850qHatcfnfpncSozfPJ_KwbrZoQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorg
    hnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgthhgvnhesuggu
    nhdrtghomh
X-ME-Proxy: <xmx:uQ3HaW9c0XQ8ZGphnhqiPF6XBBmDvrK2fFPDisJaQpsDtV8BAvBYag>
    <xmx:uQ3HaT3SmYNzYZ55umLqVcGhttNMpEN5sTMksbKEoVyNKG9-h5gmMQ>
    <xmx:uQ3HabCrmfWf1N71vPtdtz2-ty8XrJuRWZMX_y_n8GVZUK8l1CZQjw>
    <xmx:uQ3HafeBJ9_tdNjzVQZHfXEdDwMpydv8HahtAA2oGhSFPMUF9B5oTQ>
    <xmx:ug3HaeVQlTfwmzO3ejwDg9a5HY_ZcN1_lWu42WSTGPTAUpcjryxrplk3>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 19:07:36 -0400 (EDT)
Message-ID: <db13185d-787a-41a2-9204-ba469a5cf5b1@bsbernd.com>
Date: Sat, 28 Mar 2026 00:07:35 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/25] Add a new daemonize API
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-4-b1ca8fcbf60f@bsbernd.com>
 <20260327220614.GH6254@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260327220614.GH6254@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Darrick,

On 3/27/26 23:06, Darrick J. Wong wrote:
> On Thu, Mar 26, 2026 at 10:34:37PM +0100, Bernd Schubert wrote:
>> Existing example/ file systems do the fuse_daemonize() after
>> fuse_session_mount() - i.e. after the mount point is already
>> established. Though, these example/ daemons do not start
>> extra threads and do not need network initialization either.
> 
> AFAICT the situation here with the extra threads and async FUSE_INIT is:
> 
> a) You can't start them until after fuse_daemonize() because that might
>    fork the whole process

The extra threads are not cloned - they stay attached to the parent.

> 
> b) You don't want to start them until you know that the mount()
>    succeeds (maybe?)

For me the other way around, I want to start them before the mount and
let them do things like network connection/authorization. Not nice if
the mount has already suceeded and then part of the initialization fails
and a stale mount come up.

> 
> c) You need those threads to be active to start serving the fuse
>    requests that come after FUSE_INIT
> 
> d) libfuse apparently starts even more threads to wait on the iouring
>    queues after the fuse server returns from FUSE_INIT.

Actually it starts these threads from FUSE_INIT and before replying
FUSE_INIT success. In order to tell the fuse-client/kernel if
fuse-server wants io-uring.


> 
> e) fuse_loop_mt() starts up the request handler threads and waits for
>    the session to exit and/or for mt_finish to be sem_post()ed.
> 
> Does that sound right?


> 
> Looking at fuse4fs, I realize that it need /not/ start its background
> threads from the FUSE_INIT handler; all that should be done after
> daemonize before calling fuse_session_loop_mt.  The only reason I wrote

So after the mount? What is if starting the threads would fail for some
reason?

> it that way was blind patterning after fuse2fs, which doesn't call
> daemonize() directly, so FUSE_INIT is the first time any fuse2fs code
> gets called after daemonizing.
> 
>> fuse_daemonize() also does not allow to return notification
>> from the forked child to the parent.
>>
>> Complex fuse file system daemons often want the order of
>> 1) fork - parent watches, child does the work
>>
>> Child:
>>     2) start extra threads and system initialization (like network
>>        connection and RDMA memory registration) from the fork child.
>>     3) Start the fuse session after everything else succeeded
>>
>> Parent:
>>     Report child initialization success or failure
> 
> Under classic async FUSE_INIT, the sequence in most fuse servers is:
> 
> 1) The parent opens /dev/fuse and mounts the fuse filesystem before even
>    daemonizing
> 
> 2) Mounting the fuse fs causes an async FUSE_INIT to be sent to the
>    queues, which sits there because nobody's looking for event yet
> 
> 3) The parent daemonize()s, and the child proceeds with setting signal
>    handlers and starting up the fuse-request processing threads
> 
> 4) The parent exits, the child continues on to set up the fuse worker
>    threads
> 
> 5) One of the request handler threads finally reads /dev/fuse to find
>    the FUSE_INIT request and processes it
> 
> 6) do_init (in the lowlevel fuse library) starts up the uring workers
>    if the kernel acknowledges the uring feature.  The fuse server has
>    no means to discover if the fusedev would permit uring before
>    calling mount().

Yeah, initially I wanted to handle that through an ioctl and independent
of FUSE_INIT, Miklos had asked to change that.

> 
> Does my understanding make sense?
> 
>> A new API is introduced to overcome the limitations of
>> fuse_daemonize()
>>
>> fuse_daemonize_start() - fork, but foreground process does not
>> terminate yet and watches the background.
> 
> But with sync FUSE_INIT this is not workable because the child has to
> have done (4) before (1) can complete, or it has to set up a temporary
> request handler thread to process the FUSE_INIT.  That's partly why
> fuse_daemonize_start/success/fail() is created here, right?

I have written two similar APIs for two different daemons at DDN (one in
C and the other in C++), independent of sync FUSE_INIT. For us it is
important to only create the mount point when the network connection
works - that is done by threads not under control from libfuse. With
network you want to see something like "authorization failure" or "host
not reachable" in foreground.

With sync FUSE_INIT the additional issue of
FUSE_INIT-creates-the-io-uring ring thread came up - even the
<libfuse>/example/* file systems all don't work, because now
fuse_session_mount() creates the ring threads, then comes
fuse_daemonize() - parent exits - ring threads gone.

> 
> And the rest of the reason for the new functions is to enable
> communication between the parent and child processes -- if one dies
> the other can find out about it; and the child can tell the parent the
> outcome of mount()ing the filesystem.
> 
> I wonder -- if you know that the kernel supports synchronous FUSE_INIT,
> can you start the main event handling threadpool (i.e. the one created
> in fuse_loop_mt.c) after opening /dev/fuse (obviously) but before
> calling mount()?  That would make a hard requirement of having at least
> one event handling thread, but you wouldn't have to create this temp
> thread just to handle the FUSE_INIT.

That would work and I believe it would be feasible for libfuse examples,
but what about all the other real file systems out there? They would
need to be rewritten to get sync INIT? And how many people understand
the difference between sync and async init? Is this temp thread causing
issues?

> 
> Even better the daemonize() changes reduce to just the pipe between
> parent and child and watching either for a return value or the POLLERR
> when either program fails unexpectedly.

We also need to send a signal to the parent that child has success. How
many pipes we use is an internal detail? If we find a better way later
to reduce the number of pipes, even better.

> 
>> fuse_daemonize_success() / fuse_daemonize_fail() - background
>> daemon signals to the foreground process success or failure.
>>
>> fuse_daemonize_active() - helper function for the high level
>> interface, which needs to handle both APIs. fuse_daemonize()
>> is called within fuse_main(), which now needs to know if the caller
>> actually already used the new API itself.
>>
>> The object 'struct fuse_daemonize *' is allocated dynamically
>> and stored a global variable in fuse_daemonize.c, because
>> - high level fuse_main_real_versioned() needs to know
>> if already daemonized
>> - high level daemons do not have access to struct fuse_session
>> - FUSE_SYNC_INIT in later commits can only be done if the new
>> API (or a file system internal) daemonization is used.
> 
> I don't know exactly what's required to switch libfuse into uring mode.
> It look as though you inject -oio_uring as a mount option, then libfuse
> sets up the uring, starts some extra workers to handle the ring(?) and
> puts them to sleep.  If the kernel says it supports uring in FUSE_INIT
> then do_init wakes them up.  Each uring thread submits SQEs and waits
> for fuse requests to appear as CQEs, right?

Yeah, we can also make that later on a default, without the -oio_uring
option (there is also env for ci test purposes to enforce io-uring
mode). Right now it starts too many threads (got distracted today and
didn't send the new version of ring reduction patches - will try
tomorrow). And I also expected bugs in all that new code, so I didn't
want to make it a default.

> 
> So after a fuse server negotiates with the kernel about iouring, the
> background threads started by fuse_loop_mt just sit there in read()
> doing nothing else, while new fuse requests get sent to userspace as a
> CQE, right?

Exactly.


My question is now, are you ok with the new fuse_daemonize API? It
sounds a bit like you don't like it too much.


Thanks,
Bernd
