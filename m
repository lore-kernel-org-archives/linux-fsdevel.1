Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22FD5AAA75
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421409; cv=none; b=sWE4qXAe8+Hug/lEaR2bu74eSPo9jffkcW23E7apBn9onNLhzS4heFeL53iypxwK/BXSY8k17dPPh4c0weKuhHI19EmLHWdLHmQP/SLqdb6wBuafw4iKPmROXOfVJW8dklhCmlj+e+FVN4f6Cv1XA6nOg2G6ga7uQ0p3YQPCpRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421409; c=relaxed/simple;
	bh=cFugHvRsW5fezHR1c43S+/hPIFOoSYn2bj7w/7E492I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLDjKO9P78YEq0EIUg0NuDk9QxOppSlTuAJq8qQ3bOHvE0gjBpUCgYAfl/TaKec+Cychb8f5LVOCzhXT144QmktJc5gm6f1EZ/ssdta7dGB5T0JErHdR/cHdbq19ExivHHhg2O0g1iCin26pM0SZu5mOrMkk4m+PHbldnyxY7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZuzpiSg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZuzpiSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792421406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E40CoioShs+1rbppNo7iCsptx7U564WAd9P7W0mSqC0=;
	b=AZuzpiSgcsGnb9+YZusdqZ9zKIgVsJrHMvbQ+j22y2z5MRJQmmL63K7Rh2TjUeC0pGo1UX
	Tf7n0Z2HT3hsNC9a5+cUjpZYRDEYf8ytqVKKrKNc1MumOdvSbI8RD0/yw3myE5YDOQ2SED
	CEx3u63/N7e4CeblskTTQul57xGW/ao=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-l1yfSCO-OUGdlKJe0-0bRw-1; Mon,
 19 Oct 2026 14:50:03 +0000
X-MC-Unique: l1yfSCO-OUGdlKJe0-0bRw-1
X-Mimecast-MFC-AGG-ID: l1yfSCO-OUGdlKJe0-0bRw_1792421401
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 357B2180067E;
	Mon, 19 Oct 2026 14:50:00 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8C86630000E7;
	Mon, 19 Oct 2026 14:49:56 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 19 Oct 2026 16:49:59 +0200 (CEST)
Date: Mon, 19 Oct 2026 16:49:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Joel Granados <joel.granados@kernel.org>,
	Allison Henderson <achender@kernel.org>
Cc: kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com, rds-devel@oss.oracle.com
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
Message-ID: <atYuE1xnVYe0BDG4@redhat.com>
References: <202610190310.9737b2e3-lkp@intel.com>
 <atYB0bm9eEXp8A2g@redhat.com>
 <atYW0K3t57puHeLW@hobbes>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atYW0K3t57puHeLW@hobbes>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/19, Joel Granados wrote:
>
> On Mon, Oct 19, 2026 at 01:41:05PM +0200, Oleg Nesterov wrote:
> > On 10/19, kernel test robot wrote:
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map" on:
> > >
> > > commit: 8d75c338f0bcecaa6c9af67f86c176b67b6acf3e ("sysctl: remove CONFIG_PROC_SYSCTL, it just mirrors CONFIG_SYSCTL") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > I don't think that commit could cause such a problem. Please re-check.
> >
> > Oleg.
>
> That commit might not be the one that introduces the UAF, but it might
> be the one that exposes it?
>
> You have CONFIG_SYSCTL=n & CONFIG_RDS=y & CONFIG_RDS_RDMA=y.
> Therefore rds_sysctl_init() returns -ENOMEM  and rds_ib_sysctl_init
> returns -ENOMEM.
>
> If rds_ib_sysctl_init is called after a failed rds_sysctl_init, then
> rds_ib_sysctl_init would call a flush_workqueue on a rds_wq that has
> already been freed by the failed rds_sysctl_init. Right?
>
> Please let me know if I missed anything.

I think you are right...

rds_init() does

	rds_threads_init()
		rds_wq = create_singlethread_workqueue("krdsd");

	rds_sysctl_init()
		fails due to CONFIG_SYSCTL=n

	out_threads:
		destroy_workqueue(rds_wq);

After that any access to rds_wq is wrong.

If rds_rdma_init() runs after that, rds_ib_init() will call
rds_ib_unregister_client() -> flush_workqueue(rds_wq).

And this will equally happen before the blamed commit 8d75c338f0bc,
just you need CONFIG_PROC_SYSCTL=n instead of CONFIG_SYSCTL=n.


But. rds_init() can also fail even if CONFIG_SYSCTL=y, after
rds_sysctl_init(), so to me this looks like a bug in net/rds/.


In any case, I guess net/rds/ init paths should not fail if
CONFIG_SYSCTL=n ?

Oleg.

