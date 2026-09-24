Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731764A6CFA;
	Thu, 24 Sep 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275163; cv=none; b=GhVuS2dCvgBPsAJ8jvXk/H2zH/xQOl9UJO3b5H0XrFzO5rCIpmm12iEUD/tniQegVhxTgBXDrlIJ56lP2TWcnyaA9GoXCyCPUVrSEMI0HTPxtl3O1uv6SsXJ2mfsh9PVQxalsDZDs12L0Tnede4Zs8wsjIybEVDVI7v+jmwv/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275163; c=relaxed/simple;
	bh=H8nJJMWb76cMSITdXNTuNSHyaz4PlCKWuq8Jt9yIEaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGJ9zhiBlwRMqo+QeuAmUAadZEW+KojDOigJnI5ylcqmIafPxbl1K0xDvaiRXyN51FawVFXTeemvD5OSUR1GBXrPGWi4lGovhiMsBDRdmaBkS3BsTtoPWo4f00k2af5mrPtWxSydw8v4wkJ8hjRUgVJJwN7QZB4Ndzlfa/OnARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bNRPrvLp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bNRPrvLp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EWUuZjtfyyshoxjyvMybysFX9YL9S9gbnNs6T/X/oBE=; b=bNRPrvLp/EbD8vs0Ot3fA78ajJ
	XYT+pzlo+tEElsrTEiYvRMpyUdUvSLj/6kbYbdjqnnQ0AIoFv3otD0tc9ryMFke7OaQXFFq5OzK3/
	0jFQLDSklw46oj1ScIZXb5L8YPfp4QscyVO0qq7B+0n3DeBFrJJV+tjCuAnjGm9ydj7EPL9DOT9BZ
	mbFYTYTB3w21foQPVwwNugwKzhcT1PoMncWrB1G8xWwAcxnr88XIkzWSSa2hrAn7X9GITURdcBN7G
	pHUyff0TGsIJycY/d4PrBsbvlWyQ12fO0xCWzyLs9Le3odn4Lo/Ph7rh1d+I9UxROIaxpcRPtF9OX
	JuV6XwoA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9oLl-0000000BvJF-1Ksf;
	Thu, 24 Sep 2026 18:39:17 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH] fs: porting.rst: use literal string to avoid warning
Date: Thu, 24 Sep 2026 11:39:15 -0700
Message-ID: <20260924183915.400588-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid the docutils warning:

Documentation/filesystems/porting.rst:1417: WARNING: Inline emphasis start-string without end-string. [docutils]

by quoting the const pointer in literal quotation marks.
(Adding a space between the '*' and the '.' also works but it looks odd.)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609231806.ILZP6Fy0-lkp@intel.com/
Fixes: 025756ee7b47 ("fs: port mnt_idmap() and file_mnt_idmap() to const mnt_idmap")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 Documentation/filesystems/porting.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260923.orig/Documentation/filesystems/porting.rst
+++ linux-next-20260923/Documentation/filesystems/porting.rst
@@ -1418,7 +1418,7 @@ All struct mnt_idmap pointers handed to
 ->create(), ->mkdir(), ->mknod(), ->symlink(), ->rename(), ->setattr(),
 ->getattr(), ->permission(), ->tmpfile(), ->get_acl(), ->set_acl() and
 ->fileattr_set() as well as the xattr ->set() handler and the vfs_*()
-helpers take a const struct mnt_idmap *. mnt_idmap() and file_mnt_idmap()
+helpers take a ``const struct mnt_idmap *``. mnt_idmap() and file_mnt_idmap()
 return one. The idmapping is immutable so nothing should have modified it
 anyway. References are taken and dropped via mnt_idmap_get() and
 mnt_idmap_put() as before, both accept a const pointer.
