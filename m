Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7CB3A5E9C;
	Tue, 14 Apr 2026 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155263; cv=fail; b=f5/opJ94G4+FIU/PgKHNkPU+nKApE25pafJuG6TviWX+aaPMF1WC+ZwUAi5CR7HwYJ4BU+v5El7oAD67ZST1W/reD8kH6uijomeQIeVwN2vlGemuZ/nR5Mk+eQeywXhpQF9GEfoUh8X929q/++SQ49hgS3q3cgoIz4pgYHWMLGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155263; c=relaxed/simple;
	bh=0SZN4Cwb4Q2WgJxT0XbMjPQ8Lw1o+0WifyFxY4cOP8U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LDQV8KNH3iPBzMfYrGaxjloaYztuHQmuuZl2Aqrk8NUmDrwZxIqF+G3XJMVHUqJ4ytk9/ANC5Wk2b2nOusmW1InpC1WP173jfVbiMwFpmlGB5Ef8dVSz3nwBgUjcTwCJ+55m2kZ+YDi4k+2UhShpCgWDCL9GNuuh+Ukray0S2Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ii1CT/rO; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ii1CT/rO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seQdo9XrEr0Z6ZtqMexbd13VFm5QACeinhj7vh7K7XBVuOY7IQZebDAeeKX6JnNM7dmjzXE2jGYWMcqtaCZZdJSaOx6GsystPle7CEbiZyhuiZzBH2yVymhAWel1VBj8PDuhP13pah3D1HXUMDivaFpBqrGr7iRGIIQZYA4sJTvtSA323m0e8WrxRNKCZkIaEJ+dRBiZ8Rhz+mUjcKx0pMfOKv0pHkJcVJ0v98DeBDP/kt6s3qTW8Nv3kRgjp96LsAGZ2aoLWN+xBYEk53SFEFSAis99vkBmghD6PoGqVrfllEQV/rxz+xRL3GZb+8qpLXUmJqWKVetftumntSFpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGa9JMp9oxhAqKuSIcj0qKE3vYJ8fQl/ZT3cDZZ62jk=;
 b=x1TpTQay1BKtuw05Uy979y1cTOAdPaJJvOAZUdrByR07xsnAGR8jK7EY2ewsM+5QKn179v0C5n0wID37BtMW/UhzEyZUdXsBCGQ845UrchJ1hoi4jnEyiPThlyz6gQBzJtuPV/1RL4ard9P9KpuMrEQDkAGUO+yPn3i3VR+WfUTYjLrYHV0OEwC50YAxmN64LkW5CUSuM00ZiVp8/4kZF8x/12KpSuTPOPOMzgdI/LN5OjVv8zaqFvm8Cbp8v2cLM8hHIGdr9SHB4us3lly4UFcim94/XuHQaX1rDjisA0HLE+zI5Li+297roPftZlS+a3Sf0SZgKCZd8YKkcUGy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGa9JMp9oxhAqKuSIcj0qKE3vYJ8fQl/ZT3cDZZ62jk=;
 b=ii1CT/rOhr6fUCwrMzHPBl37CiOz6mS6rNczFvCPxhBIzIG1ix4OjbXQEVw/9h2Bia9KA6sWEPRrqdCuhspTL7uqV5RJg3JFanKDHipOGUgPYRy50Lxsz0QV9FPo5cZZdrPIEhUs80r+mblN9KGShejagnkksunKIRyH0y3cBzgCG0PTkzyb9go2GWEg1BF3Ftbq5+2bLubEkVX5hbKJz0hcVjwmbQGonF2wFpDm4uTCgtQKGG36I8Cz7OgrGXnyjSPyjN50ANrtpZkamtlt7evrmn5R6bxcFNgVFDNsXjmI/UFTx/OpwydjIXxAikncQKAAfXivPJ5ApDL6sDwBHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 08:27:39 +0000
Received: from DM6PR12MB4484.namprd12.prod.outlook.com
 ([fe80::39f7:9014:6113:544f]) by DM6PR12MB4484.namprd12.prod.outlook.com
 ([fe80::39f7:9014:6113:544f%5]) with mapi id 15.20.9791.032; Tue, 14 Apr 2026
 08:27:39 +0000
From: Konrad Sztyber <ksztyber@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jim Harris <jim.harris@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Sztyber <ksztyber@nvidia.com>
Subject: [PATCH] fuse: reduce attributes invalidated on directory change
Date: Tue, 14 Apr 2026 10:27:23 +0200
Message-ID: <20260414082723.350538-1-ksztyber@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To DM6PR12MB4484.namprd12.prod.outlook.com
 (2603:10b6:5:28f::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4484:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d08e3a-586a-440b-2799-08de99ffb09a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hxGIfCkzA3gjx0DWByk/YoeD23GbczIlYejpGMRLW3AvQP2wNkDB9rvjKCN7a5wwzpqmtCVl7R9Z5uOQ600ivXSldpGf59jsL+/8CdNDDpQYgkWDWzyVBxsaKFFciq5OF2Y9Lxz1zOgp8DAwhZphd/Z6myLdZdAyCuH/3dFxGBWwAxQi8psAE2qiiPjAJhkGvh/cqQZrykz/a0cfyRkTRmq/lR6ZWBrIwhWtc1Jekxr4L2Fk0S9tgvsQ7sl+tNz6tKErkThqlgXSQMbkPAuJ1O1+cQfK4w6SbnXEtKHSMwZL/Oswnd1KDw101DzkjA0dui65oBQk01SwWO2hUb8xLUSMWDQP56dgE8iDpZnTrlhcSRFu5Sr/AR4Bg6lNEFSheOW/BW59wDk/KjKxASIBu1hN5aZlhVgieYh57qTCb6pfxJzWhK69982UdbmE03MDr4sgyjt3hiQQ/BVssPbEymKw0YHYXyo4iQ1Yxuo+HO8YktqFt/GYHLsPfk7oGXfaWrGzlhm6n+EQbnTd3XFdtXBy9fTkQl7RQ95otzF89ySTcDE0sbOcof1VvwCaMsi3KbEOmHA/uZIQZBGh1wu+iPfjwQNQ7ep5QOEbV7621CBf8OzvCF+Zh+y43wPfsBxJp8C5faoudlHB6+cDKggEFxL1JViJirw57riOSha3g9UBcZHjHLhoHVVq2iRGlQlumfuTQVMcRelkpfW0zpLo19b+djybRPyYprHrCSDziVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4484.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUyghQpZkcvyJhcTpdLeqe6TNEUaCsGQcYKhqOX3nxCB+Bc+dq/xBE4aVp7q?=
 =?us-ascii?Q?o6n7Bf/Xf880unxTbKW+ctdGzsGhVcIiV11+W3xEf+TYH3mlZ3UIzjN9RLU+?=
 =?us-ascii?Q?aTT+pSkg+6UqZPTSRE7rFXAOm7nej5fKZWD79yE7/XHD/qrqB2E4QWxnexhj?=
 =?us-ascii?Q?0yF+eDslp9QxbOuKCBpAKUvHN86zDpuOvq5PY4bFt6n+pBj3zxIfXKlMddjv?=
 =?us-ascii?Q?512Ea4sLgQd4bJOknyHQeN6zFMDuFd88TE9ny0TBnQWVW2deSH6vBT2pe/MQ?=
 =?us-ascii?Q?fKJunnbAUe0fcqdi/PwlVYwPclYJ0GuzxfSJZgDzklOKvrC0WUAT5V0vUV4z?=
 =?us-ascii?Q?0LNbXov/qOBEvDDIrCMRiCHOBH7FkT/TR9wXh73K2wQoxUhJ/nuNjwgNkyPg?=
 =?us-ascii?Q?+r7KqSpOdpMOdD3uQMPYwLy0L/DpV66ip4LyUANHQ4bEIiCQ8Aw3Jd9WPXLq?=
 =?us-ascii?Q?Wdt3Obg0ZHuEI9+NLdhuOMmIYfZ061TCPCKm2DSNoldXxnOyoP3lzJ+6KD4k?=
 =?us-ascii?Q?iAFFe2Y8rBs+2lBWS9u+o87ONQrEY/8hLbd5ZVyGMt6R270RflE2HFuPYtcZ?=
 =?us-ascii?Q?qPHDHduErAk6tJ2/Zq6lshNjo3RUzALjP/YcQqH7DhbDqSr7qwHZCvRAHPrr?=
 =?us-ascii?Q?ucY1Kxbn9dGHoCQMQJquPtjrLG7wC65PIgAVShzE5QEsHrldotcwYy3jN6v+?=
 =?us-ascii?Q?Bkxmpxkr7e08nt6D/urPi11vevtHRLLUTx4B/MX5JI54hmkcW9uaCwbdxbom?=
 =?us-ascii?Q?h766AFTQS7BYNJ5N9h8jdUNG+UqNKSYa+B7ZL5xWL5akTB2L3aJuOpt7YFUy?=
 =?us-ascii?Q?4QKkj8nFWgV+S260/t7u5+qCX2rWaI+C/MpbcW3NELflo7SIQNyEmqmEPxjG?=
 =?us-ascii?Q?jtfbRZtzA5LDQxMyAfiohPwhjJQaxSGN9wXgsaPWgiVd9wq+nKvvwA6q6jhi?=
 =?us-ascii?Q?MzfMYOkU/sWZlHYxuXOjVqLrNFLTbHj+YqCNIklgp+BwMiRHlBHsPyOWUpo+?=
 =?us-ascii?Q?kG/hoSh/uSSqANe+KbQiugiNhLNdaMp8IqF2eZppi8JSvlMZt5/aEM2UBcm6?=
 =?us-ascii?Q?8YwFWTENLAyKAkqyJlDv2K9DpTGhzJ3IStfjqyj7XuHDsqy5Ra30/zeQk0e3?=
 =?us-ascii?Q?UOwVu/OiCla5CpFKQyCrkdIUegESWyTBAt61m5tJeqvzh84X8PmNYf/H2XLd?=
 =?us-ascii?Q?s5qLsRwKH57UnikUQkIuwuWI94G3X2vpNg8QiMUChaK4jKZPbTLrKKNSf5A4?=
 =?us-ascii?Q?zUih0o7PLxEIsna+ZIOMZJkTDlzr4d90NERQdh9FUBGKKCd+iT1CJR7qhqEz?=
 =?us-ascii?Q?ijHe6DwNxuneUYqu1InQY7t5aNJa6+e12SXTVPuxveCRtgfPZoKKclvEnkqm?=
 =?us-ascii?Q?bWyLAOgJy6W2gFaNY5xMrKnK4WYJ7ZhuX0UZb+luWINhNqFO/3DlBGfR7jDt?=
 =?us-ascii?Q?m++WV6X/EbBCziOArjiZkWglQdM6asOXJXO3k0YkMFlHqJiWvUNEo15KVAMj?=
 =?us-ascii?Q?KUIvYKh7q5OBEL5S82oBG4NBOIWuYys2oHuU6Scor+I0gts6KEfETb1beS3L?=
 =?us-ascii?Q?nVYStVfbYX+DMENQ4qvW1E4yH/sIvUJVUhoik4u892HSC4rftLDSJfSqNwS7?=
 =?us-ascii?Q?mnlFBcIgyy4Qhqm8WVWES8o/tDbgq/Iid7lzhgk2xLEnzjQKpDhDwyTAblpO?=
 =?us-ascii?Q?DCBMl8FZXoY01ZyqIxwfawthKZPajvoIN/92yf+JF49cj68oTQ26O2QYDpaN?=
 =?us-ascii?Q?JC21++jMsA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d08e3a-586a-440b-2799-08de99ffb09a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 08:27:39.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs0dZSHz8sGn8BbMrh9quilYF74meDt+sOViIyVAj7TOIINWqgxpuvMlV5YYZzTrs1UEimMhK13YK6iAkVXpaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425

When the contents of a directory is modified, some of its attributes may
also change, so they need to be invalidated.  But this isn't the case
for every attribute.  For instance, unlinking or creating a file doesn't
change the uid/gid of its parent directory.

This can cause unnecessary FUSE_GETATTRs to be sent to user-space.  For
example, fuse_permission() checks if mode, uid, and gid are valid and
will issue a FUSE_GETATTR if they're not, which results in an extra
FUSE_GETATTR request for every FUSE_UNLINK when removing files in the
same directory.

Signed-off-by: Konrad Sztyber <ksztyber@nvidia.com>
---
 fs/fuse/dir.c    | 2 +-
 fs/fuse/fuse_i.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7ac6b232ef12..fc4ae408a9cf 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -317,7 +317,7 @@ void fuse_invalidate_attr(struct inode *inode)
 
 static void fuse_dir_changed(struct inode *dir)
 {
-	fuse_invalidate_attr(dir);
+	fuse_invalidate_attr_mask(dir, FUSE_STATX_MODDIR);
 	inode_maybe_inc_iversion(dir, false);
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..18ebb2ab3dd9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1305,6 +1305,9 @@ void fuse_epoch_work(struct work_struct *work);
 /* Attributes possibly changed on data and/or size modification */
 #define FUSE_STATX_MODSIZE	(FUSE_STATX_MODIFY | STATX_SIZE)
 
+/* Attributes possibly changed on directory modification */
+#define FUSE_STATX_MODDIR	(FUSE_STATX_MODSIZE | STATX_NLINK)
+
 void fuse_invalidate_attr(struct inode *inode);
 void fuse_invalidate_attr_mask(struct inode *inode, u32 mask);
 
-- 
2.43.0

