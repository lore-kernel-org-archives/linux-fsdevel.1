Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB7843D4E0
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806508; cv=none; b=MSjqotx+aDMRHT0VJ7SpDYKjRZYgtEez1+dZaDt0nMqPf8FxaduhQrbpuVgQwxpxW4qUNBGPmkbELoFOaFmvclkBaN/Iw7blo8JnUUvSEbUA9i8gBJNbLAeLqeiqwf5Qg7oz5DcdROsqK+CPmgfNcL8pKFoP1J1wloqnvK4fthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806508; c=relaxed/simple;
	bh=GrA4O3AFhQYd9/Cr4SWWd3W/vDAYWfIYD3r+TAl+zs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJtQ5tXsI7GNGk1zkEJvvZztXAA8BMNemZP2LMocMrlnP21umltiRmq7qTl59YKMAFIxovL1jDsN4P3/QUgqVuIlrUZ3hz5ckVLMjTD95qpzKc5VMR9nV7as938g6xn8XZFb8SXpcnMTGElqecjIvOwXr68MI7UatC3LEHDb/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULCgPRwg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULCgPRwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784806505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HaEIOt0h6gcxa7+kOMT2WE4llGhJ4z8hATBwJERcR1s=;
	b=ULCgPRwgnT6OeYV5tStSX54uaxGqfGnvsEgqp6irL4Y9mqOKhZc2A/1+uE5zHTapr2L7Xx
	7MMdvHQFHFb6Oxf5VGszQFMIBKjmvzIER34ZY8BunvwVK9epwUsyFyYH3drWAWUfBcCHkc
	oEd/5jTlyJmywVPH746KMzNPDAzbgaw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-if1vIVDlOW2IzEjJixWMkA-1; Thu,
 23 Jul 2026 07:35:00 -0400
X-MC-Unique: if1vIVDlOW2IzEjJixWMkA-1
X-Mimecast-MFC-AGG-ID: if1vIVDlOW2IzEjJixWMkA_1784806499
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3FE61805F35;
	Thu, 23 Jul 2026 11:34:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EE37D73;
	Thu, 23 Jul 2026 11:34:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] afs: Miscellaneous fixes
Date: Thu, 23 Jul 2026 12:34:45 +0100
Message-ID: <20260723113452.566619-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hi Christian,

Can you pick up these miscellaneous AFS fixes, please?  Note that most of
these are derived from Sashiko review of some rxrpc patches[1][2].

 (1) Fix afs_fs_fetch_data() to set call->async.

 (2) Fix afs_fs_fetch_data() to subtract transferred from len instead of
     adding it.

 (3) Fix a UAF when sending a message if the call is completed so quickly
     that the sending code hasn't finished with it when it gets freed.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

[1] https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redh
[2] https://sashiko.dev/#/patchset/20260713081022.2186481-1-dhowells%40red

David Howells (3):
  afs: Fix afs_fs_fetch_data() to set call->async
  afs: Fix afs_fs_fetch_data() to subtract transferred from len
  afs: Fix UAF when sending a message

 fs/afs/fsclient.c | 5 ++++-
 fs/afs/internal.h | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

