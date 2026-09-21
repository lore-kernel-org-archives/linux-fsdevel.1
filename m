Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5049E125
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996743; cv=none; b=U9PYJj4nv5mn4MfNqv5TbapfuqsgD5PB6VLwCJhdKeASla+qK9ZOVWufKOAWDsfc6qffb44rZ+JYZ5MxrQH+eOLn4vpWvo5NuY13QkEbkekIn3Q9m85STGY1VD9twynE44ntVqrDnJZfimTamzaevKsc1qdwBW3gavedbuG7qNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996743; c=relaxed/simple;
	bh=PP/UA9DZTMlohJF2e0sfCQInzKdt7ty+8kyileMSwhQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SreyTwixWGRSY80MczOFHyKoqApc/Te4NM+pApb2ABcyZwILfpqurnzTqtZ0Yj6TWgXhZUDBd0SRX2mcnSsaYBCQAvsaMa5phZ+6vHxvbi9xmxrHUZyxnf377EUjPROUY4JUunlpBIsvRCmqSS8jqx3nMJgnyfOh8KpLwwPezHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFbqzAEi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFbqzAEi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789996740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=hA1yIzJyVOqp+vZk8oFdogzKme/kn28gpuZZqIjrFOY=;
	b=cFbqzAEigE0+UrTjWSmcl+SB6yZsXkyaDD94yY7dCps4B21NriJFb6m+zWKNQjPIJW9Sbc
	VnQGIJImxVsfozAhUoKgUxslacADvbB9hydSlUdcCK/zlDIx8dx6RPTQIoqqAmYdQM82ok
	lwch4lA0ZOJMS18Uy+TywwJh3BlkQEQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-JM9G5LDZMKecH_dqP8iM0g-1; Mon,
 21 Sep 2026 09:18:56 -0400
X-MC-Unique: JM9G5LDZMKecH_dqP8iM0g-1
X-Mimecast-MFC-AGG-ID: JM9G5LDZMKecH_dqP8iM0g_1789996735
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0568C195421A;
	Mon, 21 Sep 2026 13:18:55 +0000 (UTC)
Received: from ws (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF165180036E;
	Mon, 21 Sep 2026 13:18:52 +0000 (UTC)
Date: Mon, 21 Sep 2026 15:18:49 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.42.4
Message-ID: <hy3amg4hnijtbmtfjcpc2t5p34us2jifxpsomofnlh7ngxkt7k@4tovqvsxvcnd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The util-linux release v2.42.4 is now available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.42/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel



util-linux 2.42.4 Release Notes
===============================

This release enhances previously released security fixes and adds protection
against symlink attacks in the legacy mount(2)-based code in libmount.


Changes between v2.42.3 and v2.42.4:

libblkid:
    - minix don't detect erofs images as minix (by Clayton Craft)

lib/fileutils:
    - add safe FD-path and no-symlink helpers (by Karel Zak)
    - fix RESOLVE_NO_SYMLINKS fallback value (by Karel Zak)
    - fix unused parameter warnings without SYS_openat2 (by Karel Zak)

libmount:
    - add mnt_fs_fetch_ids() and populate uniq_id for utab (by Karel Zak)
    - use fchmodat2() for X-mount.mode= (by Karel Zak)
    - restore the original namespace on error paths (by Karel Zak)
    - secure the idmapped mount replacement (by Karel Zak)
    - pin the legacy mount target and bind/move source (by Karel Zak)
    - harden restricted mount targets and post-mount handling (by Karel Zak)
    - fix X-mount.idmap ID names in code and man page (by Karel Zak)
    - use USE_LIBMOUNT_MOUNTFD_SUPPORT for idmap hook (by Karel Zak)
    - add missing fileutils.h include to hook_idmap.c (by Karel Zak)

mount:
    - fix grammar and typo in X-mount.idmap documentation (by Karel Zak)

nsenter:
    - close cgroup.procs fd after join to prevent authority leak [CVE-2026-78408] (by Karel Zak)

po:
    - merge changes (by Karel Zak)
    - update sv.po (from translationproject.org) (by Daniel Nylander)
    - update nl.po (from translationproject.org) (by Benno Schulenberg)

po-man:
    - merge changes (by Karel Zak)
    - update sv.po (from translationproject.org) (by Daniel Nylander)

tools:
    - add non-newmount.conf config-gen profile (by Karel Zak)

