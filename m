Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792568173;
	b=rhJG0bMiZN8ENEhQBAHvqm8fu+X9VVYZizg5aLl+HI5tIoWFo8q98B5gdlqUTcxpxWn8
	 Grd7XIvyQMqdgpvJPDrSu6KzUwIc+eSZpQJbt3iWVuAQFZXlJNG0TQY69+4airDdkDcZB
	 NAYoUL3vmA+RgZzZgpbS5vQY4rTIIujPbE2cKGOhDMNnNuoEv74EMeb0WzyRi71rmqHs/
	 oO9l2fqgBnSbwyFJ8p5+xObJQLHxk88tLq5BNRavSPXoluKMp8vTWeBtVOrorDc32f4vT
	 avn/HN13auERcUGdA2E0vOkGG8xUxRhfF2Cs773RNeo4MfnxqjrHS7/4hWdw0TOVJ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568173;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=tSH1r9M+8L4bHYKhri3oj4xzwG7x+h1dMG66BLEyGEI=;
	b=h8Im9vqbJNAQJvxLEbwWrdsW2D8hyGUNvxKZrIE2cGbirx53fbVzU7FMNr4tCBIwSm6D
	 iv0UX7vaI2KCLR97ngU0fN5SwUepGaeKlmJlUZvzgWxuMDFyESSp8rqowe7EWuXsgNZRw
	 A6hvuLnVIjFmmtOOGFDWiGT1vYg6wJVaKNyMwb2M0Ry3gGPOWfRcygexJg7VCIDMh5b+Q
	 hbIeynna1CXGRtBWIb8WtVU/CE7VdHfHSDrFUpAc61KtonSQodlMQGnu11Y7/n7Xmmo0/
	 tHLnP4Vc5uFG+4XKNEEcGssKySIaNrvzejilWI7x1KyZy9ksRx09I+cFckW2xIkktjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=coybd9x0;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E4606A322
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 07:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 397E4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=coybd9x0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792568172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tSH1r9M+8L4bHYKhri3oj4xzwG7x+h1dMG66BLEyGEI=;
	b=coybd9x0a29jk7p2ymo3x474P1JUeWwIGwpcBNLHArYvNf9oIaiQ2/4WRPqHXUUBKPvOCY
	XqANwlr2CxNXl6cJCCYnCDprIIvH6uhG6aJt+rdteWxV2jr0lIDXfBnH4FLer/YtVkhcUh
	mc9/bNw7axWYArg5S5nNv3rPFRm4Vys=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-JzWEAI2jOYWe2galHTihCg-1; Wed,
 21 Oct 2026 07:36:08 +0000
X-MC-Unique: JzWEAI2jOYWe2galHTihCg-1
X-Mimecast-MFC-AGG-ID: JzWEAI2jOYWe2galHTihCg_1792568166
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D131195604D;
	Wed, 21 Oct 2026 07:36:06 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 66E7146C;
	Wed, 21 Oct 2026 07:36:04 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 21 Oct 2026 09:36:06 +0200 (CEST)
Date: Wed, 21 Oct 2026 09:36:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: fujo <hooyan2024@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] selftests/pidfd: wait for POLLHUP before reading exit
 info
Message-ID: <athrY3NE41WWDj8k@redhat.com>
References: <20261017054356.7874-1-hooyan2024@gmail.com>
 <179234213014.649.6368924662349703640@gmail.com>
 <atc59R5-oBnyOIb8@redhat.com>
 <179252551833.59967.12617794775210688694@gmail.com>
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
In-Reply-To: <179252551833.59967.12617794775210688694@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 10/20, fujo wrote:
>
> The CLONE_AUTOREAP tests poll for POLLIN and then immediately call
> PIDFD_GET_INFO with PIDFD_INFO_EXIT.  PIDFD_INFO_EXIT is only published
> from release_task() -> pidfs_exit(), which runs after the pidfd already
> reported POLLIN for the exited task.  A poller woken by
> do_notify_pidfd() can therefore read a mask without PIDFD_INFO_EXIT;
> under KASAN the autoreap_multithreaded case fails this way.
>
> POLLHUP is returned once the task linkage has been removed from
> struct pid, which happens after pidfs_exit() has published the exit
> information.  Wait for POLLHUP and check it in revents.
>
> The zero-timeout liveness check in autokill_pidfd_open_no_effect keeps
> POLLIN; it verifies that the child has not exited yet.
>
> With this change all tests pass ten consecutive runs on an unpatched
> kernel.
>
> Signed-off-by: fujo <hooyan2024@gmail.com>
> ---
>  .../selftests/pidfd/pidfd_autoreap_test.c     | 34 +++++++++----------
>  1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

