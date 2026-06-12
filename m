Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B533D5643;
	Fri, 12 Jun 2026 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303968; cv=none; b=XuqSp757nImibh0IK5tyYeMhZ2ZrUwVmQP7RdlGA3g7NrvE2w+DULlnmEeVnNVWsY2MId7V+jioqoGIjGMozY2XosrX7xviNAQEnibpNoiJn/ryp1GelEWDYAyrxyxL8q7QE8qbl0ux4G24M7IOEdV5G/NrQ+8r4g8o72Q9WLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303968; c=relaxed/simple;
	bh=6DjI1kgux2mnVZFMXBbGKBzDD7dwhgizdEAqJnh03lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joAgULHyDpNomQX5LfdRIervfUc0wLbY4yEUB87BVVB5SMUDC2dAl5vWSFaDkZZ2XS98FGok/8voXk4gk72Wzc868MjUtsxheGYSpC2uKKLR0Sgfvw21oeDrd3qx1bm65/rWxWP4l6iJmRueuFnMBHn0iIlBar7AutZ4NgzXB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bGdvryts; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bGdvryts"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 628E34A09;
	Fri, 12 Jun 2026 15:39:21 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 362D63FB7F;
	Fri, 12 Jun 2026 15:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781303966; bh=6DjI1kgux2mnVZFMXBbGKBzDD7dwhgizdEAqJnh03lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bGdvrytsv8ed+7rDvRoN3rff1b7+jUxC1zzYr2si/aSvwdGcWltpqAGSu/4ExjHKP
	 baaTYy8+ovR9YUWzmw9UKG9h2i+olwcRztiIn1hVEqVHzyczWWIjqrSg8kQ95JawAS
	 ePjtvvAKRWRCOjFWhDeTjDSfEh75oHglEbWJKM6E=
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
Subject: [PATCH v4 12/31] firmware: arm_scmi: Add support for Telemetry reset
Date: Fri, 12 Jun 2026 23:37:42 +0100
Message-ID: <20260612223802.1337232-13-cristian.marussi@arm.com>
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

Add support for Telemetry operations needed to request platform to
reset telemetry current configuration and data events values.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
 - reset tracked Telemetry DE state
v2 --> v3
 - split from monolithic Telemetry patch
 - use scmi_telemetry_de_unlink
---
 drivers/firmware/arm_scmi/telemetry.c | 47 +++++++++++++++++++++++++++
 include/linux/scmi_protocol.h         |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
index 87c3151909be..f88650916de8 100644
--- a/drivers/firmware/arm_scmi/telemetry.c
+++ b/drivers/firmware/arm_scmi/telemetry.c
@@ -2516,6 +2516,52 @@ static int scmi_telemetry_des_sample_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static void scmi_telemetry_local_resources_reset(struct telemetry_info *ti)
+{
+	struct scmi_telemetry_res_info *rinfo;
+
+	/* Get rinfo as it is...without triggering an enumeration */
+	rinfo = __scmi_telemetry_resources_get(ti);
+	/* Clear all local state...*/
+	for (int i = 0; i < rinfo->num_des; i++) {
+		rinfo->des[i]->enabled = false;
+		rinfo->des[i]->tstamp_enabled = false;
+
+		scmi_telemetry_de_unlink(rinfo->des[i]);
+	}
+	for (int i = 0; i < rinfo->num_groups; i++) {
+		rinfo->grps[i].enabled = false;
+		rinfo->grps[i].tstamp_enabled = false;
+		rinfo->grps[i].current_mode = SCMI_TLM_ONDEMAND;
+		rinfo->grps[i].active_update_interval = 0;
+	}
+
+	atomic_set(&ti->des_enabled[ENA_STATE], 0);
+	atomic_set(&ti->des_enabled[ENA_TSTAMP], 0);
+}
+
+static int scmi_telemetry_reset(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, TELEMETRY_RESET, sizeof(u32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(0, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		struct telemetry_info *ti = ph->get_priv(ph);
+
+		scmi_telemetry_local_resources_reset(ti);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static const struct scmi_telemetry_proto_ops tlm_proto_ops = {
 	.info_get = scmi_telemetry_info_get,
 	.de_lookup = scmi_telemetry_de_lookup,
@@ -2527,6 +2573,7 @@ static const struct scmi_telemetry_proto_ops tlm_proto_ops = {
 	.de_data_read = scmi_telemetry_de_data_read,
 	.des_bulk_read = scmi_telemetry_des_bulk_read,
 	.des_sample_get = scmi_telemetry_des_sample_get,
+	.reset = scmi_telemetry_reset,
 };
 
 /**
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f4ba5aa618a7..06baa4ddc55f 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -964,6 +964,7 @@ struct scmi_telemetry_de_sample {
  *		    the ones belonging to a specific group when provided.
  *		    This causes an immediate update platform-side of all the
  *		    enabled DEs.
+ * @reset: reset configuration and telemetry data.
  */
 struct scmi_telemetry_proto_ops {
 	const struct scmi_telemetry_info __must_check *(*info_get)
@@ -990,6 +991,7 @@ struct scmi_telemetry_proto_ops {
 	int __must_check (*des_sample_get)(const struct scmi_protocol_handle *ph,
 					   int grp_id, int *num_samples,
 					   struct scmi_telemetry_de_sample *samples);
+	int (*reset)(const struct scmi_protocol_handle *ph);
 };
 
 /**
-- 
2.54.0

