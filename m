Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996644F55BC
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686356; cv=none; b=UhDR9wzQXsqX5cFLHZzFkWGSMNqzhXrNv/Yy4PpjqDsHfI/bXgXhIcnTQqI2m76waUc6bagyh6ZUMoHqhKYMX3uwnmOfcZYDXD7EmFhaqZRY6pMdGTvB/nXWRqwPVHbuGVMC5mB05eDdAAWsXO+CrCZhiKnBFb2OQzphp33FfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686356; c=relaxed/simple;
	bh=Z3kbtPEfllJjrVcxV4Wsk7nVwVhApu945emFW2VOZ5s=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=BWAHXx6yPkZ0a1PJDAfBjUaK6l9Uq3ADeOQVCqH46dN9g4iaCVzHjdmEanti+Pz3kWQp8JmsKEKGZdw+jL/S7I+saZcj2ZEFtHy3jCacOs3FoEIWH+Uw6ubjfnnySPVJo1SGY4eb988V+DVKo6YmWw3xbnm3Wk8W0t+JZGYwEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C99G7HbY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C99G7HbY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790686353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=I1tT4w3UHin/AieBETFD0ZCHCtjCAxTz0zUFSdGN+NU=;
	b=C99G7HbYxEDto5wxZeV/bJsdloDxQUV/TygcNCu6u5NiPc05GEaKCv+TtoH25NJp/j2yWg
	P9O3dp/kY6q+hfQU0Ty7hQj04iqDKWIZNpQHnXcBBY8IKGRoR7xyswRUPahk/APjNzyRke
	0dshARZp5MUE+Qu2Vs1FNES6dDaNUfY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-n9oqEOOHNASfTz54GBFy3w-1; Tue,
 29 Sep 2026 08:52:28 -0400
X-MC-Unique: n9oqEOOHNASfTz54GBFy3w-1
X-Mimecast-MFC-AGG-ID: n9oqEOOHNASfTz54GBFy3w_1790686346
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93C871964CE6;
	Tue, 29 Sep 2026 12:52:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C4E430000E4;
	Tue, 29 Sep 2026 12:52:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
cc: dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
    Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Folio-related bug in __iov_iter_get_pages_alloc()?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2810984.1790686342.1@warthog.procyon.org.uk>
Date: Tue, 29 Sep 2026 13:52:22 +0100
Message-ID: <2810985.1790686342@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Willy,

I'm looking at __iov_iter_get_pages_alloc() and when it's extracting from an
ITER_BVEC, I see:

		for (int k = 0; k < n; k++) {
			struct folio *folio = page_folio(page + k);
			p[k] = page + k;
			if (!folio_test_slab(folio))
				folio_get(folio);
		}

Isn't this wrong?  You can't assume the page you're looking at is a folio, and
so you shouldn't use page_folio() on it until you've checked what it is.
Granted, it's quite likely to be a folio, but not only could it be a slab
page, it could also be a randomly allocated page used as a buffer, a network
receive buffer or something allocated with a fragment allocator.

Can we actually safely use folio_get() with all of those, or do we need to use
get_page()?  (I know, at moment, get_page() is a wrapper around folio_get(),
but that's likely not to remain the case).

David

