Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3931E833
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771134; cv=none; b=pk2RwcrpAt2WNyD52bbGLD5WIC+cgyhWf2z7HrDww27bPub+R7GnLOdrT+LXf23Fh/xuwk/SHuby65HG0eFjtIodR8czEVjKrzkZyWvDGD/ChX869awra3iHK6QHbwr4tfAs8PWkqMDGdTqSeeFjjjf61W+a4WeeoXIekYNZivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771134; c=relaxed/simple;
	bh=pASZZ7B833YGm+asL1SNnKgvxsc1BX7Y3o4xZIlH8xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbnJ2AB2K4N61N+qq0+TW4dsaM4TgfYvV2d+/hA6AfO+y3l8SMfCYAUQNbyZQqpa2+gPuVgsVkbZYjChWiAnnzHSns11hHlAGb7AsagEJ9HarwB4xARhETQDiWYO5CDUHlQRgT8xHFR57zttMDCE4fTul8+vpgqtJHYVN3BNU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Om7pqqSL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Om7pqqSL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781771131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaIdtv/k8YonAekwP3ZkiC9mnAAV7eLn1tWSwgT6cqc=;
	b=Om7pqqSLNSUHxOoTljhzIQb3epsYLC+ZSZZxRAhC/usTPRieeFKjrVFzZs0CPH47EkrM5S
	V3DpzAgdfXoDOIk+bHXsRulwTWs7JOqkCLeZH/gX98PNxkLt0eVEbz7uUxlgsE8qCT8x8f
	YodtLyjRrL1Xl9ctMeVqGRWjTUk4wso=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-wxI8sF_8ORyw6EKqpDzS8Q-1; Thu,
 18 Jun 2026 04:25:27 -0400
X-MC-Unique: wxI8sF_8ORyw6EKqpDzS8Q-1
X-Mimecast-MFC-AGG-ID: wxI8sF_8ORyw6EKqpDzS8Q_1781771126
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 225121800D9C;
	Thu, 18 Jun 2026 08:25:26 +0000 (UTC)
Received: from fedora (unknown [10.44.34.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6F0E21956086;
	Thu, 18 Jun 2026 08:25:23 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 18 Jun 2026 10:25:26 +0200 (CEST)
Date: Thu, 18 Jun 2026 10:25:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v2 14/17] afs: Remove erroneous seq |= 1 in volume lookup
 loop
Message-ID: <ajOrcnnqTp6210YC@redhat.com>
References: <20260618074903.2374756-1-dhowells@redhat.com>
 <20260618074903.2374756-15-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618074903.2374756-15-dhowells@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/18, David Howells wrote:
>
> This is an addendum to the patch to remove the erroneous seq |= 1 in volume
> lookup loop.
>
> Switch to using scoped_seqlock_read() as suggested by Oleg Nesterov[1].

Thanks, but

> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -750,8 +750,6 @@ static inline void afs_vnode_set_cache(struct afs_vnode *vnode,
>  {
>  #ifdef CONFIG_AFS_FSCACHE
>  	vnode->netfs.cache = cookie;
> -	if (cookie)
> -		mapping_set_release_always(vnode->netfs.inode.i_mapping);
>  #endif

This change looks unrelated...

Oleg.

