Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923C3E1729
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020805; cv=none; b=q6txqGNs0PGKcWA/YdPSmjN2UW3dji56AuWWdh4q7t8Dpeqkoj1Z7BxgQqmc428ZSaiZgM4fJtI/oyUkUmIRimbLsJjL6CuPkyhYihlCrshWJw/xs8l/na0O8NRrZPbKgNiNz8V/AT5kx5I8Odvi0BBCeuYk3EFlDupA5WH9JHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020805; c=relaxed/simple;
	bh=oibKvVVhPVKq6HaFrc3MJTlwNCEu7DEW4mS8DM+sD3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/CfMdSI99Ml+V3yfv2FplQt3+l0Xt5J8VGenhdHxrYn23XAE5GFrHIBZC0ZFYne2OjyvCmH/S1D2KpoA45Js8x0czRUbYNzS827yPyX1m+17WHRD8LdaZ7T948X67eWKGrKZDmPD8LcticRiQiejbguQ2NloUYwOXFrR2VOusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3eb7FeQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3eb7FeQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790020798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kSjpsnGB6PkMlYt3gFNBn+l9/iXfVXQ9UfiCD3HwhPU=;
	b=U3eb7FeQOv19GKccW6NiSB9be3dZo2j86Iqd4fjUirtjP3Lsv/yvUT4eEy9aMYD+HCrolJ
	HQPaFMg6Av67EZJLnQwDngSpG3s2vzDp4frNBhCKfTvL9LtqRO7pUC2Ovl4C+oJouw+BDz
	ITS5OSaf0+g1FBq0Ooreys8ifdgSciI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-Cl5toB87Mx-6IDyPy9kzbg-1; Mon,
 21 Sep 2026 15:59:56 -0400
X-MC-Unique: Cl5toB87Mx-6IDyPy9kzbg-1
X-Mimecast-MFC-AGG-ID: Cl5toB87Mx-6IDyPy9kzbg_1790020795
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41E6518558B4;
	Mon, 21 Sep 2026 19:59:55 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D76DF1800361;
	Mon, 21 Sep 2026 19:59:38 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Sep 2026 21:59:54 +0200 (CEST)
Date: Mon, 21 Sep 2026 21:59:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>, SJ Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>, Lorenzo Stoakes <ljs@kernel.org>,
	peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com,
	rostedt@goodmis.org, jpoimboe@kernel.org, mic@digikod.net,
	tglx@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	rafael@kernel.org, gnoack3000@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, rientjes@google.com,
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	pavel@kernel.org, lance.yang@linux.dev, mhiramat@kernel.org,
	pmladek@suse.com, longman@redhat.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com,
	babu.moger@amd.com
Subject: Re: [PATCH v4 03/15] mm/ksm: convert process iterator to
 for_each_process_rculock
Message-ID: <arGMqePU2L4q33o_@redhat.com>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-4-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921092101.89285-4-ye.liu@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 09/21, Ye Liu wrote:
>
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3280,8 +3280,7 @@ void collect_procs_ksm(const struct folio *folio, const struct page *page,
>  		struct anon_vma *av = rmap_item->anon_vma;
>  
>  		anon_vma_lock_read(av);
> -		rcu_read_lock();
> -		for_each_process(tsk) {
> +		for_each_process_rculock(tsk) {
>  			struct anon_vma_chain *vmac;
>  			const unsigned long addr = rmap_item->address & PAGE_MASK;
>  			const unsigned long index = rmap_item->linear_page_index;
> @@ -3298,7 +3297,6 @@ void collect_procs_ksm(const struct folio *folio, const struct page *page,
>  				}
>  			}
>  		}
> -		rcu_read_unlock();

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

