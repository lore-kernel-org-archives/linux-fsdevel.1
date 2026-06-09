Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A062643635B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020401; cv=none; b=ksLcd8lm8YYVbHMElNRD6vt04rdnQGx24OV8SGCCdY8CtXWzCkB1vVZ0/OO9VcFe3qRrZyFGGi7tH7DeIT5owDQicHTL5gMGOLbVsyRk4drV8z8pcl8o76gk28TksyJ20WRDPR+TRSrH4/lbbeGFvenSPErhphfXVIf8ORVdnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020401; c=relaxed/simple;
	bh=FxgccjO/PSXEoX0nYfs3JzTyrbcYhJJL4MsLNrOn47M=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=iHHUch2mlszXzOckqury8ONzAXEZkhcXbZ2wWP70FWWvD7CAEDbShAojrt37klV9eVKtdgnR929olrB6hjaE2XJtaF+t+Jq70ehvhjHiH7iILUZkXeO4cFtdc9xYLglB1OpMBUxAw5LnEtmKCismhGQz9kkW+87Bqw1mAnDvQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCSzMOMc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCSzMOMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781020398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FxgccjO/PSXEoX0nYfs3JzTyrbcYhJJL4MsLNrOn47M=;
	b=cCSzMOMc7FB5eQREG2Me0nwIEX+WNDcPbD2UGNm4BzbFl472a523U0lRBu8cnpl5gQyZWW
	SNIhkshYM6Yieo2jChb42IqByAljcxmlRmHglLMpczEK5B/HdVgfRHbnzbRrBcwiOqNVH+
	plN60oEqauYN6UlDYjJ5wftk37OShpo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-cGWgE086Mi65UOMbC1DTTQ-1; Tue,
 09 Jun 2026 11:53:14 -0400
X-MC-Unique: cGWgE086Mi65UOMbC1DTTQ-1
X-Mimecast-MFC-AGG-ID: cGWgE086Mi65UOMbC1DTTQ_1781020391
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86FF318E6A55;
	Tue,  9 Jun 2026 15:53:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73A791954B03;
	Tue,  9 Jun 2026 15:53:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aifaeKvz3KemfzaS@redhat.com>
References: <aifaeKvz3KemfzaS@redhat.com> <20260609081738.770127-1-dhowells@redhat.com> <20260609081738.770127-7-dhowells@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH 6/7] afs: Remove erroneous seq |= 1 in volume lookup loop
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <872442.1781020385.1@warthog.procyon.org.uk>
Date: Tue, 09 Jun 2026 16:53:05 +0100
Message-ID: <872443.1781020385@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Oleg Nesterov <oleg@redhat.com> wrote:

> Yes, but now that we have scoped_seqlock_read() we can make another change
> on top of this fix. afs_lookup_volume_rcu() can just do

I wonder if that would be better as a separate patch rather than merged into
this one.

David

