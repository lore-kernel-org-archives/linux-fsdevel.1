Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2633A7F6F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560923; cv=fail; b=L7ptebeUJLrmGQH2gYtIGf3StUwlkGSMyrHwOEMyKkg9r/oVmICsaAw04Pw+yN5RVePK+bc1cM48DBVaMygJbjiU0cD4KJeLYvO1FPWHtmVFh7AioCcSS4esmHnvKbjAxXTK0vHejl4gliHPGLn6Lj3x7+RpG68/E94R2c/bZ/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560923; c=relaxed/simple;
	bh=YDa8hYdriL7Z8i7le03+IwVcY9atban6Yo9O6UXleeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TL0FWFD1MAsSa53l3SEQ+pm+B+lmv0FSoojrvIZOGl137XoxEoecUyCJOjlOYEJiPUkm68a7tAJg9UCDVNlDpK+rdsCUOtfpCieP5/3zDILckIWAYnwEnS0R4NUYv1mxGEZTVIp+5uJ9WV6wCyMUkrnEg6Y0CSoC5Y/ApuktARU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=ArvAdB7Y; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="ArvAdB7Y"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022125.outbound.protection.outlook.com [52.101.43.125]) by mx-outbound20-76.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZR6AzJrj1GVOadUjUQ3qgzWWigx8rauX9dfjEyXODG5b6b/Ws2kdCynyrANLk9isO4UbwLfwnYSHKZSZZu9+OM9GOVc0IuzbiJFsatoE1pWE/aY3hRJ8gmLQXhbCOfCFQoIqRzaxmCJ1zd0D+e9QuH5DwmidR/Fh6COC7C2uPUxre2jWTekeutkHUVPW3mGuOdZkx4yMg9CP13mvWkknwzY9637uVnV1wgjcOSWQCluYQWBoJwe+M6HOu3K7S4pAWm4xDHmv8mCr0JCfOSu/rtsb4VRkuKc6cIvL6VDxf3OGeGCCyYqFvQHIn79qDs4f+RUD81JYWUL/BTbqay4Byw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTgh5+6ppgOSDFdBI8uhxvaff0twYdvNQFnsP60ogRw=;
 b=ap/QD7Um1g89bRCpB52LtV3CiquUeQcW55aeJiimGa9LNMOD28T/0STxyLHABT/QuvwAlQmKfXkbAH5kZDKq95jUjtnPP/y1aJIGTvk+jcH0mDpa3Ns1QoRShtE+vd+57IVOxVUXvkJUbE/STI1emAwrir2eO55IuTSirIFc4qP34Rvs2HF/pNSahXRALZ1zbxaOzHtm//s6tUINPLKi5lOl1o6lXv7XgVXhW3gt423IHcGtelXh5sDmQiLnJWucawFIgT+LLy/ZFBqEYl7jWIjS7yuMefTDOID86dhx0aIcRHnawBji/+UUc0qfFQiXi/5Ffw/vbcK7QQ3ewlCy3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTgh5+6ppgOSDFdBI8uhxvaff0twYdvNQFnsP60ogRw=;
 b=ArvAdB7YKn96cqAmsQD4igqTsdt/MtlcipMYSPoe0iOX8Dvx6NL0xCW3uRjmjD3lZ/iFGXRbJUuIIclYMyLv1SBy5XUON5J0hNYw7HZw914rLLU5lEKodR/aQxU71VL/QKwMx9anMaaD9IaAuYy+SrkCOgfe0WNjEJCx+cr5R0E=
Received: from IA4P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::15)
 by CH2PR19MB4039.namprd19.prod.outlook.com (2603:10b6:610:a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 21:34:58 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:559:cafe::6f) by IA4P221CA0012.outlook.office365.com
 (2603:10b6:208:559::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:34:57 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id F33338FD;
	Thu, 26 Mar 2026 21:34:56 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:38 +0100
Subject: [PATCH v2 05/25] Sync fuse_kernel.h with linux-6.18
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-5-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=735;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=uHTCpnK1/Iauoyiah+CbcHvfjwiX1B8DJgEFrBVW9ug=;
 b=quZxQtp7jWad4oojJNWW8xNb9ritIG0p+aChDKgxNO8aS+/DAH4kJBkjXv/4DjvR0qRzbAUO1
 1wi+gAfatSzBeo/UAK5NUvdrWLDFgBBXvLsaZBv3bnRVWlDazG3QJIe
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CH2PR19MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: e57445e0-1c92-411b-bed7-08de8b7f8758
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|19092799006|61400799027|376014|48200799018|18002099003|16102099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KHVRbdgf6jOnAcT1Vg+WUpj/tgies+eIGaNsGQubbMbAYp9WGxUZhhwg6MuLqw6NUGK31dvbyEiGyWQe+7SsbMhhBvp3n0ol5mhImYF1g36qHmCSJRwmNtw7wTWrAql/vxuHywYv8TugYPV45BuN9kEy+3iygu3iXr9FnnDRYenGMVabZYcsRtspSNpp7Myx6/+gLa61khuB2QDbpfK7WKYTdR/IrKRrLaplDiYKnZa4aLNLx9l/VISWzHl3Xxoyg83QlM9LCFYG/+dg6kaNdAzb9bD3/iiWDEOQ5avVbPoH6sNk9xKyXNdvbRLbfsDOpwdxPzjKIqWKjS5vvQPQVccaoywFc76G8ruXhLN/ZPb5lnEGduwXmhsUGuEDLhEA0IMNHXrwAVtO72KKQSmC6tJfq0CAogmCILTvvdu9gwP6GHcojlN2IuTeMmqSzF3C7B4XkphVVQ35HCVjRuFBvUTItAnuomtAwWxfv5of9e170mAZ+9tMOrDlFWvhYh3Nr3lHe68JTiSr6znfY8mkYZ/sXc+9AykqCO1QztMKPLogZe1GgZPE2ZPvNGu7i2OME3NGs4zTLr6WkFe61ZzNfDQJOimEJqy89/2hz2ptHDGEvHYSkoo6Ka48UY+2ft3GMBko15U1+g/6aQRbjoo65R1g7Hzfu4U92eoULE4mL87obyblBwXAHlLJgCmTb9A004cVyfdn0hfSstFGKWj5gpe/a+1mn/RiFlrOOz3RbBG33FwhVMP9odC5DWDOa0zWNefLDRFF1hZoQytA6VD1yw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(19092799006)(61400799027)(376014)(48200799018)(18002099003)(16102099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XyF4GhuqF4v1XzcUXHaMvEg1L+YmBjnQu08iCdpnNhZw8QNBiTi5GqfSC6yR07gZFjIC9fb8N1HYtXcAO+pw7l1UfYFngafJiv6exCiYTettSoMEyQaTE5R2tUcDAqUnZJ1SrpEHPE0RBPAvBS68fEHDkPnwvdIYzrJekD6o9Rjcvc6MmS3ZLCvNCK4w1zaiyfMp03FfhoF7ryDVVL0OAe56VdwQHfPBd42tv38sClm0Nfg3FflJzoNXIkS9JiP3bofUbbOyMiz35rcvV+3DE8xt4LRfQg4L9nkFh3reXAcK39GltZnrMgIn6ZsQYevvZJ7GOTrQHDvrHiBDLgIbTMJSwpJm2pKoxxbzM5ddSB+Me8GmK9INAZEUK16B0EsxZALgUCE9L25v4UgBMTMdw/he+I+8pfmaoGtwxAWiEIgsZZhBdnC6nZG2MgAu2uma
X-Exchange-RoutingPolicyChecked:
	OjNx8JDcdQEdreMqTJDJJ2B5TB6pLUPMA5+r0TYrsnmhpk++WreMbVYMUIt9Tc9x09Tombcj6+oYtcethGdAGnWYgaCnCfapj1PA8ovcFdUSdOF7vNIg5gGV/EyAcQ7RANPpfdSEEsk1nGJwxZviwbkavkVZrAgBMV8vl02FD06NYWrmKr7CCNsl3p+arHPx5RO1s4eq8Gc9LSho7AZpWeMiWt9NHmAtEsbpvEwLJ1tYGgHLzg5a+pHdtKmw+wlE0E7wR4ggz5dxcJ5Cqy+85Gq7Ap84BaRtqUKWw8slGiyornzNYNktiPPNjJCNxAxC4f3QdDE927EBdPWyNRIm0g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fcEWC6Hs1xeeA25J+vov983UaLnCmvsw4oon5yX9ygMEoHcP/ndu0pGgNd2LT0f7i/ay5yox2FALJcdZQ2jK3Mis0I0rU8QzFtWage+OqdYrIGMLtSBKHXBy6FCQK8TLm3peKlmkyPakjNar2EwmAn2IrrKZCWGKDtFTygOXZDmnual6cYBYI1M0d+KxI/F+xdJM7cPF42GvT3DMQ9NVbXRR2Ub18Yaxm97xYuguuCdr3kaCfCt5Ke3qF63Jf7E+kkMi14gocQZf1bVf9ZGLKkCEDRgsPj1sqs7+GBPeJyeyr+4jpiiKYLbbVThuVnqiQSBI+WfZftPVBFxIpSCI3LJWRFBgVYBO6pV+t2DHzYfax4e0SYrklRat6CGtUyKhG+DYGZcbT14UfQKTyVo1CK4bI2/OM2tLZQ37c/x4GcPKN7PvvXfKZZkPLhUshEZmeer6MyAT8Sp7cKuU56PZo/pElKGuqehfe2PiDjYHbP8dBzgboTGBPBgZsw9bgkbOiV5VgCdZnsa1V0m6Jkqz1oL4uDS+x7AxHRYZaPElamU6TJCtjbPXZrf9GH6Ye4Kem+MxYyj3yO4ci1DA6txx9F+UMSwv5x+GNiQMPpDuxIesO7TC3LsI4xJNCWWvnnmfO4JNerkwXs8GrD1QTPNBhA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:34:57.9685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57445e0-1c92-411b-bed7-08de8b7f8758
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4039
X-BESS-ID: 1774560903-105196-7703-14685-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.43.125
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuam5kBGBlDM0sDSzNTALMkiJT
	klMTXNKDXFwMjCIsk8yTDZKDnN0FCpNhYAOCWg4EAAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan23-245.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index f0dee3d6cf51b0eb83104c1f30f70b8ba9d710cd..c13e1f9a2f12bd39f535188cb5466688eba42263 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1138,6 +1138,7 @@ struct fuse_backing_map {
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
 
 struct fuse_lseek_in {
 	uint64_t	fh;

-- 
2.43.0

