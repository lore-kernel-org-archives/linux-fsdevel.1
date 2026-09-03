Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84B372B27
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471839; cv=none; b=XJXl4blVnLgUixAIOjDfvwRbBZae7G/2qTWl90cv6c0sPvP+S6+O+vhknDTnwn+LXJsfG1f6v99P+/aliwhRAe/4T7yxdG4K/LVyWnh5HjfxIdXYEaXA/8yrTHZcWVPUbKXps6o264kWf5PzNDsvNcUfCtN5j6z+WIVEqOxLDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471839; c=relaxed/simple;
	bh=F3jOHh+snqMsGLak2PpEkbeCpwY6HsbPB4pwFgYJvVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh9rcjVCeHn3cWbqDAxBnZ5n9pGpsW/YXvEognwcM5iNf262+to376/BoVqvDeE9LkLF4Nn0+zc/aNKlyFicdYraMv+GdOFufgux0ux/DVIKQVVC9ooWsy0xkF+XeguZTHLn/YJauKvd1w24tyac++20IlzcP5O7oqCNvN4C5Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bt+7O/4j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt+7O/4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788471837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3jOHh+snqMsGLak2PpEkbeCpwY6HsbPB4pwFgYJvVo=;
	b=bt+7O/4jZ6+kYLJIsO8zdxlrlFo0GPOnXyzt73mZ1Pft5x2oJR1P4+iDG+A9p7aCC1lm9c
	AlbthHB3hf1/jajqId7Wev/7OVGOxxd5yXMvtLLoomwqsWYsKDJcQBywktPH+FH1Bz3o5x
	62HvEGeCvSH+eT3kXWIRLBa9fH+WgiM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-E472_1DMN2K9UdbHXXDiBQ-1; Thu,
 03 Sep 2026 17:43:54 -0400
X-MC-Unique: E472_1DMN2K9UdbHXXDiBQ-1
X-Mimecast-MFC-AGG-ID: E472_1DMN2K9UdbHXXDiBQ_1788471833
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F074195605E;
	Thu,  3 Sep 2026 21:43:52 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 867C31800669;
	Thu,  3 Sep 2026 21:43:50 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  3 Sep 2026 23:43:52 +0200 (CEST)
Date: Thu, 3 Sep 2026 23:43:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] super: remember whether freeze holds writer rwsems
Message-ID: <apnqFe3aZdSM6lsy@redhat.com>
References: <20260903060855.4610-1-kmehltretter@gmail.com>
 <aplro1ObQ5YNZT6R@redhat.com>
 <apnKz_3xD-zbw0dM@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apnKz_3xD-zbw0dM@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/03, Karl Mehltretter wrote:
>
> On Thu, Sep 03, 2026 at 02:44:19PM +0100, Oleg Nesterov wrote:
> > > Tested with a test-only KUnit case in x86_64 QEMU on linux-next
> > > 32b6ef9a5d0e (next-20260902). It freezes a writable ramfs, sets SB_RDONLY,
> > > thaws it, and calls sb_start_write_trylock(). The call fails without this
> > > patch and succeeds with it.
> >
> > But I am curious, how exactly did you test this?
> >
> > ramfs_ops doesn't have ->freeze_fs or ->freeze_super, so
> > ioctl_fsfreeze() should fail?
> >
> > And how it is possible to remount with -ro, reconfigure_super() should
> > see sb->s_writers.frozen != SB_UNFROZEN ?
> >
> Hi Oleg,
>
> Thank you for the review!
>
> The original test called freeze_super() directly, changed SB_RDONLY,
> and called thaw_super().

Thanks, but this doesn't answer my questions...

How exactly this original test "called freeze_super() directly" ?
Could you show this test-case ?

IOW, how can we actually hit the problems described in the changelog?

Let me repeat, you can safely ignore me, I don't understand fs/,
I am just curious.

Oleg.

