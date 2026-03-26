Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9F3A7840
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560928; cv=fail; b=m78GlMnyXh20JvYsEN5O+N4497nStSbjcseq8RbR7shfiiHJttiPEeQL5ITbH73rvcVq3Q7Sqr/LJRzkaJWtyHA/D0AlPLgBrux9ynYn6tGr2guETzBsCeOOblhNE7SojR30V9OVnUes87jWnJ5fWEKShuBOseAJtyuNPbWmGoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560928; c=relaxed/simple;
	bh=NucyBlqMGNaNbcxjMAYzc+KUVY1ynjnPFBhXVH5rJV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZ6qEAxWO/CLnrGdFf64HcUu5vqzT54WmJYQu750DjpLx0jQaBoWUpR1NmVH2MfK5Vjd6FJTwKvApGiKHhFhyOhSjNVCPH3/jbttv6kWJQShyXeo61NxD+R/87hOZtIGPNMzPnxBRaApr10dHZooIsJyROCxMB7eCO9YVMMCmTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=ya5kn5iJ; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="ya5kn5iJ"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020096.outbound.protection.outlook.com [52.101.46.96]) by mx-outbound17-177.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrVMJxQ6MRbewhRV72TSn8DVwzd0wbsdOhei10LmwVpvudjd+4v0Ah20RDVtbLjw+EjE5fRq7edvB6zOG08/6qqhXVHiPueCF58/ConRu1cc/ogyclioMCrcSjn3AXNf/Q+LIja/qEXAx1SfIAIlKx+Z8NBRJyAAxcmMaBq79kc0P38hMgCS6UgfR1ZiqvykK2Y42KeEhTOYHlXid2w21iRLx0Rfx4g4waDFK+2ozNwwfEa1WwRgYiYDuw+6nSfEkA6F7PC+zFz8JeddrLTsH0D51Vd/ep5yMTLa6wIAWQoKIs0HgtKWeMTc7kjAYGQcjTjmMQ8+kDD3rQe7QIcIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkuVCRjcUVRxy5HLEWA61DTDTsDSzNUW1dy8BGBG03Y=;
 b=csSalPwTye4+0A0duSb7Zus6oeYoVEcVzlyujmlLfQNxN9z+5n7rrT5MMe/mwXhmyQOtfh4Nn9DXqbPfWDgSSax/J0FeiaIsNXDnNKPiwIOClaz6mBn19pbwtD6lMsfkfJuxJSnQVSoLnDnDQhIA7Db3Rbu7zjmGrnBwPgaUbCj1yjZfu25tWSulFVxjwdCOMpW4cOvdSKXlp57yto4SjIDfeUcxvLws2ptJLHrUjm7EI7DsyBx+iM4ckyGx6s7U2GnATH5DAbPoLnUrxlX/+UITRgRE88Pnqtp+q8EWa09w+AbyPJNKgDgBQjJgTY4eXEBOvimKecpbznS7LLNB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkuVCRjcUVRxy5HLEWA61DTDTsDSzNUW1dy8BGBG03Y=;
 b=ya5kn5iJVpOewIYqWDe+T2O9icmYy4fMfkm1QN/p7kjPpoqQz9plhKOmdWrV0AM9FJBzJ4lkM8BMGAI0EwdVBtP/B8R71KqMBrklwGHcspAJWtWPuYDsBJu8l8dr9tUjwY/Gh4V68S5fCxEKKMjBUqZGPztE+rV0lNcbT3o0xXg=
Received: from MN0P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::11)
 by DS0PR19MB7376.namprd19.prod.outlook.com (2603:10b6:8:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:35:10 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::a5) by MN0P222CA0004.outlook.office365.com
 (2603:10b6:208:531::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 21:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:09 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 5BC066F;
	Thu, 26 Mar 2026 21:35:08 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:50 +0100
Subject: [PATCH v2 17/25] Split the fusermount do_mount function
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-17-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=11796;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=sX6U24DOXHROivFEuTESVetY7g0rFZ1cd9mcRWtJX2M=;
 b=iEFHbiuYM/kqD8mnsXu/HSLTgALHHC0X8ZHCizEUnuyTOGu5HTCAC5J/tvXqTRNVi2OKz0Svr
 zHby5DEMMg7AeFKnLhx6qDeQ9yWY4V+oEW0VweGgaNSXXJkbvfk1IUO
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DS0PR19MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fea5a7-3312-4314-e081-08de8b7f8e3b
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|48200799018|19092799006|82310400026|61400799027|18002099003|56012099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	Rt2anp0qyRlTnYITJ6C1N+F81jJdvqwAWWaNhC6M7BqHTwgg3CeH9iLaqNxqorTI/wveGk7/bK4FzAr35jdAQ5222NtVP0CflEkwkchmcPvNP5Fulyz5rxJtZxV1D9LQ9piNBcd1EJW78fvGp7Zj2sc8N+GLiXAEQ3LDTybMhg/1mYTTZX8w2VMFmfeS5B4AwhGLCyz4s1W2Yafx6hRL2+8mEBW5v1uJZnaBkD4pwTE14NNst/NwWeQduPjukNdoUWuEi0Gc3cRxmXMQ28Wqo2HTMkInZ6h3OpofcTeR0lohGUwXH3PrRFlr1OKfgChNLVuEz0suXQg9ca90U+Ow/emRZ73xaCw54aGRQTBMp2TeCO4QWt/vKVoyPUcv9zqYq9HOMMBzDvxOIWPJA2m5keAqvq5V90iMUBPF2ktcAMZ506MKvQYl0/dIAvvpxnnVgWFJdpU9AXWuxk1ZUJyqb1KtjGLdQJxpdQwAblYfHRamEIPguNU8ym1RRoMf2e7hGEmNziomH9WFDqAB690red9z5WlfonxVm9ak7YmIIxJZqTRyZvIBYLhcma0q1schzmlMhjCf2yCDFL8UMIXB/oOPMj/iKTZraEFysSw/dd8ynYtm6Z1JeIHub0UEnKUYpxdzqSfiB6qA+aHSXafgx5IKotiQStfXquPdcieWdvcqCEKbt9Q4nGKh5GI6exLPQAinim5UVD+nwL6Gg+zCBMo06zGpOSQ5Inf77D/tL4whX8zYjUkrhuVl10LQRh6aUaHkGTYDgz7JSdiUR7XNMg==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(48200799018)(19092799006)(82310400026)(61400799027)(18002099003)(56012099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sz9ETnoVl5yqCqUVDfvh6DM5XqIyrncC89DctN7NhblJEZzPa6S22kqB1rmCxHbRZegc4+Nk+MYoekQ0tlObl/8NywUiY63OqZ690KzSuXxA8GSnJnZt5zV+12SkdpyPEOms9pg1HNS4yryrXfjZYAeL6cBjZ/xNbK6ei/2nWrBgAydnjMMh9ErHl4hra7aCsZpXqLwBI5zDVgLcahtY0O5YHxJ4o42VSTXFsb9/2M4BYUbgySm99WS0uqA+Hpy2bAcmMJucXzZ7TyYDq0z+PQwTG4Y8XfVtVCCAKg4ooYeXzywx4HMYgE3FaHQf7JnaiGQNoktgdVJgy/Lrxs+8iu8hI3Y19GEHjaKwwWO3kgZBQSIMFiYWdcKEZGBP3PdfIAvwvQOKGP4SYks3HTz7E7D8KXUAUY6DRlz7FXFar1ygjVjM0tlJY4isXftYS1u8
X-Exchange-RoutingPolicyChecked:
	Oza5FZ5Q4NkWeN0xtAo0G1Bac25qJx1/VH4Bh+WtRyzvTuXECr3+0pNt+71P7SMsTI8kVhOdA4EcPbbyfQ8cuYWOhMuLcSipYaJDjr1C5QsiPzYhaHxv9nNLVPJgQf0P4oz8hcGC2qOuBoKX7ReTEiQlqeuT0EAVfkbvepLqIOarDEyXm0mgKC25Adk6ZrpYNTlNXuLD4BHGYu6ppYTG1EUwm/FxeNJJ1SPkrnSokYmLJQF/nIZXQanFGvhn4WROlQ9c4WzYdFJETEJ/uIRAvFgYqvPX8344/7S+7BreSykaE93y41gT4zbsixy+WeEqymRt1XNGqhMeCsnR0DIY4Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YlH3q5z2HelndmYG76xeosa+C7kya8yH3DFeVK3495zVkThQ8tuHYM2+YS/+4aruHFJ3xGWXv+/7b2vo8CQo4Lq9SmVm+bE2JChB1iIbK8a/N2nsBTK5L68qh6hiHzC6e0jtgbOrlGZXyiWzv3xZKXbfClpdsh/PtypmOzxEVPD2OrQVIWAdDTHwNruFpWlbObaCxJMaKdTYRffZy6qVG82hLzilOoruzKugebD50kYjAnil8Y1clIV2uTZbZkMuVf2h7dxYQM11w0j5QCWrT8AFXGAwm8Dcak8SWWfnUcXO3at9iVXgACCVfFtFQNvhXy4f5yBevmbNnYMtlS5QAeKvD7TZpei3VryuQYClAL+G8tQaGuPt6Kl3tgLNO3MiHWbUedbdgrAw+gl6gV1nq1LBlvtqv0GDqpM1kQaClOGeDL3lgH8b2QtwbAOCbVsobJpncoIwf2SfGUA1/3ytdmDupzANmt50fcrIe+tj5YPw79L/uXiH4peCZ1XxrXBgNOKC9D08Wq09kclcjvBDYHjgN5cuvQ9DHUYk7yYI1uDObBaTFdGR54p5Dza/O6Z4EGlW5PszO7AM2qD4vP/KIDPyp38tfty+uz62BhgvpqolLbU100AhRuvOz3jS/YD9n4KWEcb3F6mgvpr2JdxO2g==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:09.5231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fea5a7-3312-4314-e081-08de8b7f8e3b
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7376
X-BESS-ID: 1774560918-104529-22511-4212-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.46.96
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGJiZmQGYGUNQ8xdLExMQiOc
	XANCXR0tDAwMLSIs0yzdwoKcUsydTSSKk2FgC1k9VgQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan18-39.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

We will need new API and old API and need to pass the options to
two different functions - factor out the option parsing.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 util/fusermount.c | 298 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 205 insertions(+), 93 deletions(-)

diff --git a/util/fusermount.c b/util/fusermount.c
index f66c4e8e0e809351384ec10cf50ba4d3d3a831b0..8d7598998788f72ea05c2a065a88cb5efd61df35 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -883,30 +883,132 @@ static int mount_notrunc(const char *source, const char *target,
 	return mount(source, target, filesystemtype, mountflags, data);
 }
 
+struct mount_params {
+	/* Input parameters */
+	int fd;                  /* /dev/fuse file descriptor */
+	mode_t rootmode;         /* Root mode from stat */
+	const char *dev;         /* Device path (/dev/fuse) */
 
-static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
-		    int fd, const char *opts, const char *dev, char **sourcep,
-		    char **mnt_optsp)
+	/* Parsed mount options */
+	unsigned long flags;     /* Mount flags (MS_NOSUID, etc.) */
+	char *optbuf;           /* Kernel mount options buffer */
+	char *fsname;           /* Filesystem name from options */
+	char *subtype;          /* Subtype from options */
+	int blkdev;             /* Block device flag */
+
+	/* Generated mount parameters */
+	char *source;           /* Mount source string */
+	char *type;             /* Filesystem type string */
+	char *mnt_opts;         /* Mount table options */
+
+	/* Pointer for optbuf manipulation */
+	char *optbuf_end;       /* Points to end of optbuf for sprintf */
+};
+
+static void free_mount_params(struct mount_params *mp)
+{
+	free(mp->optbuf);
+	free(mp->fsname);
+	free(mp->subtype);
+	free(mp->source);
+	free(mp->type);
+	free(mp->mnt_opts);
+}
+
+/*
+ * Check if option is deprecated large_read.
+ *
+ * Returns true if the option should be skipped (large_read on kernel > 2.4),
+ * false otherwise (all other options or large_read on old kernels).
+ */
+static bool check_large_read(const char *opt, unsigned int len)
+{
+	struct utsname utsname;
+	unsigned int kmaj, kmin;
+	int res;
+
+	if (!opt_eq(opt, len, "large_read"))
+		return false;
+
+	res = uname(&utsname);
+	if (res == 0 &&
+	    sscanf(utsname.release, "%u.%u", &kmaj, &kmin) == 2 &&
+	    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
+		fprintf(stderr,
+			"%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n",
+			progname, kmaj, kmin);
+		return true;
+	}
+	return false;
+}
+
+/*
+ * Check if user has permission to use allow_other or allow_root options.
+ *
+ * Returns -1 if permission denied, 0 if allowed or option is not
+ * allow_other/allow_root.
+ */
+static int check_allow_permission(const char *opt, unsigned int len)
+{
+	if (getuid() != 0 && !user_allow_other &&
+	    (opt_eq(opt, len, "allow_other") || opt_eq(opt, len, "allow_root"))) {
+		fprintf(stderr, "%s: option %.*s only allowed if 'user_allow_other' is set in %s\n",
+			progname, len, opt, FUSE_CONF);
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * Process generic mount option.
+ *
+ * Handles mount flags (ro, rw, suid, etc.), kernel options
+ * (default_permissions, allow_other, max_read, blksize), or exits on
+ * unknown options.
+ */
+static int process_generic_option(const char *opt, unsigned int len,
+				   unsigned long *flags, char **dest)
+{
+	int on;
+	int flag;
+
+	if (find_mount_flag(opt, len, &on, &flag)) {
+		if (on)
+			*flags |= flag;
+		else
+			*flags &= ~flag;
+		return 0;
+	}
+
+	if (opt_eq(opt, len, "default_permissions") ||
+	    opt_eq(opt, len, "allow_other") ||
+	    begins_with(opt, "max_read=") ||
+	    begins_with(opt, "blksize=")) {
+		memcpy(*dest, opt, len);
+		*dest += len;
+		**dest = ',';
+		(*dest)++;
+		return 0;
+	}
+
+	fprintf(stderr, "%s: unknown option '%.*s'\n", progname, len, opt);
+	exit(1);
+}
+
+static int prepare_mount(const char *opts, struct mount_params *mp)
 {
 	int res;
-	int flags = MS_NOSUID | MS_NODEV;
-	char *optbuf;
-	char *mnt_opts = NULL;
 	const char *s;
 	char *d;
-	char *fsname = NULL;
-	char *subtype = NULL;
-	char *source = NULL;
-	char *type = NULL;
-	int blkdev = 0;
 
-	optbuf = (char *) malloc(strlen(opts) + 128);
-	if (!optbuf) {
+	mp->flags = MS_NOSUID | MS_NODEV;
+	mp->optbuf = (char *) malloc(strlen(opts) + 128);
+	if (!mp->optbuf) {
 		fprintf(stderr, "%s: failed to allocate memory\n", progname);
 		return -1;
 	}
 
-	for (s = opts, d = optbuf; *s;) {
+	for (s = opts, d = mp->optbuf; *s;) {
 		unsigned len;
 		const char *fsname_str = "fsname=";
 		const char *subtype_str = "subtype=";
@@ -919,10 +1021,10 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
 				break;
 		}
 		if (begins_with(s, fsname_str)) {
-			if (!get_string_opt(s, len, fsname_str, &fsname))
+			if (!get_string_opt(s, len, fsname_str, &mp->fsname))
 				goto err;
 		} else if (begins_with(s, subtype_str)) {
-			if (!get_string_opt(s, len, subtype_str, &subtype))
+			if (!get_string_opt(s, len, subtype_str, &mp->subtype))
 				goto err;
 		} else if (opt_eq(s, len, "blkdev")) {
 			if (getuid() != 0) {
@@ -931,7 +1033,7 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
 					progname);
 				goto err;
 			}
-			blkdev = 1;
+			mp->blkdev = 1;
 		} else if (opt_eq(s, len, "auto_unmount")) {
 			auto_unmount = 1;
 		} else if (!opt_eq(s, len, "nonempty") &&
@@ -939,122 +1041,132 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
 			   !begins_with(s, "rootmode=") &&
 			   !begins_with(s, "user_id=") &&
 			   !begins_with(s, "group_id=")) {
-			int on;
-			int flag;
-			int skip_option = 0;
-			if (opt_eq(s, len, "large_read")) {
-				struct utsname utsname;
-				unsigned kmaj, kmin;
-				res = uname(&utsname);
-				if (res == 0 &&
-				    sscanf(utsname.release, "%u.%u",
-					   &kmaj, &kmin) == 2 &&
-				    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
-					fprintf(stderr, "%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n", progname, kmaj, kmin);
-					skip_option = 1;
-				}
-			}
-			if (getuid() != 0 && !user_allow_other &&
-			    (opt_eq(s, len, "allow_other") ||
-			     opt_eq(s, len, "allow_root"))) {
-				fprintf(stderr, "%s: option %.*s only allowed if 'user_allow_other' is set in %s\n", progname, len, s, FUSE_CONF);
+			bool skip;
+
+			if (check_allow_permission(s, len) == -1)
 				goto err;
-			}
-			if (!skip_option) {
-				if (find_mount_flag(s, len, &on, &flag)) {
-					if (on)
-						flags |= flag;
-					else
-						flags  &= ~flag;
-				} else if (opt_eq(s, len, "default_permissions") ||
-					   opt_eq(s, len, "allow_other") ||
-					   begins_with(s, "max_read=") ||
-					   begins_with(s, "blksize=")) {
-					memcpy(d, s, len);
-					d += len;
-					*d++ = ',';
-				} else {
-					fprintf(stderr, "%s: unknown option '%.*s'\n", progname, len, s);
-					exit(1);
-				}
-			}
+
+			skip = check_large_read(s, len);
+
+			/*
+			 * Skip deprecated large_read to avoid passing it to
+			 * kernel which would reject it as unknown option.
+			 */
+			if (!skip)
+				process_generic_option(s, len, &mp->flags, &d);
 		}
 		s += len;
 		if (*s)
 			s++;
 	}
 	*d = '\0';
-	res = get_mnt_opts(flags, optbuf, &mnt_opts);
+	res = get_mnt_opts(mp->flags, mp->optbuf, &mp->mnt_opts);
 	if (res == -1)
 		goto err;
 
+	mp->optbuf_end = d;
+
 	sprintf(d, "fd=%i,rootmode=%o,user_id=%u,group_id=%u",
-		fd, rootmode, getuid(), getgid());
+		mp->fd, mp->rootmode, getuid(), getgid());
 
-	source = malloc((fsname ? strlen(fsname) : 0) +
-			(subtype ? strlen(subtype) : 0) + strlen(dev) + 32);
+	mp->source = malloc((mp->fsname ? strlen(mp->fsname) : 0) +
+			(mp->subtype ? strlen(mp->subtype) : 0) + strlen(mp->dev) + 32);
 
-	type = malloc((subtype ? strlen(subtype) : 0) + 32);
-	if (!type || !source) {
+	mp->type = malloc((mp->subtype ? strlen(mp->subtype) : 0) + 32);
+	if (!mp->type || !mp->source) {
 		fprintf(stderr, "%s: failed to allocate memory\n", progname);
 		goto err;
 	}
 
-	if (subtype)
-		sprintf(type, "%s.%s", blkdev ? "fuseblk" : "fuse", subtype);
+	if (mp->subtype)
+		sprintf(mp->type, "%s.%s", mp->blkdev ? "fuseblk" : "fuse", mp->subtype);
 	else
-		strcpy(type, blkdev ? "fuseblk" : "fuse");
+		strcpy(mp->type, mp->blkdev ? "fuseblk" : "fuse");
 
-	if (fsname)
-		strcpy(source, fsname);
+	if (mp->fsname)
+		strcpy(mp->source, mp->fsname);
 	else
-		strcpy(source, subtype ? subtype : dev);
+		strcpy(mp->source, mp->subtype ? mp->subtype : mp->dev);
 
-	res = mount_notrunc(source, mnt, type, flags, optbuf);
-	if (res == -1 && errno == ENODEV && subtype) {
+	return 0;
+
+err:
+	free_mount_params(mp);
+	return -1;
+}
+
+/*
+ * Perform the actual mount operation using prepared parameters.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int perform_mount(const char *mnt, struct mount_params *mp)
+{
+	int res;
+
+	res = mount_notrunc(mp->source, mnt, mp->type, mp->flags, mp->optbuf);
+	if (res == -1 && errno == ENODEV && mp->subtype) {
 		/* Probably missing subtype support */
-		strcpy(type, blkdev ? "fuseblk" : "fuse");
-		if (fsname) {
-			if (!blkdev)
-				sprintf(source, "%s#%s", subtype, fsname);
+		strcpy(mp->type, mp->blkdev ? "fuseblk" : "fuse");
+		if (mp->fsname) {
+			if (!mp->blkdev)
+				sprintf(mp->source, "%s#%s", mp->subtype, mp->fsname);
 		} else {
-			strcpy(source, type);
+			strcpy(mp->source, mp->type);
 		}
 
-		res = mount_notrunc(source, mnt, type, flags, optbuf);
+		res = mount_notrunc(mp->source, mnt, mp->type, mp->flags, mp->optbuf);
 	}
 	if (res == -1 && errno == EINVAL) {
 		/* It could be an old version not supporting group_id */
-		sprintf(d, "fd=%i,rootmode=%o,user_id=%u",
-			fd, rootmode, getuid());
-		res = mount_notrunc(source, mnt, type, flags, optbuf);
+		sprintf(mp->optbuf_end, "fd=%i,rootmode=%o,user_id=%u",
+			mp->fd, mp->rootmode, getuid());
+		res = mount_notrunc(mp->source, mnt, mp->type, mp->flags, mp->optbuf);
 	}
 	if (res == -1) {
 		int errno_save = errno;
-		if (blkdev && errno == ENODEV && !fuse_mnt_check_fuseblk())
+		if (mp->blkdev && errno == ENODEV && !fuse_mnt_check_fuseblk())
 			fprintf(stderr, "%s: 'fuseblk' support missing\n",
 				progname);
 		else
 			fprintf(stderr, "%s: mount failed: %s\n", progname,
 				strerror(errno_save));
-		goto err;
+		return -1;
 	}
-	*sourcep = source;
-	*typep = type;
-	*mnt_optsp = mnt_opts;
-	free(fsname);
-	free(optbuf);
 
 	return 0;
+}
 
-err:
-	free(fsname);
-	free(subtype);
-	free(source);
-	free(type);
-	free(mnt_opts);
-	free(optbuf);
-	return -1;
+static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
+		    int fd, const char *opts, const char *dev, char **sourcep,
+		    char **mnt_optsp)
+{
+	struct mount_params mp = { .fd = fd }; /* implicit zero of other params */
+	int res;
+
+	mp.rootmode = rootmode;
+	mp.dev = dev;
+
+	res = prepare_mount(opts, &mp);
+	if (res == -1)
+		return -1;
+
+	res = perform_mount(mnt, &mp);
+	if (res == -1) {
+		free_mount_params(&mp);
+		return -1;
+	}
+
+	*sourcep = mp.source;
+	*typep = mp.type;
+	*mnt_optsp = mp.mnt_opts;
+
+	/* Free only the intermediate allocations, not the returned ones */
+	free(mp.fsname);
+	free(mp.subtype);
+	free(mp.optbuf);
+
+	return 0;
 }
 
 static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)

-- 
2.43.0

