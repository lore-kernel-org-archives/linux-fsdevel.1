Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C943B3FF;
	Fri, 24 Jul 2026 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904379; cv=none; b=shZcM4xBULol4xdki/IwFqVGxR3SSxcqY+lSXnNpUKosOL6hKrjeryZpqU/RKcH+rr8Xtr4HCJIfOR3jRGhxMHiVpTuyAxO6VRkbhOPwhDfmy2yFWHqOQIAgs0tu+j8V0ZOVgH4gsBx9sCvZumbEET/iQT2e47+gn4+obncfnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904379; c=relaxed/simple;
	bh=isgKOwgvIXg95jQKBvyD6at5aAIOIoZ46ko5FqtTmJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/fr/lAalIelSQF/1ooYgSvbnK7UxKZy2q4rsxno3fST/KNBqW8D6LwUGdsqos8/tjEr7fDYbkYRtjU8Vy/fPWiLbvE/jRkXfPbYDSX6Mwsm67DFgY3lqJ5gTm/hamL8Dz18ZbQ1xvlaB5FwUEjEvQBKuH5LFONgGHmkmBpwCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VUw3AkVa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VUw3AkVa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CD2F1684;
	Fri, 24 Jul 2026 07:46:06 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D11B93F66F;
	Fri, 24 Jul 2026 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784904370; bh=isgKOwgvIXg95jQKBvyD6at5aAIOIoZ46ko5FqtTmJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUw3AkVaac9FAGRcx3AAaRxuNzqVGlnM+yAXxqisoZDyy8MKmeAFyhAbGFIXnyM8R
	 gYiuj3fqgEdrbUUhBvhCbQe6cCwVdy2ZWjW5FVxS6xui1LBKnxq9jsMhGAC7+Mc2z+
	 kGckiFDFbVsIOb+LMV/wYLMXaYRsPFjWyZXEAT2M=
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
	david@kernel.org,
	subrahmanya.lingappa@oss.qualcomm.com,
	leitao@kernel.org,
	kas@kernel.org,
	puranjay@kernel.org,
	usama.arif@linux.dev,
	kernel-team@meta.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v6 08/22] firmware: arm_scmi: Add Telemetry configuration operations
Date: Fri, 24 Jul 2026 15:44:16 +0100
Message-ID: <20260724144430.1440170-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724144430.1440170-1-cristian.marussi@arm.com>
References: <20260724144430.1440170-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for basic Telemetry configuration operations to selectively
enable or disable DataEvents monitoring.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v5 --> v6
 - constify a few booleans used as inpurt in telemetry_operations
 - fixes (some) Sashiko reviews
   https://sashiko.dev/#/patchset/20260703123601.381275-1-cristian.marussi%40arm.com?part=9
   - underflow on de_offs
   - SHMTI overflow checks
   - bail out on failed group scan
   - unlink comprising DEs on group disable
   - add boudnary check on message response parsing
v4 --> v5
 - use renamed grp_id instead of old id in group descriptors
 - remove useless grp_ignore param from collection_configure
- fixes sparse warnings
v3 --> v4
 - track configured Telemetry DE states
 - add aggregate Telemetry state query
v2 --> v3
 - split from monolithic Telemetry patch
 - simplify clenaup with scmi_telemetry_de_unlink
---
 drivers/firmware/arm_scmi/telemetry.c | 400 ++++++++++++++++++++++++++
 include/linux/scmi_protocol.h         |  17 ++
 2 files changed, 417 insertions(+)

diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
index b9b6df48ab6b..a40d031e591d 100644
--- a/drivers/firmware/arm_scmi/telemetry.c
+++ b/drivers/firmware/arm_scmi/telemetry.c
@@ -492,6 +492,9 @@ struct telemetry_info {
 static struct scmi_telemetry_res_info *
 __scmi_telemetry_resources_get(struct telemetry_info *ti);
 
+static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
+				     unsigned int shmti_id, enum scan_mode mode);
+
 static inline void
 scmi_telemetry_de_state_update(struct telemetry_info *ti, enum de_state state,
 			       bool *current_state, const bool next_state)
@@ -1810,10 +1813,407 @@ static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
 	return 0;
 }
 
+static int scmi_telemetry_group_state_update(struct telemetry_info *ti,
+					     struct scmi_telemetry_group *grp,
+					     const bool *enable, const bool *tstamp)
+{
+	struct scmi_telemetry_res_info *rinfo;
+
+	rinfo = ti->res_get(ti);
+	for (int i = 0; i < grp->info->num_des; i++) {
+		struct scmi_telemetry_de *de = rinfo->des[grp->des[i]];
+
+		if (enable)
+			scmi_telemetry_de_state_update(ti, ENA_STATE,
+						       &de->enabled, *enable);
+
+		if (tstamp && de->tstamp_support)
+			scmi_telemetry_de_state_update(ti, ENA_TSTAMP,
+						       &de->tstamp_enabled, *tstamp);
+	}
+
+	return 0;
+}
+
+static void scmi_telemetry_group_unlink(struct telemetry_info *ti,
+					struct scmi_telemetry_group *grp)
+{
+	struct scmi_telemetry_res_info *rinfo;
+
+	rinfo = ti->res_get(ti);
+	/* Unlink the related BLK_TS/UUID lines of DEs composing the group */
+	for (int i = 0; i < grp->info->num_des; i++)
+		scmi_telemetry_de_unlink(rinfo->des[grp->des[i]]);
+}
+
+static int
+scmi_telemetry_state_set_resp_process(struct telemetry_info *ti, void *obj,
+				      void *r, bool is_group)
+{
+	struct scmi_msg_resp_telemetry_de_configure *resp = r;
+	u32 sid = le32_to_cpu(resp->shmti_id);
+
+	/* Update DE SHMTI and offset, if applicable */
+	if (IS_SHMTI_ID_VALID(sid)) {
+		if (sid >= ti->num_shmti)
+			return -EPROTO;
+
+		/*
+		 * Update SHMTI/offset while skipping non-SHMTI-DEs like
+		 * FCs and notif-only.
+		 */
+		if (!is_group) {
+			struct telemetry_de *tde;
+			struct payload __iomem *payld;
+			struct scmi_telemetry_de *de = obj;
+			u32 de_offs;
+
+			de_offs = le32_to_cpu(resp->shmti_de_offset);
+			payld = ti->shmti[sid].base;
+			/* Check boundary first... */
+			if (de_offs + LINE_LENGTH_BYTES(payld) >=
+			    ti->shmti[sid].info.len)
+				return -EPROTO;
+
+			tde = to_tde(de);
+			/*...then assign */
+			tde->base = ti->shmti[sid].base;
+			tde->offset = de_offs;
+			/* A handy reference to the Epilogue updated */
+			tde->eplg = SHMTI_EPLG(&ti->shmti[sid]);
+
+			payld = tde->base + tde->offset;
+			if (USE_BLK_TS(payld) && !tde->bts) {
+				struct payload __iomem *bts_payld;
+				u32 bts_offs;
+
+				bts_offs = le32_to_cpu(resp->blk_ts_offset);
+				bts_payld = (bts_offs) ? tde->base + bts_offs : NULL;
+
+				/* Check SHMTI overflow on returned offset */
+				if (bts_payld &&
+				    SHMTI_OVERFLOWS(bts_payld, &ti->shmti[sid]))
+					return -ENOSPC;
+
+				tde->bts = scmi_telemetry_blkts_bind(ti->ph->dev,
+								     &ti->shmti[sid],
+								     payld,
+								     &ti->xa_lines,
+								     bts_payld);
+				if (WARN_ON(!tde->bts))
+					return -EPROTO;
+			}
+		} else {
+			int ret;
+
+			/*
+			 * A full SHMTI scan is needed when enabling a
+			 * group or its timestamps in order to retrieve
+			 * offsets: note that when group-timestamp is
+			 * enabled for composing DEs a re-scan is needed
+			 * since some DEs could have been relocated due
+			 * to lack of space in the TDCF.
+			 */
+			ret = scmi_telemetry_shmti_scan(ti, sid, SCAN_UPDATE);
+			if (ret) {
+				dev_err(ti->ph->dev,
+					"Failed group-scan of SHMTI ID:%d - ret:%d\n",
+					sid, ret);
+				return ret;
+			}
+		}
+	} else {
+		/* Unlink the related BLK_TS/UUID lines on disable */
+		if (!is_group)
+			scmi_telemetry_de_unlink(obj);
+		else
+			scmi_telemetry_group_unlink(ti, obj);
+	}
+
+	return 0;
+}
+
+static int __scmi_telemetry_state_set(const struct scmi_protocol_handle *ph,
+				      bool is_group, const bool *enable,
+				      bool *enabled_state, const bool *tstamp,
+				      bool *tstamp_enabled_state, void *obj)
+{
+	struct scmi_msg_resp_telemetry_de_configure *resp;
+	struct scmi_msg_telemetry_de_configure *msg;
+	struct telemetry_info *ti = ph->get_priv(ph);
+	struct scmi_telemetry_de *de = !is_group ? obj : NULL;
+	struct scmi_telemetry_group *grp = is_group ? obj : NULL;
+	unsigned int obj_id = !is_group ? de->info->id : grp->info->grp_id;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (!enabled_state || !tstamp_enabled_state)
+		return -EINVAL;
+
+	/* Is anything to do at all on this DE ? */
+	if (!is_group && (!enable || *enable == *enabled_state) &&
+	    (!tstamp || *tstamp == *tstamp_enabled_state))
+		return 0;
+
+	/*
+	 * DE is currently disabled AND no enable state change was requested,
+	 * while timestamp is being changed: update only local state...no need
+	 * to send a message.
+	 */
+	if (!is_group && !enable && !*enabled_state) {
+		if (de->tstamp_support)
+			scmi_telemetry_de_state_update(ti, ENA_TSTAMP,
+						       tstamp_enabled_state,
+						       *tstamp);
+
+		return 0;
+	}
+
+	ret = ph->xops->xfer_get_init(ph, TELEMETRY_DE_CONFIGURE,
+				      sizeof(*msg), sizeof(*resp), &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	/* Note that BOTH DE and GROUPS have a first ID field.. */
+	msg->id = cpu_to_le32(obj_id);
+	/* Default to disable mode for one DE */
+	msg->flags = DE_DISABLE_ONE;
+	msg->flags |= cpu_to_le32(FIELD_PREP(GENMASK(3, 3),
+				 is_group ? EVENT_GROUP : EVENT_DE));
+
+	if ((!enable && *enabled_state) || (enable && *enable)) {
+		/* Already enabled but tstamp_enabled state changed */
+		if (tstamp) {
+			/* Here, tstamp cannot be NULL too */
+			msg->flags |= cpu_to_le32(*tstamp ?
+					DE_ENABLE_WTH_TSTAMP : DE_ENABLE_NO_TSTAMP);
+		} else {
+			msg->flags |= cpu_to_le32(*tstamp_enabled_state ?
+					DE_ENABLE_WTH_TSTAMP : DE_ENABLE_NO_TSTAMP);
+		}
+	}
+
+	resp = t->rx.buf;
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		ret = scmi_telemetry_state_set_resp_process(ti, obj, resp, is_group);
+		if (!ret) {
+			/* Update cached state on success */
+			if (enable) {
+				if (!is_group)
+					scmi_telemetry_de_state_update(ti, ENA_STATE,
+								       enabled_state,
+								       *enable);
+				else
+					*enabled_state = *enable;
+			}
+			if (tstamp) {
+				if (!is_group) {
+					if (de->tstamp_support)
+						scmi_telemetry_de_state_update(ti, ENA_TSTAMP,
+									       tstamp_enabled_state,
+									       *tstamp);
+				} else {
+					*tstamp_enabled_state = *tstamp;
+				}
+			}
+
+			if (is_group)
+				scmi_telemetry_group_state_update(ti, grp, enable,
+								  tstamp);
+		}
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_telemetry_state_get(const struct scmi_protocol_handle *ph,
+				    const u32 *id, bool *enabled, bool *tstamp_enabled)
+{
+	struct telemetry_info *ti = ph->get_priv(ph);
+	struct scmi_telemetry_de *de;
+
+	if (!enabled || !tstamp_enabled)
+		return -EINVAL;
+
+	if (!id) {
+		/* Returning the all_des_* state */
+		*enabled =
+			(atomic_read(&ti->des_enabled[ENA_STATE]) == ti->info.base.num_des);
+		*tstamp_enabled =
+			(atomic_read(&ti->des_enabled[ENA_TSTAMP]) == ti->num_des_tstamp);
+
+		return 0;
+	}
+
+	de = xa_load(&ti->xa_des, *id);
+	if (!de)
+		return -ENODEV;
+
+	*enabled = de->enabled;
+	*tstamp_enabled = de->tstamp_enabled;
+
+	return 0;
+}
+
+static int scmi_telemetry_state_set(const struct scmi_protocol_handle *ph,
+				    bool is_group, u32 id, const bool *enable,
+				    const bool *tstamp)
+{
+	struct telemetry_info *ti = ph->get_priv(ph);
+	bool *enabled_state, *tstamp_enabled_state;
+	struct scmi_telemetry_res_info *rinfo;
+	void *obj;
+
+	rinfo = ti->res_get(ti);
+	if (!is_group) {
+		struct scmi_telemetry_de *de;
+
+		de = xa_load(&ti->xa_des, id);
+		if (!de)
+			return -ENODEV;
+
+		enabled_state = &de->enabled;
+		tstamp_enabled_state = &de->tstamp_enabled;
+		obj = de;
+	} else {
+		struct scmi_telemetry_group *grp;
+
+		if (id >= ti->info.base.num_groups)
+			return -EINVAL;
+
+		grp = &rinfo->grps[id];
+
+		enabled_state = &grp->enabled;
+		tstamp_enabled_state = &grp->tstamp_enabled;
+		obj = grp;
+	}
+
+	return __scmi_telemetry_state_set(ph, is_group, enable, enabled_state,
+					  tstamp, tstamp_enabled_state, obj);
+}
+
+static int scmi_telemetry_all_disable(const struct scmi_protocol_handle *ph,
+				      bool is_group)
+{
+	struct telemetry_info *ti = ph->get_priv(ph);
+	struct scmi_msg_telemetry_de_configure *msg;
+	struct scmi_telemetry_res_info *rinfo;
+	struct scmi_xfer *t;
+	int ret;
+
+	rinfo = ti->res_get(ti);
+	ret = ph->xops->xfer_get_init(ph, TELEMETRY_DE_CONFIGURE,
+				      sizeof(*msg), 0, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->flags = cpu_to_le32(DE_DISABLE_ALL);
+	if (is_group)
+		msg->flags |= cpu_to_le32(GROUP_SELECTOR);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		for (int i = 0; i < rinfo->num_des; i++)
+			scmi_telemetry_de_state_update(ti, ENA_STATE,
+						       &rinfo->des[i]->enabled,
+						       false);
+		if (is_group) {
+			for (int i = 0; i < ti->info.base.num_groups; i++) {
+				rinfo->grps[i].enabled = false;
+				scmi_telemetry_group_unlink(ti, &rinfo->grps[i]);
+			}
+		}
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int
+scmi_telemetry_collection_configure(const struct scmi_protocol_handle *ph,
+				    unsigned int res_id, const bool *enable,
+				    const unsigned int *update_interval_ms,
+				    const enum scmi_telemetry_collection *mode)
+{
+	bool tlm_enable, is_group = res_id != SCMI_TLM_GRP_INVALID;
+	enum scmi_telemetry_collection *current_mode, next_mode;
+	struct telemetry_info *ti = ph->get_priv(ph);
+	struct scmi_msg_telemetry_config_set *msg;
+	unsigned int *active_update_interval;
+	struct scmi_xfer *t;
+	__le32 interval;
+	u32 control;
+	int ret;
+
+	if (mode && *mode == SCMI_TLM_NOTIFICATION &&
+	    !ti->info.continuos_update_support)
+		return -EINVAL;
+
+	if (is_group && res_id >= ti->info.base.num_groups)
+		return -EINVAL;
+
+	if (!is_group) {
+		active_update_interval = &ti->info.active_update_interval;
+		current_mode = &ti->info.current_mode;
+	} else {
+		struct scmi_telemetry_res_info *rinfo;
+
+		rinfo = ti->res_get(ti);
+		active_update_interval =
+			&rinfo->grps[res_id].active_update_interval;
+		current_mode = &rinfo->grps[res_id].current_mode;
+	}
+
+	if (!enable && !update_interval_ms && (!mode || *mode == *current_mode))
+		return 0;
+
+	ret = ph->xops->xfer_get_init(ph, TELEMETRY_CONFIG_SET,
+				      sizeof(*msg), 0, &t);
+	if (ret)
+		return ret;
+
+	if (!update_interval_ms)
+		interval = cpu_to_le32(*active_update_interval);
+	else
+		interval = cpu_to_le32(*update_interval_ms);
+
+	tlm_enable = enable ? *enable : ti->info.enabled;
+	next_mode = mode ? *mode : *current_mode;
+
+	msg = t->tx.buf;
+	msg->grp_id = cpu_to_le32(res_id);
+	control = tlm_enable ? TELEMETRY_ENABLE : 0;
+	control |= !is_group ? TELEMETRY_SET_SELECTOR_ALL : TELEMETRY_SET_SELECTOR_GROUP;
+	control |= TELEMETRY_MODE_SET(next_mode);
+	msg->control = cpu_to_le32(control);
+	msg->sampling_rate = interval;
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		ti->info.enabled = tlm_enable;
+		*current_mode = next_mode;
+		ti->info.notif_enabled = *current_mode == SCMI_TLM_NOTIFICATION;
+		if (update_interval_ms)
+			*active_update_interval = le32_to_cpu(interval);
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
 	.res_get = scmi_telemetry_resources_get,
+	.state_get = scmi_telemetry_state_get,
+	.state_set = scmi_telemetry_state_set,
+	.all_disable = scmi_telemetry_all_disable,
+	.collection_configure = scmi_telemetry_collection_configure,
 };
 
 /**
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index a03921e9a698..38d44ba8c097 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -992,6 +992,13 @@ struct scmi_telemetry_info {
  * @info_get: get the general Telemetry information.
  * @de_lookup: get a specific DE descriptor from the DE id.
  * @res_get: get a reference to the Telemetry resources descriptor.
+ * @state_get: retrieve the specific DE or GROUP state, if NULL returns the
+ *	       cumulative state of all DEs.
+ * @state_set: enable/disable the specific DE or GROUP with or without timestamps.
+ * @all_disable: disable ALL DEs or GROUPs.
+ * @collection_configure: choose a sampling rate and enable SHMTI/FC sampling
+ *			  for on demand collection via @de_data_read or async
+ *			  notificatioins for all the enabled DEs.
  */
 struct scmi_telemetry_proto_ops {
 	const struct scmi_telemetry_info __must_check *(*info_get)
@@ -1000,6 +1007,16 @@ struct scmi_telemetry_proto_ops {
 		(const struct scmi_protocol_handle *ph, u32 id);
 	const struct scmi_telemetry_res_info __must_check *(*res_get)
 		(const struct scmi_protocol_handle *ph);
+	int (*state_get)(const struct scmi_protocol_handle *ph,
+			 const u32 *id, bool *enabled, bool *tstamp_enabled);
+	int (*state_set)(const struct scmi_protocol_handle *ph,
+			 bool is_group, u32 id, const bool *enable,
+			 const bool *tstamp);
+	int (*all_disable)(const struct scmi_protocol_handle *ph, bool group);
+	int (*collection_configure)(const struct scmi_protocol_handle *ph,
+				    unsigned int res_id, const bool *enable,
+				    const unsigned int *update_interval_ms,
+				    const enum scmi_telemetry_collection *mode);
 };
 
 /**
-- 
2.54.0

