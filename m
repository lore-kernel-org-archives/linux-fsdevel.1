Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF743403E5
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993133; cv=none; b=gVY3jt/Kf/sXrvCQ/uMpWUwmK61a3ktaRdA8ZjTYWDrnyzTjGr7NO5+5xAO/lKw+7TZB2aIv0kVII2SlQ0hnVFGS/a8SeG6hzeKpDcRA/4ryHWlEQYqV8dxSzuoq1GlIHtoSFnJNf8ENPHDoUem4UgE3kNlZhcSzLUqrytCMd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993133; c=relaxed/simple;
	bh=WTENrBaikIXM8jc7yr7O6dN8zNGThKe0ct7U34w4Dtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIlrlZjE7db76d6Http5VtVFFHtTjYWoFGyPorkmTZzQW2JVvgyv6PtDoxNLBZC/I1rLrYF7wLasNcba0ZYcfQT1zVZMOyN+WAmBTQZKavySg3KGeeUrVTS0X5SfdVcV+h/MIyHa4nfaAxSgiPHTQ/uQDWTxa1AQ8YZizh2pNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0rT+CNy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0rT+CNy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780993130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UhUWP2Tb8+brDuvC83ZCMjl73eyN9JLXh++Fcq3s4lo=;
	b=d0rT+CNyEdMxi58+7ReNRU7kHxAElj+WzpNzz03lu5p5tHkjWb3lkFIgnnwNK4Nh56dUJY
	3EIQP4MAm8wvdlJ4Nc174d4WDe8+6LayJOnh5CfcRuct5GJUhf51ewJ27gol4FXWziw9zD
	Ki7rIbswbyYa7KT2dhErTXroCe03Jrc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-vS60PhkBMb6bYHr7acPxEA-1; Tue,
 09 Jun 2026 04:17:45 -0400
X-MC-Unique: vS60PhkBMb6bYHr7acPxEA-1
X-Mimecast-MFC-AGG-ID: vS60PhkBMb6bYHr7acPxEA_1780993064
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1AC11800BD4;
	Tue,  9 Jun 2026 08:17:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 417CE1800370;
	Tue,  9 Jun 2026 08:17:41 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] afs: Miscellaneous fixes
Date: Tue,  9 Jun 2026 09:17:30 +0100
Message-ID: <20260609081738.770127-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Christian,

Can you pick up these miscellaneous AFS fixes, please?

 (1) Fix the CB.InitCallBackState3 service handler to handle an unknown
     server (server pointer is NULL).

 (2) Fix the clobbering of the default error code in
     afs_extract_vl_addrs().

 (3) Fix a NULL pointer in a trace point in afs_get_tree().

 (4) Fix setting of AS_RELEASE_ALWAYS for symlinks (and mountpoints) as
     there's no release_folio function provided.

 (5) Fix the release of op->more_files to Use kvfree().

 (6) Fix erroneous seq |= 1 in volume lookup loop.

 (7) Drop for duplicate server records when parsing DNS reply into the VL
     server list (this is not strictly a bug fix, so could be punted to the
     merge window).
 
The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

Dan Carpenter (1):
  afs: Fix error code in afs_extract_vl_addrs()

David Howells (1):
  afs: Remove setting of AS_RELEASE_ALWAYS for symlinks and mountpoints

Li RongQing (1):
  afs: Remove erroneous seq |= 1 in volume lookup loop

Matvey Kovalev (1):
  afs: fix NULL pointer dereference in afs_get_tree()

Nan Li (1):
  afs: handle CB.InitCallBackState3 requests without a server record

Yuto Ohnuki (1):
  afs: check for duplicate servers in VL server list

Zilin Guan (1):
  afs: use kvfree() to free memory allocated by kvcalloc()

 fs/afs/callback.c     |  1 -
 fs/afs/cmservice.c    |  5 +++++
 fs/afs/fs_operation.c |  2 +-
 fs/afs/inode.c        |  1 -
 fs/afs/super.c        |  3 ++-
 fs/afs/vl_list.c      | 18 ++++++++++++++++--
 6 files changed, 24 insertions(+), 6 deletions(-)

