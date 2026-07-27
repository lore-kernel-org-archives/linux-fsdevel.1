Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1A3F6C25
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153031; cv=none; b=hlDiTn6AqwCMOyBhTp9b2FnCwod0bKJT+4OahdI6iU30W46RHier6ujFyCMWQ0rgsCXhEaCho/GXJ66JWPdRj4BCArtlFnPIX/4zShdDNkXVaZ0T1mnC/0rLrfrXaLy+VmGJlmpuBkXgXoU+rghlqsNYK1mxf+Pc1sSoF6+FnAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153031; c=relaxed/simple;
	bh=PjwoEkzptfuBeVHS3ev/vrI9U9O1fOp7MhbTKPXSldA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnuqqgsI2c57JG9au0ZnyDtI58Iw7IXvt5Z4oUpk1kB/Lmz6Iwk18KoCnGZhlXTEXUEWA46e/XQ+sPUn9yN+8uy+MWeeKYuF9POaKcqdrOg1qXuEiw0L/Qk6rKlleSI6iODjfFKBjEwTkm8/JMOIJeA/nPOyi/wQKmRn1BHq6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ed1X5gpT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ed1X5gpT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785153028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wffdKTFxlL1hXZHBK5IrHJWwhvTTyCkW7zVARYG64QI=;
	b=Ed1X5gpTjgZ/kxve0bNyvDwmMv2bp/6SiBippiKSQVu557yGu49WdJ8BwTsHWy1e8xUCVF
	YrwXRTKmmfMoIKnoiWiIclfPLXA8FGt9GziIonlvAGP3bQLXejnGfYtq3+sWacKBwgDpk1
	GNj2RFd7MgvVjzDqViq3RZCqDlfY8fs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-1cNczG41MIazlwQvg2ZPeg-1; Mon,
 27 Jul 2026 07:50:25 -0400
X-MC-Unique: 1cNczG41MIazlwQvg2ZPeg-1
X-Mimecast-MFC-AGG-ID: 1cNczG41MIazlwQvg2ZPeg_1785153023
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1807C19540EC;
	Mon, 27 Jul 2026 11:50:23 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1820D1955F78;
	Mon, 27 Jul 2026 11:50:18 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 27 Jul 2026 13:50:22 +0200 (CEST)
Date: Mon, 27 Jul 2026 13:50:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 0/1] pipe: only enable the extra wake_up(rd_wait) when
 epoll is actually used
Message-ID: <amdF-Ulltna5AV85@redhat.com>
References: <amIqfCo25rLtM2U0@redhat.com>
 <amIu5WWgTNkdvqIz@redhat.com>
 <amNvebqiG2fH0W_L@redhat.com>
 <CAGudoHGiKYfF6L1yFy+QZgQaTt5ULnp6rgRaZE=6BANkpjrb7g@mail.gmail.com>
 <amN8ppPXRiUdiVKM@redhat.com>
 <amc4SXBOGmLbfmp3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amc4SXBOGmLbfmp3@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/27, Breno Leitao wrote:
>
> On Fri, Jul 24, 2026 at 04:54:30PM +0200, Oleg Nesterov wrote:
> >
> > __Perhaps__ pipe_poll() could check something like wait->_key & EPOLLET to
> > detect both epoll/io_uring... Not sure, probably not, I'll try to check later.
>
> I got the impression that pipe_poll() sees EPOLLET in wait->_key for
> io_uring the same as for EPOLLET epoll. Since d59bd748db0a
> ("io_uring/poll: disable level triggered poll").
>
> io_poll_add_prep(), which is called before teh proper iouring command,
> rejects IORING_POLL_ADD_LEVEL, so io_poll_parse_events() always ORs in
> EPOLLET for IORING_OP_POLL_ADD.
>
> The internal apoll path sets EPOLLET unconditionally too
> (io_arm_apoll()), so every io_uring poll arming carries it.
>
> Maybe this would work on the set side?
>
>         if ((filp->f_mode & FMODE_READ) && wait &&
>             (wait->_key & EPOLLET) &&

This is exactly what I meant and what I did. I am writing the changelog,
will send the patch soon today. Both test-cases I wrote pass, same for
tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c

Oleg.

