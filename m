Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A8739F17F
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337396; cv=none; b=dSj2Q51/aQ91/2Zd3uo6x2uQaLslpjZwkkya5sLYx1Tm1lde90npLhulZEV9pdmCPqpayFAFq+4B9TlL/8blj0ToJWP64L/E4U8zVKNf+tJB+X8WmDvD6kRbuD5xquR81I+peXRMjILb4oJ9FYSIzCCNYdXN5Tz1ozaCReUExmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337396; c=relaxed/simple;
	bh=tQIvgQqGPyGgn78PqVP6NOGSx6WMgw2hQRFbb6w+Mtk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IMC/QLGM2hVzCy6MVEqo8INui4UuR4xdMkBbm6EJYPsUQKMfKhLvlUpKz7s6KqDZc6YVVvzchB9I9Jcl1QWk9kTXLdA8WA8qn4QATbw7fq+iuMJsgoXd0mfT9z2qCw3eY6PHBXaWb+xA7OZHgBjKVMxloBwm+6W7lfZ5A9YU2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqZ31YWS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqZ31YWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788337393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=WQuF0kvMWaNNMHPqsEiSj1pAGCWEDfGpmkrHT5U+rCI=;
	b=XqZ31YWSV/KDczB/t+THaRALkr/mmVEa7hLXh1k4vUebQHmgUAuB/2OFtRW3bQuZkcrTj5
	orY1g4B784FEqQmPwdYK5Am0RRnBasIPegcaq/Wdddc8ztNH2sxxLedwjVB8Mo+8ZyoiHF
	LHGWxxvxPgNenw6+cazwi1TCt6toh0w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-L-uV9cNSM-KEPI0xDDtzVg-1; Wed,
 02 Sept 2026 04:23:12 -0400
X-MC-Unique: L-uV9cNSM-KEPI0xDDtzVg-1
X-Mimecast-MFC-AGG-ID: L-uV9cNSM-KEPI0xDDtzVg_1788337391
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62D9E1954B05;
	Wed,  2 Sep 2026 08:23:11 +0000 (UTC)
Received: from ws (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26F241956044;
	Wed,  2 Sep 2026 08:23:08 +0000 (UTC)
Date: Wed, 2 Sep 2026 10:23:06 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.41.6
Message-ID: <iaeylahlofszibnlw3ixknbeinsavh5guesuytkag6bg5a2eh4@gwzdbo6oqb2x>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


The util-linux release v2.41.6 is now available at

  http://www.kernel.org/pub/linux/utils/util-linux/v2.41

Feedback and bug reports, as always, are welcomed.

  Karel


util-linux 2.41.6 Release Notes
===============================

Security fixes:

 CVE-2026-76642 - mount(8) post-mount hooks execute after helper failure.
   When an external mount.<type> helper exits nonzero, post-mount hooks
   (X-mount.idmap, X-mount.owner/group/mode) still execute as if the
   mount had succeeded, allowing privileged operations on the
   pre-existing target filesystem.

 CVE-2026-78410 - mount(8) TOCTOU race on source path.
   In restricted (SUID, non-root) mode, the source path is
   canonicalized with realpath() as euid=0, following symlinks through
   user-writable directories.  Additionally, open_tree() follows
   symlinks in intermediate path components.  A local attacker can
   redirect a privileged mount or post-mount ownership change to an
   arbitrary path.

 CVE-2026-78408 - nsenter(1), unshare(1) file descriptor leak.
   File descriptors in nsenter and unshare were not created with
   O_CLOEXEC, potentially leaking them across exec.  Added O_CLOEXEC
   as defense in depth.

 wall(1), write(1) - hostname escape sequence injection.
   The CVE-2024-28085 fix sanitized only message bodies; the banner
   headers still interpolated the system hostname without sanitization.
   An unprivileged user can inject terminal escape sequences via a user
   namespace hostname.
   Additional fix for CVE-2024-28085.
   Reported-by: Skyler Ferrante

Changes between v2.41.5 and v2.41.6:

lib/fileutils:
    - add ul_openat_resolve() openat2 wrapper (by Karel Zak)

libmount:
    - skip post-mount hooks after failed mount helper [CVE-2026-76642] (by Karel Zak)
    - pin source path with openat2() for restricted users [CVE-2026-78410] (by Karel Zak)
    - restrict source path canonicalization for non-root users [CVE-2026-78410] (by Karel Zak)
    - add mnt_open_tree() helper for safe tree opening (by Karel Zak)

loopdev:
    - use openat2(RESOLVE_NO_SYMLINKS) for backing file (by Karel Zak)

nsenter, unshare:
    - add O_CLOEXEC to all open() calls [CVE-2026-78408] (by Karel Zak)

tests:
    - (lsfd) add a function checking the availability of UDPLite socket (by Masatake YAMATO)
    - (lsfd/option-inet) make UDPLite related test case skippable (by Masatake YAMATO)
    - (lsfd/mkfds-udp*) make UDPLite related test cases skippable (by Masatake YAMATO)

wall, write:
    - sanitize hostname in banner header (by Karel Zak)

