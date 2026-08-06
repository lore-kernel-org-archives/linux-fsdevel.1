Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45973D5246
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050971; cv=none; b=HVT+fDUTtVUa/09LXowxT46rMtXFQEyG8w5i8Wb5aSgDIlfZagvS6pfNi8p5ugl3gCEBOjcswosF1p78fb7hJ5X0P4ABKifnXNcgiExgNF2GCh02aHDPZCFTj9srnuAvpBiNi3HoLT7Vg4faa0ZIip0TM1Z+0J8c5i9KKQMDy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050971; c=relaxed/simple;
	bh=yGuPc3HrauGmPYvoc4Zf1wOe6fbiftoBvcn8z2WmbwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR4MdfHIt9i6NB/WPsss5sEIqxotnrpDOHa4DyzEP0TX+iR8zXGJ8Aps8DcWwr51JMvmn1MLCR90XuB2fdteVU3rBGoZmaypKMjNXEGutpiMuqTth3zfWa0xVegW33R2NtIoN2mlBTQMTRBOZAs0GEolfjS3xbcbYmsF5NzoTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQkpXHTj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQkpXHTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786050968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=frxjNkLAf6DWcpkQzjV2Pst7/uwmFvKc5vfikPVJiWI=;
	b=gQkpXHTjRX/XQZ+TpSvO42T5X+z/JKrzPHJXnYgEmHK7BbsG1ZDYfFoul/jL/HFJdjgXAM
	vUBx8PVNpEB55uFktFzZkUpykRPQmcNLbRDMU8qIt6mWB6H3mGZu7l7cx6PWB5+udVwi1f
	I5gSjuNe27mAo8QC0YzP6y0nbcQOdlw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-Y_98Q7OjPricaO_9Q0HE9Q-1; Thu,
 06 Aug 2026 17:16:05 -0400
X-MC-Unique: Y_98Q7OjPricaO_9Q0HE9Q-1
X-Mimecast-MFC-AGG-ID: Y_98Q7OjPricaO_9Q0HE9Q_1786050964
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C96319560A6;
	Thu,  6 Aug 2026 21:16:03 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.74.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95BC91800347;
	Thu,  6 Aug 2026 21:16:01 +0000 (UTC)
Date: Thu, 6 Aug 2026 17:15:59 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH v1] audit: free proctitle in context so it can be set by
 fork
Message-ID: <anT5jwCYC2TfZcXs@madcap2.tricolour.ca>
References: <d67349e701acb3125d733f833e6ef2e47c91daae.1785101356.git.rgb@redhat.com>
 <2f53e3c8ee57824f1c741f76021eb2ce@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f53e3c8ee57824f1c741f76021eb2ce@paul-moore.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 2026-07-28 12:16, Paul Moore wrote:
> On Jul 26, 2026 Richard Guy Briggs <rgb@redhat.com> wrote:
> > Original title: fixes clean proctitle in audit context on exec call
> 
> Please don't add stuff like that to the description, it's not
> particularly helpful by itself.  If you want to link this patch to
> something outside of the git log, use the 'Link:' tag.
> 
> > Between the actual process startup (fork systemd) and the executable file
> > replacement (exec), systemd sets a temporary file name (executable file
> > name in parentheses). If an auditable system call occurs at this point,
> > the audit context will latch the temporary process name into the cache.
> > This name will not change again. The patch clears proctitle into the
> > audit cache when the exec call is made, allowing the new process name to
> > be latched.
> > 
> > Suggested by Roman Dolgikh https://github.com/rmd4ctf 2025-06-11
> 
> Considering that Roman lists an email on his public GH profile, it
> would be better to use a traditional "Suggested-by:" tag, for example:
> 
> Suggested-by: Roman Dolgikh <rmd4work@mail.ru>
> 
> > Link: https://github.com/linux-audit/audit-kernel/issues/170.
> 
> No trailing period please.

Ok, updated description on all counts.

> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/exec.c             | 2 ++
> >  include/linux/audit.h | 9 +++++++++
> >  kernel/auditsc.c      | 4 ++--
> >  3 files changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/exec.c b/fs/exec.c
> > index b92fe7db176c..bd51489dec23 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1744,6 +1744,8 @@ static int exec_binprm(struct linux_binprm *bprm)
> >  			fput(exec);
> >  	}
> >  
> > +	/* clear proctitle in audit context to allow replacement */
> > +	audit_proctitle_free(audit_context());
> >  	audit_bprm(bprm);
> 
> Since this is the only place where audit_bprm() is called, is there
> any reason why you simply didn't just move the free into __audit_bprm()?
> 
> Doing so should shrink this patch considerably and would keep the audit
> overhead to just a single !audit_dummy_context() check as it is now.

Yes, that is fair at this point.

> --
> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

