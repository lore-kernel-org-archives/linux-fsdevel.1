Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205535;
	b=joowL7xvlI1oMtXr0nQUxQivkm+gkjrM15yAHY7+bUopGjr8MRIRnm/CShxcTt8eBYTC
	 RlMppkq1EGDC22k1Ih6v5mHVBwWo/Kojt2uko0SgzHrTLNypdYlaOaqGtKCZa97SheX/m
	 x6xTmZ3gRj4Mfs4bNoF7hU0EdDJZt+/J0BMaE6g2h12Um/0xiq9Hnxr719yqdEKclxjXP
	 QgJHk0NgaU9f6ZA3UUblaFrkZ4HOb7cxuho6NtbrNgXRDesE2Dw16yzd8mhb75IizU+3u
	 ApWXeENw0Esb1/DHmv1PXdhzbZVRZZXBxc7UrxanubspW9MmCn+VLmPgh1wpwmi7SdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205535;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PyyEhaD8x2m34MKiecPyQSIILKDN7dZJGfcyqFPUk4o=;
	b=a4DyQf55OvKJtTsOX8DbXWCJnJGOyzSNwRNxou6Zem7puZ+a7Dxxragxu5VuMzqStPTr
	 7H4ViuR8Ior8wJZHJ2x/QYms6UlHo8THU/QujlM/Q3TdTVXh/sXUuMDvIfP2ZwFM/pcb7
	 Ew/7Li7C9NRS/UZUR18PsMYEiGbyGNypLAvJPYqU0M42cbeE3Xlvhgbvblo7wdUe5Nsi/
	 oZ6x2WpSG1KaBk5++gewM44Jf0zYHIfotxwkDC4op45iooeOYNDoxCdm7KqqRBHG7wNO9
	 FrkpjbkBatpcMzJDjCp3T3q+FBLm2Mby1wpY2ICZsOINt8G/3/k5xN/ZBNrVFobReZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DP2PbMCG;
	arc=none smtp.remote-ip=95.215.58.130
Received: from mta1.migadu.com (out-130.mta1.migadu.com [95.215.58.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922160A2627
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4922160A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DP2PbMCG
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Xz3+iH/EXgndvNvYbLnjDx/bNEeb8fE/MJkYV6nAti8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205532; v=1; x=1793810332;
 b=DP2PbMCGbps496lJrX4QbF5vMRxJ9ZKulVXeJ2WMWEBXTcrzHPJExtySUI5s08w4nFWn4Aoj
 mNMCL9UtwKIthGzpBf1+1TE9MdMOuDPz/QjgBCkx4PdW4r1HQ9yqt7dKk2k1sWfZPkLvKMMiYFg
 AZ8/JYum0j71Yg2S3/Vo1rx8=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 97da82f30ffae365;
	Wed, 28 Oct 2026 16:38:52 +0000
X-Mizu-Trace-ID: 97da82f30ffae365
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 36/39] parport: move device sysctl context to priv
Date: Thu, 29 Oct 2026 00:35:15 +0800
Message-Id: <99e864dc88f931ba5f065717bb5a9cb950b05eb7.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

The per-port table uses extra1 for both the spintime minimum and the
port context of the active and hardware entries. During registration,
the loop also assigns the port pointer to vars[0].extra1, overwriting
the minimum. A spintime write can consequently be checked against data
from struct parport instead of the intended minimum.

Move the port context to priv and use numeric bounds for spintime.
Keep probe_info in data and set priv only for the entries that need the
port. Separating context from bounds prevents this overwrite.

The spintime bug exists in the base tree and can also be fixed separately;
this RFC does not depend on that fix.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/parport/procfs.c | 51 +++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 1bfafc2a5724..6f6d96c37a93 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -36,7 +36,7 @@
 static int do_active_device(const struct ctl_table *table, int write,
 		      void *result, size_t *lenp, loff_t *ppos)
 {
-	struct parport *port = (struct parport *)table->extra1;
+	struct parport *port = table->priv;
 	char buffer[256];
 	struct pardevice *dev;
 	int len = 0;
@@ -73,7 +73,7 @@ static int do_active_device(const struct ctl_table *table, int write,
 static int do_autoprobe(const struct ctl_table *table, int write,
 			void *result, size_t *lenp, loff_t *ppos)
 {
-	struct parport_device_info *info = table->extra2;
+	struct parport_device_info *info = table->data;
 	const char *str;
 	char buffer[256];
 	int len = 0;
@@ -116,7 +116,7 @@ static int do_autoprobe(const struct ctl_table *table, int write,
 static int do_hardware_base_addr(const struct ctl_table *table, int write,
 				 void *result, size_t *lenp, loff_t *ppos)
 {
-	struct parport *port = (struct parport *)table->extra1;
+	struct parport *port = table->priv;
 	char buffer[64];
 	int len = 0;
 
@@ -143,7 +143,7 @@ static int do_hardware_base_addr(const struct ctl_table *table, int write,
 static int do_hardware_irq(const struct ctl_table *table, int write,
 			   void *result, size_t *lenp, loff_t *ppos)
 {
-	struct parport *port = (struct parport *)table->extra1;
+	struct parport *port = table->priv;
 	char buffer[20];
 	int len = 0;
 
@@ -170,7 +170,7 @@ static int do_hardware_irq(const struct ctl_table *table, int write,
 static int do_hardware_dma(const struct ctl_table *table, int write,
 			   void *result, size_t *lenp, loff_t *ppos)
 {
-	struct parport *port = (struct parport *)table->extra1;
+	struct parport *port = table->priv;
 	char buffer[20];
 	int len = 0;
 
@@ -197,7 +197,7 @@ static int do_hardware_dma(const struct ctl_table *table, int write,
 static int do_hardware_modes(const struct ctl_table *table, int write,
 			     void *result, size_t *lenp, loff_t *ppos)
 {
-	struct parport *port = (struct parport *)table->extra1;
+	struct parport *port = table->priv;
 	char buffer[40];
 	int len = 0;
 
@@ -236,19 +236,6 @@ do {									\
 	return 0;
 }
 
-static const unsigned long parport_min_timeslice_value =
-PARPORT_MIN_TIMESLICE_VALUE;
-
-static const unsigned long parport_max_timeslice_value =
-PARPORT_MAX_TIMESLICE_VALUE;
-
-static const  int parport_min_spintime_value =
-PARPORT_MIN_SPINTIME_VALUE;
-
-static const int parport_max_spintime_value =
-PARPORT_MAX_SPINTIME_VALUE;
-
-
 struct parport_sysctl_table {
 	struct ctl_table_header *port_header;
 	struct ctl_table_header *devices_header;
@@ -270,8 +257,8 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 			.maxlen		= sizeof(int),
 			.mode		= 0644,
 			.proc_handler	= proc_dointvec_minmax,
-			.extra1		= (void*) &parport_min_spintime_value,
-			.extra2		= (void*) &parport_max_spintime_value
+			.min		= PARPORT_MIN_SPINTIME_VALUE,
+			.max		= PARPORT_MAX_SPINTIME_VALUE,
 		},
 		{
 			.procname	= "base-addr",
@@ -367,8 +354,8 @@ parport_device_sysctl_template = {
 			.maxlen		= sizeof(unsigned long),
 			.mode		= 0644,
 			.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
-			.extra1		= (void*) &parport_min_timeslice_value,
-			.extra2		= (void*) &parport_max_timeslice_value
+			.min		= PARPORT_MIN_TIMESLICE_VALUE,
+			.max		= PARPORT_MAX_TIMESLICE_VALUE,
 		},
 	},
 	{
@@ -397,8 +384,8 @@ parport_default_sysctl_table = {
 			.maxlen		= sizeof(parport_default_timeslice),
 			.mode		= 0644,
 			.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
-			.extra1		= (void*) &parport_min_timeslice_value,
-			.extra2		= (void*) &parport_max_timeslice_value
+			.min		= PARPORT_MIN_TIMESLICE_VALUE,
+			.max		= PARPORT_MAX_TIMESLICE_VALUE,
 		},
 		{
 			.procname	= "spintime",
@@ -406,8 +393,8 @@ parport_default_sysctl_table = {
 			.maxlen		= sizeof(parport_default_spintime),
 			.mode		= 0644,
 			.proc_handler	= proc_dointvec_minmax,
-			.extra1		= (void*) &parport_min_spintime_value,
-			.extra2		= (void*) &parport_max_spintime_value
+			.min		= PARPORT_MIN_SPINTIME_VALUE,
+			.max		= PARPORT_MAX_SPINTIME_VALUE,
 		},
 	}
 };
@@ -422,15 +409,15 @@ int parport_proc_register(struct parport *port)
 	if (t == NULL)
 		return -ENOMEM;
 
-	t->device_dir[0].extra1 = port;
+	t->device_dir[0].priv = port;
 
 	t->vars[0].data = &port->spintime;
-	for (i = 0; i < 5; i++) {
-		t->vars[i].extra1 = port;
+	for (i = 1; i < 5; i++)
+		t->vars[i].priv = port;
 #ifdef CONFIG_PARPORT_1284
-		t->vars[5 + i].extra2 = &port->probe_info[i];
+	for (i = 0; i < 5; i++)
+		t->vars[5 + i].data = &port->probe_info[i];
 #endif /* IEEE 1284 support */
-	}
 
 	tmp_dir_path = kasprintf(GFP_KERNEL, "dev/parport/%s/devices", port->name);
 	if (!tmp_dir_path) {
-- 
2.25.1

