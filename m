Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B03A782E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560952; cv=fail; b=uvu4yztgBw/xE3Lwi/10nSAWP4w2tdfQxIMIJtELJafVcjC9grU/wQi7EC7KVOBzlD+6ijCjTPh6NH6dcfvZp6K8PcKj/yZTaVgmopOpGfCOzfZ1qMic1nfd9CcKmqlTgkZG3bvWoeycThJjW2XiYXFPVN79vPXv5bGu74LOnTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560952; c=relaxed/simple;
	bh=KYvDPRUJSF0ibTO+Avns+tb0KmJf0L+cNhS8aZgWKQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=adHuXcIUfR9sRRk88is3hPDakVj/CHjYN9EamcO7JPdKI2MM/c6dYBZDt46wtsWS4cKuygHZnMNpmBsGmNovzOPa5PtsglpuMlYD+LPjs7fHAWQJ2wSnHuhxz/3GtO/bWqs/94iQzqzGLM5L4YVT5t52anvZP5JWE0LKPCHt9IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=OS05Lb+4; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="OS05Lb+4"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023080.outbound.protection.outlook.com [40.93.196.80]) by mx-outbound-ea46-43.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLPXLUX+5yYUyUSYiCvWOxjtoJXnpmnvPaZoILbk3WhmtjckdvpZGMe3mKd8Na2kLxZXPRp/ilaZY5N1RHdZldZ4IlTBCnXpxaEumTy8boeXxdX9Fsg7OQdVXYZeSz1KBPpMq7kqJiCwcQcS3FkkHxAdl2aR0mAg7COd1+7A6EWfOhTGbjaTb/OI/J9YXJVm0BIHrO+mfQ44hdtYVWpQj2l40kGoB3j28A5WBlujohbV6xHzuC3GNmatUJiDejeaky6/ovtHjpE+lXlLk2KBrsr0K7F+K/vVPw9/PBvWL7hSr6Mtjndb/jPUI/HV2CkUwMfpzuuhpTsQaTUcH55b1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCj7jzmp6SuCxdMsnA+k2UgzXNlqKuIZ+R3AYWlAgRY=;
 b=jeL05pbpuQc8QTBv0Zl4qxYBIJi1xw8toiBcyC0RQmlWTgQKOtDGgFBdjdvFeqMd9e2CTDJ4TZ27RTe44QdZWx0/z7W2kD80h0yG3IvWlDUXInfibvXCMyke7qd3jFiaqeWZXsa/ezNpQzUeBPc+kvaWg8aryToH/SuQ2tRxBgJSjvYU3P11JU45E4g8GC/Y0j0EqN3lKKI+N0wF7gnNhOrRs3CxlNfY6lvMkA6NDt1WltKOF08Hh8BzcTf0uPwo8t8KBhVRiUjr31yjd+BGmLzzdoX7QPPz2rq8uJZ+YyBjF7ZByzBG2BwFDQnem6vZ4S73ojEJXwaLYD3gbhvFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCj7jzmp6SuCxdMsnA+k2UgzXNlqKuIZ+R3AYWlAgRY=;
 b=OS05Lb+4QP7uy1TcWyE1/yOv9Wq5CNZE9eE6VzpN8DKLGrLbNTnxjachFOFvMefoSrF2lm+KYz6h3kD0ToWlA583o2oefZ0c56X4yEXag0hSKkKwWYhyPg02qr8a/g1kaMYekJuOtMWXzrlZesMLgsqc15RrDa2XksbN8XxOnro=
Received: from PH7P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::20)
 by SJ0PR19MB4592.namprd19.prod.outlook.com (2603:10b6:a03:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 21:35:14 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::fc) by PH7P221CA0057.outlook.office365.com
 (2603:10b6:510:33c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:13 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 1CB4C6F;
	Thu, 26 Mar 2026 21:35:13 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:55 +0100
Subject: [PATCH v2 22/25] Add support for sync-init of unprivileged daemons
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-22-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560892; l=17141;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=Qnhq2bi25ECDccQ9CiRE7Wa59eZrDpybI0oCtTFslIY=;
 b=AB453EAGHmPuSW0hX5ULzd/CH3qLQehvU3VJc9i+TGn+MpFRRqqc2/r5EYosyxKE8NKuPITTP
 +NzobLIb1sxCwjtI9pil90cKlaxPnrxEBVwFb/EAugAVGSkIStxGgqQ
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SJ0PR19MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: 238fac32-5218-4622-50a9-08de8b7f90ba
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|61400799027|48200799018|82310400026|36860700016|376014|56012099003|22082099003|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KKePBcdAN1MYWhs52q5W+SNh1OVoyHYxM2BDPMXpZheHfXW6OWzpCsyYQvJi1L14pcIcTjAxShyWvnoQNbU3hZmiwIgvfMEm8VKx21O91VpnsAXDcB4QjqJpN6wyr1g270EWzDKfnqJCRsnyf0b8HRheL0vYNYcEX24kdUtaH7h3m3ifaCRZsqYwDWF/fL/YyfK8OeAZjJ0ap1jVrf+gJn+OKiTZuk3QfXYyZeArJv5InfDRlN4cykiJbRCkfg+6w7hubjMCxpJ2ToP2t2av23nG+Skj7n5o6ARKzsDey0i0ZRkpyKktdVFnc9SCeTl8qDbiJ6dcaCy8l6fFVwTH/Z9+ZpoPTSdD4bnaZ4UCZEf5ZUNa3dtf4XBmkv8qMljHcS0CBN6oG6RZe+E16l4SOIDU1Bfozdd0uT4biSgXeMO76dZwBjcii3BGlFi+IYGsquIegPwTNEP4Urtr/1aSUYUBxb3zEI4LMSEwRUUrpqU7dUvWpumZrvtZVvw4caO+jzgAFfsq6ODds8+FLMG1DAlpPeNp3hC3bKa/DVOYJq7OWtGggf3wyoenShCudH0VWJM0qA1Am7ts2RtUi7Av3divAXQSMoecDE4AEAPjnqLo992cOnhwsnNQf5vm7PgZTsdbYnm9xsGSf7bcZOqAbZWisXw95CEDF2JOTAc3KNAarlGEZIwiXPO432F+ZBdXfesLyUP2GkUIvW93AwsVh77GyiL3S6C/paCpLby++GjWt3eA0VYDxEWKSy9tN+AsDBlrD8pXANN9uojthWR4KQ==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(61400799027)(48200799018)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(16102099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OraiCpZ+hgfjkTzGZZ/CYuDEIJlWuIeZqjwVD4mUYEFfvBN8ZZsGkWd8bQsfm2ey8BtPwj1gKpWOwU0gpKW6EhtyEkGzE2MskvVIsvuVMIvY4kNVnN6lSSn/whDGIUYHujoKlCJqgvf5oTW8IK5JkUNOi3d/UC2iZF7g/Vcvdiz06ABfXhqLQBOym9nUWq5S7HHUrB9IghaScn2PiDTzm49NlWC61UBE+uhzrxZE1f3GQGF7D3Yu7YTyOGYYuF3KAIrn8EguYXZWXGJtSspZSW35yq+CzRkAFvR2mwesJ2kzgrkaRBeuhGREjp9ePI/UPEmYEL3iKERp0qp1CHEcCn9/1KfmSTb3obHa6lHvWDMnXc5yg596ZQi5pzLNAlG3as2UA7JXfXigyiz8fbCf//3BxUgh75dITE5eyy7W9Fyeu5Zi5eolOEDtLqDdyouP
X-Exchange-RoutingPolicyChecked:
	KDx8Z0jp52MEVvWuHGkO5w6fUywfWf66hAkOFlW+DpBj/+DWAmJdKZapUrCvkVnMR24tNcTISBWEXxKyOnW9jE/vU/TYVxjCPodHHnIRiWYaVBFqdnuBdbyFwZP43yozMyD8b4UkITmmxaL6iXkFSZ9VnUfNR2DtECm61dBZyeOHOpSNf0CcohF5Fa8Vnd4RA3HPd94ZxBcpPNO/EF9fSe1bmdOkNxBTEDNlPKWNneZbEJLmMAJGEUWXncUWPHm6Bki9EF7hsaLDXHwBYqCC7fj2K9tbASfqALKY5FHPfErnfq4Qi6o6s8GvbUfIPCQ+YX2FijeZ5wK2H3+3fc3Q8A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LFJZ6mYfQtOK+QP9+/vaZMebiZ0GlgAzGDWGuZlTEK5oGnBjWFtWXepwOCQuIxUmadlEu8LPhc623ALssY+W6pMadjJi4g1I/gpipD7J3SyvHim8YHYEyP99c31KX2YdSXma7lzBPz25obqWIUtzdm76OUFeN/Og/1J8WF54Lib0dV6RDurfE4XQGM/Da10IhJ1SJPBOmaoZ06ShnCsQiIJIV3BfjHtJD16rWt5fR7jXsfGCq2BlxZ/imgy1gPnxqN1U7lzRCkdpmLlOXJPDfjBY9+rcFwIahhyYbI87VS3M9GJZlKlvsTE54b1PI+Cedmue5WPL7iR01gu4yUaNrews3/JAzCP8QLnaQq3FSLM6DGIElICKW5PVDFoWuGkZNBTuFRmeGI4mCc8EYy3oMgI6JsON/OAi0d8vTZSzxiH9nzvzOGIktbjqHHJ6hSEaqBJs6TfaEoMFRObXRmGYS+g0fuS26xZNk0tSgKG19Px/NMmvPxgGOz5LX3nRFApn/tSjVNa7puPbYVUQlvrG3D7gGxeKs9djEteQQ6Q6ZDiiNPNC8AazUbKrLpDR2wNfwd1n+8ttjtLzng4TlMcae+jrL91Ty/w4mfwf9dHA7Dv+1gbXsH6QuoJJEHl3VdW29DWOVWCquSv0YWIUszgRVg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:13.7920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 238fac32-5218-4622-50a9-08de8b7f90ba
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4592
X-BESS-ID: 1774560942-111819-21249-29176-1
X-BESS-VER: 2019.3_20260325.1648
X-BESS-Apparent-Source-IP: 40.93.196.80
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmZoaGQGYGUNTExCzRNNnQLC
	XNxCjNxNjIwMgyzdLIIi0x2dDSKMXMQqk2FgBlP+XtQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan16-50.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

This makes use of the bidirectional fusermount. Added is
doc/README.mount, which explains the new bidirectional
communication with fusermount.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 example/passthrough_hp.cc |   5 +-
 include/fuse_daemonize.h  |  16 ++++--
 include/fuse_lowlevel.h   |   8 +++
 lib/fuse_daemonize.c      |  14 ++++--
 lib/fuse_i.h              |   1 +
 lib/fuse_lowlevel.c       | 121 ++++++++++++++++++++++++++++++++++++--------
 lib/mount.c               | 126 +++++++++++++++++++++++++++++++++++++++++++++-
 lib/mount_i_linux.h       |   7 +++
 util/fusermount.c         |   2 -
 9 files changed, 266 insertions(+), 34 deletions(-)

diff --git a/example/passthrough_hp.cc b/example/passthrough_hp.cc
index bad435077697e8832cf5a5195c17f2f873f2dfe6..cca865973ab5e8e9c1faa0fa28eb292a172a4812 100644
--- a/example/passthrough_hp.cc
+++ b/example/passthrough_hp.cc
@@ -245,7 +245,7 @@ static void sfs_init(void *userdata, fuse_conn_info *conn)
 	/* Try a large IO by default */
 	conn->max_write = 4 * 1024 * 1024;
 
-	/* Signal successful init to parent */
+	/* required here for async init */
 	fuse_daemonize_success();
 }
 
@@ -1661,6 +1661,9 @@ int main(int argc, char *argv[])
 	if (teardown_watchog == NULL)
 		goto err_out4;
 
+	/* required here for sync init */
+	fuse_daemonize_success();
+
 	if (options.count("single"))
 		ret = fuse_session_loop(se);
 	else
diff --git a/include/fuse_daemonize.h b/include/fuse_daemonize.h
index 6215e42c635ba5956cb23ba0832dfc291ab8dede..6d3c4a6134f408d0f0a08b87495bde65d491286d 100644
--- a/include/fuse_daemonize.h
+++ b/include/fuse_daemonize.h
@@ -42,6 +42,16 @@ int fuse_daemonize_start(unsigned int flags);
 
 /**
  * Signal daemonization success to parent and cleanup.
+ *
+ * Note: For synchronous FUSE_INIT, this must be called after
+ *       fuse_session_mount() and before the first call to
+ *       fuse_session_loop*(). For asynchronous FUSE_INIT, this should
+ *       be called in the file system ->init() callback.
+ *
+ *       In order to simplify application code, this should be called from
+ *       the file system ->init() callback *and* after fuse_session_mount.
+ *       Libfuse knows internally if this is a sync or async FUSE_INIT
+ *       and will only signal the parent if the mount was completed.
  */
 void fuse_daemonize_success(void);
 
@@ -60,12 +70,12 @@ void fuse_daemonize_fail(int err);
 bool fuse_daemonize_is_active(void);
 
 /**
- * Set mounted flag.
- *
- * Called from fuse_session_mount().
+ * Set mounted flag. Called from fuse_session_mount().
  */
 void fuse_daemonize_set_mounted(void);
 
+void fuse_daemonize_set_got_init(void);
+
 /**
  * Check if daemonization is used.
  *
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index d85929e291a77de8caad7d6b3d9ac5b092ce0e62..ba7c4b3ac788f19f30fbf120fe8f6ae5851b425e 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2441,6 +2441,14 @@ int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf);
  */
 void fuse_session_want_sync_init(struct fuse_session *se);
 
+/**
+ * Check if the connection / session is using synchronous FUSE_INIT
+ *
+ * @param conn the connection
+ * @return true if using synchronous FUSE_INIT, false otherwise
+ */
+bool fuse_conn_is_sync_init(struct fuse_conn_info *conn);
+
 /**
  * Enable debug output
  *
diff --git a/lib/fuse_daemonize.c b/lib/fuse_daemonize.c
index 97cfad7be879beacf69b020b7af78d512a224fd5..d4a34da15114fc0742394e72510946b63a98a252 100644
--- a/lib/fuse_daemonize.c
+++ b/lib/fuse_daemonize.c
@@ -40,7 +40,8 @@ struct fuse_daemonize {
 	bool watcher_started;
 	_Atomic bool active;
 	_Atomic bool daemonized;
-	_Atomic bool mounted;
+	_Atomic bool mounted;  /* fuse_session_mount() completed */
+	_Atomic bool got_init; /* got FUSE_INIT */
 };
 
 /* Global daemonization object pointer */
@@ -238,9 +239,9 @@ static void fuse_daemonize_signal(int status)
 	struct fuse_daemonize *dm = &daemonize;
 	int rc;
 
-	/* Warn because there might be races */
-	if (status == FUSE_DAEMONIZE_SUCCESS && !dm->mounted)
-		fprintf(stderr, "fuse daemonize success without being mounted\n");
+	/* The file system is not mounted yet - don't signal parent */
+	if (status == FUSE_DAEMONIZE_SUCCESS && (!dm->mounted || !dm->got_init))
+		return;
 
 	dm->active = false;
 
@@ -292,6 +293,11 @@ void fuse_daemonize_set_mounted(void)
 	daemonize.mounted = true;
 }
 
+void fuse_daemonize_set_got_init(void)
+{
+	daemonize.got_init = true;
+}
+
 bool fuse_daemonize_is_used(void)
 {
 	return daemonize.active;
diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index 164401e226eb727192a49e1cc7b38a75f031643b..20e9c275cbffade69d3fd440d1b48b371135bd84 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -75,6 +75,7 @@ struct fuse_timeout_thread;
 struct fuse_session {
 	_Atomic(char *)mountpoint;
 	int fd;
+	_Atomic bool is_sync_init;
 	struct fuse_custom_io *io;
 	struct mount_opts *mo;
 	int debug;
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 4445e134a7ff5be508306f74db9d9c56e3582070..c4bb227b51a5226543adf7f037fb2c4604a5f978 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -41,6 +41,7 @@
 #include <assert.h>
 #include <sys/file.h>
 #include <sys/ioctl.h>
+#include <sys/wait.h>
 #include <stdalign.h>
 #include <poll.h>
 
@@ -3024,6 +3025,7 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 	 * over the thread scheduling.
 	 */
 	se->got_init = 1;
+	fuse_daemonize_set_got_init();
 	send_reply_ok(req, &outarg, outargsize);
 	if (enable_io_uring)
 		fuse_uring_wake_ring_threads(se);
@@ -4456,7 +4458,8 @@ static void *session_sync_init_worker(void *data)
 }
 
 /* Enable synchronous FUSE_INIT and start worker thread */
-static int session_start_sync_init(struct fuse_session *se, int fd)
+static int session_start_sync_init(struct fuse_session *se, int fd,
+				   bool *fall_back)
 {
 	int err, res;
 
@@ -4491,6 +4494,12 @@ static int session_start_sync_init(struct fuse_session *se, int fd)
 		return err;
 	}
 
+	/*
+	 * If we get here, we know that sync init is enabled and fall back
+	 * to the old mount API is not allowed
+	 */
+	*fall_back = false;
+
 	if (se->debug)
 		fuse_log(FUSE_LOG_DEBUG,
 				"fuse: synchronous FUSE_INIT enabled\n");
@@ -4553,6 +4562,8 @@ static int session_wait_sync_init_completion(struct fuse_session *se)
 		se->init_wakeup_fd = -1;
 	}
 
+	se->init_thread = 0;
+
 	if (se->init_error != 0) {
 		fuse_log(FUSE_LOG_ERR, "fuse: init worker failed: %s\n",
 			 strerror(-se->init_error));
@@ -4567,10 +4578,19 @@ static int session_wait_sync_init_completion(struct fuse_session *se)
 	return 0;
 }
 
+/*
+ * Mount using the new Linux mount API (fsopen/fsconfig/fsmount/move_mount)
+ * Sync-init is only supported with the new API, as the mount might hang
+ * in case of daemon crash during FUSE_INIT. That also means once the sync init
+ * ioctl succeed fallback is not allowed anymore.
+ * Returns: fd on success, -1 on failure
+ */
 static int fuse_session_mount_new_api(struct fuse_session *se,
-				      const char *mountpoint)
+				      const char *mountpoint, bool *fall_back)
 {
 	int fd = -1;
+	int sock_fd = -1;
+	pid_t fusermount_pid = -1;
 	int res, err;
 	char *mnt_opts = NULL;
 	char *mnt_opts_with_fd = NULL;
@@ -4587,34 +4607,85 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
 	fd = fuse_kern_mount_prepare(mountpoint, se->mo);
 	if (fd == -1) {
 		fuse_log(FUSE_LOG_ERR, "Mount preparation failed.\n");
-		err = -EIO;
 		goto err;
 	}
 
-	/*
-	 * Enable synchronous FUSE_INIT and start worker thread, sync init
-	 * failure is not an error
-	 */
+	*fall_back = true;
 	se->fd = fd;
-	err = session_start_sync_init(se, fd);
+	err = session_start_sync_init(se, fd, fall_back);
 	if (err)
 		goto err;
 
 	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
+	err = -ENOMEM;
 	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
 	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
-		err = -ENOMEM;
 		goto err;
 	}
 
+	/* Try to mount directly */
 	err = fuse_kern_fsmount_mo(mountpoint, se->mo, mnt_opts_with_fd);
+
+	/* If mount failed with EPERM, fall back to fusermount3 with sync-init */
+	if (err < 0 && errno == EPERM) {
+		if (se->debug)
+			fuse_log(FUSE_LOG_DEBUG,
+				 "fuse: privileged mount failed with EPERM, falling back to fusermount3\n");
+
+		/* Terminate worker thread with wrong fd */
+		if (session_wait_sync_init_completion(se) < 0)
+			fuse_log(FUSE_LOG_ERR, "fuse: sync init completion failed\n");
+
+		/* Close the privileged fd */
+		close(fd);
+		fd = -1;
+		se->fd = -1;
+		*fall_back = true; /* reset */
+
+		/* Call fusermount3 with --sync-init */
+		err = -ENOTSUP;
+		fd = mount_fusermount_obtain_fd(mountpoint, se->mo, mnt_opts,
+						&sock_fd, &fusermount_pid);
+		if (fd < 0) {
+			fuse_log(
+				FUSE_LOG_ERR,
+				"fuse: fusermount3 sync-init failed\n");
+			goto err;
+		}
+
+		/* Start worker thread with correct fd from fusermount3 */
+		se->fd = fd;
+		err = session_start_sync_init(se, fd, fall_back);
+		if (err)
+			fuse_log(FUSE_LOG_ERR,
+				"fuse: failed to start sync init worker\n");
+
+		/* Send proceed signal and wait for mount result */
+		err = fuse_fusermount_proceed_mnt(sock_fd);
+		if (err < 0) {
+			err = -EIO;
+			goto err_with_sock;
+		}
+	} else if (err < 0) {
+		/* Mount failed with non-EPERM error, bail out */
+		goto err;
+	}
+
+err_with_sock:
+	if (sock_fd >= 0) {
+		close(sock_fd);
+		/* Reap fusermount3 child process to prevent zombie */
+		if (fusermount_pid > 0)
+			waitpid(fusermount_pid, NULL, 0);
+	}
 err:
 	if (err < 0) {
+		/* Close fd first to unblock worker thread */
 		if (fd >= 0)
 			close(fd);
 		fd = -1;
 		se->fd = -1;
-		se->error = -errno;
+		se->error = err;
 	}
 	/* Wait for synchronous FUSE_INIT to complete */
 	if (session_wait_sync_init_completion(se) < 0)
@@ -4626,10 +4697,11 @@ err:
 }
 #else
 static int fuse_session_mount_new_api(struct fuse_session *se,
-				      const char *mountpoint)
+				      const char *mountpoint, bool *fall_back)
 {
 	(void) se;
 	(void) mountpoint;
+	(void) fall_back;
 
 	return -1;
 }
@@ -4639,6 +4711,7 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 {
 	int fd;
 	char *mountpoint;
+	bool fall_back;
 
 	if (_mountpoint == NULL) {
 		fuse_log(FUSE_LOG_ERR, "Invalid null-ptr mountpoint!\n");
@@ -4682,21 +4755,18 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 		return 0;
 	}
 
-	/* new linux mount api */
-	fd = fuse_session_mount_new_api(se, mountpoint);
-	if (fd >= 0)
-		goto out;
+	/* new linux mount api (and sync init) */
+	fd = fuse_session_mount_new_api(se, mountpoint, &fall_back);
 
 	/* fall back to old API */
-	se->error = 0; /* reset error of new api */
-	fd = fuse_kern_mount(mountpoint, se->mo);
-	if (fd < 0)
-		goto error_out;
+	if (fall_back && fd < 0) {
+		se->error = 0; /* reset error of new api */
+		fd = fuse_kern_mount(mountpoint, se->mo);
+		if (fd < 0)
+			goto error_out;
+	}
 
-out:
 	se->fd = fd;
-
-	/* Save mountpoint */
 	se->mountpoint = mountpoint;
 
 	fuse_daemonize_set_mounted();
@@ -5015,3 +5085,10 @@ void fuse_session_set_debug(struct fuse_session *se)
 {
 	se->debug = 1;
 }
+
+bool fuse_conn_is_sync_init(struct fuse_conn_info *conn)
+{
+	struct fuse_session *se = container_of(conn, struct fuse_session, conn);
+
+	return se->is_sync_init;
+}
diff --git a/lib/mount.c b/lib/mount.c
index 408e9d36896048fc167e264c95b6f6e31d86679f..f0d12525310a9ad239c0f447af60bd49b105a091 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -37,6 +37,7 @@
 #define FUSERMOUNT_PROG		"fusermount3"
 #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
 #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
+#define ARG_FD_ENTRY_SIZE	30
 
 	enum { KEY_KERN_FLAG,
 	       KEY_KERN_OPT,
@@ -306,7 +307,7 @@ static int setup_auto_unmount(const char *mountpoint, int quiet)
 		return -1;
 	}
 
-	char arg_fd_entry[30];
+	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
 	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
 	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
 	/*
@@ -379,7 +380,7 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
 		return -1;
 	}
 
-	char arg_fd_entry[30];
+	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
 	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
 	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
 	/*
@@ -439,6 +440,127 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
 	return fd;
 }
 
+/*
+ * Mount using fusermount3 with --sync-init flag for bidirectional fd exchange
+ * Used by new mount API when privileged mount fails with EPERM
+ *
+ * Returns: fd on success, -1 on failure
+ * On success, *sock_fd_out contains the socket fd for signaling fusermount3
+ */
+int mount_fusermount_obtain_fd(const char *mountpoint, struct mount_opts *mo,
+			       const char *opts, int *sock_fd_out,
+			       pid_t *pid_out)
+{
+	int fds[2];
+	pid_t pid;
+	int res;
+	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
+	posix_spawn_file_actions_t action;
+	int fd, status;
+
+	(void)mo;
+
+	if (!mountpoint) {
+		fuse_log(FUSE_LOG_ERR, "fuse: missing mountpoint parameter\n");
+		return -1;
+	}
+
+	res = socketpair(PF_UNIX, SOCK_STREAM, 0, fds);
+	if (res == -1) {
+		fuse_log(FUSE_LOG_ERR, "Running %s: socketpair() failed: %s\n",
+			 FUSERMOUNT_PROG, strerror(errno));
+		return -1;
+	}
+
+	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
+	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
+	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[1]);
+	setenv(FUSE_COMMFD2_ENV, arg_fd_entry, 1);
+
+	char const *const argv[] = {
+		FUSERMOUNT_PROG,
+		"--sync-init",
+		"-o", opts ? opts : "",
+		"--",
+		mountpoint,
+		NULL,
+	};
+
+	posix_spawn_file_actions_init(&action);
+	posix_spawn_file_actions_addclose(&action, fds[1]);
+	status = fusermount_posix_spawn(&action, argv, &pid);
+	posix_spawn_file_actions_destroy(&action);
+
+	if (status != 0) {
+		close(fds[0]);
+		close(fds[1]);
+		return -1;
+	}
+
+	close(fds[0]);
+
+	fd = receive_fd(fds[1]);
+	if (fd < 0) {
+		close(fds[1]);
+		waitpid(pid, NULL, 0);
+		return -1;
+	}
+
+	fcntl(fd, F_SETFD, FD_CLOEXEC);
+
+	/* Return socket fd for later signaling */
+	*sock_fd_out = fds[1];
+	*pid_out = pid;
+
+	return fd;
+}
+
+/*
+ * Send proceed signal to fusermount3 and wait for mount result
+ * Returns: 0 on success, -1 on failure
+ */
+int fuse_fusermount_proceed_mnt(int sock_fd)
+{
+	char buf = '\0';
+	ssize_t res;
+
+	/* Send proceed signal */
+	do {
+		res = send(sock_fd, &buf, 1, 0);
+	} while (res == -1 && errno == EINTR);
+
+	if (res != 1) {
+		fuse_log(FUSE_LOG_ERR, "fuse: failed to send proceed signal: %s\n",
+			 strerror(errno));
+		return -1;
+	}
+
+	/* Wait for mount result from fusermount3 (4-byte error code) */
+	int32_t status;
+
+	do {
+		res = recv(sock_fd, &status, sizeof(status), 0);
+	} while (res == -1 && errno == EINTR);
+
+	if (res != sizeof(status)) {
+		if (res == 0)
+			fuse_log(FUSE_LOG_ERR, "fuse: fusermount3 closed connection\n");
+		else
+			fuse_log(FUSE_LOG_ERR, "fuse: failed to receive mount status: %s\n",
+				 strerror(errno));
+		return -1;
+	}
+
+	if (status != 0) {
+		if (status != -EPERM)
+			fuse_log(FUSE_LOG_ERR, "fuse: fusermount3 mount failed: %s\n",
+				 strerror(-status));
+		return -1;
+	}
+
+	return 0;
+}
+
 #ifndef O_CLOEXEC
 #define O_CLOEXEC 0
 #endif
diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
index 597b380076fccc1d38fd4d0b9108fc92a1adfa62..ae98296a334a2aa39c4f3e5c3e4e3c136ae38cd3 100644
--- a/lib/mount_i_linux.h
+++ b/lib/mount_i_linux.h
@@ -43,4 +43,11 @@ int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
 
 char *fuse_mnt_build_source(const struct mount_opts *mo);
 char *fuse_mnt_build_type(const struct mount_opts *mo);
+int mount_fusermount_obtain_fd(const char *mountpoint,
+					   struct mount_opts *mo,
+					   const char *opts, int *sock_fd_out,
+					   pid_t *pid_out);
+
+int fuse_fusermount_proceed_mnt(int sock_fd);
+
 #endif /* FUSE_MOUNT_I_LINUX_H_ */
diff --git a/util/fusermount.c b/util/fusermount.c
index 31bf959024ae0cd2a4e50974589bfab30a100b0a..bf442416c83d6da3f80eca5c9814df29f61bec56 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -1323,7 +1323,6 @@ struct mount_context {
 	char *source;
 	char *mnt_opts;
 	char *x_opts;
-	const char *type;
 };
 
 /*
@@ -1447,7 +1446,6 @@ static int mount_fuse_finish_fsmount(const char *mnt, const char *opts,
 
 	/* Store results in context */
 	ctx->source = mp.source;
-	ctx->type = mp.type;
 	ctx->mnt_opts = final_mnt_opts;
 	*type = mp.type;
 

-- 
2.43.0

