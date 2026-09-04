Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224E41379F
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512743; cv=none; b=JxU3h9b/31PK6HTpjWmitIHk242WwVhs5yLXftaO2UhnB8PvL134DVsDta+G24bgsUiqltGpyU0wBk8fbEVVsxXuyivE42phBhzGi1jcjB5GYuK+5vFASJ837df5Y82iqfCuuZ4nQo2jeZKZk2QZ9vI7ChUBVJ1X+K3VanL0hEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512743; c=relaxed/simple;
	bh=M6w7B48YIF+aPWOx3xihk4xBVrqMn/9Q/N/IqvBUIpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZZfaDu5W1tph18eW1anps42ijh/DjvlZ42O8tKjHjRQWvX6HqkyQgFL6oQYUgjvInchKXKpvZ2xcmjZN/ZB98UU63LHOUZWFQ1GHD09ScCCgdP4DBucwXoevNSNEJJVj8fl52gbZnaLqrCcCGIAH6a3z4oUSLRpewJXO9KTwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiUxEDXK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiUxEDXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788512740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4u1C7OXtz+q7Du9mudTGLU9pxTJSa31ihUy6u+Fg95k=;
	b=HiUxEDXK8ziFwHAFuqWhjvAX38iVgNJat3peR+VARKWc9V+lo/ISjhyDUbdJTYqdAHEnMP
	SKcQRgFb1fh1jUBtzn+JbngBa8LG11LFf3JjS4r11UYSoEUM+l04ju/tzj4ftY1wdLPC+s
	x7egMP8R6SrA/fcAg6XIP7B/rXIiyYU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-1Qwbf8GEMzKcrmrW0S84tQ-1; Fri,
 04 Sep 2026 05:05:37 -0400
X-MC-Unique: 1Qwbf8GEMzKcrmrW0S84tQ-1
X-Mimecast-MFC-AGG-ID: 1Qwbf8GEMzKcrmrW0S84tQ_1788512734
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 829841829E26;
	Fri,  4 Sep 2026 09:05:33 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C1B591800598;
	Fri,  4 Sep 2026 09:05:27 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  4 Sep 2026 11:05:33 +0200 (CEST)
Date: Fri, 4 Sep 2026 11:05:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	"David Hildenbrand (arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Ye Liu <liuye@kylinos.cn>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/8] fs: convert process/thread iterators to
 for_each_*_rcu
Message-ID: <apqJ1t4L2KkIDRlP@redhat.com>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-7-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904083001.553587-7-ye.liu@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/04, Ye Liu wrote:
>
> @@ -1160,8 +1160,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  	if (mm) {
>  		struct task_struct *p;
>
> -		rcu_read_lock();
> -		for_each_process(p) {
> +		for_each_process_rcu(p) {
>  			if (same_thread_group(task, p))
>  				continue;

Hmm... I am not aware of for_each_process_rcu(), but looking at this
change I guess it includes something like scope_guard(rcu) ?

Perhaps makes sense, but the naming looks sligthly confusing to me.
I mean, to for_each_process_rcu() looks like (say) list_for_each_entry_rcu()
where _rcu has another meaning...

Oleg.

