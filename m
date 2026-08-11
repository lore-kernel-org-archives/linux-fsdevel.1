Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7DE2C21F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433043; cv=none; b=gFJbJIoCo6PGt5sVrH3BRttWEmZDZjzu8F0J9BklnMrgX+ckJaLCETpdM01qtGzB7zj6tdaHXhTUXs+dwUmzvyRTMQ5OxsKaETMdieM76vk12C4rB0Sk2F4JzHLKXPV0p/AIlm88NbPDtd1O9e92k4dOOcqsunAXSmBVJxSd2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433043; c=relaxed/simple;
	bh=4PF9UO5mV16bEfh+9IYD3sDpV4/G2Ijfj+ze6EOElOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzyexW2bTBi09w/vgr55AbHwnCRWPP9ccTNTe7jZKuJ6NsdFaFVU/IYlMh8d7FEAIDhJPtok7xQAWh7QiBIcU6qNWPPc2/gUWEIAWrTkLH44pOc6s7HTPE72MCoSZ8kNuJSCrcwmISmmCsGsAdmL9SzYv1Lk3aYHHtQD4dgRooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pxba++2j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pxba++2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786433040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xR837NnXZy7HXvZPnt4PmIBdKsmCljxGFnneVYQf2LM=;
	b=Pxba++2jyBU8MITg0ltjSynLWoqUA6RCQVO60XwSGGBNlr5Q5lIMXVlCXrvlAWlsGABY87
	EicFH6i9pNKH3zA4j62JfwgKuhhPemQo36aUjIWBN/ycjzT5oo3HVkD5W+nhTODpAvJpSm
	4vEYJFxxUc+EbYwpRN7Cn2tuanid0aE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-a-rIfENHPo-b7iATv93CgQ-1; Tue,
 11 Aug 2026 03:23:57 -0400
X-MC-Unique: a-rIfENHPo-b7iATv93CgQ-1
X-Mimecast-MFC-AGG-ID: a-rIfENHPo-b7iATv93CgQ_1786433036
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 011C819560B4;
	Tue, 11 Aug 2026 07:23:56 +0000 (UTC)
Received: from oxygen.station (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26A6D180034F;
	Tue, 11 Aug 2026 07:23:52 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	gscrivan@redhat.com,
	brauner@kernel.org
Subject: [PATCH v5 0/2] erofs: share the superblock for file-backed mounts
Date: Tue, 11 Aug 2026 09:10:49 +0200
Message-ID: <20260811071241.389589-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series adds a "superblock_share" mount option for file-backed EROFS
mounts.  When set, mounting the same backing file (identified by inode and
fsoffset) with compatible options reuses the existing superblock instead
of creating a new one, so the page cache and inode cache are shared across
all mounts of the image.  Without the option the behaviour is unchanged.

v4: https://lore.kernel.org/linux-fsdevel/20260804060455.2928514-1-gscrivan@redhat.com/
v3: https://lore.kernel.org/linux-fsdevel/20260801075446.2508805-1-gscrivan@redhat.com/
v2: https://lore.kernel.org/linux-fsdevel/20260731160901.2276832-1-gscrivan@redhat.com/
v1: https://lore.kernel.org/linux-fsdevel/20260730124120.1501126-1-gscrivan@redhat.com/
Needs: https://lore.kernel.org/linux-fsdevel/20260804055949.2927896-1-gscrivan@redhat.com/

Giuseppe Scrivano (2):
  fs: rename vfs_get_super() to get_tree_super() and export it
  erofs: reuse superblock for file-backed mounts

 Documentation/filesystems/erofs.rst |  8 ++++
 fs/erofs/internal.h                 |  1 +
 fs/erofs/super.c                    | 58 +++++++++++++++++++++++++++--
 fs/super.c                          | 19 ++++++++--
 include/linux/fs_context.h          |  4 ++
 5 files changed, 83 insertions(+), 7 deletions(-)

-- 
2.55.0

