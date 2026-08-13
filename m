Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD703F23D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643889; cv=none; b=DqZxPY/L6l2uzeF0s2LwJ4ZqBbHC7ib6UzihpsCeg+G2fvLWvjSfIr0R1WRGFlp6Gd1iHejSc6YScZbvO57mmiTAENUov+YeK96nEMIL53kBEYX4Y9M3xMVlgGeCGw/H1s0ebeuhTl3yW/ZqENlfMuZtvWwjgSiKOaTinDxbsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643889; c=relaxed/simple;
	bh=TyKtUql8/UMqDIvuNXPwCFvRWEM9LL83DrHVkXw9tQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpOQPWsKz5IGfkmx4mlLm3F5TXpz7Uy0G9bEyVBXSuiwFOZin+nUcGlQZtF41WkHK3mUPOkQl5wsi/YvLfgHjE5no15h0kjW5+XQmtq7itRob2xyKNE4w60hoxKMTeHiBsdNVMfsPVubIp8ZXqD0RzuJzVB2M4+MqiPmXhmMBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVGSep/D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVGSep/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786643876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OukkhkVorBxthESNUlOuVMe4JLx+OvknbdAjxQDfoCo=;
	b=QVGSep/DCWKtAO/DqHeHCmaqh4aWg1GTyftKx6yRDuiDgvIzdshOoSXM2xACH1UIe4w9KO
	IuJSt/ZV5XmyH+r4lPRKx2d176cqwG6qqlZ9l2PX0Clz28O+0nzJU7H5yefEkHrawnG4jW
	FHVbi7luNszyZWvgh7xpjrKstvnA58A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-LcEgHWJwMwyEu-ZNJlzpMQ-1; Thu,
 13 Aug 2026 13:57:43 -0400
X-MC-Unique: LcEgHWJwMwyEu-ZNJlzpMQ-1
X-Mimecast-MFC-AGG-ID: LcEgHWJwMwyEu-ZNJlzpMQ_1786643862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8372E195609D;
	Thu, 13 Aug 2026 17:57:41 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.74.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C939180049F;
	Thu, 13 Aug 2026 17:57:38 +0000 (UTC)
Date: Thu, 13 Aug 2026 13:57:36 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>,
	Roman Dolgikh <rmd4work@mail.ru>
Subject: Re: [PATCH v2] audit: free proctitle in context so it can be re-set
 by fork on exec_binprm
Message-ID: <an4FkMk27Wxo2PuS@madcap2.tricolour.ca>
References: <c8581fcfb66e5cfb2e6e9b0e95f9b356b2245b7b.1785261601.git.rgb@redhat.com>
 <CAABTaaAR4O188N6wazEuqMMUmMyWFxr2oX0WhyS7Hw_CauuC0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABTaaAR4O188N6wazEuqMMUmMyWFxr2oX0WhyS7Hw_CauuC0Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 2026-08-07 09:25, Ricardo Robaina wrote:
> On Thu, Aug 6, 2026 at 6:17 PM Richard Guy Briggs <rgb@redhat.com> wrote:
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
> > Link: https://github.com/linux-audit/audit-kernel/issues/170
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > Changelog:
> > v2: simplified to call single use directly before need in audit_bimprm
> > ---
> >  kernel/auditsc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 6610e667c728..c12b5dfcb279 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2601,6 +2601,8 @@ void __audit_bprm(struct linux_binprm *bprm)
> >  {
> >         struct audit_context *context = audit_context();
> >
> > +       /* clear proctitle in audit context to allow replacement */
> > +       audit_proctitle_free(audit_context());
> 
> Since we already got the context right above, it would probably be
> better to use the context var instead to avoid calling audit_context()
> again.

Yup, right you are.  Silly oversight.

> Otherwise looks good to me.
> 
> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> 
> >         context->type = AUDIT_EXECVE;
> >         context->execve.argc = bprm->argc;
> >  }
> > --
> > 2.43.5
> 
> -Ricardo

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

