Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A130675F
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771625; cv=none; b=h1jmIlDYMgkD8TKYAS4dDBGXvxsdmaeGEG1aQ2SAG0+uPlbQdEsisRni0hmssKTaG46lXcxNGs39kb3MKMbt9YCSleEy58tn6cMj2sIzwJl8fWaJJqkHb5IAgN55vMyM/4cuDMDSJbKiVSQYQMmilJ+5e4/2RZT5iCeUOo5hOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771625; c=relaxed/simple;
	bh=AIpo2iAQhlfbtifTE6AGWLwY3POUXuspD2JIcaNCeF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiSJWN0UeNFU9M8/cb43YCRnhO3tojFOGgZCOt7p8MTbhIHZ7wiqKD0gTcd1Sgnhc1j5yaLfN3wjfQdW4RuN40VNqqVw98uitMGsHhGOkzps8Srj361aHdl/yqbNdFYqp1yItniDvHe5y/aTjaFniROV4j4WtqZR1g1X0XMavnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hmDxM8Bi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o4a9DImu; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hmDxM8Bi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4a9DImu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35ECE7A012F;
	Wed, 22 Jul 2026 21:53:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jul 2026 21:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1784771622; x=1784858022; bh=yV8kr3p+6X
	/5U35/oJ57WcxCxbilvXhM5lKLd5vkd1U=; b=hmDxM8Bi3+fh5+n4+mslmpGHNv
	H1gtE6KAvPbJ4CRJRDBuT3Zbzknp8Sb3MHJFpHXl24ARTFlnAP3Guc1PxW8LOGig
	1v8Zd6BNxYGpPDdz+5rJDin72vGmR2I73nI4QNWbBDoh/670y4dVihIPE11BdpFR
	4AoVouY5N2HTHeIbKvqB6d0Cl1OAlBYF1U8htar+NM3JGoEasXXbrb5AtvcTYtN2
	AE/YEFJWjIc/IaTZdZDb5a8NwXVGRKgamsOtTFljbXVFMQVepQtkBxgeSMd5BJv+
	qYygl1sPE2l6YvW3LQHab/a9fmHbHgn45j4xHGLhJqCVl59LuzXhWz4ktDKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784771622; x=1784858022; bh=yV8kr3p+6X/5U35/oJ57WcxCxbil
	vXhM5lKLd5vkd1U=; b=o4a9DImuopQ3LiFuX2jQipCUIUKay8k5MENi3iZbEBQD
	/7XJ72qeALZcDoS1GDnQHAC1xLjVd/GB3pv/fu7rbQMU1Bkiu3ckFJTbIuxU4PiB
	lAK5VDLQ5Cn74gifFWJEm8u0X0KJb3wDf/lcV8g5Q/diEyP6YXLgsJ503lQOzXbb
	zpnqvcsyvgL2hus3+LfraDlZb68fNYUX90EiGEqGaFlTFUXu1ZBxWJhjVe6lwhyj
	yQi3QXXse9y1Yh7bLJmhk2OQtS2yrbQ3wEbQrAz8gtvME5eQj08Ezi5YdfKRMFer
	ryropsMreNJNXEhs41E6VONyMUpBBxotftwszTkN7A==
X-ME-Sender: <xms:JXRhaj4wQXLAlsF9CJ9VX3TTxWAqQqQaS0DfcdU7qcXUI1B6vTAW9A>
    <xme:JXRhakWM18KWGLtyTgBL_9OpmHLmaWl6barlWTt8XYyiQhcxz-Co73QuroLKNcdH1
    VT5iAnA9rYPZXijBD_ZlRs-BQ-uFtwRoTKUIbGhlWWpN1C22A>
X-ME-Received: <xmr:JXRhat_KU0tAjtXTSl6_zONDU3TsdSq18t1RSh-A3etZT0ibs1EOKC_cqcJA827Xxe37djzhbLr7HIxNwnZvpC3M12MaaI0>
X-ME-Proxy-Cause: dmFkZTEEcLEPnRs0lsbayDI0NKtJ9t0kgNssvwLtYyFulv7wA+jTnR3246Hbq8hbe7/1e6
    0OAdWwaOzOArkqp6/2qtrC9IAkv8Q95U/lZWEm99zbgMl4uBHrwvcC4Dg5YeIZ6bCgEOcP
    tk6XC0CHGQnIGT0XE2C7nHbNWzA6/zxzBWUr0FvkPpLq3BHLf0YNHp/dQ3XdpQluWKj7gH
    2IejgPkhOAES+j3dlt442f+DsgDMjojiRUcUsIR9XOOhYN+zxSNv79FgHdrIoxdM+ylyQD
    WZAMJxNMgUGPR+yMAPIkVsYk2MzwctQCjyN4Dvp9+jfIa0dcvUhHoBo5KCt5hXahZQ4hBx
    wQLvHODnopE95OcfWHHyBuyDGPzO8nzvLY0UgDLGBEV6s88QOjnALqo+662HOPUsZy8gF8
    DIW6KdddIcbYR/HdS318Zo5/Bm97ZuCtElig+LmB73c+EtGxLS6SE/N4/ECxODEwxiYP7F
    wsYFE4RniSx/IUQBSLdlYvqjE9/RK8ScwA2Bkvtvji1KT5dUtDFNGWukuEfbSVf9tt68Nx
    39/7rIId3uIXTL3HN76fPi4ieBRkdydiN7Xo+Wa/idtBNJQSb9db236bvmqFd3D7E72gqW
    46TSlyD3io8gm/0cVMPoQ7jVH+NUZg7MfuL2DEWp0xjPTasvK6KPk+6mH7jg
X-ME-Proxy: <xmx:JXRhaomhst3mW3UMxenEl4UAz0dZIrdSRbX_UK2yQ43Qw-RYJ5ZYjw>
    <xmx:JXRhajVwjj2LgTtMVxrh_LL1-Vv-HkCw-0HRNnVhA4CZ2oNrqbrBkA>
    <xmx:JXRhatGO8hoX3zGYi-O-pvI96O0woo1YvyFpBW4qgXb-RaDMtej70w>
    <xmx:JXRhavdRWIG63obZb9P1vnyMEsUFqTUk0Kvn8ziYgipQtHQ6fY6odQ>
    <xmx:JnRhalrUZe3CZhieYbTfyIf3gammQz4Nhx_WjtWC2BaDp_J-TBR9fgcU>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 21:53:40 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/4] VFS: prepare for changes to directory locking
Date: Thu, 23 Jul 2026 11:49:45 +1000
Message-ID: <20260723015330.3093207-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks a lot to Christian for the review.  I have address all this
issues found.

Original intro, slightly modified:

These patches are part of some prep work to allow changes to directory
locking.
The short term goal is to invert the locking order between d_alloc_parallel() 
and inode_lock() so that d_alloc_parallel() can (only) be called without
holding inode_lock().  This particularly requires filesystems not to use 
d_drop() in the middle of an operation, which particularly requires the d_splice_alias()
change.

As it will require d_alloc_parallel() to NOT be called under the inode
lock, d_alloc_trylock() is added which CAN be used when failure is safe
(dcache priming in readdir).

Once these land upstream I can submit patches to various filesystems to
make use of them.  Then when filesystems are ready I can continue the
VFS changes.

Thanks,
NeilBrown


 [PATCH v2 1/4] VFS: fix various typos in documentation for
 [PATCH v2 2/4] VFS: enhance d_splice_alias() to handle hashed
 [PATCH v2 3/4] VFS: introduce d_alloc_trylock()
 [PATCH v2 4/4] VFS: add d_duplicate()
