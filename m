Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0D4570E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544968; cv=none; b=kZu4tPFtaqX5SlUnvYzT1CNvvtis7hV/p++8W4Pkc1WSS9SmudNY2zUYD92v4B2SQaYaxu/VKX6vcomEcxUUfpe/+8PFjVVlWin/c0ma2a+H8PtaGDhm7ypCCCLQJ0jKvKPA2gZMZK9FFo2/3DNUw3pkzBd3d7XA7ZGWMmM+tjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544968; c=relaxed/simple;
	bh=JthIyDGL0+HAc3aZ7mgyr7RCGovAt3YnxeXbEppVbdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cs1rzQKNqCpnZ58Ka9fIR5nxWE4JftiXnxC2xMNCNa81Ry8iDvTx/biy2VnyZvarjebtfIMB7q3ONOERr0MWLEXpMS8DXf1DLlPep4MjbU+oS2CZ8plWOkUs4YK6BDjm/udvBPHj/++IS0W+ioFhCoA7j8wdRMuF4/1jFTZVFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikJgffep; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikJgffep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786544963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cQlSbAIttH+rNkAEoVDMXcXh5dsCND2QuLXOvV9cLG0=;
	b=ikJgffepLNzP8b9rS3ZF4rr4T9KZlFHH/8qSc87HJWeSzVFR+JMvK3H69rs+nsgUt4H04w
	nMPfyEp01Yc2uye3xDazhoAWhKQlylvIxBBL6NtWrmHk4bl2XiQJEmcoR/otBGSe5ur2zb
	5SlGRxSbFtNjNCKpw53dB5fPS58BVcE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-37Ig9cT_MuWTn-sfLDU5cw-1; Wed,
 12 Aug 2026 10:29:20 -0400
X-MC-Unique: 37Ig9cT_MuWTn-sfLDU5cw-1
X-Mimecast-MFC-AGG-ID: 37Ig9cT_MuWTn-sfLDU5cw_1786544959
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92AA71800984;
	Wed, 12 Aug 2026 14:29:18 +0000 (UTC)
Received: from oxygen.station (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD1011800577;
	Wed, 12 Aug 2026 14:29:15 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	gscrivan@redhat.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: [PATCH v6 0/2] erofs: share the superblock for file-backed mounts
Date: Wed, 12 Aug 2026 16:28:02 +0200
Message-ID: <20260812142907.1010046-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

v5: https://lore.kernel.org/linux-fsdevel/20260811071241.389589-1-gscrivan@redhat.com/
v4: https://lore.kernel.org/linux-fsdevel/20260804060455.2928514-1-gscrivan@redhat.com/
v3: https://lore.kernel.org/linux-fsdevel/20260801075446.2508805-1-gscrivan@redhat.com/
v2: https://lore.kernel.org/linux-fsdevel/20260731160901.2276832-1-gscrivan@redhat.com/
v1: https://lore.kernel.org/linux-fsdevel/20260730124120.1501126-1-gscrivan@redhat.com/
Needs: https://lore.kernel.org/linux-fsdevel/20260804055949.2927896-1-gscrivan@redhat.com/

Giuseppe Scrivano (2):
  fs: rename vfs_get_super() to get_tree_super() and export it
  erofs: reuse superblock for file-backed mounts

 Documentation/filesystems/erofs.rst |  7 ++++
 fs/erofs/internal.h                 |  1 +
 fs/erofs/super.c                    | 56 +++++++++++++++++++++++++++--
 fs/super.c                          | 19 +++++++---
 include/linux/fs_context.h          |  4 +++
 5 files changed, 80 insertions(+), 7 deletions(-)

-- 
2.55.0

