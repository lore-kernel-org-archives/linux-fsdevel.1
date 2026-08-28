Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9745223708
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881998; cv=none; b=ehYNByFAjc5mJ1/dY6R0o8x92dOhsXWhS6Js5xZJP9asW/WuOMJKsF3M7Owmw6s/1z1QDF9cmesMq6bTEf1og4IGPb33DEFLtUGU78CROYxqtoRsmLKw/O0mYrj+HQXg3fPaenToaDNQ2n2dm6pXiZpEX0lzzEW26h+HVzJ4zWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881998; c=relaxed/simple;
	bh=a879juwz7YnXRSU0aj4H9oqy8QG+UQ6p/1llyGoW7h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0jmR2e285UEmYhqoa/HZRp+yeAeXKEHexZchUgWL7tJpI/05A/rCTVW84YUYfVtSjEqg//An24SYqSxMDlmZY7ow0xP2bguXxYoXviDLaBPp3mOxKw3B+wO+2uS5CrpluQkj4X/N4kGNfR3UanVn8hRm7ZStsbLw71NDcP9q2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVVx8yuW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVVx8yuW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787881994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVa9ltN/AYxfIIR3vFfpODM3T6RUi+J6FBmrLKMnXUo=;
	b=WVVx8yuWYNA/RpazYoy0OlBrJeywhsXR9UBA42YDnaIEGPsIIHvDtOW5AhL0x/3WrWW8C0
	HOY2SVWsh+LNmR3v2CbF6Y9rtD/g7LpEgyfpWDO32osxk9pEV8vgqLudznNqDoTx22vYjl
	lS/dQrz3etbbNmRRbZByA43kckibaYs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-jo8oXn_8Ne6Y4KKQywx0iw-1; Thu,
 27 Aug 2026 21:53:09 -0400
X-MC-Unique: jo8oXn_8Ne6Y4KKQywx0iw-1
X-Mimecast-MFC-AGG-ID: jo8oXn_8Ne6Y4KKQywx0iw_1787881988
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6056219539AE;
	Fri, 28 Aug 2026 01:53:07 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.76.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4CB5180059E;
	Fri, 28 Aug 2026 01:53:04 +0000 (UTC)
Date: Thu, 27 Aug 2026 21:53:02 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>,
	Roman Dolgikh <rmd4work@mail.ru>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v3] audit: free proctitle in context so it can be re-set
 by  fork on exec_binprm
Message-ID: <apDp/lou9KwOz7M/@madcap2.tricolour.ca>
References: <ef5bf18a4b3805ec0fe5fb638963ccbdfc01d6fe.1787077711.git.rgb@redhat.com>
 <65425b98ae226a9d19f89bd66a1defbe@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65425b98ae226a9d19f89bd66a1defbe@paul-moore.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 2026-08-24 18:07, Paul Moore wrote:
> On Aug 18, 2026 Richard Guy Briggs <rgb@redhat.com> wrote:
> > 
> > Between the actual process startup (fork systemd) and the executable file
> > replacement (exec), systemd sets a temporary file name (executable file
> > name in parentheses). If an auditable system call occurs at this point,
> > the audit context will latch the temporary process name into the cache.
> > This name will not change again. The patch clears proctitle into the
> > audit cache when the exec call is made, allowing the new process name to
> > be latched.
> > 
> > Suggested-by: Roman Dolgikh <rmd4work@mail.ru>
> > Link: https://github.com/user-attachments/files/20751461/fix_audit_proctitle.txt
> 
> I did drop the link above from the commit as it is contained within the
> link below.
> 
> > Link: https://github.com/linux-audit/audit-kernel/issues/170
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> > Reviewed-by: Bradley Morgan <include@grrlz.net>
> > ---
> > Changelog:
> > v3: use previously assigned context
> > v2: simplified to call single use directly before need in audit_bimprm
> > ---
> >  kernel/auditsc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Merged into audit/dev-staging since we're currently in the middle of the
> merge window, this will got to audit/dev once the window closes.

Thank you!

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

