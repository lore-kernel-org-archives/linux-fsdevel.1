Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7FC38228E;
	Sun, 29 Mar 2026 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802131; cv=none; b=WYRduX4YqL8ZoNJ/ykk0u7dSG4jGu1oiEXjIuM5blXwy3GcDFPBb1MQ0a2zo3oqwRLWo+IyTyPNctAbsTyvO4JfFsf3XdAs4S7bYXd3CDdj5aPE6t2FHvuMdCP8KLaoZ3gzzlzs2kKJHdkp4iFInwCMr+0ybUYzBYAgeaCoRU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802131; c=relaxed/simple;
	bh=6wzddMfUQyGGtHJTwF0gZAbRgVKVvLunzYpai4YkSBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7zzU3Ywg/aYclJ+otpLE3uw9qPHck07LsE4Rv4qdBGTcQ8T+vcBL8Z32WKm14H7dMT57+/BLgMSuQ3YWN9B/XleQE97fP0puKf2toaC1UwrHaawSFwbVchv00miJZX6xhe4mg89PrI1Cwk0vdd0+NWGPF/MIa1XW5d4hy2BEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pSeNA74C; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pSeNA74C"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA605451B;
	Sun, 29 Mar 2026 09:35:23 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FAFF3F915;
	Sun, 29 Mar 2026 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774802129; bh=6wzddMfUQyGGtHJTwF0gZAbRgVKVvLunzYpai4YkSBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSeNA74CAx7djO856jVtla60xS71CAxUgKCgH3O1AA3gBb8aLRUH8PRRntLS/wqVz
	 jDkwRcetmJ7imYb5jLHgT+JQ/8EM8YUza9rBSVnA5b6My9oejxtTv5aGE3KQ9VnAST
	 ge0ZnfIRC8AHAn+FcfQGL/cmqZm0GNHEo/is6ZNk=
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
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	jonathan.cameron@huawei.com,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	brauner@kernel.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 23/24] fs/stlmfs: Document lazy mode and related mount option
Date: Sun, 29 Mar 2026 17:33:34 +0100
Message-ID: <20260329163337.637393-24-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329163337.637393-1-cristian.marussi@arm.com>
References: <20260329163337.637393-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document optional lazy enumeration behaviour and related mount option.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/filesystems/stlmfs.rst | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/stlmfs.rst b/Documentation/filesystems/stlmfs.rst
index a775da24f320..9a5c8bf588c8 100644
--- a/Documentation/filesystems/stlmfs.rst
+++ b/Documentation/filesystems/stlmfs.rst
@@ -74,8 +74,12 @@ Design
 STLMFS is a pseudo filesystem used to expose ARM SCMI Telemetry data
 discovered dynamically at run-time via SCMI.
 
-Inodes are all dynamically created at mount-time from a dedicated
-kmem_cache based on the gathered available SCMI Telemetry information.
+Normally all of the top level file/inodes are dynamically created at
+mount-time from a dedicated kmem_cache based on the gathered available
+SCMI Telemetry information, but it is possible to enable a lazy enumeration
+and FS population mode that delays SCMI Telemetry resources enumerations
+and related FS population till the moment a user steps into the related FS
+subdirectories: *des/* *groups/* and *components/*.
 
 Since inodes represent the discovered Telemetry entities, which in turn are
 statically defined at the platform level and immutable throughout the same
@@ -105,6 +109,19 @@ The filesystem can be typically mounted with::
 
 	mount -t stlmfs none /sys/fs/arm_telemetry
 
+It is possible to mount it in lazy-mode by using the *lazy* mount option::
+
+	mount -t stlmfs -o lazy none /sys/fs/arm_telemetry
+
+In this latter case, the des/ groups/ and components/ directory will be
+created empty at mount-time and only filled later when 'walked in'.
+
+This allows a user to benefit from a lazy enumeration scheme of the SCMI
+Telemetry resources by delaying such, usually expensive, message exchanges
+to the last possible moment: ideally, even never, if using some of the
+other alternative binary interfaces that does not need any resource
+enumeration at all.
+
 It will proceed to create a top subdirectory for each of the discovered
 SCMI Telemetry instances named as 'tlm_<N>' under which it will create
 the following directory structure::
-- 
2.53.0

