Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6039B495
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120583; cv=none; b=N3zmP8QKP0Oz4kPrZAphoJIJIv0yaoXoESmHQiZSouRluGO0POX20gZDXU8oJhsJeH5K2vNztnWyp5UItwlMLpWY7V1VHjPclffOmB1W67a0jhLpuKkvzRjm0kvVge/rdk5R5i5vsOHTGN5kUtTYeLx7hpLdeXH2VZd8OLQ5WDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120583; c=relaxed/simple;
	bh=18zbZNBSnfzEQNxf3NzURV1iOgz5TdTGposrZRBN7p8=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=KYhSYJeLud8oAJQ0cnPCq0ZMdwYioD31uzuvDtO6qK6kJHHlOR8wD9/3y3nmZAiWB/svrW40/pMO89d8DlhvVX68iu7fA80MTRPpLsHWY4EeFRW9kir9BnWaaBaqiaAOuQwR5Be5r7Rjh9uOtK4BPWk1t0DpdZJVuT1JVBvBDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbWOVh8c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbWOVh8c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782120580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18zbZNBSnfzEQNxf3NzURV1iOgz5TdTGposrZRBN7p8=;
	b=CbWOVh8cMLhup9MEkDfSht82ZWvWg20QkCkhGlqlxPf3KjBcs9JUvdDOlx9FzlQ7k+dN0S
	vIf/FQsx1Io1UnDOapWTJ0POYOFHIjlbTVaO3KSF8W2sVZ8fRdJpvgLoiOMWxrmsVklFAL
	8WuvnHokPd8C2Ybq8RLXTxD6S2avopY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-QcGPzxt3Nq2BQ29ZEjXUmw-1; Mon,
 22 Jun 2026 05:29:38 -0400
X-MC-Unique: QcGPzxt3Nq2BQ29ZEjXUmw-1
X-Mimecast-MFC-AGG-ID: QcGPzxt3Nq2BQ29ZEjXUmw_1782120577
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CDF41802679;
	Mon, 22 Jun 2026 09:29:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.242])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C10A43691C;
	Mon, 22 Jun 2026 09:29:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-20-dhowells@redhat.com>
References: <20260622090856.2746629-20-dhowells@redhat.com> <20260622090856.2746629-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/21] afs: Fix premature cell exposure through /afs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2747976.1782120574.1@warthog.procyon.org.uk>
Date: Mon, 22 Jun 2026 10:29:34 +0100
Message-ID: <2747977.1782120574@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Fixes: 1d0b929fc070 ("afs: Change dynroot to create contents on demand")

