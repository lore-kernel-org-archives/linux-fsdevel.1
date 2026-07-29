Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139D3D45C8
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334640; cv=none; b=A3T9VU0m9P1ejTP1AtawJatNz8zhAoeRmltFbWx2Zl2EYZRuIkgD2ou7hG1UmmgcWoPoSc/4csIwTEv8bNFo0lRzaCdbh+ZMvbKLxNh8jvZRJJ7URrpEssojW7wncaQ9kYq4Z7on6SDSon7EJy3jHMALQ0NK5+mWeBBv0cTN4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334640; c=relaxed/simple;
	bh=4YWtOsbn5Mhi7VS6aqmr6wzCigPAWdplq6jzDD1yZG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2tDE4W78ezgQCq19rSCXwiR1uMJSbHRPzob0YSets5yLp8P736+RwyNyjPRE7PcYfKQfdW/iGwB20AGViVVJDk5COrJJmkDuczwGdqUXa+6Lz1RIwiJnsVYSlESI5wzAPeTuX50K28m4Q3JsYoB8/lFOEvCOl1xhZsOCqigqgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EXZpLQrF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXZpLQrF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785334637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7+n4j40225VPB6wZ9Q0L2w0LqypEnipePu3ccpC+yoU=;
	b=EXZpLQrFhmeIGjOPUOswLEN9I+EhpFhM74Cb7ccSC0+PmJ4BDZGBBJEok4XjzR9iJmsDU4
	67PcKuyp34OhG8d/f9Gq37HM+Cd7IPexrbUj41dVwm4bBcdQry2uvDtnETTXYTTeMhZ7Tj
	rten+IiYlpgxKi4LZ6A+sVFSq6YbNWw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-DhfV98C_P-q5nCNObYc8vQ-1; Wed,
 29 Jul 2026 10:17:13 -0400
X-MC-Unique: DhfV98C_P-q5nCNObYc8vQ-1
X-Mimecast-MFC-AGG-ID: DhfV98C_P-q5nCNObYc8vQ_1785334632
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 925F01800358;
	Wed, 29 Jul 2026 14:17:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0511E1956089;
	Wed, 29 Jul 2026 14:17:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] afs: Miscellaneous fixes
Date: Wed, 29 Jul 2026 15:17:02 +0100
Message-ID: <20260729141705.1977658-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Christian,

Can you pick up these miscellaneous AFS fixes, please?  They were found by
Sashiko[1].

 (1) Fix missing kunmap in afs_dir_search_bucket().

 (2) Fix double-unmap of directory block.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

[1] https://sashiko.dev/#/patchset/20260716103030.3065561-1-dhowells%40redhat.com

David Howells (2):
  afs: Fix missing kunmap in afs_dir_search_bucket()
  afs: Fix double-unmap of directory block

 fs/afs/dir_edit.c   |  9 ++-------
 fs/afs/dir_search.c | 11 ++---------
 fs/afs/internal.h   |  8 ++++++++
 3 files changed, 12 insertions(+), 16 deletions(-)

