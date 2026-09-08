Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE6592219
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887546; cv=none; b=qO9+yq3nTwsm9o4lq6diLD7sCGCVHnIsn9wwsW7z8Ytbwez/FZO5gYmM7zsMTJEeniFPa94b9FYZnP5d63wiimt3KSNMXdX/5t2DqPG0Yliogav9Z9YCY6efhy1htZmdqzMwhMqAvwfgyPPFedTmRMU8d7wkrwEFmx0W/1d27uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887546; c=relaxed/simple;
	bh=bFfiyDhMTYsXIaRarWFmIgSETkJcz5MnYRCF8sjGN0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXOg4yOgbnrJkpMjtm942moK8FqenW0tVTb3VWfvd+iH4p9BSvcA3RgtLNa9qBEwwztD08DV5twUws6kE8nuoBZRLnt4PxbX96H3IKKXqAKOVnhSGB3abnZ1osVWI5IHBPyVOskq8aOHJuVqBy8dUrVlBWs7L3igouKQoF0G0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eEzfRl7T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEzfRl7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788887542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cr9AELuw5H9idpdwLdrYmWGJ6ZfMYkalViYQFkg2pyc=;
	b=eEzfRl7TzeM4H6Mfq/0l/6yBghk3E0s8y5ZD2RAcdSkFdcJFrrvmVSJKEGGryQSkssdKrg
	szDpv21NIoHj+51CbLJUjKme75Qy2rUwixhKGDEC/s33GVrQOrby3etXP/+6ts+WaqOhyg
	UjAkhyOMNsx+AiomKW+DulZd3/UQo9s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-7ZKgDR04MVW0vhCxiJOlZQ-1; Tue,
 08 Sep 2026 13:12:16 -0400
X-MC-Unique: 7ZKgDR04MVW0vhCxiJOlZQ-1
X-Mimecast-MFC-AGG-ID: 7ZKgDR04MVW0vhCxiJOlZQ_1788887534
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 813B6184B382;
	Tue,  8 Sep 2026 17:12:13 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9081930001A2;
	Tue,  8 Sep 2026 17:12:08 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  8 Sep 2026 19:12:13 +0200 (CEST)
Date: Tue, 8 Sep 2026 19:12:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Ye Liu <ye.liu@linux.dev>, Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	"David Hildenbrand (arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Ye Liu <liuye@kylinos.cn>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/8] fs: convert process/thread iterators to
 for_each_*_rcu
Message-ID: <aqBB5_X-Z5C7ORWK@redhat.com>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-7-ye.liu@linux.dev>
 <662ade9d-d662-4f6f-869f-08c41da53170@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662ade9d-d662-4f6f-869f-08c41da53170@p183>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/08, Alexey Dobriyan wrote:
>
> On Fri, Sep 04, 2026 at 04:29:58PM +0800, Ye Liu wrote:
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -1160,8 +1160,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> >  	if (mm) {
> >  		struct task_struct *p;
> >
> > -		rcu_read_lock();
> > -		for_each_process(p) {
> > +		for_each_process_rcu(p) {
> >  			if (same_thread_group(task, p))
> >  				continue;
> >
> > @@ -1177,7 +1176,6 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> >  			}
> >  			task_unlock(p);
> >  		}
> > -		rcu_read_unlock();
> >  		mmdrop(mm);
> >  	}
> >  err_unlock:
>
> What's going on here?
> Now it's RCU unlock after mmdrop().

Confused... Why do you think so?

I think mmdrop() is called after rcu_read_unlock(), with or without this change.

No?

Oleg.

