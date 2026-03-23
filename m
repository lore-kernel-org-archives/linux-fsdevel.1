Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FEC3C6A4F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289919; cv=fail; b=igZzhVIvLCscQu5MuW5fbtmThjyAViPqPpQqOg6LI9To9dS/FnrPa8knOAfdRX6oIzjkPWTH1ip0kGqaOS1166WEj8Rh6phkhdkCYgdg/407JQvfl5nCu0JNRsOKqtqUHMEf5oqXnl/NtVq5vo+3W7tgObkK6taBeH0saZzmYoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289919; c=relaxed/simple;
	bh=Fs22iYbgnM55BAtJjuZU48o2DCtnsraPF9VIje8AjU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKbVNZAepYSrm1Oc2liC4J0i2lOdULSKvi0bqVneugWsCGncczVQAlsGVhIjLFQM0VG78QV3dsEZQS1Gj1Bry9GPye4h5UkYLnbNBpfnZYaqiBYnTj21dSYQe0bPaMVwXoiloMWPY5JyNL+Z+R3RauOTMA2DKgx20BwuYd01ku8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=jmqAipZj; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="jmqAipZj"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020077.outbound.protection.outlook.com [52.101.201.77]) by mx-outbound15-37.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 18:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6M01QIIldpL+iYW5Z34vemUvHQFNi176NEWK/EUUwQvQmQ8eR5D9Sn4ozjoAXiThgdXoPvPHkmYzRS8qzQCDqRFlVomq4F4MSSBjHLxszHck83zx8NlR+D0TV1SZmhhZxdmGo0ksZCXMIB8jbrQJ1JuVC8mBB5gI1e94c5IO1gy9wYF9rMZ5BJJAxFdYcL335YC0W68SwVWbhkPPc4M2LYJDV9BA5y67Eyp0noNfGwuwGc4gefcIDFq2X1GQ62V749Rjr7Hdp8+KSxpy6WelPszGzRkoBxyDD6hI7RfIySsvCwDIIDchqmD2dHcyBePIp6ZdvcrvmXJCM7ShNGnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCQ768AfgRDk9rLXnNu8Fkl8o50UTC4KJJC0xcKTdWI=;
 b=i/bscQtSlWn9uBz8zbbt0AZXdXQ4w3vDHQYRX4TxVIx6sb5xsNhuTjYawRMHjkcxycn1+s5IUAsu3baNSXaI8xA6miIN9adVOaLtqaH0YLT/uWXO+YnRRV8yVEve5GdlAtWlcP6zNMyTQKT5Bxr53lbwhMwIwtC4KEc536uP8LgEt8lCILe5PhfS8xYd8uMtWfBUkTSH7V9BW/8KQ+/ZnSmXhCA/JA1rBIOfX53tXk9uaVtxV5d18pDwE0nvCyQElVrigVHTgMg/tLIKqL5JYDDk5HiTIJCxL7WwoNHZfWAtHtfemtoow8mwZNUs0+ZspM22ksj5dbaOl+81yCIUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCQ768AfgRDk9rLXnNu8Fkl8o50UTC4KJJC0xcKTdWI=;
 b=jmqAipZjIl8ZydP66NgD/OFnKQ5HYdpmGABmCw0qJzsEiFG4qcqNFhpqt84lbQqmPVTfx5rO3vJwKRRbcTTjUwzRFPUFK0Ssi7TqNH0Mssq9ik01edzJpz2gjbbYZtccaZIsg4X2kSjOeT6bB7Z4HURr+h5HBiE844I2Bp44ji0=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by CO1PR19MB5078.namprd19.prod.outlook.com (2603:10b6:303:d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:17 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::49) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.0
 via Frontend Transport; Mon, 23 Mar 2026 17:45:16 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 528E015C;
	Mon, 23 Mar 2026 17:45:13 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:05 +0100
Subject: [PATCH 10/19] conftest.py: Add more valgrind filter patterns
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-10-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=1837;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=kuBJ5LUqgo3u7XVa/ZdeGo8e13LKV871C4KIVFodCH4=;
 b=XFZ22gzR0+kpnjTXYfUnzcNZs5UwiQFDL9pt/bI3MIwXASrrK8BpRbJomwC35KVI9QaqNYsd7
 5borE/YAWU+AiPJS/4CjEHk+zXfZ3hILJoDq3TrGsW//SwKcqNGEruu
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CO1PR19MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cde07f8-53ca-46e8-e06c-08de8903f1fe
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|48200799018|61400799027|82310400026|36860700016|19092799006|376014|18002099003|22082099003|56012099003|16102099003;
X-Microsoft-Antispam-Message-Info:
 +C94gsC1ylu1BpD93SxFt4xfsl2fuT/42LaQ7TkQ18BhHnUlZxFhkPxI7uwZhg9xv13O/cLGkMbapAQS4sTJi7T/F1a3gQoEnTbWfXb249OZab+qI3PxocLEwHSy4JeD942yHUH0pF1PGhUesCNSH2CH1J5rreVB3TRXosqe7+gk2y5GVGw3kKysOZYT+wKfdCMgA84+DQSfcyS54rtfemh4MYYjX1Ks+wR13aF8cbMtGBfZyGPtq88oHs/J2CMTmnXW9o7PUxK1KGkoT1sdz+4Vmoxqzm6UwV0UlyshIgl2H8wzALeQi0JxWCHEmeCSKaXylZXRuS5K8hu3HabhgbCAf1rGete3VQwPM9HkPqIwxv8/k1kJ9vw8KbNiFgF1kz57S03QQrNYD0lfGa+aneRi+rdv2AiLM8rnn4iUz5KVVH8sn1BrsIDLjIeZzG5FsKifjWt7lCKBD8uRp77bz99LJ59Vjxap2WCGKuLSifJQp+X/BzsqbvALpb5f7MBLMfgQnFJP9qEByU0lrFH/JWwvqECFZILcbmj6Kfj06jQQWiz99SXH4jn4mlAFg9V0+42fK01qieu53tDArvwlfrAk6Rr7OV6AlxQpOufWnjt56Ppv+JLdbsjvladoX/JtwNo3OT4HoMPAIrfWplLlRr2rYJSlfFznALGEf2kHmOyK9/ITd/rTKw+eZ8bEcP/e40yHHglGKnPvnB1BcQVA5A4PjCZ5TNvhOw9PARTAzLI=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(61400799027)(82310400026)(36860700016)(19092799006)(376014)(18002099003)(22082099003)(56012099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 s1xUJvgTh+yVwGEN0kK77WxxRi3lfkD5Swm41VaJA0yjggcJJxlqQEDUMmDKIaEx0Ac5sBNypsf50aBC/194/EJwRJClXpTzfdeKfuTu6wgUjpMGNDD0FbBginF0XCdVBcXQI0nyAqcWwnuYkHoaKg5mtAqBx7juN07nCIDioR9yQfo2EqkfsXQWMrfXm+o+k+7T4IEX6I6rhoEoGawQO1tohe6iORi+L4Y3LKSWSlYpZK5mIc7VN8AhKMmgiVFzq4bV5BM1VWB0SSMWVqWEOysvkAokD97vFplMjlB5uUF4omZwZZiwYJH3mkTIWSM6Zt7C9jdWkamjNP3opDdgJARZs8/xgLK1Pa5xoB6cgtKaUPXrDu5CbpQwWzq3aPd6qEd8x2MQa97Nv8O5w4zpG20WsWgHOE+vo3ElAZz7pGobxaYnPkeHG5xCWB41Wgu2
X-Exchange-RoutingPolicyChecked:
 WUomqfWVXJr1sKfdOqNIUjC/TyuV9PS/ma+fSzQ2jKLHWO7Bk6phxp+LbjvOffKf2gZWq5f9ECL1NsiLZQBLVTzVtbHeoakyUyhJG9e65VRdsxUs0cmJJ152PoXE/lR41j5JcxkX2wWdvwofAFaj74ChMBVuqaE4hqZs1Ao7JF0chGvEG+alr0SV5Jfn2f1cp/Fpu/4KPVfGyOYzRd/u3i7GYOm9amHSY4ROLa5dKxljvhzeJG9RxZtcsAanVSoc/vy7N+e8KAui826Q8d4YYA3HB1NmR0raceR7RRS/vqvnqDp7F2FbhKL1cr9WW00qmA/b1aWK4hpC/lFt+5Ap9g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 fEbks6BrSf7XQflNjfvL9cMg1QHoz6I5L7t6rwzGTzDPSJaIEZxjf+e2ojYe/eatecZaoKTnIVltpDGATgJr8uQAXB1qNbiTNkdhwBU6xaQzeO65YyzzAAkILWyFR+YARjHMRw7PB7bes9QKc6jrSU854CnBJfVqDDZNJR4L2QSKKVGtyEk5ASSr8nXWSfK41bNxNTAt9CA2qxBwZXJ0SSdNRzCgDGC/j1TgQFnm/R7ab6ClhfSCBvB5dE/WS1f9NpbrgRB3Ab2nq/C4iJUaBDnkGyRllCjmhX4oOpDbpc1sVUAz6AlvkBeQgHISbicYujXZvhXSQtT8pPfh8NdLDzPjwKIgnDkhK8heeugbMWGfJ8Fr+JYWF98fK1tdVvfUqZ5HgM/pEiL6HUzbmCCLunZNpmI3gzc6etdP/nJGCyl8Ip2W2hmIr/8CGi413F4DnzswQJAM07UbeEuTTawsj5x0Q2Yc1aPCqymx2jaJ6SkW2ny/zOfD+gBSirql2O9ebo86SW0nqU4mpsonkXabv1JXkHLXMiCY8tN7F242R88nkY3tOrB74GF/wfQnzStaOxLClfV2D/cguRwK8jUKhC7zy5oDaVp+Qwsagp0SCajY2Zm+DNQIT67zOGniKK51WFYEATIVyQSLaASYj+dnSA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:16.9708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cde07f8-53ca-46e8-e06c-08de8903f1fe
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5078
X-OriginatorOrg: ddn.com
X-BESS-ID: 1774289912-103877-15856-10323-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 52.101.201.77
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYWxuZAVgZQ0Nw40SLJzNw4Ld
	XM0sg01dQwzdjMyDLVzMTczMzC2DBZqTYWAFGPIydBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan23-175.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Valgrind complains that it does not know the fsmount syscall,
pytest checks for warnings, find that and fails the test

--14936-- WARNING: unhandled amd64-linux syscall: 430
--14936-- You may be able to write your own handler.
--14936-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--14936-- Nevertheless we consider this a bug.  Please report
--14936-- it at http://valgrind.org/support/bug_reports.html.
fuse: fsopen(fuse) failed: Function not implemented
=========================== short test summary info

Obviously we want to filter our valgrind warnings.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 test/conftest.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/test/conftest.py b/test/conftest.py
index 291c9199b9860d664600638213382bd8cc182104..45e9672a92e687980ba93cb25ef711ad1c2e3633 100644
--- a/test/conftest.py
+++ b/test/conftest.py
@@ -67,11 +67,16 @@ class OutputChecker:
             cp = re.compile(pattern, flags)
             (buf, cnt) = cp.subn('', buf, count=count)
 
+        # Filter out Valgrind output lines before checking for suspicious words
+        # ==PID== prefix: Valgrind standard messages (errors, info)
+        # --PID-- prefix: Valgrind warnings (e.g., unhandled syscalls)
+        buf = re.sub(r'^==[0-9]+== .*$', '', buf, flags=re.MULTILINE)
+        buf = re.sub(r'^--[0-9]+-- .*$', '', buf, flags=re.MULTILINE)
+
         patterns = [ r'\b{}\b'.format(x) for x in
                      ('exception', 'error', 'warning', 'fatal', 'traceback',
                         'fault', 'crash(?:ed)?', 'abort(?:ed)',
                         'uninitiali[zs]ed') ]
-        patterns += ['^==[0-9]+== ']
 
         for pattern in patterns:
             cp = re.compile(pattern, re.IGNORECASE | re.MULTILINE)

-- 
2.43.0

