Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AB472F6A
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351043; cv=none; b=KvAPItu7R3sqgnNbGY4/7FdzVWsA7h/z/GaW1S7j+xndGsMAOI3CB+fcxTC2VlMvZ9D//FII83F3pGc6OfZrNbV8GjQ8Mx0fjAvCFMHEtQJ0BO+Z2ykDRRN5c64WOL/XgDCOhhR2LkXht2bU9tPPQaW1BUcCFLFxr3clU1eoXZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351043; c=relaxed/simple;
	bh=RNbpoZIzCwZV6J29KpTJel6AjjZLP9SNafsmIdyqdpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/xS4ATEGUUXSm4PHAoTasZ+xqHp7/nQHi7g0STj3uDh/Jof5rei9K62wNk3SdBCvsgL6RnCKREUO3krvh2zwGRNVSQvKN+T3Z9SlcDRBETd5NceBIYlAo11n/WJadFMCLs7EjR/V9jRwaT5N73v8y3eJybvu4TKn+QerQIsyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUr60xbS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUr60xbS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788351037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CNqDta9XziBCzSI/2GOPfZApm4WhihukBptO3kpJr8E=;
	b=jUr60xbSqbWKQ1f/ajD1Rub+39irR48bLWc7u0oouSdEkbWbhgK91tU0PLnvyZyDRPDd7I
	wmb1S5mC8U2CfSlnS4morgFpxqXnNj20hDOkwYo1L0eCYvnYmatIeDJd8ERJg1jxm8iCmd
	vVFzdquBGFSs31BfdAPmii4g3h0ylkg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668--E5Xl-F7OX-SVOL6d-etQQ-1; Wed,
 02 Sept 2026 08:10:33 -0400
X-MC-Unique: -E5Xl-F7OX-SVOL6d-etQQ-1
X-Mimecast-MFC-AGG-ID: -E5Xl-F7OX-SVOL6d-etQQ_1788351032
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E5311843ADE;
	Wed,  2 Sep 2026 12:10:31 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 860103000239;
	Wed,  2 Sep 2026 12:10:28 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] afs: Miscellaneous fixes
Date: Wed,  2 Sep 2026 13:10:18 +0100
Message-ID: <20260902121024.3328255-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Christian,

Can you pick up these miscellaneous AFS fixes, please?  Three were found by
Sashiko[1][2] and one was a posted patch.

 (1) Fix missing kunmap in afs_dir_search_bucket().

 (2) Fix double-unmap of directory block.

 (3) Fix an incorrect free in afs_lookup_server().

 (4) Clear stale peer app data after address list changes.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

[1] https://sashiko.dev/#/patchset/20260716103030.3065561-1-dhowells%40redhat.com
[2] https://sashiko.dev/#/patchset/20260729160108.2031453-1-dhowells%40redhat.com

Chengfeng Ye (1):
  afs: Clear stale peer app data after address list changes

David Howells (3):
  afs: Fix missing kunmap in afs_dir_search_bucket()
  afs: Fix double-unmap of directory block
  afs: Fix incorrect free in candidate cleanup in afs_lookup_server()

 fs/afs/addr_list.c  |  5 ++++-
 fs/afs/dir_edit.c   |  9 ++-------
 fs/afs/dir_search.c | 11 ++---------
 fs/afs/fs_probe.c   |  1 +
 fs/afs/internal.h   |  8 ++++++++
 fs/afs/server.c     |  1 -
 6 files changed, 17 insertions(+), 18 deletions(-)

