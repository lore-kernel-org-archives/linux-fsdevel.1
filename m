Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488174;
	b=3EXBNUD+DjndZwn9vZFeLFviUkawt+5t12TaBvfvcDi9WV5wURltdKf6AJLupCgXLvzZ
	 WxGA96wjhW6awItA0tIruhuMiu7dDusQ/7bL5AVibkhNeg81dUT7nxMZvzhRpVd73aSWL
	 X/PK54dvrBGxECOIyjTdAafGF/ujJ+r7VcwYE8LyD/nPwZH2PcAdFikUf9zB638VGzHxp
	 p9/p9IBMcGJ43Y21z1fZ7cG/UurQabVQLt2i4qFnwccwrlOHOXmW94ixko/IhpIzlIrcB
	 eP0+19R5JD2vufQlOzJjGotEiH+yBLB8L01xo3bTZHmbGm08Nw3tCPQ+h78IzRsBvxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488174;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=HIutJ6yACOJKX+uQmsN7/6s8/2mZh9QVoLdPsM7BRLU=;
	b=lbaCLYZFBalePG83IO7JSgndoFke5rxw/XSK+zN0FQblvX2DU2rGcvc6B1Q9ALNfNvD3
	 +dxuHSKxL5nDxfapSTJQ0Tw0MJW6mA3B/afti4F6beyJPJICCLEeAFAc5yhdREFobxgiC
	 pqXEyWFMeLFMLQhg7iAhI7KG42ePcENP/ePkoavJ5AyAttBewk3RWiE8v6eRKgZlPca5x
	 K1B/AiRttb6/ZmcR4f+Z/OmiWd1bmWyLHzB+l6rZOO/OGfwDHCssiMz9RYHP+EKMppgYF
	 9je0DmsufQd24g0eS8fy8iQan/xrvvzU3SDH533eacjHE7yspbulM3mdgCCUov4TWCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gxzUpD8g;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25603606A32E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 12:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25603606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gxzUpD8g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794488173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIutJ6yACOJKX+uQmsN7/6s8/2mZh9QVoLdPsM7BRLU=;
	b=gxzUpD8gCgBgDRAn98ufdm2ic6Uw3F2NdoKxGRlclGTLU0lEBA1uUv3jSs5ZsbKxjuvtZg
	dvxFEppget6V7QqVEjt0MTRU1kCUmlGBapYNs+7pu1SH9QlPEtvMqt4AtT+gRmqO7CbHGW
	hFYzVq2scIKEd3E6uTqRC/aVlsBXptE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-4uDYgcquMemIy5s-3lLvRw-1; Thu,
 12 Nov 2026 07:56:09 -0500
X-MC-Unique: 4uDYgcquMemIy5s-3lLvRw-1
X-Mimecast-MFC-AGG-ID: 4uDYgcquMemIy5s-3lLvRw_1794488168
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC1A2180060B;
	Thu, 12 Nov 2026 12:56:07 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E730641F;
	Thu, 12 Nov 2026 12:56:04 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Thu, 12 Nov 2026 13:56:07 +0100 (CET)
Date: Thu, 12 Nov 2026 13:56:03 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
Message-ID: <avW3Y_ea5v_zR48U@redhat.com>
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This probably needs more discussion... I will write another email.
But so far I think we don't really care.

On 11/11, Mani Tofigh via B4 Relay wrote:
>
> A task blocked in read() on a pipe can sleep while the pipe holds data,
> when an epoll(EPOLLEXCLUSIVE) watcher of the read end was added before
> it.  The watcher's entry on ->rd_wait is exclusive and sits ahead of the
> reader, so a write into an empty pipe wakes only the watcher.  The
> watcher reads without sleeping in anon_pipe_read() and doesn't pass the
> wakeup on.  Since commit f1cebdec9739 ("pipe: only enable the extra
> wake_up(rd_wait) for EPOLLET consumers") the next writes into the
> non-empty pipe don't wake anyone anymore:
>
>   Task E                   Task A                 Task C
>   epoll_wait(ep, -1)
>     /* EPOLLEXCLUSIVE */
>                            read(p[0])
>                                                   write(p[1], "1")
>                                                     /* wakes E only */
>                                                   write(p[1], "2")
>                                                     /* no wakeup */
>   read(p[0], 1 byte)
>   exit()
>                            /* still asleep, "2" is in the pipe */

Yes, in this case f1cebdec9739 ("pipe: only enable the extra wake_up(rd_wait)
for EPOLLET consumers") makes a difference.

However, this trivial test-case

	#include <unistd.h>
	#include <sys/epoll.h>
	#include <sys/wait.h>
	#include <assert.h>
	#include <stdio.h>

	int main(void)
	{
		int pfd[2], efd;
		struct epoll_event evt = { .events = EPOLLIN | EPOLLEXCLUSIVE };
		char c;

		pipe(pfd);
		efd = epoll_create1(0);
		epoll_ctl(efd, EPOLL_CTL_ADD, pfd[0], &evt);

		if (!fork()) {
			epoll_wait(efd, &evt, 1, -1);
			read(pfd[0], &c, 1);
			printf("1st: %c\n", c);
			return 0;
		}

		sleep(1);

		if (!fork()) {
			read(pfd[0], &c, 1);
			printf("2nd: %c\n", c);
			return 0;
		}

		sleep(1);

		write(pfd[1], "12", 2);
		assert(wait(NULL) > 0);
		assert(wait(NULL) > 0);

		return 0;
	}

hangs even with this patch

	+++ b/fs/pipe.c
	@@ -749,6 +749,7 @@ pipe_poll(struct file *filp, poll_table *wait)
		    unlikely(!READ_ONCE(pipe->pseudo_edgetrigger)))
			WRITE_ONCE(pipe->pseudo_edgetrigger, true);
	 
	+WRITE_ONCE(pipe->pseudo_edgetrigger, true);
		/*
		 * Reading pipe state only -- no need for acquiring the semaphore.
		 *

which reverts f1cebdec9739.

The 2nd child sleeps in read(pfd[0]) forever even if the pipe is not empty.
So I am not sure we want to enforce another oddity in pipe_poll/read ...

Oleg.

