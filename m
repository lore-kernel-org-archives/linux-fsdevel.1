Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595230DD2F
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503296; cv=none; b=rREL4uE4k9JGykkK7kJtJ4hB6kSBTC3ck5Ljh5CUM6Qm/Q30tCVw3SyEdi/b44vSFO63ouVFLDf22XuhKdZCg43VfEwJNfwTtz/pZ8wU2LGym5gs9kqYLJkGN97Gd/nnUw65ogCIL2JVbKQ3UIl3OIARjLUodRs4asquU7+tjxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503296; c=relaxed/simple;
	bh=beVtjXrWuYofT5C9A2ZJDghifOTh4tK5f37wTOg0H/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cBVBbNrPZdZBKKYhvUQnAu2Vn7pQuSzWOYDTnXUBombdPTu1sH+s+zS9qFNYyh1hLg5nO8dNJjt9zutn6PfPlnAYHkKxrOH8bUoPjAd8ShtiHIyhFLylBMdt6CePMetxQZx/1p+GqBzF8dR0oTklas2uvBsp5RhKZ92KmwPK6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOG08D7Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOG08D7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783503292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LSGrhlD0yn8NtGRpP/yuLz9/lKXd3YZ5anjPExUEXbM=;
	b=LOG08D7ZEzd9W1H5KPbMoW4JZijjH8hMz8+P1an8F+es9YWsDyw5EBCmmeXHt8gK1Uf9EX
	0MJQQIDhguYuBzgJJyqUHxgrUy2+fUzWR0SWjuAgwqG0B1pIX0Lrf4U60iEx5sHlHMGsuX
	W0HdqkCxy+Fyx9vym3Pm4VnVPoptiaU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-1jWkn7APP-qkLQEIcXgpAg-1; Wed,
 08 Jul 2026 05:34:51 -0400
X-MC-Unique: 1jWkn7APP-qkLQEIcXgpAg-1
X-Mimecast-MFC-AGG-ID: 1jWkn7APP-qkLQEIcXgpAg_1783503290
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 391EB1956068;
	Wed,  8 Jul 2026 09:34:50 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAC481955F43;
	Wed,  8 Jul 2026 09:34:48 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH 0/2] erofs: fd-based source and backing file introspection
Date: Wed,  8 Jul 2026 11:34:25 +0200
Message-ID: <20260708093446.3370200-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This series adds two features to erofs for file-backed mounts:

1. Accept a source file descriptor via fsconfig(FSCONFIG_SET_FD,
  "source", NULL, fd) as an alternative to a path string.  This is
  useful when the backing file isn't reachable by path in the caller's
  mount namespace.  For example, composefs reusing an already-mounted
  erofs image's backing file.

2. Add an EROFS_IOC_GET_SOURCE_FD ioctl that returns a file descriptor
  to the backing image file.  This allows userspace to retrieve the
  backing file from an existing erofs mount without needing to know or
  parse the original source path.

Giuseppe Scrivano (2):
  erofs: accept source file descriptor via fsconfig
  erofs: add ioctl to retrieve the backing source file descriptor

 fs/erofs/inode.c           | 25 +++++++++++++++++++++++++
 fs/erofs/super.c           | 36 +++++++++++++++++++++++++-----------
 include/uapi/linux/erofs.h |  9 +++++++++
 3 files changed, 59 insertions(+), 11 deletions(-)
 create mode 100644 include/uapi/linux/erofs.h

--
2.55.0

