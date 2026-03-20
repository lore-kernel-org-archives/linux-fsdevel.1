Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577D2620E5;
	Fri, 20 Mar 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015856; cv=fail; b=N+47JMlCMBYkvc53jiRJdxbVUXZrzXQgiYt7ziaEgRLi8Bgy87Ykz4v2C3OFVR4wkg2yyozGc6qBB6ysOE5ZXwK0Vku4Iy8timqn+pximmliY8+nBKvQuE9PEJPjMCy+vRWptMOP/2+vI7Z8AJoD3L1ClZAAZ4aIxWpiLJrRr7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015856; c=relaxed/simple;
	bh=ZflQ64lsBP/AQdFq3rGk4loSvynR83mjs2EHqtM+iFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QS7Xo4nYdTwZ94/QSTAMRKgwgaiIhY+WHdB7YSQvpweYIWBwwoEhDtiHcEcUaR0qlWOs6Bqsn/n9ftSXB1rDzBLzvlJ97zTwS9hydWuHxS/xUKRVO4YK0ZON/zw1/g/kmNCHUO2+gxzZid//aaECUufB0ZqxEht3RpbW9HWxKIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l3m8yt99; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l3m8yt99"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5/GbKVQorpNC4GD2KMUKXfNnc+XS8iy/M1AK7CAW1SngjIZAVj7AtZPl1pFlYtlIaWBppMmrqri+7bNgrGjuGdKkXCEyzsms2Kx/L3dgAUWrfFNew3wrY+btYuVWnTcrRTc0esBuCnF1sASkoPrvBTX3H7vpFEO/q0S1hDbXYYhVZXLZCL/DRtM00ufDH0IzXFdTzSiS+yH8J+qZ47e7RGmibcYxdSRBrM7MyimfQo4yr04wOX2joPTKOLG0pOI0Nep4aK+xJWK9uPZisx8vR26qzSsySoAwokfrs7jh1I7Z75UeoMaJBNPCeVcFu/GTkmQ84OzLGj9dfIOj7UTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti8XBouzRe/C3irBBNqwZWGPOp+UdPPnFTWwLPTHyeI=;
 b=FC4SgznBuCVKC0hgPFZPCtH4V0UbdJZ+LwF29ODDKn1KokOBMiXhZVFVNMSaXGlJHAOTXCDhGyS1Aq+quYe5RHTY6IyK8dD/ZhqcreMb6K6NO+7GBduRN1wc3jWGhfVn8rJGSfa8VRQpsnptut5YCZJhr0EkM6Ty7nZW6SLQprgPTUS8Pv3g50xyZhsBwV6Il3JoJ/qoTAxY6jkekMhQlDaitPZsKzySpru2xusaMMV+Zwovmbmw7zhJOc5j4oKYh2NH+LNM8QPql5j+UILt4oBWOmFTdqBLVvIA86eXjPfhMgdiSW7PKmDqEpl82zPmcM3v314W1U7J1PuHhcLvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti8XBouzRe/C3irBBNqwZWGPOp+UdPPnFTWwLPTHyeI=;
 b=l3m8yt99eSbyu4O+h3r1zZ6++IjvdpsL8pptH6At/SnlBKfbDSXku1cKgiN8O3v20w1fDJdW+ljJZeGV6zy8ZTQB+2sEViIoXVKUb4k4A/R40ibxZM24pCSa2W8zr3+GnRveCOvF0obgESAkJJ+lN+4nPmoY/u1NAHhoR39Ypv2Cg/CDpn1eJoOkp8imJQXpJDwPVpGxZAlpwKNzW1RSVoEDza6yaiezH+accMmKDlwZGXVi/3xk4TNN6PX310buJ3n2Vb6D5MED9OQkVvoucllOoAsQ1O7YUbDv6qxvInsBhabJ0N7euTNqzYjMFh8gprBI7RFvvfpWgDPkjPFhqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Fri, 20 Mar 2026 14:10:52 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9723.016; Fri, 20 Mar 2026
 14:10:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Matthew Wilcox <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>,
 Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/mm: add folio_split() and
 filemap_get_entry() race test
Date: Fri, 20 Mar 2026 10:10:44 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <8B720FB8-DE4D-487A-9AEF-AC204E9F5755@nvidia.com>
In-Reply-To: <20260319194118.3eb42ee3c507fd0ce2cd66bd@linux-foundation.org>
References: <20260319190409.294523-1-ziy@nvidia.com>
 <20260319194118.3eb42ee3c507fd0ce2cd66bd@linux-foundation.org>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 834158a2-1051-4641-de94-08de868a7e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|83080400003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cRExSmgCnb+8m9ob77kU6c4+5YfPVPznhfu2GXN5vSG05wByVUEQ0qrIwtyR7B9vnL7/Z9/h+jEApZKJlMn//b1C3gQS6q4DhO9Ll1vnkdS/TqOA++UmJoZ/IjK/grZVsTOVUXSGZRICw4p2sngjI056FdP0HUEToDkIVnGVsBP6+Q6jQDEjzY1c+6Sbli1aigyk4oWS9SdZgh5fOs5gCTguWLTBIy/5d2oPndLg/M8BWNlS/5JyzCnTiWjd8b5Wav1wBF/eP5GEFykTYEuUhyOGKrAyXaLh7Rw1XE8y5XE/2YDYo/G1+ha2FwOREBhR9iXT+bRHzrqb+3evfMjRRSjETXRFb1OxgiDW+I7Ie2Rb62mu4/Ly3UD064RmW5Ii8Iyw4cei22C5MhlrUCQ76pohzbPemsv5a9zLKj7wbOX0vC3I26SCNb1v9Y+l4cOooXPk396DR0vqZgPw1heey0WTZnEXrXf2hXbKBUB9AejCk5JbqHKN936fIK2SroV6RCxkcm1e32/LkmOZjnTR4T4KzkMkGpHT4slXrpDSQt8xRvfScf7hc4fnaT0UVk+tYNIsBRBwTC9vKrsMRGS5IlildrlX2tOd+a4xUCHHgndQmAYcm0rypmf8zdvjQGv8mq8MLyXaGlyuXdaE/0YqzmDw8QbJE3b1cDH3fOE+bKF3KCaFavzftYVufAlShKjHji9CBliY0CQEqp8ziXCqArwvB6KDv7usv0gYaw6MdEFHm+7gRQ0XZN6m4z4fukqxJTatkvw1MWQnrWeiu1VUHtN7kJI4bKd71CxT6ZgNS5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(83080400003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4m20GYpaWlDnZaVzbyVz3yA5oxf7HbrffTW3vtl0ExXb/aHVRZy3Ztvk+m2O?=
 =?us-ascii?Q?bQ5v9ZFukYjopi7aFeRQ77Kwg8VG7nIPl0gBDfTarJ8liwNtePYhgPfmq9fq?=
 =?us-ascii?Q?2z7TU7a/475nrtoo4NtVddrp0bDYnDoOyci6KynmzTt2kXgyg7DEj6L6Zyla?=
 =?us-ascii?Q?8BQ32SHMmo5Tuq5oW3sl7mjwY7D8V0MN8MsEyCij2KddZId5RWcTn91g+6Zs?=
 =?us-ascii?Q?dvfQ0xv8OepRuDY5+pTj9QRGxPGUUg3xSNBZXurN1qVREAT1npEVfJVxyDl6?=
 =?us-ascii?Q?tnswRE1VoH3YmZjBnqHqpxpL6z0zER9QvJCoj0/u8et7KDNCLGoFGWfcXqpU?=
 =?us-ascii?Q?dmkQlc6F8whZmr4wXv+fXEpPNJoh5QYMJMdL8xqG6OLqRUFRyKDZ4kcac6u7?=
 =?us-ascii?Q?ddHCUET+RV29fYKbQtdZCgfKB+VLbuf7R3r7zaC8J7bqrIMBVj2TVQiDJG52?=
 =?us-ascii?Q?oMeRYihq+o5PHuOZZTk/nqkDLQ1rCYb1e8pXGtP63gGP2yH/oewKD0dUeeRv?=
 =?us-ascii?Q?nmMFaqjDVKqsuxfUlRVRF9chcjTVAtiC4gTnyV8a0CNE8ruzk7JN3n0LPyUv?=
 =?us-ascii?Q?MALAWGam8xt4JIWfElLYGolpqqT0uRn+/Dv8RT8bd9OMMver9tKMVo86ovT/?=
 =?us-ascii?Q?0YvuurD8ovngIsyV3YB2JEyP/GAMf+Dwz74Qfjj18F9GuKwvtRyLFnLAiBAg?=
 =?us-ascii?Q?FJ1pzIadb3lRIb8DTxG+z09fVACH/MjuYHBH7qivzaEdRxmoMYjp8KaddMiu?=
 =?us-ascii?Q?hPxkB2SC9fIxKHnfK7bC+sEME0KGW66w8C0S1j/8w/d+ScKEiSd0LV9/3Rtg?=
 =?us-ascii?Q?jOQyPwaCXs5mstwAYZTNr+Fpg/qmkANT7An1DfxzWvjgdJr+Lm9NgcrvvLn3?=
 =?us-ascii?Q?wUSGtA+YZw/H14rqOMv0GSXR5xgEgsK5MyAwpuxms8ySpPp+hoMWg3XzsHiz?=
 =?us-ascii?Q?5Z2/IuCWoXlZk1NVjTTTG1Fr0VH8KSgeZJD0lLz/5ES5ERo/ADK8S23YxZDV?=
 =?us-ascii?Q?ng+65H7fvhKpgSMgGLcnQvl6/VM7xZ8c3zi3uunEivJhjSdyrmYG/jyvqUfx?=
 =?us-ascii?Q?VYFENhp15SH2pAu+0OUqRVsnr50HCdWzh4Pv+wY7XErT0vNfP4N5KiaivY+A?=
 =?us-ascii?Q?dqKYYpinOKcbQwbTR1/IF4uU8uRdztCQT98DTm5EvNuYFdSl6RPIE2i9HsBN?=
 =?us-ascii?Q?AZVARkFIRKhhanNJjp52Ugl5AXqAFJeuxidk0StZeH4u0FN3w/ZpPN2MyYMU?=
 =?us-ascii?Q?T2NFM2ApC42d2J/dIF36ShymQAHq/Yx6nhpXFDPxOPVp/0NgMeAKA6ZkVEgN?=
 =?us-ascii?Q?OrXdvwVAGcYxyVS2Fxx0l83A/21z4VSGdBO194sidnhXxVMKheR+9v2FniJA?=
 =?us-ascii?Q?EuF9oJoBOYe4IhNJECH4ZHn6aEYNgh+8tmDHomL42TNcGkpZIYxBCcKW2/9P?=
 =?us-ascii?Q?UyYcjCoBGAn4Vx7Bfuqnq6SzH+Y1kakgZC/P+lwOFOd+956RdZmjEnQTdmqo?=
 =?us-ascii?Q?3JOP1ZedhK3WuEidrn+a+TXisSn5ILzzMkAqOL63n4rhR8NK97l68SfpiVZW?=
 =?us-ascii?Q?jX833bzzKO7jUIYHyaiQt5Y44CFkAyFUdXlT+RT5oletvTkJ6/+CoGKb75Pw?=
 =?us-ascii?Q?JD30Gy1sxYvQMZo4RwvJbs2VcK9tOlb89bcZHy1RwGRByTgnuksiB72lZZmz?=
 =?us-ascii?Q?l7Ykz2AqaG//natF8X9nW7EGtA7B4dCFFtZplf0cs0eyXvUlE9mcmjS0Z7hp?=
 =?us-ascii?Q?eCGloCWdVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834158a2-1051-4641-de94-08de868a7e17
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:10:51.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vct7KF2hqvCnOi8ULc7nbkIEhAvnEDwlxnZ0hLzBKECVJmzgdQbezd1AwQZlIlwK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494

On 19 Mar 2026, at 22:41, Andrew Morton wrote:

> On Thu, 19 Mar 2026 15:04:08 -0400 Zi Yan <ziy@nvidia.com> wrote:
>
>> The added folio_split_race_test is a modified C port of the race condition
>> test from [1]. The test creates shmem huge pages, where the main thread
>> punches holes in the shmem to cause folio_split() in the kernel and
>> a set of 16 threads reads the shmem to cause filemap_get_entry() in the
>> kernel. filemap_get_entry() reads the folio and xarray split by
>> folio_split() locklessly. The original test[2] is written in rust and uses
>> memfd (shmem backed). This C port uses shmem directly and use a single
>> process.
>>
>> Note: the initial rust to C conversion is done by Cursor.
>
> Sashiko has questions:
> 	https://sashiko.dev/#/patchset/20260319190409.294523-1-ziy%40nvidia.com
>
> (this is getting painful :(.  I hope they're worthwhile)

Q1: Does this test actually trigger filemap_get_entry() in the kernel?

Yes, when MADV_REMOVE triggers folio_split(), in remap_page(), after-split
folios are not mapped. So subsequent accesses to these folios will trigger
page fault and filemap_get_entry().

Q2: Does this loop advance the index further than intended?

Will fix it.

Q3: Is it safe to call thp_restore_settings() from a signal handler?

There is a theoretical hazard but it is unlikely to happen in practice,
since it would only occur when thp_restore_settings() errors out to
use printf().

Q4: Use %zu for uint64_t.

Will use %" PRIu64 " instead.

Best Regards,
Yan, Zi
