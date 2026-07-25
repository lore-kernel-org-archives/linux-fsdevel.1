Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197B30FF08
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992765; cv=none; b=HccvToB8tXm2ye+zgS5Rbpb15kkDV0d775baDy18fhPlqK848FYW4kJnmqQPAOOYlsOmRx1/tc4rcQ6UkgSSHV+Yo1x5jBhBI0GjOKV46J6RbQ8wsXqM6d1xaaFjHegrVayHYM/DO+YZ3dZt2CRTfacsqhCy6Ewx5crOSReInWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992765; c=relaxed/simple;
	bh=Hqv3F1djcLzAo9MDiOdGAro4PDCik3lCiqHwZjMccXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTJ4oHWbGsNM3NF6GjQcSp+z5KQoLuOQ0PkpZqjX8TQk9ddHAOQTJFTUfLEn647AGdrw1roCo0xCgPqFGX8JRZDniI4qDYaaZg1lFZFSrnSojIpE33pC2dPVKDVc8xKxgRnpCMbSMVHA7B8Aady9sDLocUnYApR/Lww1nfvWtB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTC9si2U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTC9si2U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784992761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIRORT1kU38zV87IyK7DJhs0FHcTVCf+7F2mJTgH46U=;
	b=OTC9si2UgiN4Xy74pvdhNXPfTUo5oa5Ab/ryrzqxJB+Ca+D1NUYLOJnrt501b+gjXTb+MM
	WXSNYRPGUriPV1h6FrGJTpkub22E2ZzKNUGNZNCn/9yssHYFVBAHC5/pSr0WcJr3KDqEp4
	ZQTnWx272ySyBRgaZJEVWUc7OqpwHnA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-DBXaVzCgOKin7_KDTum_0g-1; Sat,
 25 Jul 2026 11:19:15 -0400
X-MC-Unique: DBXaVzCgOKin7_KDTum_0g-1
X-Mimecast-MFC-AGG-ID: DBXaVzCgOKin7_KDTum_0g_1784992753
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A6421800587;
	Sat, 25 Jul 2026 15:19:13 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1EFBA1954229;
	Sat, 25 Jul 2026 15:19:08 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 25 Jul 2026 17:19:12 +0200 (CEST)
Date: Sat, 25 Jul 2026 17:19:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 0/1] pipe: only enable the extra wake_up(rd_wait) when
 epoll is actually used
Message-ID: <amTT60nc1QNIyPfL@redhat.com>
References: <amIqfCo25rLtM2U0@redhat.com>
 <amIu5WWgTNkdvqIz@redhat.com>
 <amNvebqiG2fH0W_L@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amNvebqiG2fH0W_L@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/24, Oleg Nesterov wrote:
>
> On 07/23, Oleg Nesterov wrote:
> >
> > OK, sashiko has some concerns
> >
> > 	https://sashiko.dev/#/patchset/amIqmbbZx3NlzUsX%40redhat.com
>
> Let me quote:
>
> 	Does skipping this wakeup for non-epoll consumers break io_uring?
>
> 	Applications polling pipes via io_uring do not attach an eventpoll context,
> 	so pipe->epoll_usage will be false. If a writer writes to an empty pipe,
> 	io_uring receives the wakeup.
>
> 	If the writer then writes a second chunk before the first is drained,
> 	anon_pipe_write() observes was_empty == false and
> 	pipe_get_epoll_usage() == false, skipping the waitqueue wakeup.
>
> 	Could this cause io_uring to miss events and hang permanently, waiting
> 	for a CQE that will never be emitted for the new data?
>
> and I am starting to think sashiko is right (damn as always ;) and this
> patch does affect/break io_uring.
>
> Jens, could you confirm? If yes, we need to update the comments in pipe.c
> (I've attached 1/1 at the end, so that you can see what this patch does)
...
> It seems that IORING_OP_POLL_ADD / IORING_POLL_ADD_MULTI is edge-triggered
> by default! Like EPOLL_CTL_ADD / EPOLLET.

Yes, sashiko is right. With some help from AI I wrote the simple test-case

	#include <unistd.h>
	#include <sys/mman.h>
	#include <sys/epoll.h>
	#include <sys/syscall.h>
	#include <linux/io_uring.h>
	#include <assert.h>

	int main(void)
	{
		struct io_uring_params p = {};
		int fd, pfd[2];

		pipe(pfd);

		fd = syscall(SYS_io_uring_setup, 2, &p);
		assert(fd >= 0);

		void *ring = mmap(0, p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe),
				  PROT_READ | PROT_WRITE, MAP_SHARED, fd, IORING_OFF_SQ_RING);
		assert(ring != MAP_FAILED);
		*(unsigned *)(ring + p.sq_off.array) = 0;
		*(unsigned *)(ring + p.sq_off.tail) = 1;

		struct io_uring_sqe *sqes = mmap(0, p.sq_entries * sizeof(*sqes),
				  PROT_READ | PROT_WRITE, MAP_SHARED, fd, IORING_OFF_SQES);
		assert(sqes != MAP_FAILED);
		sqes[0].opcode = IORING_OP_POLL_ADD;
		sqes[0].fd = pfd[0];
		sqes[0].len = IORING_POLL_ADD_MULTI;
		sqes[0].poll32_events = EPOLLIN;

		syscall(SYS_io_uring_enter, fd, 1, 0, 0, 0, 0);

		unsigned *cq_head = ring + p.cq_off.head;
		unsigned *cq_tail = ring + p.cq_off.tail;
		for (int i = 0; i < 2; ++i) {
			write(pfd[1], "", 1);
			syscall(SYS_io_uring_enter, fd, 0, 0, IORING_ENTER_GETEVENTS, 0, 0);
			assert(*cq_tail == ++*cq_head);
		}

		return 0;
	}

with this patch the 2nd assert(*cq_tail == ++*cq_head) fails.

And just for the record, another one for epoll

	#include <unistd.h>
	#include <sys/epoll.h>
	#include <assert.h>

	int main(void)
	{
		int pfd[2], efd;
		struct epoll_event evt = { .events = EPOLLIN | EPOLLET };

		pipe(pfd);
		efd = epoll_create1(0);
		epoll_ctl(efd, EPOLL_CTL_ADD, pfd[0], &evt);

		for (int i = 0; i < 2; ++i) {
			write(pfd[1], "", 1);
			assert(epoll_wait(efd, &evt, 1, 0) == 1);
		}

		return 0;
	}

I'll try to make V2 later.

> And. io_poll_parse_events() doesn't set EPOLLET if IORING_POLL_ADD_LEVEL, but
> how is it possible to use IORING_POLL_ADD_LEVEL? io_poll_add_prep() only allows
> IORING_POLL_ADD_MULTI in flags? OK, I don't understand this code anyway...

OK, I see: d59bd748db0a9 ("io_uring/poll: disable level triggered poll")

Oleg.

