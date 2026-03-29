Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFB4381B04;
	Sun, 29 Mar 2026 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802071; cv=none; b=LQR4OIeKNdKnDvge95Fuhjl0Km39W+MubGBCbQxmNPAb41s6Xna3Zux+URXCWw49mgXwORAO2vHDR+TS9fxNLUzQ1aRCRwbigUCMwlI+vB+Grv2zxPT8Fntop2u128YmL/dkUXwVFQbRzYCevsD6kHXNODWOaEpw/j39RX+HIB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802071; c=relaxed/simple;
	bh=xNYiNlokGMyWLi884sS3qr/UctzD+hmYePgcXSJOwio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lP/hHxxgjOiAh7S2zr/jj73Q/GaKIGStAwrWLMLrxiOK0zOXtduTE8nWhJZQ7WylWbmmeQ7A6XQJvy4nt6f1qvcpfIKNW5u0mQPnzqYpBHsMHXSsnqixPp+Czwh8PQxGm4DVDwC1QZfdA+xIWCCNV4zaD9wmS5xvd4G1Rd2YmV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UgZZJ4a7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UgZZJ4a7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AAEC4387;
	Sun, 29 Mar 2026 09:34:20 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 698923F915;
	Sun, 29 Mar 2026 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774802066; bh=xNYiNlokGMyWLi884sS3qr/UctzD+hmYePgcXSJOwio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UgZZJ4a72OJLQyIF5bZKVHx2Eu6jOqq/D0tONgjdNAbPH8BRRP83O7N5yD2e6dypL
	 hyOavwRkEi37i9mRqf+DwUX/h3gAkr6UftIOGPFP+uDO+oEWrXlTahnYpPFcLsD7se
	 bzaX2HXgfBoS1ickQxTXGaQ8RjX09qsrl0SanXK4=
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
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 04/24] firmware: arm_scmi: Allow protocols to register for notifications
Date: Sun, 29 Mar 2026 17:33:15 +0100
Message-ID: <20260329163337.637393-5-cristian.marussi@arm.com>
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

Allow protocols themselves to register for their own notifications and
provide their own notifier callbacks.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2-->v3
 - split out unrelated changes on event sizing
v1-->v2
 - Fixed multiline comment format
---
 drivers/firmware/arm_scmi/common.h    |  6 ++++++
 drivers/firmware/arm_scmi/driver.c    | 12 ++++++++++++
 drivers/firmware/arm_scmi/notify.c    |  6 +++---
 drivers/firmware/arm_scmi/protocols.h |  6 ++++++
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 44af2018e21d..7989c79e9bd9 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -17,6 +17,9 @@
 #include <linux/hashtable.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/property.h>
 #include <linux/refcount.h>
 #include <linux/scmi_protocol.h>
 #include <linux/spinlock.h>
@@ -529,5 +532,8 @@ static struct platform_driver __drv = {					       \
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv);
 void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
+int scmi_notifier_register(const struct scmi_handle *handle, u8 proto_id,
+			   u8 evt_id, const u32 *src_id,
+			   struct notifier_block *nb);
 int scmi_inflight_count(const struct scmi_handle *handle);
 #endif /* _SCMI_COMMON_H */
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 26f192b8d7a9..c4aefbeead62 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1655,6 +1655,17 @@ static void *scmi_get_protocol_priv(const struct scmi_protocol_handle *ph)
 	return pi->priv;
 }
 
+static int
+scmi_register_instance_notifier(const struct scmi_protocol_handle *ph,
+				u8 evt_id, const u32 *src_id,
+				struct notifier_block *nb)
+{
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+
+	return scmi_notifier_register(pi->handle, pi->proto->id,
+				      evt_id, src_id, nb);
+}
+
 static const struct scmi_xfer_ops xfer_ops = {
 	.xfer_get_init = xfer_get_init,
 	.reset_rx_to_maxsz = reset_rx_to_maxsz,
@@ -2223,6 +2234,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	pi->ph.hops = &helpers_ops;
 	pi->ph.set_priv = scmi_set_protocol_priv;
 	pi->ph.get_priv = scmi_get_protocol_priv;
+	pi->ph.notifier_register = scmi_register_instance_notifier;
 	refcount_set(&pi->users, 1);
 
 	/*
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 3e4c97ab7b61..2a8efdf0bab8 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1389,9 +1389,9 @@ static int scmi_event_handler_enable_events(struct scmi_event_handler *hndl)
  *
  * Return: 0 on Success
  */
-static int scmi_notifier_register(const struct scmi_handle *handle,
-				  u8 proto_id, u8 evt_id, const u32 *src_id,
-				  struct notifier_block *nb)
+int scmi_notifier_register(const struct scmi_handle *handle,
+			   u8 proto_id, u8 evt_id, const u32 *src_id,
+			   struct notifier_block *nb)
 {
 	int ret = 0;
 	u32 evt_key;
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index f51245aca259..3e7b6f8aa72c 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -166,6 +166,9 @@ struct scmi_proto_helpers_ops;
  *	  can be used by the protocol implementation to generate SCMI messages.
  * @set_priv: A method to set protocol private data for this instance.
  * @get_priv: A method to get protocol private data previously set.
+ * @notifier_register: A method to register interest for notifications from
+ *		       within a protocol implementation unit: notifiers can
+ *		       be registered only for the same protocol.
  *
  * This structure represents a protocol initialized against specific SCMI
  * instance and it will be used as follows:
@@ -185,6 +188,9 @@ struct scmi_protocol_handle {
 	const struct scmi_proto_helpers_ops *hops;
 	int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv);
 	void *(*get_priv)(const struct scmi_protocol_handle *ph);
+	int (*notifier_register)(const struct scmi_protocol_handle *ph,
+				 u8 evt_id, const u32 *src_id,
+				 struct notifier_block *nb);
 };
 
 /**
-- 
2.53.0

