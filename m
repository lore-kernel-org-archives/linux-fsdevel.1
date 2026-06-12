Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E492D384250;
	Fri, 12 Jun 2026 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303928; cv=none; b=IoM9ZguECcCC8OG1QHm6oD9AzHZuVNRtIjLyMvQAPmLOTiU69IeVIn4CBHGmyGSjE7cFvL3F+C7K4HFbYDX77zyJ5Xal2lO9yr57jyfK41ujwImOVAHncg93vMGLNUqtfmccfndHRRFBK02PTFeqotS0RHmvCH4LxtQbNRG/zQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303928; c=relaxed/simple;
	bh=kERIHBTqo+45BsoHlnrL4Ov7/lPYVch35gHn4ON5zrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAmrS+X1tqmBA1UrTaEDFL1NTPe3sQwNrqjsOoGI8X8tT6D7JSI/7XxIKx5WsHDgvK76uMbJn+6henZukHGF8/M/Zx0Uls0lkEBDOc+AFD70C0Mcdz8qDTGnFb55Io57+33ORsC9EhmWVPdeav4EJ00rJwJ0p2w28gTL8R5FvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vOhrDFz5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vOhrDFz5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8223F3543;
	Fri, 12 Jun 2026 15:38:38 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48B703FB7F;
	Fri, 12 Jun 2026 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781303923; bh=kERIHBTqo+45BsoHlnrL4Ov7/lPYVch35gHn4ON5zrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOhrDFz54vuokxrQlNWbI8VSRGX57QG3DZ/v+VJNXvN66bM53FRztFbMFsiFr3lPb
	 Mi/EIM5LgQlU22JA4Acwx+oNJdebbUiyllggSdkg/npRm16F6hU6X3n2RlaN5K+qHt
	 Y8YspYEY9ufqsNVqSJ0UUpcPnCVYWVKrCvorYufc=
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
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 02/31] firmware: arm_scmi: Reduce the scope of protocols mutex
Date: Fri, 12 Jun 2026 23:37:32 +0100
Message-ID: <20260612223802.1337232-3-cristian.marussi@arm.com>
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

Currently the mutex dedicated to the protection of the list of registered
protocols is held during all the protocol initialization phase.

Such a wide locking region is not needed and causes problem when trying to
initialize notifications from within a protocol initialization routine.

Reduce the scope of the protocol mutex.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1-->v2
 - Fixed improper mixed usage of cleanup and goto constructs
---
 drivers/firmware/arm_scmi/driver.c | 50 ++++++++++++++----------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index f167194f7cf6..2ee4cad1f93d 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -17,6 +17,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/export.h>
@@ -2190,7 +2191,6 @@ static void scmi_protocol_version_initialize(struct device *dev,
  * all resources management is handled via a dedicated per-protocol devres
  * group.
  *
- * Context: Assumes to be called with @protocols_mtx already acquired.
  * Return: A reference to a freshly allocated and initialized protocol instance
  *	   or ERR_PTR on failure. On failure the @proto reference is at first
  *	   put using @scmi_protocol_put() before releasing all the devres group.
@@ -2236,8 +2236,10 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	if (ret)
 		goto clean;
 
-	ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1,
-			GFP_KERNEL);
+	/* Finally register the initialized protocol */
+	mutex_lock(&info->protocols_mtx);
+	ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1, GFP_KERNEL);
+	mutex_unlock(&info->protocols_mtx);
 	if (ret != proto->id)
 		goto clean;
 
@@ -2284,27 +2286,25 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 static struct scmi_protocol_instance * __must_check
 scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 {
-	struct scmi_protocol_instance *pi;
 	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol *proto;
 
-	mutex_lock(&info->protocols_mtx);
-	pi = idr_find(&info->protocols, protocol_id);
-
-	if (pi) {
-		refcount_inc(&pi->users);
-	} else {
-		const struct scmi_protocol *proto;
+	scoped_guard(mutex, &info->protocols_mtx) {
+		struct scmi_protocol_instance *pi;
 
-		/* Fails if protocol not registered on bus */
-		proto = scmi_protocol_get(protocol_id, &info->version);
-		if (proto)
-			pi = scmi_alloc_init_protocol_instance(info, proto);
-		else
-			pi = ERR_PTR(-EPROBE_DEFER);
+		pi = idr_find(&info->protocols, protocol_id);
+		if (pi) {
+			refcount_inc(&pi->users);
+			return pi;
+		}
 	}
-	mutex_unlock(&info->protocols_mtx);
 
-	return pi;
+	/* Fails if protocol not registered on bus */
+	proto = scmi_protocol_get(protocol_id, &info->version);
+	if (!proto)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return scmi_alloc_init_protocol_instance(info, proto);
 }
 
 /**
@@ -2335,10 +2335,11 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct scmi_protocol_instance *pi;
 
-	mutex_lock(&info->protocols_mtx);
-	pi = idr_find(&info->protocols, protocol_id);
-	if (WARN_ON(!pi))
-		goto out;
+	scoped_guard(mutex, &info->protocols_mtx) {
+		pi = idr_find(&info->protocols, protocol_id);
+		if (WARN_ON(!pi))
+			return;
+	}
 
 	if (refcount_dec_and_test(&pi->users)) {
 		void *gid = pi->gid;
@@ -2357,9 +2358,6 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
 		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
 			protocol_id);
 	}
-
-out:
-	mutex_unlock(&info->protocols_mtx);
 }
 
 void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
-- 
2.54.0

