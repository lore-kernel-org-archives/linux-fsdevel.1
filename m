Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765CC38422A;
	Sun, 29 Mar 2026 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802112; cv=none; b=LHxJj9IUquu/fffzWb4wJGUd53ZQcW7LZi0I7EEhMrknLxNt2JWo8icGaOBsFxwqWfKF6iZKJi9kHU2qRthLmn24sW8aZeg60odaj5nWq3u7YgyDrFWB4fNhrJ57aaE8FtpLNDzsfE8maAqYS7FkXJeQAsDwIb/IjJQlJ7GFcOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802112; c=relaxed/simple;
	bh=I3dyXn36TXt78tvaGyYCPvuvcN/0eUpHS6Jjf0pgSqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unb5po6l3sXm2KLxM3vG56KlEH+e3quC7IxKotEBADKgunOXqhjJvPG3dqQ8/M8t/aVYVezdopHSmx8id06YwvNG868HLOp3EvDzHsxhn3dXmZTPNZ9RZ1UKKilCWucBjsK04dndCbbe2Zdb8Glfyo6JXcqHSQ3bdRkBAeSuO1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Yt/HaCv5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Yt/HaCv5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 012774387;
	Sun, 29 Mar 2026 09:35:04 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0138A3F915;
	Sun, 29 Mar 2026 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774802109; bh=I3dyXn36TXt78tvaGyYCPvuvcN/0eUpHS6Jjf0pgSqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yt/HaCv548Czb7m4641urAPbmt4BKTQ5j3kQqld3/9Ttf0DLBqof3nGoxeOvBSLP4
	 MRcnHFu5rTS3fkK+2kN4KW5m75LfPIjxbWapdoboS7h8Dwwhr76Ls0hjEg7sMwBLwz
	 +YZYnLTcPksEgFHUZYL0BYDpi8l4Y4TTcP665IAU=
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
Subject: [PATCH v3 17/24] firmware: arm_scmi: Add System Telemetry ioctls support
Date: Sun, 29 Mar 2026 17:33:28 +0100
Message-ID: <20260329163337.637393-18-cristian.marussi@arm.com>
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

Extend the filesystem based interface with special 'control' files that can
be used to configure and retrieve SCMI Telemetry data in binary form using
the ioctls-based ABI described in uapi/linux/scmi.h.

This alternative ABI is meant to provide a more performant access to SCMI
Telemetry configuration and data events, without the hassle of navigating
the human readable VFS based intwerface.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
 - Use new res_get() operation which use new resource accessors
 - Use new de_lookup() tlm_ops
 - Using cleanup.h
 - use new interval.num_intervals
---
 .../firmware/arm_scmi/scmi_system_telemetry.c | 404 ++++++++++++++++++
 1 file changed, 404 insertions(+)

diff --git a/drivers/firmware/arm_scmi/scmi_system_telemetry.c b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
index e850fc57c609..9ac9138e5e30 100644
--- a/drivers/firmware/arm_scmi/scmi_system_telemetry.c
+++ b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
@@ -24,6 +24,8 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 
+#include <uapi/linux/scmi.h>
+
 #define TLM_FS_MAGIC		0x75C01C80
 #define TLM_FS_NAME		"stlmfs"
 #define TLM_FS_MNT		"arm_telemetry"
@@ -1076,6 +1078,406 @@ DEFINE_TLM_CLASS(grp_available_interval_tlmo, "available_update_intervals_ms",
 DEFINE_TLM_CLASS(grp_intervals_discrete_tlmo, "intervals_discrete",
 		 TLM_IS_GROUP, S_IFREG | S_IRUSR, &intrv_discrete_fops, NULL);
 
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
+	ret = tsp->ops->state_get(tsp->ph, tcfg.id,
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
+		 S_IFREG | S_IRUSR | S_IWUSR, &scmi_tlm_ctrl_fops, NULL);
+DEFINE_TLM_CLASS(grp_ctrl_tlmo, "control", TLM_IS_GROUP,
+		 S_IFREG | S_IRUSR | S_IWUSR, &scmi_tlm_ctrl_fops, NULL);
+
 static int scmi_telemetry_groups_initialize(struct scmi_tlm_instance *ti)
 {
 	const struct scmi_telemetry_res_info *rinfo;
@@ -1115,6 +1517,7 @@ static int scmi_telemetry_groups_initialize(struct scmi_tlm_instance *ti)
 		stlmfs_create_dentry(sb, tsp, grp_dir_dentry,
 				     &grp_composing_des_tlmo, grp->des_str);
 
+		stlmfs_create_dentry(sb, tsp, grp_dir_dentry, &grp_ctrl_tlmo, grp);
 		stlmfs_create_dentry(sb, tsp, grp_dir_dentry, &grp_data_tlmo, grp);
 		stlmfs_create_dentry(sb, tsp, grp_dir_dentry,
 				     &grp_single_sample_tlmo, grp);
@@ -1299,6 +1702,7 @@ static int scmi_tlm_root_dentries_initialize(struct scmi_tlm_instance *ti)
 			     &ti->info->base.version);
 	stlmfs_create_dentry(sb, tsp, ti->top_dentry, &data_tlmo, ti->info);
 	stlmfs_create_dentry(sb, tsp, ti->top_dentry, &single_sample_tlmo, ti->info);
+	stlmfs_create_dentry(sb, tsp, ti->top_dentry, &ctrl_tlmo, ti->info);
 	ti->des_dentry =
 		stlmfs_create_dentry(sb, tsp, ti->top_dentry, &des_dir_cls, NULL);
 	ti->grps_dentry =
-- 
2.53.0

