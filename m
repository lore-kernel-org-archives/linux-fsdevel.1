Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F58F4BF94F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826414; cv=none; b=YVeGoacdN6wyZyH+BuxpbUIgKGgKsO/Vuj3l2MWaOZHLb3c+YQ7nyK0ts7FZ7RgXqThYxtKuyfFY23/pvxJV0KeAYl3Bnr3vvycWzhxbsks34KP9vkuA8Pd9jcmf3uNlF3bWLohhIjeB8flsLxdnRjw1PUcjGvKofcmzJ9hbnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826414; c=relaxed/simple;
	bh=A2Lw1qEwiVqek4QQJv+8yes4AI+kfJoHfEBfQC1r45o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D39janqGGLmGcynobZZ1SbScMpg58XnuV77GEWpBwuGyko+zXncxBP4F0lQxxQ3B06amVClnhuoj5v2Xbwl8qUPQ7QjBfRL0lA+OMQ8yVGQ66kT1FrcGcPCHIF1S2PxuMDrVu+N+yty01n+OeVMmzG6m/wilrJz5SVEdePwUmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSTCtxto; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSTCtxto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791826412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiWPlyJ/kHmIcgrx0dElZdSiJcK1k2eBqgSvDAJP7IY=;
	b=OSTCtxtoiRN94VfcRixfdDOE380J727M30qWfMeqZcLieHHlt3+BbUUnK3W/J8GN5iMEzo
	2FCrs8bnHXVlczMENiuhPxUsZsetCkHr7f+DHXGKjReZsZgoh7rzlJ/KTLd5M5vF8H+r5v
	Yj8tMvCPtYST0evdrlM5vabOP0tTp8g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-AlrKjK9gPdeV7ySUBQPTDQ-1; Mon,
 12 Oct 2026 17:33:27 +0000
X-MC-Unique: AlrKjK9gPdeV7ySUBQPTDQ-1
X-Mimecast-MFC-AGG-ID: AlrKjK9gPdeV7ySUBQPTDQ_1791826405
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 601E6195606D;
	Mon, 12 Oct 2026 17:33:24 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6D2E3180034C;
	Mon, 12 Oct 2026 17:33:20 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 12 Oct 2026 19:33:24 +0200 (CEST)
Date: Mon, 12 Oct 2026 19:33:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: w15303746062@163.com, David Laight <david.laight.linux@gmail.com>,
	jlayton@kernel.org, chuck.lever@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, alex.aring@gmail.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync
 signaling
Message-ID: <as0Z302oRQpI7rgX@redhat.com>
References: <d15a25fe784b5d4449c7ce4e56f1428d7ff28885.camel@kernel.org>
 <20260523135210.590928-1-w15303746062@163.com>
 <asI5Fn87_SoEd4G5@redhat.com>
 <asuxzwl4iWjjEjRD@redhat.com>
 <437297ff-1bb4-49a7-a979-abccdd1814f8@stu.xidian.edu.cn>
 <asz_NnX9_KaJdaf_@redhat.com>
 <dbf95fb6-1685-463c-a533-79024d7a0a18@stu.xidian.edu.cn>
 <as0K5CT8IIaCWsfR@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as0K5CT8IIaCWsfR@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

perhaps it is time to add pid->tasks_lock or abuse pid->lock we already
have (we would need to make it irq-safe) but this doesn't look nice...

Oleg.

On 10/12, Oleg Nesterov wrote:
>
> On 10/13, Mingyu Wang wrote:
> >
> > report7.txt corresponds to the warning quoted in my previous reply
> > (syz.2.658/3606).
>
> ...
>
> >   kill_fasync fs/fcntl.c:1159 [inline]
> >   kill_fasync+0x13c/0x520 fs/fcntl.c:1152
> >   __pass_event drivers/input/evdev.c:240 [inline]
> >   evdev_pass_values.part.0+0x62a/0x8f0 drivers/input/evdev.c:278
> >   evdev_pass_values drivers/input/evdev.c:253 [inline]
> >   evdev_events+0x3ba/0x440 drivers/input/evdev.c:306
> >   input_pass_values+0x70c/0x860 drivers/input/input.c:128
> >   input_event_dispose drivers/input/input.c:353 [inline]
> >   input_handle_event+0xdb3/0x1490 drivers/input/input.c:370
> >   input_inject_event+0x1ea/0x3b0 drivers/input/input.c:424
> >   evdev_do_ioctl+0x547/0x1980 drivers/input/evdev.c:1070
> >   evdev_ioctl_handler drivers/input/evdev.c:1270 [inline]
> >   evdev_ioctl+0x14f/0x1b0 drivers/input/evdev.c:1279
> >   vfs_ioctl fs/ioctl.c:51 [inline]
> >   __do_sys_ioctl fs/ioctl.c:597 [inline]
> >   __se_sys_ioctl fs/ioctl.c:583 [inline]
> >   __x64_sys_ioctl+0x194/0x210 fs/ioctl.c:583
>
> Thanks. So yes, this is what I suspected...
>
> kill_fasync() is called under dev->event_lock (input_inject_event() abobe)
> in process contect.
>
> If another CPU takes the same dev->event_lock in softirq context and we race
> with write_lock(tasklist) on yet another CPU, deadlock is indeed possible...
>
> I'll try to take a look, but I can't promise too much ;)
>
> Oleg.

