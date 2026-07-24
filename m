Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9329E43B3EA;
	Fri, 24 Jul 2026 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904463; cv=none; b=ZY3gREi52mBKgglZPrHbGsldcOYnZaDztMqP76ax8+84lbuQyAzL0T4pHQ5YTJaEbD8o/qngepCDvIITu+hTzdhCmUGzbpm8vE26JWBlpOdb6KNlpCVh0+UlVFcry+hOqdltRNhA+8F253Kh26kNXUoWSWtUuoCQoRgtJM/5SZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904463; c=relaxed/simple;
	bh=ymv/kIKrrnqWzhOuFsecKHzmvk5BcHPvyumkcygECFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnOJBtm6qOXG0pnjCVpZnXh7L9UJPLi4WL3S78ZAUTs56YqkhJkA6mmi1ItdJfbxQvwETrfAPzq1TBzY1BLDFTMRS4b/S5ZF1mdJEZXuWuX6QM1bMbHyqRRc+n3R/Tn9tYb0lL524AL39TqA+scjsjNf3+ZabRESAUnrU9ZdKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sbYaF2hJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sbYaF2hJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 531491477;
	Fri, 24 Jul 2026 07:47:35 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 231A43F66F;
	Fri, 24 Jul 2026 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784904459; bh=ymv/kIKrrnqWzhOuFsecKHzmvk5BcHPvyumkcygECFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbYaF2hJZ//Lk94h2jBweu4+XZhN8Q//sgm67dFkz38d1mDVabrFLEyajOvZh7fRA
	 QF3du53GObkM7b1j8Kwvd5nqFn/ZLCC8ZiQnasJnK5Umz41GA8PXg7gFSDBRAi1YuE
	 2d0YmuJgpNKamTX0uJEbYvIPZSoNy+UeZ7egyhC0=
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
Subject: [PATCH v6 18/22] uapi: Add ARM SCMI Telemetry definitions
Date: Fri, 24 Jul 2026 15:44:26 +0100
Message-ID: <20260724144430.1440170-19-cristian.marussi@arm.com>
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

Add a number of structures and ioctls definitions used by the ARM
SCMI Telemetry protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v5 --> v6
 - Fixed interval exp to be __s32 as documented
 - Using a more unique name for IOCTL MAGIC define
 - Renamed a few IOCTLs to be consistent
 - redefine primary UUID as an array of u8
 - add GET_ABI_INFO to gather ABI version and instance info
 - add RESET support
 - fixed typos in kdoc
v4 --> v5
 - Added more structure padding
 - Removed frowned upon flexible array in favour of u64 pointers to external
   userspace provided buffer
 - Added UAPI support to access SHMTIs from userspace
 - Cleaned up Doxygen
v2 --> v3
 - Change tstamp_exp tp ts_rate
 - renamed num -> num_intervals in scmi_tlm_interval
 - added padding in scmi_tlm_de_sample to avoid packing issues on 32bit
v1 --> v2
 - Added proper __counted_by marks
 - Fixed a few dox comments
 - Renamed reserved[] fields to pad[]
---
 MAINTAINERS               |   1 +
 include/uapi/linux/scmi.h | 373 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 374 insertions(+)
 create mode 100644 include/uapi/linux/scmi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a674e36529f7..6587cba09aae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26305,6 +26305,7 @@ F:	drivers/regulator/scmi-regulator.c
 F:	drivers/reset/reset-scmi.c
 F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
+F:	include/uapi/linux/scmi.h
 F:	include/uapi/linux/virtio_scmi.h
 
 SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX Extension Message Protocol drivers
diff --git a/include/uapi/linux/scmi.h b/include/uapi/linux/scmi.h
new file mode 100644
index 000000000000..3684d390be06
--- /dev/null
+++ b/include/uapi/linux/scmi.h
@@ -0,0 +1,373 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2026 ARM Ltd.
+ */
+#ifndef _UAPI_LINUX_SCMI_H
+#define _UAPI_LINUX_SCMI_H
+
+/*
+ * Userspace interface SCMI Telemetry
+ */
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define SCMI_TLM_ABI_VERSION_V1			1
+#define SCMI_TLM_CURRENT_ABI_VERSION		SCMI_TLM_ABI_VERSION_V1
+
+#define SCMI_TLM_DE_IMPL_UUID_MAX	16
+
+/**
+ * struct scmi_tlm_abi_info - Basic information on the ABI/instance
+ *
+ * @size: sizeof this structure
+ * @abi_version: ABI Version
+ * @abi_features: ABI capabilities bitmap
+ * @de_impl_version: SCMI Telemetry DE implementation revision
+ * @num_des: Number of defined DEs
+ * @num_groups: Number of defined DEs groups
+ * @num_intervals: Number of available update intervals (instance-level)
+ * @num_shmtis: Number of discovered SHMTI areas
+ * @features: Instance specific SCMI feature-support bitmap
+ * @reserved: Some room for future expansion without the need to resize
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_ABI_INFO
+ */
+struct scmi_tlm_abi_info {
+	__u32 size;
+	__u32 abi_version;
+	__u32 abi_features;
+#define SCMI_TLM_ABI_FEAT_RESET				(1 << 0)
+	__u8 de_impl_version[SCMI_TLM_DE_IMPL_UUID_MAX];
+	__u32 num_des;
+	__u32 num_groups;
+	__u32 num_intervals;
+	__u32 num_shmtis;
+	__u32 features;
+#define SCMI_TLM_BASE_SUPPORT_RESET			(1 << 0)
+#define SCMI_TLM_BASE_SUPPORT_SINGLE_SAMPLE		(1 << 1)
+#define SCMI_TLM_BASE_SUPPORT_GROUP_CONFIG		(1 << 2)
+#define SCMI_TLM_BASE_SUPPORT_UPDATE_NOTIFICATION	(1 << 3)
+	__u64 reserved;
+};
+
+/**
+ * struct scmi_tlm_update_interval  - Update interval descriptor
+ *
+ * @secs: integer representing seconds
+ * @exp: signed integer representing the base 10 exponent used as a multiplier
+ *	 with @secs to represent the interval
+ *
+ * The resulting update interval is calculated as: <secs> * 10 ^ <exp>
+ */
+struct scmi_tlm_update_interval {
+	__u32 secs;
+	__s32 exp;
+};
+
+/**
+ * struct scmi_tlm_config  - Whole instance or group configuration
+ *
+ * @enable: Enable/Disable Telemetry for the whole instance or the group
+ * @t_enable: Enable/Disable timestamping for all the DEs belonging to a group
+ * @flags: Bitmask to represent special characteristics
+ * @pad: Padding fields to enforce alignment
+ * @grp_id: Identifier of the target group upon which this configuration will
+ *	    be applied: ignored if not marked as a group in @flags
+ * @active: Get/Set currently active update interval for the whole instance or
+ *	    a group
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_CFG
+ *	WO - SCMI_TLM_SET_CFG
+ */
+struct scmi_tlm_config {
+	__u8 enable;
+	__u8 t_enable;
+	__u8 flags;
+#define SCMI_TLM_CONFIG_GROUP		(1 << 0)
+#define SCMI_TLM_CONFIG_FLAGS		(SCMI_TLM_CONFIG_GROUP)
+#define SCMI_TLM_CONFIG_IS_GROUP(f)	((f) & SCMI_TLM_CONFIG_GROUP)
+	__u8 pad;
+	__u32 grp_id;
+	struct scmi_tlm_update_interval active;
+};
+
+/**
+ * struct scmi_tlm_intervals  - Update intervals descriptor
+ *
+ * @grp_id: Identifier of the target group upon which this configuration
+ *	    will be applied: ignored if not marked as a group in @flags
+ * @flags: Bitmask to represent special characteristics. When the interval
+ *	   is NOT marked as SCMI_TLM_INTERV_DISCRETE, @intervals will
+ *	   contain a triplet: min/max/step
+ * @pad: Padding fields to enforce alignment
+ * @num_intervals: Number of entries of @intervals
+ * @pad2: Padding fields to enforce alignment
+ * @intervals: A pointer to an array of struct scmi_tlm_update_interval
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_INTRVS
+ */
+struct scmi_tlm_intervals {
+	__u32 grp_id;
+	__u8 flags;
+#define SCMI_TLM_INTERV_GROUP	(1 << 0)
+#define SCMI_TLM_INTERV_DISCRETE	(1 << 1)
+#define SCMI_TLM_INTERV_FLAGS					\
+	(SCMI_TLM_INTERV_GROUP | SCMI_TLM_INTERV_DISCRETE)
+#define SCMI_TLM_INTERV_IS_GROUP(f)	((f) & SCMI_TLM_INTERV_GROUP)
+	__u8 pad[3];
+	__u32 num_intervals;
+	__u32 pad2;
+#define SCMI_TLM_UPDATE_INTVL_SEGMENT_LOW	0
+#define SCMI_TLM_UPDATE_INTVL_SEGMENT_HIGH	1
+#define SCMI_TLM_UPDATE_INTVL_SEGMENT_STEP	2
+	__u64 intervals;
+};
+
+/**
+ * struct scmi_tlm_de_config  - DE configuration
+ *
+ * @id: Identifier of the DE to act upon (ignored by SCMI_TLM_GET/SET_ALL_CFG)
+ * @enable: A boolean to enable/disable the DE
+ * @t_enable: A boolean to enable/disable the timestamp for this DE
+ *	      (if supported)
+ * @pad: Padding fields to enforce alignment
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_CFG
+ *	RW - SCMI_TLM_SET_DE_CFG
+ *	RW - SCMI_TLM_GET_ALL_CFG
+ *	RW - SCMI_TLM_SET_ALL_CFG
+ */
+struct scmi_tlm_de_config {
+	__u32 id;
+	__u32 enable;
+	__u32 t_enable;
+	__u32 pad;
+};
+
+/**
+ * struct scmi_tlm_de_info  - DataEvent Descriptor
+ *
+ * @id: DE identifier
+ * @grp_id: Identifier of the group which this DE belongs to; valid only if
+ *	    this DE is marked as belonging to a group in @flags.
+ * @data_sz: DE data size in bytes
+ * @type: DE type
+ * @unit: DE unit of measurements
+ * @unit_exp: Power-of-10 multiplier for DE unit
+ * @ts_rate: Clock rate in kHz used to generate the DE timestamp
+ * @instance_id: DE instance ID
+ * @compo_instance_id: DE component instance ID
+ * @compo_type: Type of component which is associated to this DE
+ * @persistent: Data value for this DE survives reboot (non-cold ones)
+ * @flags: Bitmask to represent special characteristics
+ * @pad: Padding fields to enforce alignment
+ * @pad2: Padding fields to enforce alignment
+ * @name: Name of this DE
+ *
+ * Used to get the full description of a DE: it reflects DE Descriptors
+ * definitions in SCMI V4.0 specification at 3.12.4.6.
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_INFO
+ */
+struct scmi_tlm_de_info {
+	__u32 id;
+	__u32 grp_id;
+	__u32 data_sz;
+	__u32 type;
+	__u32 unit;
+	__s32 unit_exp;
+	__u32 ts_rate;
+	__u32 instance_id;
+	__u32 compo_instance_id;
+	__u32 compo_type;
+	__u8 persistent;
+	__u8 flags;
+#define SCMI_TLM_DEINFO_GROUP		(1 << 0)
+#define SCMI_TLM_DEINFO_FLAGS		(SCMI_TLM_DEINFO_GROUP)
+#define SCMI_TLM_DEINFO_HAS_GROUP(f)	((f) & SCMI_TLM_DEINFO_GROUP)
+	__u8 pad[2];
+	__u32 pad2;
+	__u8 name[16];
+};
+
+/**
+ * struct scmi_tlm_des_list  - List of all defined DEs
+ *
+ * @num_des: Number of entries in @des
+ * @pad: Padding fields to enforce alignment
+ * @des: A reference to an array containing struct scmi_tlm_de_info
+ *	 descriptors for all the existent DEs
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_LIST
+ */
+struct scmi_tlm_des_list {
+	__u32 num_des;
+	__u32 pad;
+	__u64 des;
+};
+
+/**
+ * struct scmi_tlm_de_sample - A DataEvent reading
+ *
+ * @id: DE identifier
+ * @pad: Padding fields to enforce alignment.
+ * @tstamp: DE reading timestamp (0 if timestamp NOT supported)
+ * @val: Reading of the DE data value
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_VALUE
+ */
+struct scmi_tlm_de_sample {
+	__u32 id;
+	__u32 pad;
+	__u64 tstamp;
+	__u64 val;
+};
+
+/**
+ * struct scmi_tlm_data_read - Bulk read of a number of DataEvents
+ *
+ * @grp_id: Optional group ID number, ignored if not marked as a group request
+ *	    in @flags and not supported by SCMI_TLM_BATCH_READ
+ * @flags: Bitmask to represent special characteristics
+ * @pad: Padding fields to enforce alignment
+ * @pad2: Padding fields to enforce alignment
+ * @num_samples: Number of entries returned in @samples
+ * @samples: A reference to an array of struct scmi_tlm_de_sample containing
+ *	     an entry for each DE
+ *
+ * Used by:
+ *	RW - SCMI_TLM_SINGLE_SAMPLE
+ *	RW - SCMI_TLM_BULK_READ
+ *	RW - SCMI_TLM_BATCH_READ
+ */
+struct scmi_tlm_data_read {
+	__u32 grp_id;
+	__u8 flags;
+#define SCMI_TLM_READ_GROUP		(1 << 0)
+#define SCMI_TLM_READ_FLAGS		(SCMI_TLM_READ_GROUP)
+#define SCMI_TLM_READ_IS_GROUP(f)	((f) & SCMI_TLM_READ_GROUP)
+	__u8 pad[3];
+	__u32 pad2;
+	__u32 num_samples;
+	__u64 samples;
+};
+
+/**
+ * struct scmi_tlm_grp_info  - Group info descriptor
+ *
+ * @grp_id: Group ID number
+ * @num_des: Number of DEs part of this group
+ * @num_intervals: Number of update intervals supported. Zero if group does not
+ *		   support per-group update interval configuration.
+ * @pad: Padding fields to enforce alignment
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_GRP_INFO
+ */
+struct scmi_tlm_grp_info {
+	__u32 grp_id;
+	__u32 num_des;
+	__u32 num_intervals;
+	__u32 pad;
+};
+
+/**
+ * struct scmi_tlm_grps_list  - Group info descriptor list
+ *
+ * @num_grps: Number of entries returned in @grps
+ * @pad: Padding fields to enforce alignment
+ * @grps: A reference to an array of struct scmi_tlm_grp_info containing an
+ *	  entry for each defined group
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_GRP_LIST
+ */
+struct scmi_tlm_grps_list {
+	__u32 num_grps;
+	__u32 pad;
+	__u64 grps;
+};
+
+/**
+ * struct scmi_tlm_grp_desc  - Group descriptor
+ *
+ * @grp_id: Group ID number
+ * @num_des: Number of DEs composing this group
+ * @composing_des: A reference to an array of __u32 elements containing the
+ *		   DataEvent IDs composing this group.
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_GRP_DESC
+ */
+struct scmi_tlm_grp_desc {
+	__u32 grp_id;
+	__u32 num_des;
+	__u64 composing_des;
+};
+
+/**
+ * struct scmi_tlm_shmti_info  - SHMTI descriptor
+ *
+ * @sid: SHMTI ID
+ * @fd: Associated opened file descriptor to use for mmap
+ * @len: Size of the SHMTI to be used with mmap on this SHMTI
+ * @offset: Offset in the mmap where the specified SHMTI start
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_SHMTI_LIST
+ */
+struct scmi_tlm_shmti_info {
+	__u32 sid;
+	__u32 fd;
+	__u32 len;
+	__u32 offset;
+};
+
+/**
+ * struct scmi_tlm_shmtis_list  - SHMTIs List
+ *
+ * @num_shmtis: Number of entries returned in @shmtis
+ * @pad: Padding fields to enforce alignment
+ * @shmtis: A reference to an array of struct scmi_tlm_shmti_info containing
+ *	    an entry for each defined SHMTI
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_SHMTI_LIST
+ */
+struct scmi_tlm_shmtis_list {
+	__u32 num_shmtis;
+	__u32 pad;
+	__u64 shmtis;
+};
+
+#define SCMI_TLM_IOCTL_MAGIC 0xF1
+
+#define SCMI_TLM_GET_ABI_INFO	_IOWR(SCMI_TLM_IOCTL_MAGIC,  0x00, struct scmi_tlm_abi_info)
+#define SCMI_TLM_GET_CFG	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x01, struct scmi_tlm_config)
+#define SCMI_TLM_SET_CFG	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x02, struct scmi_tlm_config)
+#define SCMI_TLM_GET_INTRVS	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x03, struct scmi_tlm_intervals)
+#define SCMI_TLM_GET_DE_CFG	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x04, struct scmi_tlm_de_config)
+#define SCMI_TLM_SET_DE_CFG	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x05, struct scmi_tlm_de_config)
+#define SCMI_TLM_GET_DE_INFO	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x06, struct scmi_tlm_de_info)
+#define SCMI_TLM_GET_DE_LIST	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x07, struct scmi_tlm_des_list)
+#define SCMI_TLM_DE_READ	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x08, struct scmi_tlm_de_sample)
+#define SCMI_TLM_GET_ALL_CFG	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x09, struct scmi_tlm_de_config)
+#define SCMI_TLM_SET_ALL_CFG	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x0A, struct scmi_tlm_de_config)
+#define SCMI_TLM_GET_GRP_LIST	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x0B, struct scmi_tlm_grps_list)
+#define SCMI_TLM_GET_GRP_INFO	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x0C, struct scmi_tlm_grp_info)
+#define SCMI_TLM_GET_GRP_DESC	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x0D, struct scmi_tlm_grp_desc)
+#define SCMI_TLM_SINGLE_READ	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x0E, struct scmi_tlm_data_read)
+#define SCMI_TLM_BULK_READ	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x0F, struct scmi_tlm_data_read)
+#define SCMI_TLM_BATCH_READ	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x10, struct scmi_tlm_data_read)
+#define SCMI_TLM_GET_SHMTI_LIST	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x11, struct scmi_tlm_shmtis_list)
+#define SCMI_TLM_RESET		_IO(SCMI_TLM_IOCTL_MAGIC, 0x12)
+
+#endif /* _UAPI_LINUX_SCMI_H */
-- 
2.54.0

