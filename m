Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27303E2764;
	Fri, 12 Jun 2026 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303989; cv=none; b=eomgp7TzTA6rFgxsgEk4m7kiW7nStasdCRadVlLzhj3cl6Bfoj/q/jW2CZvSzNfkjZXHuTh3gZkk+hXy1l3lE504j7CI3wYlPUay9UvCnjY7VyrEJRbV/cYHOBb/fpXq58R/fRPSzbagxEoC1ihspAPLe4p81gZpFLU7XA1fA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303989; c=relaxed/simple;
	bh=/PEkXgAYYFOhyEcxt6J56Cr7JLw0E8Z69BYkFeVKBaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDyDsIIroBTyo/b47FnDTpUKrCrYOSBFdIX15grxc0t9toqli1YTtpK3ieLCp9oIGIF1oBfOo4Ca72lPuRCOMs2Wec1Vqms4NFpBoG5LY9ANA71j3j2txBKNNoQ04uK1njCVOPVO0prQUuRYasf4Lgs32UKZ4oztobUXNmrjk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r4+DsWaY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r4+DsWaY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EE053543;
	Fri, 12 Jun 2026 15:39:42 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49EAF3FB7F;
	Fri, 12 Jun 2026 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781303987; bh=/PEkXgAYYFOhyEcxt6J56Cr7JLw0E8Z69BYkFeVKBaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4+DsWaYBqX8p7JRaVWt376Q9uqfpLB14otBWPyyY0KCqkbseltfGwnvZE1gE+i5E
	 a1jo3AVs4vVjArKKT2pUDRYc0+ethQyNKrUAD7kf2ELESurg+YKZKgnC2OrA+pwOd7
	 zm2lEpk8ziqc/JoDMTSNGTI3S6j/UMVoAZfr3TcE=
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
Subject: [PATCH v4 17/31] firmware: arm_scmi: Add Telemetry debugfs SHMTI dump support
Date: Fri, 12 Jun 2026 23:37:47 +0100
Message-ID: <20260612223802.1337232-18-cristian.marussi@arm.com>
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

Expose one debugfs entry for each discovered SHMTI that can be used to
dump the related SHMTI in binary form from TBGN up to TEND markers.

No processing is done kernel side, beside using proper accessors for
device memory.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/telemetry.c | 90 +++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
index ab1be6c462f1..a43d67494d73 100644
--- a/drivers/firmware/arm_scmi/telemetry.c
+++ b/drivers/firmware/arm_scmi/telemetry.c
@@ -11,6 +11,8 @@
 #include <linux/compiler_types.h>
 #include <linux/completion.h>
 #include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/limits.h>
@@ -371,6 +373,12 @@ struct telemetry_shmti {
 	u32 last_magic;
 };
 
+struct scmi_telemetry_dbg_shmti {
+	struct telemetry_shmti *shmti;
+	size_t buf_sz;
+	void *buf;
+};
+
 #define SHMTI_EPLG(s)						\
 	({							\
 		struct telemetry_shmti *_s = (s);		\
@@ -1299,6 +1307,85 @@ scmi_telemetry_enumerate_common_intervals(struct telemetry_info *ti)
 					ti->info.intervals);
 }
 
+static int scmi_telemetry_dbg_shmti_open(struct inode *inode, struct file *filp)
+{
+	struct scmi_telemetry_dbg_shmti *sblob;
+	struct telemetry_shmti *shmti;
+
+	if (!inode->i_private)
+		return -ENODEV;
+
+	shmti = inode->i_private;
+	sblob = kzalloc_obj(*sblob);
+	if (!sblob)
+		return -ENOMEM;
+
+	sblob->shmti = shmti;
+	sblob->buf = kzalloc(shmti->len, GFP_KERNEL);
+	if (!sblob->buf) {
+		kfree(sblob);
+		return -ENOMEM;
+	}
+
+	filp->private_data = sblob;
+
+	return 0;
+}
+
+static ssize_t scmi_telemetry_dbg_shmti_read(struct file *filp, char __user *buf,
+					     size_t count, loff_t *ppos)
+{
+	struct scmi_telemetry_dbg_shmti *sblob = filp->private_data;
+
+	/* Dump on first read and again after each rewind to start pos */
+	if (!sblob->buf_sz || *ppos == 0) {
+		memcpy_fromio(sblob->buf, sblob->shmti->base, sblob->shmti->len);
+		sblob->buf_sz = sblob->shmti->len;
+		/* update inode timestamps */
+		simple_inode_init_ts(file_inode(filp));
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, sblob->buf, sblob->buf_sz);
+}
+
+static int scmi_telemetry_dbg_shmti_release(struct inode *inode, struct file *filp)
+{
+	struct scmi_telemetry_dbg_shmti *sblob = filp->private_data;
+
+	kfree(sblob->buf);
+	kfree(sblob);
+
+	return 0;
+}
+
+static const struct file_operations scmi_telemetry_dbg_shmti_fops = {
+	.open = scmi_telemetry_dbg_shmti_open,
+	.release = scmi_telemetry_dbg_shmti_release,
+	.read = scmi_telemetry_dbg_shmti_read,
+	.llseek = generic_file_llseek,
+	.owner = THIS_MODULE,
+};
+
+static void scmi_telemetry_debugfs_initialize(struct telemetry_info *ti)
+{
+	const struct scmi_protocol_handle *ph = ti->ph;
+	struct dentry *top, *shmti_top;
+
+	top = ph->hops->debugfs_proto_dentry_get(ph);
+	shmti_top = debugfs_create_dir("shmtis", top);
+
+	for (unsigned int i = 0; i < ti->num_shmti; i++) {
+		struct dentry *d;
+		char id[16];
+
+		snprintf(id, 16, "%u", i);
+		d = debugfs_create_file(id, 0444, shmti_top, &ti->shmti[i],
+					&scmi_telemetry_dbg_shmti_fops);
+		if (!IS_ERR(d))
+			i_size_write(d->d_inode, ti->shmti[i].len);
+	}
+}
+
 static int iter_shmti_update_state(struct scmi_iterator_state *st,
 				   const void *response, void *priv)
 {
@@ -3195,6 +3282,9 @@ static int scmi_telemetry_protocol_init(const struct scmi_protocol_handle *ph)
 				 "Could NOT register Telemetry notifications\n");
 	}
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_PROTOCOLS))
+		scmi_telemetry_debugfs_initialize(ti);
+
 	return ret;
 }
 
-- 
2.54.0

