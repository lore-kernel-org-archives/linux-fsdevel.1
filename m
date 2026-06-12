Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CB23D6474;
	Fri, 12 Jun 2026 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303956; cv=none; b=IZ7mI5hzmICMFzcmiZ0uwpuzU4ZetPRS17QmDHU5yjbzP7hWZ6DL/W+2uf/zVqzmui9A7WckgCfA+lrjW+BzFA790vwYcfCnddGGcLDxLZDrHOInAbB9lRPAlxCH6lTxOV29wguvBZelfldBhQggYXlbqJk6rBrkvkgrLoae3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303956; c=relaxed/simple;
	bh=6+rh/9iDMeFRpeSuzj32XH+u+sF8aWSC7c8EXzr2Ju8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDOzDsPJ1gV/ZqecshdFj0FVuGutGTGSWWM1pITL9VUcL7a1Y+116a8vOOjgt21QZg78QaqdsFRSOCxdy64nZx4ctbdw7ApElmXHT5UvFARZOPrgmrj0aPq7971NGyTe86mKZ+eBVm6Wk0cobfkZjPSJ56XPEYLDb646scRZyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V6j9Idro; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V6j9Idro"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73FCF49FF;
	Fri, 12 Jun 2026 15:39:08 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 727E13FB7F;
	Fri, 12 Jun 2026 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781303953; bh=6+rh/9iDMeFRpeSuzj32XH+u+sF8aWSC7c8EXzr2Ju8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6j9IdroRSkVdx8GIx7ErJf4bNrq9ohYkZ4K5Q8N149+tyEziwLSvYYvxvEWKQjuM
	 aB7Eda2qpo1aIMiecoRkTZ3jT15lq3khMCWGiBKWIDbRxMl7kPckZ8ir5EelgXCog/
	 e45gTTbmwUO811wJugdhrF782D1fGto1wsdkfp84=
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
Subject: [PATCH v4 09/31] firmware: arm_scmi: Add support to parse SHMTIs areas
Date: Fri, 12 Jun 2026 23:37:39 +0100
Message-ID: <20260612223802.1337232-10-cristian.marussi@arm.com>
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

Add logic to scan the SHMTI areas, parsing the TDCF descriptors while
collecting DataEvent, BlockTimestamp and UUID lines.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
 - use kzalloc_obj
 - track SHMTI-discovered Telemetry DE states
 - refactor TDE cache with dedicated helpers
 - force tstamp to zero when timestamp is NOT supported or disabled
v2 --> v3
 - split from monolithic Telemetry patch
 - avoid devres allocation for resources that are added to the xa_lines XArray
 - simplify prototype of line parsing helpers to drop unneeded dev
 - flip tstmap logic in scmi_telemetry_line_data_parse() to properly emit
   a TLM ftrace event
 - use ternary ops to simplify quite a few expressions
---
 drivers/firmware/arm_scmi/telemetry.c | 629 ++++++++++++++++++++++++++
 1 file changed, 629 insertions(+)

diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
index a5c61ec37065..087a3b6d18e4 100644
--- a/drivers/firmware/arm_scmi/telemetry.c
+++ b/drivers/firmware/arm_scmi/telemetry.c
@@ -254,6 +254,23 @@ struct uuid_line {
 	u32 dwords[SCMI_TLM_DE_IMPL_MAX_DWORDS];
 };
 
+#define LINE_DATA_GET(f)					\
+({								\
+	typeof(f) _f = (f);					\
+								\
+	(TO_CPU_64(_I(&_f->data_high), _I(&_f->data_low)));	\
+})
+
+#define LINE_TSTAMP_GET(f)					\
+({								\
+	typeof(f) _f = (f);					\
+								\
+	(TO_CPU_64(_I(&_f->ts_high), _I(&_f->ts_low)));	\
+})
+
+#define BLK_TS_STAMP(f)		LINE_TSTAMP_GET(f)
+#define BLK_TS_RATE(p)		PAYLD_ID(p)
+
 enum tdcf_line_types {
 	TDCF_DATA_LINE,
 	TDCF_BLK_TS_LINE,
@@ -365,6 +382,7 @@ struct telemetry_line {
 	refcount_t users;
 	u32 last_magic;
 	struct payload __iomem *payld;
+	struct xarray *xa_lines;
 	/* Protect line accesses  */
 	struct mutex mtx;
 };
@@ -413,18 +431,34 @@ struct telemetry_de {
 
 #define to_tde(d)	container_of(d, struct telemetry_de, de)
 
+#define TDE_HAS_TSTAMP(_t)						\
+	({								\
+		bool ts;						\
+		struct telemetry_de *t = _t;				\
+									\
+		ts = t->de.tstamp_support && t->de.tstamp_enabled;	\
+	})
+
 #define DE_ENABLED_WITH_TSTAMP	2
 
+enum de_state {
+	ENA_STATE,
+	ENA_TSTAMP,
+	ENA_MAX
+};
+
 struct telemetry_info {
 	bool streaming_mode;
 	unsigned int num_shmti;
 	unsigned int num_des_tstamp;
+	atomic_t des_enabled[ENA_MAX];
 	unsigned int default_blk_ts_rate;
 	const struct scmi_protocol_handle *ph;
 	struct telemetry_shmti *shmti;
 	struct telemetry_de *tdes;
 	struct scmi_telemetry_group *grps;
 	struct xarray xa_des;
+	struct xarray xa_lines;
 	/* Mutex to protect access to @free_des */
 	struct mutex free_mtx;
 	struct list_head free_des;
@@ -439,6 +473,21 @@ struct telemetry_info {
 static struct scmi_telemetry_res_info *
 __scmi_telemetry_resources_get(struct telemetry_info *ti);
 
+static inline void
+scmi_telemetry_de_state_update(struct telemetry_info *ti, enum de_state state,
+			       bool *current_state, bool next_state)
+{
+	if (!current_state || *current_state != next_state)
+		atomic_add(next_state ? 1 : -1, &ti->des_enabled[state]);
+
+	if (current_state)
+		*current_state = next_state;
+
+	dev_dbg(ti->ph->dev, "Telemetry des_enabled[%s]:%u\n",
+		state == ENA_STATE ? "STATE" : "TSTAMP",
+		atomic_read(&ti->des_enabled[state]));
+}
+
 static struct telemetry_de *
 scmi_telemetry_free_tde_get(struct telemetry_info *ti)
 {
@@ -518,6 +567,27 @@ static int scmi_telemetry_tde_register(struct telemetry_info *ti,
 	return ret;
 }
 
+static bool
+scmi_telemetry_tde_cache_unchanged(struct telemetry_de *tde, u32 magic)
+{
+	guard(mutex)(&tde->mtx);
+
+	return tde->last_magic == magic;
+}
+
+static void
+scmi_telemetry_tde_cache_update(struct telemetry_de *tde, u64 val,
+				u64 *tstamp, u32 *magic)
+{
+	guard(mutex)(&tde->mtx);
+
+	tde->last_magic = magic ? *magic : TDCF_BAD_END_SEQ;
+	tde->last_val = val;
+	tde->last_ts = tstamp && TDE_HAS_TSTAMP(tde) ? *tstamp : 0;
+	if (tstamp)
+		*tstamp = tde->last_ts;
+}
+
 struct scmi_tlm_de_priv {
 	struct telemetry_info *ti;
 	void *next;
@@ -1122,6 +1192,555 @@ scmi_telemetry_resources_get(const struct scmi_protocol_handle *ph)
 	return ti->res_get(ti);
 }
 
+static u64
+scmi_telemetry_blkts_read(u32 magic, struct telemetry_block_ts *bts)
+{
+	if (WARN_ON(!bts || !refcount_read(&bts->line.users)))
+		return 0;
+
+	guard(mutex)(&bts->line.mtx);
+
+	if (bts->line.last_magic == magic)
+		return bts->last_ts;
+
+	/* Note that the bts->last_rate can change ONLY on creation */
+	bts->last_ts = BLK_TS_STAMP(&bts->line.payld->blk_tsl);
+	bts->line.last_magic = magic;
+
+	return bts->last_ts;
+}
+
+static void scmi_telemetry_blkts_update(struct telemetry_info *ti, u32 magic,
+					struct telemetry_block_ts *bts)
+{
+	guard(mutex)(&bts->line.mtx);
+
+	if (bts->line.last_magic != magic) {
+		bts->last_ts = BLK_TS_STAMP(&bts->line.payld->blk_tsl);
+		bts->last_rate = BLK_TS_RATE(bts->line.payld);
+		/* BLK_TS clock rate value can change ONLY here on creation */
+		if (!bts->last_rate)
+			bts->last_rate = ti->default_blk_ts_rate;
+		bts->line.last_magic = magic;
+	}
+}
+
+static void scmi_telemetry_line_put(struct telemetry_line *line, void *blob)
+{
+	if (refcount_dec_and_test(&line->users)) {
+		scoped_guard(mutex, &line->mtx)
+			xa_erase(line->xa_lines, (unsigned long)line->payld);
+		kfree(blob);
+	}
+}
+
+static void scmi_telemetry_blkts_unlink(struct telemetry_de *tde)
+{
+	scmi_telemetry_line_put(&tde->bts->line, tde->bts);
+	tde->bts = NULL;
+}
+
+static void scmi_telemetry_uuid_unlink(struct telemetry_de *tde)
+{
+	scmi_telemetry_line_put(&tde->uuid->line, tde->uuid);
+	tde->uuid = NULL;
+}
+
+static void scmi_telemetry_de_unlink(struct scmi_telemetry_de *de)
+{
+	struct telemetry_de *tde = to_tde(de);
+
+	/* Unlink all related lines triggering their deallocation */
+	if (tde->bts)
+		scmi_telemetry_blkts_unlink(tde);
+	if (tde->uuid)
+		scmi_telemetry_uuid_unlink(tde);
+}
+
+static struct telemetry_line *
+scmi_telemetry_line_get(struct xarray *xa_lines, struct payload *payld)
+{
+	struct telemetry_line *line;
+
+	line = xa_load(xa_lines, (unsigned long)payld);
+	if (!line)
+		return NULL;
+
+	refcount_inc(&line->users);
+
+	return line;
+}
+
+static int
+scmi_telemetry_line_init(struct telemetry_line *line, struct xarray *xa_lines,
+			 struct payload __iomem *payld)
+{
+	refcount_set(&line->users, 1);
+	line->payld = payld;
+	line->xa_lines = xa_lines;
+	mutex_init(&line->mtx);
+
+	return xa_insert(xa_lines, (unsigned long)payld, line, GFP_KERNEL);
+}
+
+static struct telemetry_block_ts *
+scmi_telemetry_blkts_create(struct device *dev, struct xarray *xa_lines,
+			    struct payload *payld)
+{
+	struct telemetry_block_ts *bts;
+	int ret;
+
+	bts = kzalloc_obj(*bts);
+	if (!bts)
+		return NULL;
+
+	ret = scmi_telemetry_line_init(&bts->line, xa_lines, payld);
+	if (ret) {
+		kfree(bts);
+		return NULL;
+	}
+
+	trace_scmi_tlm_collect(0, (u64)payld, 0, "SHMTI_NEW_BLKTS");
+
+	return bts;
+}
+
+static struct telemetry_block_ts *
+scmi_telemetry_blkts_get_or_create(struct device *dev, struct xarray *xa_lines,
+				   struct payload *payld)
+{
+	struct telemetry_line *line;
+
+	line = scmi_telemetry_line_get(xa_lines, payld);
+	if (line)
+		return to_blkts(line);
+
+	return scmi_telemetry_blkts_create(dev, xa_lines, payld);
+}
+
+static struct telemetry_uuid *
+scmi_telemetry_uuid_create(struct device *dev, struct xarray *xa_lines,
+			   struct payload *payld)
+{
+	struct telemetry_uuid *uuid;
+	int ret;
+
+	uuid = kzalloc_obj(*uuid);
+	if (!uuid)
+		return NULL;
+
+	for (int i = 0; i < SCMI_TLM_DE_IMPL_MAX_DWORDS; i++)
+		uuid->de_impl_version[i] = le32_to_cpu(payld->uuid_l.dwords[i]);
+
+	ret = scmi_telemetry_line_init(&uuid->line, xa_lines, payld);
+	if (ret) {
+		kfree(uuid);
+		return NULL;
+	}
+
+	trace_scmi_tlm_collect(0, (u64)payld, 0, "SHMTI_NEW_UUID");
+
+	return uuid;
+}
+
+static struct telemetry_uuid *
+scmi_telemetry_uuid_get_or_create(struct device *dev, struct xarray *xa_lines,
+				  struct payload *payld)
+{
+	struct telemetry_line *line;
+
+	line = scmi_telemetry_line_get(xa_lines, payld);
+	if (line)
+		return to_uuid(line);
+
+	return scmi_telemetry_uuid_create(dev, xa_lines, payld);
+}
+
+static void scmi_telemetry_tdcf_uuid_parse(struct telemetry_info *ti,
+					   struct payload __iomem *payld,
+					   struct telemetry_shmti *shmti,
+					   void **active_uuid)
+{
+	struct telemetry_uuid *uuid;
+
+	if (UUID_INVALID(payld)) {
+		trace_scmi_tlm_access(0, "UUID_INVALID", 0, 0);
+		return;
+	}
+
+	/* A UUID descriptor MUST be returned: it is found or it is created */
+	uuid = scmi_telemetry_uuid_get_or_create(ti->ph->dev, &ti->xa_lines,
+						 payld);
+	if (WARN_ON(!uuid))
+		return;
+
+	*active_uuid = uuid;
+}
+
+static struct payload *
+scmi_telemetry_nearest_line_by_type(struct telemetry_shmti *shmti,
+				    void *last, enum tdcf_line_types ltype)
+{
+	struct tdcf __iomem *tdcf = shmti->base;
+	void *next, *found = NULL;
+
+	/* Scan from start of TDCF payloads up to last_payld */
+	next = tdcf->payld;
+	while (next < last) {
+		if (LINE_TYPE((struct payload *)next) == ltype)
+			found = next;
+
+		next += LINE_LENGTH_WORDS((struct payload *)next);
+	}
+
+	return found;
+}
+
+static struct telemetry_block_ts *
+scmi_telemetry_blkts_bind(struct device *dev, struct telemetry_shmti *shmti,
+			  struct payload *payld, struct xarray *xa_lines,
+			  struct payload *bts_payld)
+{
+	/* Trigger a manual search when no BLK_TS payload offset was provided */
+	if (!bts_payld) {
+		/* Find the BLK_TS immediately preceding this DE payld */
+		bts_payld = scmi_telemetry_nearest_line_by_type(shmti, payld,
+								TDCF_BLK_TS_LINE);
+		if (!bts_payld)
+			return NULL;
+	}
+
+	return scmi_telemetry_blkts_get_or_create(dev, xa_lines, bts_payld);
+}
+
+/**
+ * scmi_telemetry_tdcf_blkts_parse  - A BLK_TS line parser
+ *
+ * @ti: A reference to the telemetry_info descriptor
+ * @payld: TDCF payld line to process
+ * @shmti: SHMTI descriptor inside which the scan is happening
+ * @active_bts: Input/output reference to keep track of the last blk_ts found
+ *
+ * Process a valid TDCF BLK_TS line and, after having looked up or created a
+ * blk_ts descriptor, update the related data and return it as the currently
+ * active blk_ts, given that it is effectively the last found during this
+ * scan.
+ */
+static void scmi_telemetry_tdcf_blkts_parse(struct telemetry_info *ti,
+					    struct payload __iomem *payld,
+					    struct telemetry_shmti *shmti,
+					    void **active_bts)
+{
+	struct telemetry_block_ts *bts;
+
+	/* Check for spec compliance */
+	if (BLK_TS_INVALID(payld)) {
+		trace_scmi_tlm_access(0, "BLK_TS_INVALID", 0, 0);
+		return;
+	}
+
+	/* A BLK_TS descriptor MUST be returned: it is found or it is created */
+	bts = scmi_telemetry_blkts_get_or_create(ti->ph->dev,
+						 &ti->xa_lines, payld);
+	if (WARN_ON(!bts))
+		return;
+
+	/* Update the descriptor with the lastest TS */
+	scmi_telemetry_blkts_update(ti, shmti->last_magic, bts);
+	*active_bts = bts;
+}
+
+static inline struct telemetry_de *
+scmi_telemetry_tde_allocate(struct telemetry_info *ti, u32 de_id,
+			    struct payload __iomem *payld)
+{
+	struct telemetry_de *tde;
+
+	tde = scmi_telemetry_tde_get(ti, de_id);
+	if (IS_ERR(tde))
+		return NULL;
+
+	tde->de.info->id = de_id;
+	tde->de.enabled = true;
+	tde->de.tstamp_enabled = LINE_TS_VALID(payld) || USE_BLK_TS(payld);
+
+	if (scmi_telemetry_tde_register(ti, tde)) {
+		scmi_telemetry_free_tde_put(ti, tde);
+		return NULL;
+	}
+
+	scmi_telemetry_de_state_update(ti, ENA_STATE, NULL, true);
+	if (tde->de.tstamp_enabled)
+		scmi_telemetry_de_state_update(ti, ENA_TSTAMP, NULL, true);
+
+	return tde;
+}
+
+static inline void
+scmi_telemetry_line_data_parse(struct telemetry_de *tde, u64 *val, u64 *tstamp,
+			       struct payload __iomem *payld, u32 magic)
+{
+	/* Data is always valid since we are NOT handling BLK TS lines here */
+	*val = LINE_DATA_GET(&payld->l);
+	if (tstamp) {
+		if (USE_BLK_TS(payld)) {
+			/* Read out the actual BLK_TS */
+			*tstamp = scmi_telemetry_blkts_read(magic, tde->bts);
+		} else if (LINE_TS_VALID(payld)) {
+			/*
+			 * Note that LINE_TS_VALID implies HAS_LINE_EXT and that
+			 * the per DE line_ts_rate is advertised in the DE
+			 * descriptor.
+			 */
+			*tstamp = LINE_TSTAMP_GET(&payld->tsl);
+		} else {
+			*tstamp = 0;
+		}
+	}
+
+	trace_scmi_tlm_collect(tstamp ? *tstamp : 0, tde->de.info->id,
+			       *val, "SHMTI_DE_READ");
+
+	scmi_telemetry_tde_cache_update(tde, *val, tstamp, &magic);
+}
+
+static inline void scmi_telemetry_bts_link(struct telemetry_de *tde,
+					   struct telemetry_block_ts *bts)
+{
+	refcount_inc(&bts->line.users);
+	tde->bts = bts;
+	/* Update TS clock rate if provided by the BLK_TS */
+	if (tde->bts->last_rate)
+		tde->de.info->ts_rate = tde->bts->last_rate;
+}
+
+static inline void scmi_telemetry_uuid_link(struct telemetry_de *tde,
+					    struct telemetry_uuid *uuid)
+{
+	refcount_inc(&uuid->line.users);
+	tde->uuid = uuid;
+}
+
+/**
+ * scmi_telemetry_tdcf_data_parse  - TDCF DataLine parsing
+ * @ti: A reference to the telemetry info descriptor
+ * @payld: Line payload to parse
+ * @shmti: A reference to the containing SHMTI area
+ * @mode: A flag to determine the behaviour of the scan
+ * @active_bts: A pointer to keep track and report any found BLK timestamp line
+ * @active_uuid: A pointer to keep track and report any found UUID line
+ *
+ * This routine takes care to:
+ *  - verify line consistency in relation to the used flags and the current
+ *    context: e.g. is there an active preceding BLK_TS line if the DataLine
+ *    sports a USE_BLKTS flag ?
+ *  - verify the related Data Event ID exists OR create a brand new DE
+ *    (depending on the @mode of operation)
+ *  - links any active BLK_TS or UUID line to the current DE
+ *  - read and save value/tstamp for the DE ONLY if anything has changed (by
+ *    tracking the last TDCF magic) and update related magic: this allows to
+ *    minimize future needs of single-DE reads
+ *
+ *    Modes of operation.
+ *
+ *    The scan behaviour depends on the chosen @mode:
+ *    - SCAN_LOOKUP: the basic scan which aims to update value associated to
+ *		     existing DEs. Any discovered DataLine that could NOT be
+ *		     matched to an existing, previously discovered, DE is
+ *		     discarded. This is the normal scan behaviour.
+ *    - SCAN_UPDATE: a more advanced scan which provides all the SCAN_LOOKUP
+ *		     features plus takes care to update the DEs location
+ *		     coordinates inside the SHMTI: note that the related DEs are
+ *		     still supposed to have been previously discovered when
+ *		     this scan runs. This is used to update location
+ *		     coordinates for DEs contained in a Group when such group
+ *		     is enabled.
+ *    - SCAN_DISCOVERY: the most advanced scan available which provides all
+ *			the SCAN_LOOKUP features plus discovery capabilities:
+ *			any DataLine referring to a previously unknown DE leads
+ *			to the allocation of a new DE descriptor.
+ *			This mode is used on the first scan at init time, ONLY
+ *			if Telemetry was found to be already enabled at boot on
+ *			the platform side: this helps to maximize gathered
+ *			information when dealing with out of spec firmwares.
+ *			Any usage of this discovery mode other than in a boot-on
+ *			enabled scenario is discouraged since it can easily
+ *			lead to spurious DE discoveries.
+ */
+static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
+					   struct payload __iomem *payld,
+					   struct telemetry_shmti *shmti,
+					   enum scan_mode mode,
+					   void *active_bts, void *active_uuid)
+{
+	bool use_blk_ts = USE_BLK_TS(payld);
+	struct telemetry_de *tde;
+	u64 val, tstamp = 0;
+	u32 de_id;
+
+	de_id = PAYLD_ID(payld);
+	/* Discard malformed lines...a preceding BLK_TS must exist */
+	if (use_blk_ts && !active_bts) {
+		trace_scmi_tlm_access(de_id, "BAD_USE_BLK_TS", 0, 0);
+		return;
+	}
+
+	/* Is this DE ID known ? */
+	tde = scmi_telemetry_tde_lookup(ti, de_id);
+	if (!tde) {
+		if (mode != SCAN_DISCOVERY) {
+			trace_scmi_tlm_access(de_id, "DE_INVALID", 0, 0);
+			return;
+		}
+
+		/* In SCAN_DISCOVERY mode we allocate new DEs for unknown IDs */
+		tde = scmi_telemetry_tde_allocate(ti, de_id, payld);
+		if (!tde)
+			return;
+	}
+
+	/* Update DE location refs if requested: normally done only on enable */
+	if (mode >= SCAN_UPDATE) {
+		tde->base = shmti->base;
+		tde->eplg = SHMTI_EPLG(shmti);
+		tde->offset = (void *)payld - (void *)shmti->base;
+
+		dev_dbg(ti->ph->dev,
+			"TDCF-updated DE_ID:0x%08X - shmti:%pK  offset:%u\n",
+			tde->de.info->id, tde->base, tde->offset);
+	}
+
+	/* Has any value/tstamp really changed ?*/
+	if (scmi_telemetry_tde_cache_unchanged(tde, shmti->last_magic))
+		return;
+
+	/* Link the related BTS when needed, it's unlinked on disable */
+	if (use_blk_ts && !tde->bts)
+		scmi_telemetry_bts_link(tde, active_bts);
+
+	/* Link the active UUID when existent, it's unlinked on disable */
+	if (active_uuid)
+		scmi_telemetry_uuid_link(tde, active_uuid);
+
+	/* Parse data words */
+	scmi_telemetry_line_data_parse(tde, &val, &tstamp, payld,
+				       shmti->last_magic);
+
+}
+
+static int scmi_telemetry_tdcf_line_parse(struct telemetry_info *ti,
+					  struct payload __iomem *payld,
+					  struct telemetry_shmti *shmti,
+					  enum scan_mode mode,
+					  void **active_bts, void **active_uuid)
+{
+	int used_qwords;
+
+	used_qwords = LINE_LENGTH_QWORDS(payld);
+	/* Invalid lines are not an error, could simply be disabled DEs */
+	if (DATA_INVALID(payld)) {
+		trace_scmi_tlm_access(PAYLD_ID(payld), "TDCF_INVALID", 0, 0);
+		return used_qwords;
+	}
+
+	switch (LINE_TYPE(payld)) {
+	case TDCF_DATA_LINE:
+		scmi_telemetry_tdcf_data_parse(ti, payld, shmti, mode,
+					       *active_bts, *active_uuid);
+		break;
+	case TDCF_BLK_TS_LINE:
+		scmi_telemetry_tdcf_blkts_parse(ti, payld, shmti, active_bts);
+		break;
+	case TDCF_UUID_LINE:
+		scmi_telemetry_tdcf_uuid_parse(ti, payld, shmti, active_uuid);
+		break;
+	default:
+		trace_scmi_tlm_access(PAYLD_ID(payld), "TDCF_UNKNOWN", 0, 0);
+		break;
+	}
+
+	return used_qwords;
+}
+
+/**
+ * scmi_telemetry_shmti_scan  - Full SHMTI scan
+ * @ti: A reference to the telemetry info descriptor
+ * @shmti_id: ID of the SHMTI area that has to be scanned
+ * @mode: A flag to determine the behaviour of the scan
+ *
+ * Return: 0 on Success
+ */
+static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
+				     unsigned int shmti_id, enum scan_mode mode)
+{
+	struct telemetry_shmti *shmti = &ti->shmti[shmti_id];
+	struct tdcf __iomem *tdcf = shmti->base;
+	int retries = SCMI_TLM_TDCF_MAX_RETRIES;
+	u32 startm = 0, endm = TDCF_BAD_END_SEQ;
+
+	if (!tdcf)
+		return -ENODEV;
+
+	do {
+		void *active_bts = NULL, *active_uuid = NULL;
+		unsigned int qwords;
+		void __iomem *next;
+
+		/* A bit of exponential backoff between retries */
+		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);
+
+		/*
+		 * Note that during a full SHMTI scan the magic seq numbers are
+		 * checked only at the start and at the end of the scan, NOT
+		 * between each parsed line and this has these consequences:
+		 *  - TDCF magic numbers accesses are reduced to 2 reads
+		 *  - the set of values obtained from a full scan belong all
+		 *    to the same platform update (same magic number)
+		 *  - a SHMTI full scan is an all or nothing operation: when
+		 *    a potentially corrupted read is detected along the way
+		 *    (MSEQ_MISMATCH) another full scan is triggered.
+		 */
+		startm = TDCF_START_SEQ_GET(tdcf);
+		if (IS_BAD_START_SEQ(startm)) {
+			trace_scmi_tlm_access(0, "MSEQ_BADSTART", startm, 0);
+			continue;
+		}
+
+		/* On a BAD_SEQ this will be updated on the next attempt */
+		shmti->last_magic = startm;
+
+		qwords = QWORDS(tdcf);
+		next = tdcf->payld;
+		while (qwords) {
+			int used_qwords;
+
+			used_qwords = scmi_telemetry_tdcf_line_parse(ti, next,
+								     shmti, mode,
+								     &active_bts,
+								     &active_uuid);
+			if (qwords < used_qwords) {
+				trace_scmi_tlm_access(PAYLD_ID(next),
+						      "BAD_QWORDS", startm, 0);
+				return -EINVAL;
+			}
+
+			next += used_qwords * 8;
+			qwords -= used_qwords;
+		}
+
+		endm = TDCF_END_SEQ_GET(SHMTI_EPLG(shmti));
+		if (startm != endm)
+			trace_scmi_tlm_access(0, "MSEQ_MISMATCH", startm, endm);
+	} while (startm != endm && --retries);
+
+	if (startm != endm) {
+		trace_scmi_tlm_access(0, "TDCF_SCAN_FAIL", startm, endm);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
 static const struct scmi_telemetry_proto_ops tlm_proto_ops = {
 	.info_get = scmi_telemetry_info_get,
 	.de_lookup = scmi_telemetry_de_lookup,
@@ -1211,6 +1830,13 @@ static void scmi_telemetry_resources_free(void *arg)
 	struct telemetry_info *ti = arg;
 	struct scmi_telemetry_res_info *rinfo = ACCESS_PRIVATE(ti, rinfo);
 
+	/*
+	 * Unlinking all the BLK_TS/UUID lines related to a DE triggers also
+	 * the deallocation of such lines when the embedded refcount hits zero.
+	 */
+	for (int i = 0; i < rinfo->num_des; i++)
+		scmi_telemetry_de_unlink(rinfo->des[i]);
+
 	kfree(ti->tdes);
 	kfree(rinfo->des);
 	kfree(rinfo->dei_store);
@@ -1316,6 +1942,9 @@ static int scmi_telemetry_instance_init(struct telemetry_info *ti)
 		return ret;
 
 	xa_init(&ti->xa_des);
+	xa_init(&ti->xa_lines);
+	atomic_set(&ti->des_enabled[ENA_STATE], 0);
+	atomic_set(&ti->des_enabled[ENA_TSTAMP], 0);
 	/* Setup resources lazy initialization */
 	atomic_set(&ti->rinfo_initializing, 0);
 	init_completion(&ti->rinfo_initdone);
-- 
2.54.0

