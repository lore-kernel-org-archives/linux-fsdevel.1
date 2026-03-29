Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07C381B1C;
	Sun, 29 Mar 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802092; cv=none; b=JUtWZ2458ZpzY83qheJ/n7nnmE9iONPk6F0bw5obwflkrzJ/kBpJIKdSj9wOjZp2TBCuEdDHYoPFBE7zSu1icmnPXUtfutxbXJI5neZXPtkJsdXJBiZuRjhJoXLUbp1d2Juyg5IzS94HMzRzpwCZ9SfWJB8/spUR44TLT4ve/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802092; c=relaxed/simple;
	bh=BD1Ezs8Lm3PZy+LBZz/g12XnPTQ1zgd+Y2+OAXBkV/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR8UH095/hmO5FjEdWfi57XfZ0ygVxTPWH+N7I+hkl+UySrztKqnaxkGJpQZSEgXs14U7iTOewm3LOJ7vf7e5V4FMuuoiT/57LW3yrvYpNMD/xrl6TSIYV4cniW6xaA0Y32Eghe3OXYN1JEOa14LL//JXHcktQWfl+KnGhZcHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vehVEO/B; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vehVEO/B"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E48EA2A31;
	Sun, 29 Mar 2026 09:34:43 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E74043F915;
	Sun, 29 Mar 2026 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774802089; bh=BD1Ezs8Lm3PZy+LBZz/g12XnPTQ1zgd+Y2+OAXBkV/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vehVEO/BzKfigF0v0/PRNjBGl/cGM4c1+j49w7R+oMYDnYYH71JFGzvW23m16o6SJ
	 f85pvelFTvHZ1l/5jtr85yspgL+VfRfxWuDEsbNW2yWGNZLvMDBvAI3UGVbHHneUsI
	 ojWlLkQtoyAD5y+mAaAL4ehYwTTH+sIsN1dUwlYk=
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
Subject: [PATCH v3 11/24] firmware: arm_scmi: Add Telemetry DataEvent read capabilities
Date: Sun, 29 Mar 2026 17:33:22 +0100
Message-ID: <20260329163337.637393-12-cristian.marussi@arm.com>
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

Add support for Telemetry operations needed to read DataEvent values and
timestamps as single entities or all together in a single bulk buffer.
The returned values are effectiely retrieved from the platform only
when strictly needed, i.e. when no fresh recent cached value was already
available.
The DataEvent values are fetched transparently from the platform origins
using the proper synchronization and consistency primitives, directly from
the SHMTIs areas or the FastChannels memory depending on the configuration.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
 - split from monolithic Telemetry patch
 - simplity using a few assignement using ternary ops
 - remove useless ts param from scanning function
 - use a compound literal to simplify samples init
 - add a missing __must_check on telemetry_ops
 - changed errno on DE read troubles:
   - ENODEV/ENOENT: DE is UNKNOWN
   - EINVAL: DE is marked as DATA_INVALID
   - ENODATA: TLM susbsystem or the specific DE is OFF
---
 drivers/firmware/arm_scmi/telemetry.c | 428 ++++++++++++++++++++++++++
 include/linux/scmi_protocol.h         |  23 ++
 2 files changed, 451 insertions(+)

diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
index 9536262bbdf7..61eaad817db4 100644
--- a/drivers/firmware/arm_scmi/telemetry.c
+++ b/drivers/firmware/arm_scmi/telemetry.c
@@ -2031,6 +2031,431 @@ scmi_telemetry_collection_configure(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static inline void scmi_telemetry_de_data_fc_read(struct telemetry_de *tde,
+						  u64 *tstamp, u64 *val)
+{
+	struct fc_tsline __iomem *fc = tde->base + tde->offset;
+
+	*val = LINE_DATA_GET(fc);
+	if (tstamp)
+		*tstamp = tde->de.tstamp_support ? LINE_TSTAMP_GET(fc) : 0;
+
+	trace_scmi_tlm_collect(tstamp ? *tstamp : 0,
+			       tde->de.info->id, *val, "FC_READ");
+}
+
+static void scmi_telemetry_scan_update(struct telemetry_info *ti)
+{
+	struct telemetry_de *tde;
+
+	/* Scan all SHMTIs ... */
+	for (int id = 0; id < ti->num_shmti; id++) {
+		int ret;
+
+		ret = scmi_telemetry_shmti_scan(ti, id, SCAN_LOOKUP);
+		if (ret)
+			dev_warn(ti->ph->dev,
+				 "Failed update-scan of SHMTI ID:%d - ret:%d\n",
+				 id, ret);
+	}
+
+	if (!ti->info.fc_support)
+		return;
+
+	/* Need to enumerate resources to access fastchannels */
+	ti->res_get(ti);
+	list_for_each_entry(tde, &ti->fcs_des, item) {
+		u64 val, tstamp;
+
+		if (!tde->de.enabled)
+			continue;
+
+		scmi_telemetry_de_data_fc_read(tde, &tstamp, &val);
+
+		guard(mutex)(&tde->mtx);
+		tde->last_val = val;
+		tde->last_ts = tde->de.tstamp_enabled ? tstamp : 0;
+	}
+}
+
+/*
+ * TDCF and TS Line Management Notes
+ * ---------------------------------
+ *
+ * TCDF Payload Metadata notable bits:
+ *  - Bit[3]: USE BLK Tstamp
+ *  - Bit[2]: Line-Extension Field present (LineTstamp)
+ *  - Bit[1]: Tstamp VALID
+ *  - Bit[0]: Data INVALID
+ *
+ * CASE_1:
+ * -------
+ *	+ A DE is enabled with timestamp disabled, so the TS fields are
+ *	  NOT present
+ *	  -> BIT[3:0] = 0000b
+ *
+ *	  - 1/A LINE_TSTAMP
+ *	  ------------------
+ *	     + that DE is then 're-enabled' with TS: so it was ON, it remains
+ *	       ON but using DE_CONFIGURE I now enabled also TS, so the
+ *	       platform relocates it at the end of the SHMTI and return the
+ *	       new offset
+ *	       -> BIT[3:0] = 0110b
+ *
+ *	  - 1/B BLK_TSTAMP
+ *	  ------------------
+ *	     + that DE is then 're-enabled' with BLK TS: so it was ON, it
+ *	       remains ON but using DE_CONFIGURE, we now also enabled the TS,
+ *	       so the platform will:
+ *	       - IF a preceding BLK_TS line exist (with same clk rate)
+ *	         it relocates the DE at the end of the SHMTI and return the
+ *	         new offset (if there is enough room, if not in another SHMTI)
+ *	       - IF a preceding BLK_TS line DOES NOT exist (with same clk rate)
+ *	         it creates a new BLK_TS line at the end of the SHMTI and then
+ *	         relocates the DE after the new BLK_TS and return the
+ *	         new offset (if there is enough room, if not in another SHMTI)
+ *	       -> BIT[3:1] = 1010b
+ *
+ *	+ the hole left from the relocated DE can be reused by the platform
+ *	to fit another equally sized DE. (i.e. without shuffling around any
+ *	other enabled DE, since that would cause a change of the known offset)
+ *	anyway it will be marked as:
+ *	-> BIT[3:0] = 0101b iff it was a LINE_TSTAMP
+ *	-> BIT[3:0] = 0001b iff it was a BLK_TSTAMP
+ *
+ * CASE_2:
+ * -------
+ *	+ A DE is enabled with LINE timestamp enabled, so the TS_Line is there
+ *	  -> BIT[3:0] = 0110b
+ *	+ that DE has its timestamp disabled: again, you can do this without
+ *	  disabling it fully but just disabling the TS, so now that TS_line
+ *	  fields are still physically there but NOT valid
+ *	  -> BIT[3:0] = 0100b
+ *	+ the hole from the timestamp remain there unused until
+ *		- you enable again the TS so the hole is used again
+ *		  -> BIT[3:0] = 0110b
+ *			OR
+ *		- you disable fully the DE and then re-enable it with the TS
+ *		  -> potentially CASE_1 the DE is relocated on enable
+ *	+ same kind of dynamic applies if the DE had a BLK_TS line
+ */
+static struct payload __iomem *
+scmi_telemetry_tdcf_de_payld_get(struct telemetry_de *tde)
+{
+	struct payload __iomem *payld;
+
+	payld = tde->base + tde->offset;
+	if (DATA_INVALID(payld)) {
+		trace_scmi_tlm_access(PAYLD_ID(payld), "DE_DATA_INVALID", 0, 0);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (IS_BLK_TS_LINE(payld)) {
+		trace_scmi_tlm_access(tde->de.info->id, "BAD_DE_META", 0, 0);
+		return ERR_PTR(-EPROTO);
+	}
+
+	if (PAYLD_ID(payld) != tde->de.info->id) {
+		trace_scmi_tlm_access(tde->de.info->id, "DE_ID_MISMATCH", 0, 0);
+		return ERR_PTR(-ENODEV);
+	}
+
+	/*
+	 * A valid line using BLK_TS should have been initialized with the
+	 * related BLK_TS when enabled.
+	 */
+	if (WARN_ON((USE_BLK_TS(payld) && !tde->bts))) {
+		trace_scmi_tlm_access(tde->de.info->id, "BAD_USE_BLK_TS", 0, 0);
+		return ERR_PTR(-EPROTO);
+	}
+
+	return payld;
+}
+
+static int
+scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde, u64 *tstamp, u64 *val)
+{
+	int retries = SCMI_TLM_TDCF_MAX_RETRIES;
+	struct tdcf __iomem *tdcf = tde->base;
+	u32 startm, endm;
+
+	if (!tdcf)
+		return -ENODEV;
+
+	do {
+		struct payload __iomem *payld;
+
+		/* A bit of exponential backoff between retries */
+		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);
+
+		startm = TDCF_START_SEQ_GET(tdcf);
+		if (IS_BAD_START_SEQ(startm)) {
+			trace_scmi_tlm_access(tde->de.info->id, "MSEQ_BADSTART",
+					      startm, 0);
+			continue;
+		}
+
+		/* Has anything changed at all at the SHMTI level ? */
+		scoped_guard(mutex, &tde->mtx) {
+			if (tde->last_magic == startm) {
+				*val = tde->last_val;
+				if (tstamp)
+					*tstamp = tde->last_ts;
+				return 0;
+			}
+		}
+
+		payld = scmi_telemetry_tdcf_de_payld_get(tde);
+		if (IS_ERR(payld))
+			return PTR_ERR(payld);
+
+		/* Parse data words */
+		scmi_telemetry_line_data_parse(tde, val, tstamp, payld, startm);
+
+		endm = TDCF_END_SEQ_GET(tde->eplg);
+		if (startm != endm)
+			trace_scmi_tlm_access(tde->de.info->id, "MSEQ_MISMATCH",
+					      startm, endm);
+	} while (startm != endm && --retries);
+
+	if (startm != endm) {
+		trace_scmi_tlm_access(tde->de.info->id, "TDCF_DE_FAIL",
+				      startm, endm);
+		return -EPROTO;
+	}
+
+	guard(mutex)(&tde->mtx);
+	tde->last_magic = startm;
+	tde->last_val = *val;
+	if (tstamp)
+		tde->last_ts = *tstamp;
+
+	return 0;
+}
+
+static int scmi_telemetry_de_access(struct telemetry_de *tde, u64 *tstamp, u64 *val)
+{
+	if (!tde->de.fc_support)
+		return scmi_telemetry_tdcf_de_parse(tde, tstamp, val);
+
+	scmi_telemetry_de_data_fc_read(tde, tstamp, val);
+
+	return 0;
+}
+
+static int scmi_telemetry_de_collect(struct telemetry_info *ti,
+				     struct scmi_telemetry_de *de,
+				     u64 *tstamp, u64 *val)
+{
+	struct telemetry_de *tde = to_tde(de);
+
+	if (!de->enabled)
+		return -ENODATA;
+
+	/*
+	 * DE readings returns cached values when:
+	 *  - DE data value was retrieved via notification
+	 */
+	scoped_guard(mutex, &tde->mtx) {
+		if (tde->cached) {
+			*val = tde->last_val;
+			if (tstamp)
+				*tstamp = tde->last_ts;
+			return 0;
+		}
+	}
+
+	return scmi_telemetry_de_access(tde, tstamp, val);
+}
+
+static int scmi_telemetry_de_cached_read(struct telemetry_info *ti,
+					 struct scmi_telemetry_de *de,
+					 u64 *tstamp, u64 *val)
+{
+	struct telemetry_de *tde = to_tde(de);
+
+	if (!de->enabled)
+		return -ENODATA;
+
+	guard(mutex)(&tde->mtx);
+	*val = tde->last_val;
+	if (tstamp)
+		*tstamp = tde->last_ts;
+
+	return 0;
+}
+
+static int scmi_telemetry_de_data_read(const struct scmi_protocol_handle *ph,
+				       struct scmi_telemetry_de_sample *sample)
+{
+	struct telemetry_info *ti = ph->get_priv(ph);
+	struct scmi_telemetry_de *de;
+
+	if (!ti->info.enabled || !sample)
+		return -ENODATA;
+
+	de = xa_load(&ti->xa_des, sample->id);
+	if (!de)
+		return -ENOENT;
+
+	return scmi_telemetry_de_collect(ti, de, &sample->tstamp, &sample->val);
+}
+
+static int
+scmi_telemetry_samples_collect(struct telemetry_info *ti, int grp_id,
+			       int *num_samples,
+			       struct scmi_telemetry_de_sample *samples)
+{
+	struct scmi_telemetry_res_info *rinfo;
+	int max_samples;
+
+	max_samples = *num_samples;
+	*num_samples = 0;
+
+	rinfo = ti->res_get(ti);
+	for (int i = 0; i < rinfo->num_des; i++) {
+		struct scmi_telemetry_de *de;
+		u64 val, tstamp;
+		int ret;
+
+		de = rinfo->des[i];
+		if (grp_id != SCMI_TLM_GRP_INVALID &&
+		    (!de->grp || de->grp->info->id != grp_id))
+			continue;
+
+		ret = scmi_telemetry_de_cached_read(ti, de, &tstamp, &val);
+		if (ret)
+			continue;
+
+		if (*num_samples == max_samples)
+			return -ENOSPC;
+
+		samples[(*num_samples)++] = (struct scmi_telemetry_de_sample) {
+			.tstamp = tstamp,
+			.val = val,
+			.id = de->info->id,
+		};
+	}
+
+	return 0;
+}
+
+static int scmi_telemetry_des_bulk_read(const struct scmi_protocol_handle *ph,
+					int grp_id, int *num_samples,
+					struct scmi_telemetry_de_sample *samples)
+{
+	struct telemetry_info *ti = ph->get_priv(ph);
+
+	if (!ti->info.enabled || !num_samples || !samples)
+		return -EINVAL;
+
+	/* Trigger a full SHMTIs & FCs scan */
+	scmi_telemetry_scan_update(ti);
+
+	/* Collect all last cached values */
+	return scmi_telemetry_samples_collect(ti, grp_id, num_samples, samples);
+}
+
+static void
+scmi_telemetry_msg_payld_process(struct telemetry_info *ti,
+				 unsigned int num_dwords, u32 *dwords)
+{
+	struct scmi_telemetry_res_info *rinfo;
+	u32 next = 0;
+
+	rinfo = ti->res_get(ti);
+	if (!rinfo->fully_enumerated) {
+		dev_warn_once(ti->ph->dev,
+			      "Cannot process DEs in message payload. Drop.\n");
+		return;
+	}
+
+	while (next < num_dwords) {
+		struct payload *payld = (struct payload *)&dwords[next];
+		struct scmi_telemetry_de *de;
+		struct telemetry_de *tde;
+		u32 de_id;
+
+		next += LINE_LENGTH_WORDS(payld);
+
+		if (DATA_INVALID(payld)) {
+			dev_err(ti->ph->dev, "MSG - Received INVALID DATA line\n");
+			continue;
+		}
+
+		de_id = le32_to_cpu(payld->id);
+		de = xa_load(&ti->xa_des, de_id);
+		if (!de || !de->enabled) {
+			dev_err(ti->ph->dev,
+				"MSG - Received INVALID DE - ID:%u  enabled:%c\n",
+				de_id, de ? (de->enabled ? 'Y' : 'N') : 'X');
+			continue;
+		}
+
+		tde = to_tde(de);
+		guard(mutex)(&tde->mtx);
+		tde->cached = true;
+		tde->last_val = LINE_DATA_GET(&payld->tsl);
+		/* TODO BLK_TS in notification payloads */
+		tde->last_ts = HAS_LINE_EXT(payld) && LINE_TS_VALID(payld) ?
+			LINE_TSTAMP_GET(&payld->tsl) : 0;
+
+		trace_scmi_tlm_collect(tde->last_ts, tde->de.info->id,
+				       tde->last_val, "MESSAGE");
+	}
+}
+
+static int scmi_telemetry_des_sample_get(const struct scmi_protocol_handle *ph,
+					 int grp_id, int *num_samples,
+					 struct scmi_telemetry_de_sample *samples)
+{
+	struct telemetry_info *ti = ph->get_priv(ph);
+	struct scmi_msg_telemetry_config_set *msg;
+	struct scmi_xfer *t;
+	bool grp_ignore;
+	int ret;
+
+	if (!ti->info.enabled || !num_samples || !samples)
+		return -EINVAL;
+
+	grp_ignore = grp_id == SCMI_TLM_GRP_INVALID ? true : false;
+	if (!grp_ignore && grp_id >= ti->info.base.num_groups)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, TELEMETRY_CONFIG_SET,
+				      sizeof(*msg), 0, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->grp_id = grp_id;
+	msg->control = TELEMETRY_ENABLE;
+	msg->control |= grp_ignore ? TELEMETRY_SET_SELECTOR_ALL :
+		TELEMETRY_SET_SELECTOR_GROUP;
+	msg->control |= TELEMETRY_MODE_SINGLE;
+	msg->sampling_rate = 0;
+
+	ret = ph->xops->do_xfer_with_response(ph, t);
+	if (!ret) {
+		struct scmi_msg_resp_telemetry_reading_complete *r = t->rx.buf;
+
+		/* Update cached DEs values from payload */
+		if (r->num_dwords)
+			scmi_telemetry_msg_payld_process(ti, r->num_dwords,
+							 r->dwords);
+		/* Scan and update SMHTIs and FCs */
+		scmi_telemetry_scan_update(ti);
+
+		/* Collect all last cached values */
+		ret = scmi_telemetry_samples_collect(ti, grp_id, num_samples,
+						     samples);
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
@@ -2039,6 +2464,9 @@ static const struct scmi_telemetry_proto_ops tlm_proto_ops = {
 	.state_set = scmi_telemetry_state_set,
 	.all_disable = scmi_telemetry_all_disable,
 	.collection_configure = scmi_telemetry_collection_configure,
+	.de_data_read = scmi_telemetry_de_data_read,
+	.des_bulk_read = scmi_telemetry_des_bulk_read,
+	.des_sample_get = scmi_telemetry_des_sample_get,
 };
 
 /**
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 03aa6b3dbd6b..5f05df297064 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -935,6 +935,12 @@ struct scmi_telemetry_info {
 	enum scmi_telemetry_collection current_mode;
 };
 
+struct scmi_telemetry_de_sample {
+	u32 id;
+	u64 tstamp;
+	u64 val;
+};
+
 /**
  * struct scmi_telemetry_proto_ops - represents the various operations provided
  *	by SCMI Telemetry Protocol
@@ -948,6 +954,15 @@ struct scmi_telemetry_info {
  * @collection_configure: choose a sampling rate and enable SHMTI/FC sampling
  *			  for on demand collection via @de_data_read or async
  *			  notificatioins for all the enabled DEs.
+ * @de_data_read: on-demand read of a single DE and related optional timestamp:
+ *		  the value will be retrieved at the proper SHMTI offset OR
+ *		  from the dedicated FC area (if supported by that DE).
+ * @des_bulk_read: on-demand read of all the currently enabled DEs, or just
+ *		   the ones belonging to a specific group when provided.
+ * @des_sample_get: on-demand read of all the currently enabled DEs, or just
+ *		    the ones belonging to a specific group when provided.
+ *		    This causes an immediate update platform-side of all the
+ *		    enabled DEs.
  */
 struct scmi_telemetry_proto_ops {
 	const struct scmi_telemetry_info __must_check *(*info_get)
@@ -966,6 +981,14 @@ struct scmi_telemetry_proto_ops {
 				    bool *enable,
 				    unsigned int *update_interval_ms,
 				    enum scmi_telemetry_collection *mode);
+	int __must_check (*de_data_read)(const struct scmi_protocol_handle *ph,
+					 struct scmi_telemetry_de_sample *sample);
+	int __must_check (*des_bulk_read)(const struct scmi_protocol_handle *ph,
+					  int grp_id, int *num_samples,
+					  struct scmi_telemetry_de_sample *samples);
+	int __must_check (*des_sample_get)(const struct scmi_protocol_handle *ph,
+					   int grp_id, int *num_samples,
+					   struct scmi_telemetry_de_sample *samples);
 };
 
 /**
-- 
2.53.0

