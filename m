Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC83A75BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560921; cv=fail; b=SsIZ8hp19beuPCl2KXaWxscsOj//pzv1zmTjgrbg59b8ZaeBbdWWSw2iL6fEpHl/2zAda8TjXn54TNaIIYaRqZ+ulMhpUFz2RoRo4Z9Fyg4G/4fWU/99PNVzvxMvhH2iVX41Fbf5W0C3ZEX++P9RpvXAC9bHNkXJ/jtqp8E8w8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560921; c=relaxed/simple;
	bh=Fs22iYbgnM55BAtJjuZU48o2DCtnsraPF9VIje8AjU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RbGdREfUMFeM39B4KmBmpjiUogjIoyBfx8GeumjfnJezdlfUnKVZuRmGtB4S/BDP2UFbYKJzadb1G8XLNAFoWOEVJapbcdJRHIYcXuCueflFSe1hCbPmxh/Qejln1vYX+98wAq5s+11ewEtnxefO9Xj7fB7/PgPqhkjBPlDE5bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=UXp2pkjt; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="UXp2pkjt"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020126.outbound.protection.outlook.com [52.101.193.126]) by mx-outbound14-27.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xi0VfC8Z7E8zvNc4oa24oqJe+tlfLXKpKggXLstzQUbrWQn1BPtq8wbfGYAPqIoYH7BPr1fiO+lYr2p6l+uRKkh+17xUwbzoUDSMKkZao8UZhFjZlrVO6qnCo+UUH+2fvTyQHzR/dSnllBP2AhTVTLd0ymvJc8R0peWrHkk2dsyQ6uvaR/I9Uuf2PiowVQgrmjYncJdKUp3ywJ1j7SxoNVrKbfF/6ACvBNSXLQGiIZymiXHLf2UXgoewV7AIQQ1ANdLq2MWlLsXlZrADP0rO1Z5JLY03Oya2ibfAJlRfQ0jls0XvmpkItucXjaIi9pc67YjN5yhuYwusG+ZBTZjplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCQ768AfgRDk9rLXnNu8Fkl8o50UTC4KJJC0xcKTdWI=;
 b=eGdlFd1iUcNnH7Diaxum7IreGXo9Hmp1smKCvqvIBPN9If9S6fmtnkmcwtKth0iu9Ou1/M4Ho+mZlFd1zT30UShmeSsjxKr8MkvxsPKzE4p9WqUsSxeLhlewLmeZyP8TRIAUr7b2qvRIpdtUA1XjZ9azsbMOM1+lRWC1nwUYCYz9T1iy7W7Xjjz58kbNacJZad4tKP1Z472Av9KkieU0HCyW7hlbwguDsqHdFBxVrpZ+Fuydr5rjP962BpBnbB6I1TxCLah5zMLhdqY3atVg/VYFlOBOgT8xEFlrlAclNVa4YteYD/P5jDdvXayLU+e5zMZnTAWp5VcwlNYLM3haWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCQ768AfgRDk9rLXnNu8Fkl8o50UTC4KJJC0xcKTdWI=;
 b=UXp2pkjtnVebJnF/jCGdyCSjXlbFeGXmC4INdF8Y17W3YOgCbIhKBAqqkFq1lIEEtBUykdxiPEN4usbnSV58bxo9SUa5u3Yc7jCXBfL/1zsxzyw3LwYv7nTD8oieWu4KKIAn+ifQcL/4udkGnq9nuPcRJIuD0QhqeKvComlLgz0=
Received: from PH8PR05CA0007.namprd05.prod.outlook.com (2603:10b6:510:2cc::18)
 by PH7PR19MB5750.namprd19.prod.outlook.com (2603:10b6:510:1d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 21:35:07 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::b9) by PH8PR05CA0007.outlook.office365.com
 (2603:10b6:510:2cc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via Frontend Transport; Thu,
 26 Mar 2026 21:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:07 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 9960D6F;
	Thu, 26 Mar 2026 21:35:03 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:45 +0100
Subject: [PATCH v2 12/25] conftest.py: Add more valgrind filter patterns
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-12-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=1837;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=kuBJ5LUqgo3u7XVa/ZdeGo8e13LKV871C4KIVFodCH4=;
 b=zNWvO3xhOl2fw0gGiqW8/kJYypplMflfpKEqEdDeB31u0l6woYF24+leWuvSh1UUpuFSVlv23
 oRZhu5PfTD6AUAw2jdPnx5KNeHQbtmpMKqvDje/Mi1FmEUqBnfxRrfI
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|PH7PR19MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 64754ad7-c241-4b57-8164-08de8b7f8cf7
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|19092799006|61400799027|376014|36860700016|48200799018|13003099007|22082099003|16102099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Zu7XdgTiIwsklMuM5BfOKO0jRw3a2mk/o/GT25WMq5Vs6RIy66MxsmBOnjN9XfeN6uUzF8xD/EC04cJxkVSab8rNSp3mTmbidy+I7TRO4Z/hRaF38UnwRIZoyyXect4suK0ZXXZQOlmxIwkePHb5lcHxskuactDuXN0tkrCrfHJclzd7A6XFXMOD9hmdyyo8aHicN5Iw/MsxryfsrVftJ4pqOBryzhbz8C1SsdkbESqxzHgpR4+BTCTGzlC4kt5ecchRIny0kpbguWXdV/W8pkv4CyR9O+AjRnqduiksn1DcfDKddUcQO8hGHi//RS6MJTKeryUFxaKSsCfGtbOOurHVIAWo+pug2SAIEHP8x6lJT47Nq0oO/VUghNIwUXlywKCy8ATIPBXusATs2/lON+H6rim7JfEevLHkyk+5cbsccOq+53pOQVyznbFtx+BaOMk8o6fJsdD4xn0sv0rLGyDzr5ut5cVKBfII5xppC7voCfMz+CQEt2dOzy7lMRpfRAHlmdKwv3Hsmzniu3uKg5VDOCFKQyqX4zPd+6c0Pt5MdsQlPzV+0rZAvF3yDYiRlGDbcHjbwNEld7wKXkRHcR+Z8rad+mD9/Qr0iKgzgpQ1NHKWEkj7fNItuJSVRif/cq/4n/DlIUgGyTnD4pFP0bdCIGLaHvtFMmxDt2aDcmqcdLV7Fh8ps53OL/eD8DjGEIdCy8KNtgDkr2nKzymihQta/XvNqhxYEvABIbvDHog=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(19092799006)(61400799027)(376014)(36860700016)(48200799018)(13003099007)(22082099003)(16102099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lp+QYdupNqHsIUeWHLKqBXcXp9re8wL2cwBgzfQdLjgWJ8RN5wgUlZUN8wPQRje2xJjtCuZZRWhylZ+H43UhLfSXkCLOC/UlVDuBiIgz1mhu3G0yduDm1qcVMmEq33TaQVH4DntqwWM5fXmpjVdlnlamhQ902GQ8VEkrRNUEYhAWJjhXDOI4gMAZaCulnzVkGHKbvQsDybEMCY4jeb8WPt8kUl+F3JPMko35rzS5TWIwUa1zHtyICpLl+Jy/b5WJ5O5T8HAsgPTuULhzPX/qH6uDPF5XVwgNjxdxBkhwithz8jElupuF0r64nYXbdB9JEVH8qOB0p/Nv9CPjfIEy/1QTF5wYuoXwdKJhYFr3GKF5EGApxhZFiGO8HzkKXpamnVynTG6VLdVLmQ9Rv/ezxsV6JG5O8pJTqYvcOGvTW8oiFUjeUMnNvYyrUMjuqNXL
X-Exchange-RoutingPolicyChecked:
	RZ9tBbifP+zcgvex5vYlkFC6fgZI4HBlrTEilzYjp8v6AeOzYKWE+6gApq1nFl4bPKQ0Z0StCNMoEmuLdOHL/HIIc8fULiBNoHCGZRT+868DdCfJ3lXbSbq/dCj10pKHJzM1CdsMApAEmaK7JCo+gHERdYMtcGAI30loq4xUMUAZWZ5DXUGFmyuqJ4uiLpw3ANlc3DBe0Kci5kcFI/UXzK08uBCN3iKVa4jOTakjX0EwMmzn0jnmNjeg+usxGmyYqgievGdcDKN+aQkrCE1gKvIweii4fOXPoeMTpoOkwcloa7yqVLjFikh6NOB2LXH6Zf3w0vmgFDzfM+vZuku5AA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YXGCf4naU/0UOFfRzh5kttUndVxoo7EtUzVTxfOff65PpJves72NaLCiLT+etyj5owlc54YDyGQ409NWOjHk1EZauy8p13h2gc6QnWWfbaRAEczMnrexH9lP/xiaLaC1jxr6E/poR/Gvx7a5Qy1NPWw/JknEvovk8fssXcwN9gSMw2VKvwzUqfHwhf+pBTqqRpRbiRCj/vvuS/KPZBLpPPe7H+SkgQJCUgrHsMp9f+a8TN49hR0/os+iOuzd2f/Kvg8s64ya6eEOEOF0OSgJZ4QOf/lbjOOoS4ZR2pPh76K4BLlH9g84OnzcKTwSoy2meRT2ydBZkV1wH8G/MbLGDwZiiW+0kftcD5XehLGOczt2VUQcufcFI/vWvUZkRV2TinW8/Rxdi8XWBpjovzpN1EvWjF9TyXkY54Y1QUXVeatRBMyRqb6glYwPIeIwnQpVDCP210wBjSmDwjmGtoS4L49j4WDaxuzfvFkTA5XZfTgkOBNpT7aQlmvwd11MVfkyfrKQxy+QXNCRBNVqhgnhsL6cTlnn3NqJ3UTr8uizbw5J0D04lbTQ1rA1IVboWgarJU7n7V0wc2iZDIELjr+8ewN5BltwoFPZWN5g1Ch5TQC8eHDcX6gpdp79az/ovfuU5TQ28dzlQsYdwmv6uw+hew==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:07.4731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64754ad7-c241-4b57-8164-08de8b7f8cf7
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5750
X-BESS-ID: 1774560913-103611-7702-3109-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.193.126
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYWxuZAVgZQ0Nw40SLJzNw4Ld
	XM0sg01dQwzdjMyDLVzMTczMzC2DBZqTYWAFGPIydBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan13-56.us-east-2a.ess.aws.cudaops.com]
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

