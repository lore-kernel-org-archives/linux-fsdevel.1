Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CEC3E0243;
	Fri, 12 Jun 2026 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304015; cv=none; b=AI3YMyMpYDnfdZhcYoZSsjTUEXdgA9oYcpcJ6WkJ7DAwCi++unKA0qBVQqBz5APPMiFoxpTp/ou+vGVTryg/xoOmH69qR18gHEp5bhp9V5gJ7/6S9oUNanpqyt+fFCGT+vB6qirL+J/QQw/lep8fv51tfl3nbrYgPZCJdYQF+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304015; c=relaxed/simple;
	bh=iJPklCmkST3EdkOX6tIdGL0vlY6hcfuqOTGz9gQHOL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slYR3YtoWPXJF3zegIQM9vMllCdgE3LFci+XDS4GHjxOmPV0/zSfrCEk93EhlXqc35JbXAeQuk98mtpa2nYAE39kzfjNX1XxWzhbeF++5kGorZdHWku+rw3O+tpaVZoQpK5oI7GCG1/OITmAu7inOtgw+EZbM96J5EjpA4BvHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Zn4OuIrz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Zn4OuIrz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09F0449FF;
	Fri, 12 Jun 2026 15:40:08 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAC823FB7F;
	Fri, 12 Jun 2026 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781304012; bh=iJPklCmkST3EdkOX6tIdGL0vlY6hcfuqOTGz9gQHOL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zn4OuIrzDbh/uh/ijIfAkT9b+T+OnRUGheWDt9MzPYa4MisWI1wyl4r0d/MWKj6eS
	 WzH4gC+i1S8HODpih4o345gxxEngO8RQggIv5VCFKGlhp+43JbFKWvWGWt3g4oOJxH
	 qjShbU/SBFbc9Fm9nS3YmXcZ6+1AtSnCFR75he5M=
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
Subject: [PATCH v4 23/31] firmware: arm_scmi: stlmfs: Add ioctls support
Date: Fri, 12 Jun 2026 23:37:53 +0100
Message-ID: <20260612223802.1337232-24-cristian.marussi@arm.com>
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

Extend the filesystem based interface with special 'control' files that can
be used to configure and retrieve SCMI Telemetry data in binary form using
the ioctls-based ABI described in uapi/linux/scmi.h.

This alternative ABI is meant to provide a more performant access to SCMI
Telemetry configuration and data events, without the hassle of navigating
the human readable VFS based intwerface.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
 - make FS entries world-Readable and user-Writable where applicable
 - consider default umask when defining file perms
 - update Telemetry ioctl state query caller with tracking data
 - added stlmfs tag in $SUBJECT
v1 --> v2
 - Use new res_get() operation which use new resource accessors
 - Use new de_lookup() tlm_ops
 - Using cleanup.h
 - use new interval.num_intervals
---
 .../firmware/arm_scmi/scmi_system_telemetry.c | 404 ++++++++++++++++++
 1 file changed, 404 insertions(+)

diff --git a/drivers/firmware/arm_scmi/scmi_system_telemetry.c b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
index f4d284335ac0..720930f6bcd1 100644
--- a/drivers/firmware/arm_scmi/scmi_system_telemetry.c
+++ b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
@@ -26,6 +26,8 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 
+#include <uapi/linux/scmi.h>
+
 #define TLM_FS_MAGIC		0x75C01C80
 #define TLM_FS_NAME		"stlmfs"
 #define TLM_FS_MNT		"arm_telemetry"
@@ -1121,6 +1123,406 @@ DEFINE_TLM_CLASS(grp_available_interval_tlmo, "available_update_intervals_ms",
 DEFINE_TLM_CLASS(grp_intervals_discrete_tlmo, "intervals_discrete",
 		 TLM_IS_GROUP, S_IFREG | 0444, &intrv_discrete_fops, NULL);
 
+static long
+scmi_tlm_info_get_ioctl(const struct scmi_tlm_inode *tlmi, unsigned long arg)
+{
+	const struct scmi_telemetry_info *info = tlmi->priv;
+	void * __user uptr = (void * __user)arg;
+
+	if (copy_to_user(uptr, &info->base, sizeof(info->base)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+scmi_tlm_intervals_get_ioctl(const struct scmi_tlm_inode *tlmi,
+			     unsigned long arg, bool is_group)
+{
+	struct scmi_tlm_intervals ivs, *tlm_ivs;
+	void * __user uptr = (void * __user)arg;
+
+	if (copy_from_user(&ivs, uptr, sizeof(ivs)))
+		return -EFAULT;
+
+	if (!is_group) {
+		const struct scmi_telemetry_info *info = tlmi->priv;
+
+		tlm_ivs = info->intervals;
+	} else {
+		const struct scmi_telemetry_group *grp = tlmi->priv;
+
+		tlm_ivs = grp->intervals;
+	}
+
+	if (ivs.num_intervals != tlm_ivs->num_intervals)
+		return -EINVAL;
+
+	if (copy_to_user(uptr, tlm_ivs,
+			 sizeof(*tlm_ivs) + sizeof(u32) * ivs.num_intervals))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+scmi_tlm_de_config_set_ioctl(const struct scmi_tlm_inode *tlmi,
+			     unsigned long arg, bool all)
+{
+	const struct scmi_telemetry_res_info *rinfo;
+	void * __user uptr = (void * __user)arg;
+	struct scmi_tlm_setup *tsp = tlmi->tsp;
+	struct scmi_tlm_de_config tcfg = {};
+	int ret;
+
+	if (copy_from_user(&tcfg, uptr, sizeof(tcfg)))
+		return -EFAULT;
+
+	if (!all)
+		return tsp->ops->state_set(tsp->ph, false, tcfg.id,
+					   (bool *)&tcfg.enable,
+					   (bool *)&tcfg.t_enable);
+
+	rinfo = scmi_telemetry_res_info_get(tsp);
+	for (int i = 0; i < rinfo->num_des; i++) {
+		ret = tsp->ops->state_set(tsp->ph, false,
+					  rinfo->des[i]->info->id,
+					  (bool *)&tcfg.enable,
+					  (bool *)&tcfg.t_enable);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static long
+scmi_tlm_de_config_get_ioctl(const struct scmi_tlm_inode *tlmi,
+			     unsigned long arg)
+{
+	struct scmi_tlm_setup *tsp = tlmi->tsp;
+	void * __user uptr = (void * __user)arg;
+	struct scmi_tlm_de_config tcfg = {};
+	int ret;
+
+	if (copy_from_user(&tcfg, uptr, sizeof(tcfg)))
+		return -EFAULT;
+
+	ret = tsp->ops->state_get(tsp->ph, &tcfg.id,
+				  (bool *)&tcfg.enable, (bool *)&tcfg.t_enable);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(uptr, &tcfg, sizeof(tcfg)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+scmi_tlm_config_get_ioctl(const struct scmi_tlm_inode *tlmi, unsigned long arg,
+			  bool is_group)
+{
+	void * __user uptr = (void * __user)arg;
+	struct scmi_tlm_config cfg;
+
+	if (!is_group) {
+		const struct scmi_telemetry_info *info = tlmi->priv;
+
+		cfg.enable = !!info->enabled;
+		cfg.current_update_interval = info->active_update_interval;
+	} else {
+		const struct scmi_telemetry_group *grp = tlmi->priv;
+
+		cfg.enable = !!grp->enabled;
+		cfg.t_enable = !!grp->tstamp_enabled;
+		cfg.current_update_interval = grp->active_update_interval;
+	}
+
+	if (copy_to_user(uptr, &cfg, sizeof(cfg)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+scmi_tlm_config_set_ioctl(const struct scmi_tlm_inode *tlmi, unsigned long arg,
+			  bool is_group)
+{
+	struct scmi_tlm_setup *tsp = tlmi->tsp;
+	void * __user uptr = (void * __user)arg;
+	struct scmi_tlm_config cfg = {};
+	bool grp_ignore;
+	int res_id;
+
+	if (copy_from_user(&cfg, uptr, sizeof(cfg)))
+		return -EFAULT;
+
+	if (!is_group) {
+		res_id = SCMI_TLM_GRP_INVALID;
+		grp_ignore = true;
+	} else {
+		const struct scmi_telemetry_group *grp = tlmi->priv;
+		int ret;
+
+		res_id = grp->info->id;
+		grp_ignore = false;
+		ret = tsp->ops->state_set(tsp->ph, true, res_id,
+					  (bool *)&cfg.enable,
+					  (bool *)&cfg.t_enable);
+		if (ret)
+			return ret;
+	}
+
+	return tsp->ops->collection_configure(tsp->ph, res_id, grp_ignore,
+					      (bool *)&cfg.enable,
+					      &cfg.current_update_interval,
+					      NULL);
+}
+
+static long
+scmi_tlm_de_info_get_ioctl(const struct scmi_tlm_inode *tlmi, unsigned long arg)
+{
+	struct scmi_tlm_setup *tsp = tlmi->tsp;
+	void * __user uptr = (void * __user)arg;
+	const struct scmi_telemetry_de *de;
+	struct scmi_tlm_de_info dei;
+
+	if (copy_from_user(&dei, uptr, sizeof(dei)))
+		return -EFAULT;
+
+	de = tsp->ops->de_lookup(tsp->ph, dei.id);
+	if (!de)
+		return -EINVAL;
+
+	if (copy_to_user(uptr, de->info, sizeof(*de->info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+scmi_tlm_des_list_get_ioctl(const struct scmi_tlm_inode *tlmi, unsigned long arg)
+{
+	struct scmi_tlm_setup *tsp = tlmi->tsp;
+	const struct scmi_telemetry_res_info *rinfo;
+	void * __user uptr = (void * __user)arg;
+	struct scmi_tlm_des_list dsl;
+
+	rinfo = scmi_telemetry_res_info_get(tsp);
+	if (copy_from_user(&dsl, uptr, sizeof(dsl)))
+		return -EFAULT;
+
+	if (dsl.num_des < rinfo->num_des)
+		return -EINVAL;
+
+	if (copy_to_user(uptr, &rinfo->num_des, sizeof(rinfo->num_des)))
+		return -EFAULT;
+
+	if (copy_to_user(uptr + sizeof(rinfo->num_des), rinfo->dei_store,
+			 rinfo->num_des * sizeof(*rinfo->dei_store)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+scmi_tlm_de_value_get_ioctl(const struct scmi_tlm_inode *tlmi, unsigned long arg)
+{
+	struct scmi_tlm_setup *tsp = tlmi->tsp;
+	void * __user uptr = (void * __user)arg;
+	struct scmi_tlm_de_sample sample;
+	int ret;
+
+	if (copy_from_user(&sample, uptr, sizeof(sample)))
+		return -EFAULT;
+
+	ret = tsp->ops->de_data_read(tsp->ph,
+				     (struct scmi_telemetry_de_sample *)&sample);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(uptr, &sample, sizeof(sample)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+scmi_tlm_grp_info_get_ioctl(const struct scmi_tlm_inode *tlmi, unsigned long arg)
+{
+	const struct scmi_telemetry_group *grp = tlmi->priv;
+	void * __user uptr = (void * __user)arg;
+
+	if (copy_to_user(uptr, grp->info, sizeof(*grp->info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+scmi_tlm_grp_desc_get_ioctl(const struct scmi_tlm_inode *tlmi, unsigned long arg)
+{
+	const struct scmi_telemetry_group *grp = tlmi->priv;
+	unsigned int num_des = grp->info->num_des;
+	void * __user uptr = (void * __user)arg;
+	struct scmi_tlm_grp_desc grp_desc;
+
+	if (copy_from_user(&grp_desc, uptr, sizeof(grp_desc)))
+		return -EFAULT;
+
+	if (grp_desc.num_des < num_des)
+		return -EINVAL;
+
+	if (copy_to_user(uptr, &num_des, sizeof(num_des)))
+		return -EFAULT;
+
+	if (copy_to_user(uptr + sizeof(num_des), grp->des,
+			 sizeof(*grp->des) * num_des))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+scmi_tlm_grps_list_get_ioctl(const struct scmi_tlm_inode *tlmi, unsigned long arg)
+{
+	struct scmi_tlm_setup *tsp = tlmi->tsp;
+	const struct scmi_telemetry_res_info *rinfo;
+	void * __user uptr = (void * __user)arg;
+	struct scmi_tlm_grps_list gsl;
+
+	if (copy_from_user(&gsl, uptr, sizeof(gsl)))
+		return -EFAULT;
+
+	rinfo = scmi_telemetry_res_info_get(tsp);
+	if (gsl.num_grps < rinfo->num_groups)
+		return -EINVAL;
+
+	if (copy_to_user(uptr, &rinfo->num_groups, sizeof(rinfo->num_groups)))
+		return -EFAULT;
+
+	if (copy_to_user(uptr + sizeof(rinfo->num_groups), rinfo->grps_store,
+			 rinfo->num_groups * sizeof(*rinfo->grps_store)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long scmi_tlm_des_read_ioctl(const struct scmi_tlm_inode *tlmi,
+				    unsigned long arg, bool single,
+				    bool is_group)
+{
+	struct scmi_tlm_setup *tsp = tlmi->tsp;
+	void * __user uptr = (void * __user)arg;
+	struct scmi_tlm_data_read bulk;
+	int ret, grp_id = SCMI_TLM_GRP_INVALID;
+
+	if (copy_from_user(&bulk, uptr, sizeof(bulk)))
+		return -EFAULT;
+
+	struct scmi_tlm_data_read *bulk_ptr __free(kfree) =
+		kzalloc(struct_size(bulk_ptr, samples, bulk.num_samples),
+			GFP_KERNEL);
+	if (!bulk_ptr)
+		return -ENOMEM;
+
+	if (is_group) {
+		const struct scmi_telemetry_group *grp = tlmi->priv;
+
+		grp_id = grp->info->id;
+	}
+
+	bulk_ptr->num_samples = bulk.num_samples;
+	if (!single)
+		ret = tsp->ops->des_bulk_read(tsp->ph, grp_id,
+					      &bulk_ptr->num_samples,
+			  (struct scmi_telemetry_de_sample *)bulk_ptr->samples);
+	else
+		ret = tsp->ops->des_sample_get(tsp->ph, grp_id,
+					       &bulk_ptr->num_samples,
+					       (struct scmi_telemetry_de_sample *)bulk_ptr->samples);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(uptr, bulk_ptr, sizeof(*bulk_ptr) +
+			 bulk_ptr->num_samples * sizeof(bulk_ptr->samples[0])))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long scmi_tlm_unlocked_ioctl(struct file *filp, unsigned int cmd,
+				    unsigned long arg)
+{
+	struct scmi_tlm_inode *tlmi = to_tlm_inode(file_inode(filp));
+	bool is_group = IS_GROUP(tlmi->cls->flags);
+
+	switch (cmd) {
+	case SCMI_TLM_GET_INFO:
+		if (is_group)
+			return -EOPNOTSUPP;
+		return scmi_tlm_info_get_ioctl(tlmi, arg);
+	case SCMI_TLM_GET_CFG:
+		return scmi_tlm_config_get_ioctl(tlmi, arg, is_group);
+	case SCMI_TLM_SET_CFG:
+		return scmi_tlm_config_set_ioctl(tlmi, arg, is_group);
+	case SCMI_TLM_GET_INTRVS:
+		return scmi_tlm_intervals_get_ioctl(tlmi, arg, is_group);
+	case SCMI_TLM_GET_DE_CFG:
+		if (is_group)
+			return -EOPNOTSUPP;
+		return scmi_tlm_de_config_get_ioctl(tlmi, arg);
+	case SCMI_TLM_SET_DE_CFG:
+		if (is_group)
+			return -EOPNOTSUPP;
+		return scmi_tlm_de_config_set_ioctl(tlmi, arg, false);
+	case SCMI_TLM_GET_DE_INFO:
+		if (is_group)
+			return -EOPNOTSUPP;
+		return scmi_tlm_de_info_get_ioctl(tlmi, arg);
+	case SCMI_TLM_GET_DE_LIST:
+		if (is_group)
+			return -EOPNOTSUPP;
+		return scmi_tlm_des_list_get_ioctl(tlmi, arg);
+	case SCMI_TLM_GET_DE_VALUE:
+		if (is_group)
+			return -EOPNOTSUPP;
+		return scmi_tlm_de_value_get_ioctl(tlmi, arg);
+	case SCMI_TLM_SET_ALL_CFG:
+		return scmi_tlm_de_config_set_ioctl(tlmi, arg, true);
+	case SCMI_TLM_GET_GRP_LIST:
+		if (is_group)
+			return -EOPNOTSUPP;
+		return scmi_tlm_grps_list_get_ioctl(tlmi, arg);
+	case SCMI_TLM_GET_GRP_INFO:
+		if (!is_group)
+			return -EOPNOTSUPP;
+		return scmi_tlm_grp_info_get_ioctl(tlmi, arg);
+	case SCMI_TLM_GET_GRP_DESC:
+		if (!is_group)
+			return -EOPNOTSUPP;
+		return scmi_tlm_grp_desc_get_ioctl(tlmi, arg);
+	case SCMI_TLM_SINGLE_SAMPLE:
+		return scmi_tlm_des_read_ioctl(tlmi, arg, true, is_group);
+	case SCMI_TLM_BULK_READ:
+		return scmi_tlm_des_read_ioctl(tlmi, arg, false, is_group);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static const struct file_operations scmi_tlm_ctrl_fops = {
+	.owner = THIS_MODULE,
+	.open = nonseekable_open,
+	.unlocked_ioctl = scmi_tlm_unlocked_ioctl,
+};
+
+DEFINE_TLM_CLASS(ctrl_tlmo, "control", 0,
+		 S_IFREG | 0666, &scmi_tlm_ctrl_fops, NULL);
+DEFINE_TLM_CLASS(grp_ctrl_tlmo, "control", TLM_IS_GROUP,
+		 S_IFREG | 0666, &scmi_tlm_ctrl_fops, NULL);
+
 static int scmi_telemetry_groups_initialize(struct scmi_tlm_instance *ti)
 {
 	const struct scmi_telemetry_res_info *rinfo;
@@ -1160,6 +1562,7 @@ static int scmi_telemetry_groups_initialize(struct scmi_tlm_instance *ti)
 		stlmfs_create_dentry(sb, tsp, grp_dir_dentry,
 				     &grp_composing_des_tlmo, grp->des_str);
 
+		stlmfs_create_dentry(sb, tsp, grp_dir_dentry, &grp_ctrl_tlmo, grp);
 		stlmfs_create_dentry(sb, tsp, grp_dir_dentry, &grp_data_tlmo, grp);
 		if (ti->info->single_read_support)
 			stlmfs_create_dentry(sb, tsp, grp_dir_dentry,
@@ -1375,6 +1778,7 @@ static int scmi_tlm_root_dentries_initialize(struct scmi_tlm_instance *ti)
 	if (ti->info->single_read_support)
 		stlmfs_create_dentry(sb, tsp, ti->top_dentry,
 				     &single_sample_tlmo, ti->info);
+	stlmfs_create_dentry(sb, tsp, ti->top_dentry, &ctrl_tlmo, ti->info);
 	ti->des_dentry =
 		stlmfs_create_dentry(sb, tsp, ti->top_dentry, &des_dir_cls, NULL);
 	ti->grps_dentry =
-- 
2.54.0

