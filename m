Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839538E8A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777668; cv=none; b=aZ8gc/FzqTNAYIkUZlTka4rjKlKOnoGj6LvzdGPfUCinn+rBRCOV/WwXl5KYATZ8NHOrMB0J0K1ZJFfkUJlZYcYrmRVyIpxjFSoViLovGmNFGmVsfrTFwxR5NitBmfk0sJBOqnCELxXRjawMxVoyu1KAxHpo29RzX3xGbuPStkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777668; c=relaxed/simple;
	bh=179xiaQ1iwtEz4kmCwhsfrv3qku11TOHyqdC3s/whUM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fRgq4RJd3i4obnAdKxjixN45j9lp/UMnAy1PebAtVXi342h8eFTUqfJhwY3eJ5iueBJXM6UkVUOkxgf91cmCZRxL9OLuigbyDQqwNSVjifdvSOUvH8RixM+QZacx3iJAqDCMVOdJmH35pGIWKXjJ1OfuJeIXrjke6CLz4lUr88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PT8cetKQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PT8cetKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787777666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=179xiaQ1iwtEz4kmCwhsfrv3qku11TOHyqdC3s/whUM=;
	b=PT8cetKQvfpp0fbbZJEIHKp13L2fJPxjvOXu8ismCJo5QyL4zNVA8yGtHPBdWs8yIFtu9t
	Si5hznTzB+3ujQ9zu6WNbdaVPwNr8IE2bEEChgVLC7EtwLcqV5KpldiSwrLLlCuPIf8IHU
	d+i7qhPrYxs3jrmwPLSGRSWrXKhTve8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-EfdkxYmVMO2Wb6-8Qogj5Q-1; Wed,
 26 Aug 2026 16:54:21 -0400
X-MC-Unique: EfdkxYmVMO2Wb6-8Qogj5Q-1
X-Mimecast-MFC-AGG-ID: EfdkxYmVMO2Wb6-8Qogj5Q_1787777659
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A240F1862D42;
	Wed, 26 Aug 2026 20:54:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.88.47])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A779F5B3;
	Wed, 26 Aug 2026 20:54:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1895550.1787777192@warthog.procyon.org.uk>
References: <1895550.1787777192@warthog.procyon.org.uk> <1819786.1787768317@warthog.procyon.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: dhowells@redhat.com, Keith Busch <kbusch@kernel.org>,
    Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix start and length check added to iov_iter_extract_bvecs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1896255.1787777654.1@warthog.procyon.org.uk>
Date: Wed, 26 Aug 2026 21:54:14 +0100
Message-ID: <1896256.1787777654@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

I forgot to add:

Signed-off-by: David Howells <dhowells@redhat.com>

