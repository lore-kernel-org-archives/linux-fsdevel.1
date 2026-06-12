Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2A3D6CD9;
	Fri, 12 Jun 2026 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304044; cv=none; b=ERguHGOUJFBB+wPURnqIwS6wxluLgNawB+G83Dz7kjlJoPlxwfqt2chmgRzMRXlTebq2XpzTJctd0p9XFtOm8VsmfW1gD4vxOLZ0To8Wixed0U695GAhd8sU15YDzujguHoRWTIAW8VHaK3fi+/S/QVhDuKaz/uWwBzzI0iNcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304044; c=relaxed/simple;
	bh=rYNWoT8FgHcrkaH/pzU7XRjAp+88/ymTw1A/6aJvCgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmPAJkzvxslaCh0uukgXxUMO920CJf+6j+4FGAB7q5Z6l9+StCHeyNYG07uY/K3tTBOm150Jdkr8ONwJEfKjyZUC3OOvL4oCV09vJmjF5mpxWJGeI3shdCa9EsYeqmf8AWXWHRMRNBCKzhdtZ108GalvMj+Bmq1xgZZoO06MGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IlSb6Qi3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IlSb6Qi3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E707049FF;
	Fri, 12 Jun 2026 15:40:37 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89A993FB7F;
	Fri, 12 Jun 2026 15:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781304042; bh=rYNWoT8FgHcrkaH/pzU7XRjAp+88/ymTw1A/6aJvCgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlSb6Qi3U8df8DpFzhjdlpV4dfBvQ7A5sFn5af0QwPfcOND3YFNyqwgsQofD5VlhU
	 +72gUw0PL+Rm+OzXwnicYGZ0+T13jqeFnNaIfUYBHRhbYYc1fbr+yMFycJR2Fny8RW
	 E8M3XA+R2onW7E9o4S5kVecMMcNWPMe2CRkrAJac=
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
Subject: [PATCH v4 30/31] fs/stlmfs: Document lazy mode and related mount option
Date: Fri, 12 Jun 2026 23:38:00 +0100
Message-ID: <20260612223802.1337232-31-cristian.marussi@arm.com>
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

Document optional lazy enumeration behaviour and related mount option.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/filesystems/stlmfs.rst | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/stlmfs.rst b/Documentation/filesystems/stlmfs.rst
index b5b3cd649775..fe69d40f9249 100644
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
@@ -128,6 +132,19 @@ Note that all of the above options are explicitly designed NOT to support
 a remount operation, so as not have surprising effects on permissions of
 already discovered/created telemetry files.
 
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
 Usage
 =====
 
-- 
2.54.0

