Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AA3314AC
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779714243; cv=none; b=iYxhqSH5EgBBy9XrBuMAOsxnn1DqP5tbyrl+F/S+LqyyQbXhCkl0bkHXHlXD8BfXFiIIPJphxr5Wi/cz4rbUM+HLYILXAr9zv8T2XRrML84VgTFKaFvO5vg+6/4zFdpG7+zgoQmvZ2SMxz5gMRlQACcfkpu7P/v5C5riN7OQ8Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779714243; c=relaxed/simple;
	bh=YZeC2jCwuVnPZKExXKZpqZxCuA6z1T1TislizEKmCVw=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=QvSaVoGLiMVHXSUlGPV69Wi+UecRsLD9WaHBpr2x8aPO4nsmsyyCaDT6dZxjfwfnpRvgkKj6WZtKMqrF7oxb0dYis4O2xbSk9bT3SR8bZn97n/7dy1EkUHbkSvj20bzd+ONWY+H9nJsbaG+IkUKkWZJ1VXfS3lCZXFCyViOHqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJLiFl2v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJLiFl2v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779714240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=/iJPBg2HVIQNZ4w06CvcvCHjJK2B0ZOmsFbG69oTHhI=;
	b=UJLiFl2vf3tYbDaf9OX9ZUSqiRI9J7my8Y/vacpIl870fc7M4u+PSth8yzHhxvZeivkw2H
	FoS2SnAxnB+vlxdBaj9mHQ3chVGr4P3q+C2enZDKS7McSmemkdbJpBRtCtNACtPnjA8Y2c
	uau66azfTBsU0GRiGibeW3P+htejihQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-XifH-8YBOg2pSkky4ceDlQ-1; Mon,
 25 May 2026 09:03:57 -0400
X-MC-Unique: XifH-8YBOg2pSkky4ceDlQ-1
X-Mimecast-MFC-AGG-ID: XifH-8YBOg2pSkky4ceDlQ_1779714236
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43BFD180034C;
	Mon, 25 May 2026 13:03:56 +0000 (UTC)
Received: from [10.44.32.28] (unknown [10.44.32.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CE8E1800465;
	Mon, 25 May 2026 13:03:54 +0000 (UTC)
Date: Mon, 25 May 2026 15:03:49 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-fsdevel@vger.kernel.org, Farhad Alemi <farhad.alemi@berkeley.edu>
Subject: [git pull] HPFS fixes for 7.1
Message-ID: <c28d3045-a040-d66d-7ceb-702a071d7621@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Linus

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-7.1/hpfs-fixes

for you to fetch changes up to 974820a59efde7c1a7e1260bcfe9bb81f833cc9f:

  hpfs: fix a crash if hpfs_map_dnode_bitmap fails (2026-05-25 14:48:58 +0200)

Please, pull. Thanks.

Mikulas


----------------------------------------------------------------
- hpfs: fix a crash on corrupted filesystem
-----BEGIN PGP SIGNATURE-----

iIoEABYIADIWIQRnH8MwLyZDhyYfesYTAyx9YGnhbQUCahRHEhQcbXBhdG9ja2FA
cmVkaGF0LmNvbQAKCRATAyx9YGnhbTeRAQC469Voj6ymkvJ6QqQRaz3u71nofiyw
ZwqHyq+HfoOXtgD/UPll03KkKRvZapI9+YWwaugH4FLcw2tZLUb15bBugQ8=
=59tH
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Mikulas Patocka (1):
      hpfs: fix a crash if hpfs_map_dnode_bitmap fails

 fs/hpfs/alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

