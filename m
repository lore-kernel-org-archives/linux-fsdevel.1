Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4DC3B9DA7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287940; cv=fail; b=o9ur1PUBMlJGoAc7T0LQ1HcYGOAq3hZXzk26tG3S2fB196takYF4AIUr7Rndlta+O6E7sYu2sbcdy9M4HcabaFxq4PNHFB9M7uel/UkK3AN6TlYJ27hvlcKuSGeLI4NvH193B85ueDVzX1K2YOogj+XEAdVJpa+jL7dAgcXHruo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287940; c=relaxed/simple;
	bh=nFScg1piTFWiEuwGFd7JvgBC/m6cWTXa0rc702xaywU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bAK1HY0iW3tYta6MiLQVzuUGrD/Q8cdGfbGh05kqkFPZCvjeDrVagr+QWYqBaehkBZIWxraWrKDpfn0HYFilimKuEjhLXChKj8eJd7Y+PwKEL5dN9jj4Sb0y1TPKq5er8DXKDNly+GeXXGESEylwz3iSMy3dU204ehV70fUkVck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=kPO2jFEk; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="kPO2jFEk"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022128.outbound.protection.outlook.com [52.101.48.128]) by mx-outbound45-132.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 17:45:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp0LOHUbSUOlx4w+/ltq+BHAjb/ZyAtVIuraWBHb723jlhS/OBXRlo9B+Yut7RychW+bZk5bbvXp92Ec9fus03OgMEBIgaYFvCkscHi5WvQRrq8lsplqmAm9sMeBlJVya4xwP5BfAxQ4JfIwaEVAnPY0Fk8rXNvPdBY15oN0mCzzASGYz9kNKPoSgrCn2YMvs4DltfxlJA0Myk2YMWqkV6MvMWWamb1Gle1+EetsqAG390Pfi7VzIGIqJLImx3odKjYWqUVrLBWtMJzx7aZf0LFpSVfJghefJCCWn9dbbQku6PlayNE2TfVKjnAca0u0br6Iqm3IjD1jHTO+G9+eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urW/s1bv5B1lfeCJvz0AAKOjxlH+gMIvlJxqeVu5i4s=;
 b=SdBlDoZ9DG/dUIyvb0idlHnL/0H1UnKglUWoJR3bJMwInJP2iYkIkk8K5PKic/3IQKgfOVF1MWMh2WWqhe3X+/e8eT7qAnFfVboYe2RDquRiA0Y9SAyNltuRsaOWhL5QWikLh/hem04cVEtTqVpSLyCRp7We4JyyhkL2DjCUD8X68hMUlpg7JP8SdEtJpcObJvTCJK1AhTT3pfVR7p10gVBBE8Vw+Ka3qQ7WqJvD5DT18jlLLiViJijn22XQjM2wdPNN4FyE6vZ2IfcN3XFwY7EqR1zkQLo65gwC5WfMUZ4CHPbQhojnebo/yW5YzTGBceGr9199wlDT7eNk0L7ecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urW/s1bv5B1lfeCJvz0AAKOjxlH+gMIvlJxqeVu5i4s=;
 b=kPO2jFEkSCFNMSxb9rd0LwNnRTmr13LMfeb9IrVplBlboPf+w05ZfGuEaLMj06IavF5BY62QOjgvcJVCYVrZs5KlwLuVf9bgA9nw6no1BvzBGu0dOApfUlRCeaVTF5IWaFcvOtzIs2Upw43161nMRmhOVHMfmfWp3bZjrp9oYlU=
Received: from MN2PR06CA0015.namprd06.prod.outlook.com (2603:10b6:208:23d::20)
 by DM3PR19MB8475.namprd19.prod.outlook.com (2603:10b6:0:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:12 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::41) by MN2PR06CA0015.outlook.office365.com
 (2603:10b6:208:23d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:12 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 9233115C;
	Mon, 23 Mar 2026 17:45:08 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:00 +0100
Subject: [PATCH 05/19] Sync fuse_kernel.h with linux-6.18
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-5-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=683;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=uzymrsPxVlONqz6hamgD8UzIW1n9REtZMdxhIHc/dGI=;
 b=vY6NpmHZxWFDoOpeothG4/OegzwNEYXJoREpq1SxiVG0Gq7a+YRYa5P01YUe2bVlWtqfil+VX
 cJO98/RObYCB3CvUHttf1ovX1DRR0KLmidMcwzWq3w81JbdcKVkQtd1
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM3PR19MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f3c8f6-73a3-40fc-2f39-08de8903ef40
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700016|19092799006|48200799018|56012099003|22082099003|18002099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	sDqanEePuhA+GATtEczEDPGVWcqWJffPFJ9+tDbiUtLxu7L8yaTrdibm5G1m3yZf4mK/DSfn0lGaBFSlHTKaemMBQWhtDZNbxo9KH5vFYrQg4F/YNrXBSPcsq5JH2KC5i6tW8NfX/dBXfjiLSDp7PjccElRgqj9tS20eqpiIxK7nY+he8gdKWGyCdSKMzRNA5VEJFpyaS+F7F/GauUZ/P3NJ/r58mVv0D918J6lY2xc4qgzIzXeznB214QgBe7Rcy/v5VzJCg5WJ+vBAguIBmycUh5XkyrSF9O4XUb0HJZoxs3wW5/wZEY4m5jLF3rGgMDzW9p8CH1OXTxKSb9wFXYvsDUNnSScweHxDSMzls2mcnJSTnl/6KYqAkUAC4zKm6AHXjxLZlPQiO01qLW+mMu/G7lN1gTIWK2YmmjWxwaXKr0uDPKSPqlCS3AO3ZuBNzuKm1Mg+HlhS6nS93RmYSPz6+Oh2Q5VQRg7xXxD/vJuMkWF4aECA8yRxZCvtm/2PF5SriTA2LmpV2mTvTqTDdH2qawGpIWrK7eba+U136t4hWAaSAXxlSNb1tO8NEoYfLWzCb2Ui/zv3Mtr/f/UUEYR+MREBuB/b8L08kgzNCO0AsxveWW59lvLXu+JusEiIqewJPj8JmWTtVXPDMWBu93snu9B7BVFULx2EqJ2xGfYONKvTYMwx4W4hHrFnAnO+0ESYoh8A7IVQXg+0maM95W6VR57n7du+GW8+v+kJnaxnH0fShnOdroVjYAcn2BJ4jd2PKMqStDqLVjvm+sv5nw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700016)(19092799006)(48200799018)(56012099003)(22082099003)(18002099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eEinseK0Mlj2EJBXiiZyRHgbOywuuIVBGcFp0zcm1S2xMkQWCwwk0WH8nnTS0UmlA2y9Do3rIPj6fqXYrnQyuQgcRkqG5Ejhvefn3d8rEgD97BQEyrUZouqX1c2kDoLwzkaJBCj1Lkit5/9mX/AC/EL3TmGxC8t3MD+8poRO6KjOTCrM5a/RQY/7uRVy8k+7nPfAJpO0uYyBWkwslR8yZXv3sD0UlFqU3Sx1yjvoTaiH2YCSS0Lues3cgw15QAYVKFe7LOIr7XV7G4LfPd6vf+rzAp3qSf8OW5yMnoH7gghQMDXKwH8dBfpkzjloWMWea4z+5xHUTipOULX/QBsi0wFQXn/aIPob7NylYjIO3MhgPH/U7916DlDfs3uWkp6FXJRn1s7jm1eqeD9q3tOD0KDBaeryE4yJ1bDk3G5Y+vIvpIDIs0Dcp4KaHYwILv4K
X-Exchange-RoutingPolicyChecked:
	OwCRqe9YZMiukHeWwi7DpaTJRilsZL2QJU8Pgz/bbOFBq8VUwdabJzRxsi/WlDZqzil/PzSrC7imWkAZB08eDT4hffhMplihk+GVjNiuKTY601wOdoffT5kWFQUMtkmtURTTuudVKQyyNG1gXB9ZB+D9gmFjBzsq2wkbZd0lS1o0aisT6F//dB1UY0Dl6hQwGSNhB961j48/LHtDni5hrzDBzB3c1TgECsI+sJwfLWExmiO9hCiG6+b4Dxrz9+f5cY53fVbdKZsCiOdcd4gEeJk5BqpRIfOg10fcjT6mcQai9IIrIl6UbJWbclZ7zeCZbTJ/FiFvoYMRICmqtVTWtw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SNVwQOrMn2WipEmY/UPVarvWk/7lv4MkySoJxnRa2BLa5r7ZJ3hHOdSWuOL0DIWiExvui2PJUzYMqQytm+Lvup8JCtMi1Y8yqnldv1jmOvGAwyaKO/BzFSjCPJ4utzF0GUsPh0keQ+w/IR24svKRN6CEq5e3gf+1KaamQHZqOV2NN90gEQYHrx1BHcML5sigyNtGS5JD0KtJvMjeOUuHw+02bFlXJTxVVULwALMt7dpe0OhgMZHgg2j4MIzLNf6zIRxNoRSiY0utZZDLjBSF/0exO+jFEly8TFbeMw5wpBWX8/AZEo+2evvGJYATR5s6rRFXCywZdEWsCc4+ALnvDmz4vnW3BLL1DDY3E9RIAp8pUit/RT/rqvX/Xh57V5nIk+Cemr6crZsWj31YLCa5WCMcprYf8nEjrUPs194trTIJwALQBtQIyh1/dxPS/8R2l9nSNTEsCoIJLUGs+pZHPnybOhYf8CUsNyiPpXxR4+54chBQGF6eOYVWk29/jqgpOL58j37FxG7/CuO5tBCwrpcH+jS0wFoLXED6Yt2DQbaosswjiceXKo/U2fegwxij7zaRKV1kOCAk44sEjXc47JTdYfHXne/BrbURUj0rMlyHCpn0I8dJGYkFPa/jzwoZwRC3B1b5iJ2w/fZMf4NGCQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:12.3560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f3c8f6-73a3-40fc-2f39-08de8903ef40
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR19MB8475
X-BESS-ID: 1774287918-111652-7713-23291-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 52.101.48.128
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYGZkBGBlDMzMQ0JdEw0TLFyC
	TJKCU5xcjA2CDZJNnMwDjNLC0pNVWpNhYAPc+t50AAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan22-179.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
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

