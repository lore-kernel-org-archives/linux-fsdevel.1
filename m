Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05463148C2
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613273; cv=none; b=K7s7++KMlgt4XVJ+CKOw7nBnYrjj9G0zXcDadQ/nMyIAW6iTPF3pOdLYa6vnCczTE3ZNuKHqA4Bxvl8TidaCJcxRWdWHSVBOnijn9llaaHLiEAey5ICshY1oMgV2dPmn3GPXCkpSFBWXbhjMIT5XUbWeeMd3afsSLjKpexbaQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613273; c=relaxed/simple;
	bh=dHYXSuMIuncDCQHUa2kWZmPKgrl3nU1x2uQFJeuEmQU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gJsRKPz5nI36fYL+0MDZkYLQTJxSEYkQUECqMw2uU+adrztHFLsrt0guQD4TOfAxaI2CO91R7bo229yWCwpuQmaGJrgBCCl/1hAasL0Ve67PoU4TMiILVyH0qeewbHm1eFv17ZYtxl9YYJNPqmfHxBSBy4tlpZWY5W4MTRmYylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cIlMo93B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIlMo93B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781613271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=l7dJghem+f0E2akGXB5TbSpsh9R99AMpixwdVcMXjus=;
	b=cIlMo93BlPVcNvjKZ8AACKe8dVtm8PQLgVRD4yXalT4FdyBHKZ37rh7bTNvTsxzBsh9Hkf
	UgU9oi7wUGhWhgEGV8NKDyjBNiKZ+uC3xmVwqTrsBvP9fLH//5NRcEq9HIKoj99KZEewIv
	ebRHOyAuWCy6HOXiYZy2j0wg2tSIG+0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-xPlpVIcHPxelqkxmk4Yq9w-1; Tue,
 16 Jun 2026 08:34:30 -0400
X-MC-Unique: xPlpVIcHPxelqkxmk4Yq9w-1
X-Mimecast-MFC-AGG-ID: xPlpVIcHPxelqkxmk4Yq9w_1781613269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C3FC18004A9;
	Tue, 16 Jun 2026 12:34:29 +0000 (UTC)
Received: from ws (unknown [10.44.50.174])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E007C1800594;
	Tue, 16 Jun 2026 12:34:26 +0000 (UTC)
Date: Tue, 16 Jun 2026 14:34:23 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.42.2 and v2.41.5
Message-ID: <c2fo4x3lcppsj77k564i4qodmon3wagx47qf4mqwjwdtiplupg@jmaqrlzp273h>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

  The util-linux releases v2.42.2 and v2.41.5 are now available at

    https://www.kernel.org/pub/linux/utils/util-linux/v2.42/
    https://www.kernel.org/pub/linux/utils/util-linux/v2.41/

  Both releases contain security fixes for libmount and libblkid:

   CVE-2026-53613 - mount(8) TOCTOU race on target path
   CVE-2026-53612 - mount(8) TOCTOU race on post-mount owner/mode change
   CVE-2026-53614 - mount(8) SUID bypass via LIBMOUNT_FORCE_MOUNT2
   libblkid use-after-free in nested partition probing

  v2.42.2 additionally includes a follow-up fix for CVE-2026-27456
  (loop device symlink attack) -- the v2.42.1 fix used O_NOFOLLOW
  which only rejects symlinks at the last path component; this update
  uses openat2(RESOLVE_NO_SYMLINKS) to reject symlinks at any component.

  Note for v2.41 downstream maintainers: the same loopdev follow-up
  fix for CVE-2026-27456 is available on the stable/v2.41 branch
  (commit 2dacaf3ee) but did not make it into the v2.41.5 tarball.
  Please cherry-pick it into your builds.

  Release notes:
    https://www.kernel.org/pub/linux/utils/util-linux/v2.42/v2.42.2-ReleaseNotes
    https://www.kernel.org/pub/linux/utils/util-linux/v2.41/v2.41.5-ReleaseNotes

  Feedback and bug reports, as always, are welcomed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

