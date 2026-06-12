Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB153FF1A2;
	Fri, 12 Jun 2026 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304010; cv=none; b=DerLCUs4qcc8LvPeLqXMKWEpCBSBCcDkfQH0TWoNFUOfVroPEJPDGiXCsMvQ8Q5wSmwfT2dTE8+x80wvv6OXjIs2FHNEOhB9wO9DACxoj9Kcbl8r4KWSRuc8Rp2g6Q7WmLvewzwAg4q2LnnfDNHxkKxi4z/vacW3liXX8VusvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304010; c=relaxed/simple;
	bh=2xFb0yd4e6PVKxK1zP38kbrj0J9BwkRIv50r5RQ9dow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2Kk625Y3ARDlfWWXPK1p76B2s9n7sEE3C5NeoTZ8UOCNdpYn1foyqo8gAbZ+lOaWRIweXL/tbYqHXRTdHoDKGIIOQBAu+RvBTVxO4Lay/7nu5l09tsn0fpeVM09DLspDHe6SZTYErlcl4o4tkuk4Mooke+Q0MPtXl2/taPnR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Zg39thJA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Zg39thJA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE71A49FF;
	Fri, 12 Jun 2026 15:40:03 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 819793FB7F;
	Fri, 12 Jun 2026 15:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781304008; bh=2xFb0yd4e6PVKxK1zP38kbrj0J9BwkRIv50r5RQ9dow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zg39thJAVlH1mNgA7oz/sukNr8YuChQlDHrmMcSoZg3Nqgwu1/RKQWwk+GSPDjTaZ
	 NorWhjJuK/qCOs8QQmmQRW/gSDlNVCul15/5M3CBJv1f5EXS9Acuwl/KR7W8LnV2OW
	 Hd1smxlreZ9G+NW02ok43EkvlqO5OZDUgvWae7a4=
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sudeep.holla@kernel.org,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	d-gole@ti.com,
	jic23@kernel.org,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	brauner@kernel.org,
	souvik.chakravarty@arm.com,
	leitao@kernel.org,
	kas@kernel.org,
	puranjay@kernel.org,
	usama.arif@linux.dev,
	kernel-team@meta.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 22/31] fs/stlmfs: Document ARM SCMI Telemetry FS mount options
Date: Fri, 12 Jun 2026 23:37:52 +0100
Message-ID: <20260612223802.1337232-23-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612223802.1337232-1-cristian.marussi@arm.com>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detail ARM SCMI Telemetry filesystem available mount options.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/filesystems/stlmfs.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/filesystems/stlmfs.rst b/Documentation/filesystems/stlmfs.rst
index 123e0e68e041..a15da85b9971 100644
--- a/Documentation/filesystems/stlmfs.rst
+++ b/Documentation/filesystems/stlmfs.rst
@@ -109,6 +109,25 @@ sense to allow this FS to be mounted inside a container.
 All files are created world readable and, where needed for configuration,
 owner writable.
 
+Mount Options
+=============
+
+This FS supports the typical mount options needed to modify, at mount time, the
+ownership of the root and all of the underlying inodes:
+
+ - uid: id of the owner of the root inode and all of the files subsequently
+	created under it
+
+ - gid: id of the group of the root inode and all of the files subsequently
+	created under it
+
+ - umask: a standard umask filter to be applied to user/group/other: defaults
+	  to 00222
+
+Note that all of the above options are explicitly designed NOT to support
+a remount operation, so as not have surprising effects on permissions of
+already discovered/created telemetry files.
+
 Usage
 =====
 
-- 
2.54.0

