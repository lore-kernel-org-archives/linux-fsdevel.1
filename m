Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D53EBF3D
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783960; cv=none; b=cSMq7SHz61oZlp+GmSzLprzJSgy4bPjZZeK+9ZZ0lZ3E4/4pVcFCruKQt1liR4QHpd2U5B0dInMP8qZBx9aOcauzhq4uefzefwY8qh7ukUaA4YotJDhAOUKCT76M2PN3fmwAX2tsL8cJqRlYU0bpbMiFrlLTodJzAMtugduefXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783960; c=relaxed/simple;
	bh=PHOr0zD7WhsNzatxbc5t/f6TGNvfY+isPEWoU38PfOs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=goxrbKsveA6qjA961pgwvaxAbtd/gvTMtmZUGGFumltHoKl2M9mu3GRMisDClXd1wa9T0m0t/ki7yw9ljT0fNYrorArNyTlYNJIx3xpTVo+yGHs+pvdZy7qHE8nzvKa3jmvaLzDEYIxccPUZ4zpScfL+9JNyKglyZWxL4wkZlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CuzeT0qw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuzeT0qw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781783958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5UUoPgH50Dw2EtzaO6boztwLnYh/UrsymulXp92vCU=;
	b=CuzeT0qwR3vGcXEaBvhKESByqG2Z7aGvvd2l6Cg/Ed+y6DA+jmyXxM/gQqj0r3HefVerfW
	Xsr4DadmS/BFs1R6RDblKZeU3Ss8xnwgEPjG2RKmf0/FzD7dCd2ODEKi3wregVXcfgEbfw
	pKu3wS83ltpg/K4wBc0zyLNxlTi8ppE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-8OkU9jZOM7y3tKqDczbNwg-1; Thu,
 18 Jun 2026 07:59:13 -0400
X-MC-Unique: 8OkU9jZOM7y3tKqDczbNwg-1
X-Mimecast-MFC-AGG-ID: 8OkU9jZOM7y3tKqDczbNwg_1781783952
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9EC7195604D;
	Thu, 18 Jun 2026 11:59:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.50.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 864611956087;
	Thu, 18 Jun 2026 11:59:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ajOrcnnqTp6210YC@redhat.com>
References: <ajOrcnnqTp6210YC@redhat.com> <20260618074903.2374756-1-dhowells@redhat.com> <20260618074903.2374756-15-dhowells@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v2 14/17] afs: Remove erroneous seq |= 1 in volume lookup loop
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2418120.1781783947.1@warthog.procyon.org.uk>
Date: Thu, 18 Jun 2026 12:59:07 +0100
Message-ID: <2418121.1781783947@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Oleg Nesterov <oleg@redhat.com> wrote:

> > -	if (cookie)
> > -		mapping_set_release_always(vnode->netfs.inode.i_mapping);
> >  #endif
> 
> This change looks unrelated...

Oh...  That should've been in the preceding patch.

David

