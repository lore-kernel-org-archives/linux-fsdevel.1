Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794268862;
	b=s6gNP7LqEC7vg4R5QDxFV1waz/IbjLNsz2AbHVdmww0EtvTDtSMUfWun1zg+SsLEcVaL
	 rYALoN+SxK0IDjSpize/qsRTuEM4+kBKr5c6RW6OsS17dJzy/OBAdanRMkyN0Ik5dnB+q
	 pkvGlA6bfNCmp8vXDFST3xQAvn7qDOgS+YVDLAbTwyND6rShRh9jizK2LFOdSw+D2FwDJ
	 8lwFX4NQUcSlykMmX1czIokBXRFGI/hccGahnXW3v9Wot4SJjLrCKDLdxVP8O/8c8CZcc
	 LnCJwzho9m/DVYx3WtXJnVB2JRyEJKy9m8Y29rZIINKB21PAmpgqQ5Bu8RKpDMgW6ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268862;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Wisc_ValidFrom:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WRCuT5yuMVKSV9RM+g34QisLSWCR1AoigQtkhE+Eln8=;
	b=4ANokEsc5++5Sfi0dXPR3b1Vimdb26DVd3M2McwzyQYDwsLmq9kj+L6NneFKq3gwkgnZ
	 8Q/2wJZz7yEKkRw7enT70ogL4ZsLa8cVqtRnPsnzCHBE6XkwIoGA2iPr112c6erYXV9In
	 /8Gfkt8r0aBdNtZzuG6orwjK0z2E7PfrBJcgeaMeaoYXHBzJSy0cdq9a41aqqgsR0ui4U
	 87iuYnxWkBs0WDaVVMy2HgYgfBjv+Dr6RM/tORBAZFgXsBI19kLVzLTBS461rKr4wSB4+
	 nVIermY0KN5cnTVe8z7orixhd/rrVtJo8EkQucapYsBUaceYcVevfzPJHSjBdz+tuDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wisc.edu;
	spf=pass smtp.mailfrom=wisc.edu;
	dkim=pass header.d=wisc.edu header.i=@wisc.edu header.a=rsa-sha256 header.s=pps1 header.b=KBssQFab;
	dkim=pass header.d=wisc.edu header.i=@wisc.edu header.a=rsa-sha256 header.s=selector1 header.b=PjwEsRKg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.71
Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF760A263B;
	Tue, 10 Nov 2026 00:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CDF760A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wisc.edu header.i=@wisc.edu header.a=rsa-sha256 header.s=pps1 header.b=KBssQFab;
	dkim=pass (2048-bit key, unprotected) header.d=wisc.edu header.i=@wisc.edu header.a=rsa-sha256 header.s=selector1 header.b=PjwEsRKg
Received: from pps.filterd (m0316040.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9L7LHp3196546;
	Mon, 9 Nov 2026 18:00:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wisc.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=WRCuT
	5yuMVKSV9RM+g34QisLSWCR1AoigQtkhE+Eln8=; b=KBssQFab6ujrXA83ajeqA
	OC08G0HmA0OFjORD8rnwDX68A+SzpuNeMh6kZBuQ4agcRXbtkCWfjXeaTxiyOU5n
	1W9E5uAS/n50hP3QVTM03L1K33CeQXhP3qkJ0Xs6asOQKtdU0p1TFCdELlH1/Cl+
	HnHD4Etf2kJmVecyKo+uwxPdo587VvVdloBQ8PshGdvOc+MgLQBEnhBNlvFfGqaa
	KchbJflukiu098Qr4CTZetOB9BAlY0dmyY6GT7x+Ds5r8l+w4lQq4+oxpsz3fnTB
	XNwWFojPLJvckYH9dJoVSCwcDQmLahAuDI91r+YoUZQRVmHA3CwCcn0JtLtvm15N
	g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 4humm8hym6-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 18:00:13 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWkrj4EuiB1+WLHdLissQESmRxG0diT7sCRuAIDj7cEC9gzFhu6iJ1OqAn3YU6cv29k7IFibLHEVOrd7JM4uOBJS1TCYaBW4CihB5/4ZkLkdYY0laBTVMu0Tdg1HUOizniHSGcf7plSJH/a8xwuH3iqZJcr1lXja1cSfvtD9rBaxIog2keKMLfi/D3SzQLohVcXEO7QSXQLb0xrTGdtcU/dUwBXHw35PKrXee/0jQ4xUNJo46uOHVYwPIjgHNLdBw5dXyupL3plhtOwahdgSREa2TNAJbCxZ0AfmfqB9ZwycqxerI4nOJIU+/6LsFmH5eAn4c03SCaHYYsr1fZZ0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRCuT5yuMVKSV9RM+g34QisLSWCR1AoigQtkhE+Eln8=;
 b=HiWdMaTiWsiylMmhIDxXG13Ry7psjx2YNrKAVVCbISD3Wf98DNg/Pngz4aDAMUNxRXTHNqa+PPfR4SWk5jFSXLU5dqC+Y5rENNWyqjXBriyoO0YLM48bEWTtAKUpu5DIX76gBkEQjurCJJ9Sj8NlYDPlppIAoMOCzvfPGs7B2gJjkRc1nmRGvNNnIvEGW+D+0bmC+iWuQZs8I+cq338+zHwR8m3yLumfKDqOxrTBoHvXwgSE/iA2/mEv30aldx01385HvV6gQ/YSZRdDigXYEpm5mTyqEtxdSUQfHBMpvZjHhg/UTKyRU9P4VqDzQxOA+Gtasy+KXlQZh5B99Wzdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wisc.edu; dmarc=pass action=none header.from=wisc.edu;
 dkim=pass header.d=wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wisc.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRCuT5yuMVKSV9RM+g34QisLSWCR1AoigQtkhE+Eln8=;
 b=PjwEsRKgFc59l+R9GIP9A1KYK/RHmVDumY2XQ/SnHscuuq+0qdo4ldi9Q0HfdxqgNHq0G1uWAGHUVDX6/dmTYtzKppT9h/S962DbM/QMraMrUFv0Xt5pW47dqbsfGz9jDZ0orTPpP7KMBEELAXNnyoXLh/JQjZtWjpTP47Rdq9zrMjyQJiVLVIPWNfTz7phMlO/uTKfOWBp5q+d/OHxrQjhxh9ST7dwf1i+sMsHA5DWSz3tEc3A8HVesofYgMfl5PcAyrdWXig0nonHg4DvB+SaKnXs3v+JgEMgGFioSJUud7kUvn075fz3GduyRxm11KmsqdZjA2zEqTtmrmdk0tQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wisc.edu;
Received: from MN2PR06MB6639.namprd06.prod.outlook.com (2603:10b6:208:20a::22)
 by DS8PR06MB656475.namprd06.prod.outlook.com (2603:10b6:8:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 00:00:11 +0000
Received: from MN2PR06MB6639.namprd06.prod.outlook.com
 ([fe80::c7c1:6e17:5f9d:1245]) by MN2PR06MB6639.namprd06.prod.outlook.com
 ([fe80::c7c1:6e17:5f9d:1245%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 00:00:11 +0000
From: Seunghyun An <san55@wisc.edu>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, David Hildenbrand <david@kernel.org>,
        Vlastimil Babka <vbabka@kernel.org>,
        "Liam R . Howlett" <liam@infradead.org>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Dave Hansen <dave.hansen@linux.intel.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] mm/vma: only assert VMA stability in vma_has_anon_rmap() with CONFIG_DEBUG_VM
Date: Mon,  9 Nov 2026 18:00:02 -0600
Message-ID: <20261110000002.1834454-3-san55@wisc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110000002.1834454-1-san55@wisc.edu>
References: <20261110000002.1834454-1-san55@wisc.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::11) To MN2PR06MB6639.namprd06.prod.outlook.com
 (2603:10b6:208:20a::22)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR06MB6639:EE_|DS8PR06MB656475:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d1f706-6aec-4324-61e2-08df3ebd96e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|786006|56012099006|11063799006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	6yoySY8aNlIUUllWQ4YuAcPD5bIYP/is9PP6qtAbRrhRMvN8DKK/5cfci0DLcRFTmNGeNllkgNNLIykLguhCTWZj6A7dFf1gkZ5Qh8Eft1N/T9YD9wBbcFOzavLzd7LcrFUQ1K3rkCf4iUNtMusPz2dNyMFc5EiGjp0R1gr3v91uVeCwvYjraxLGxvcGT3n0s66HkcLFlvstAAv42vxgBKL7TdZkSqf4Jrrjr5evsvczIIYyOEpR16y7NARZKvKyeEp5SlJv6iYeGbQS0/n0q8OMgezYUdoPwUBsSaxZ2JEgk/RHsMOr31h7czq8Y6qLT0K1pfYmDnCwMJdFJ0oAasAcc7UZI8Bhy1Hh3fbmvbtFL8exnYDLxHU2ZU/HXEaaLdrr9wzJ8xtYQJ1f78eB9zcNSTuBPkJCJVQXbVh2nxrX2e+mfenhgpx8PQQoWBzG8HZlYFRxFRNbk0Ld4mQUa5LPxkU9F/Nz//ubWLF6q8T/TZtkk9M2Qa81dW/wJYndiw/TNUBInmlsW2wcs9bkwxXd89ywrP9MASo1N+MDRkgmqtYacEEBZMfTKKsBJc1gCnH55EKpjABDda98naLOnkV3Dq7x3sq/5n1RYHRTx2E3QpuRH3IudMqsJ/X/3yo6NekNoU6LtgFNsNyBW5i8dqr2sc+g4QJ27TqEUbSN7OE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR06MB6639.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(786006)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9B3q529pVgiVLNVjEYe27PIjvL/w7fq4TEQ1aCb+agpe631LBNHOJITZx06?=
 =?us-ascii?Q?z5uNnh2FwxamsUNG8dhzoJp760encpauWY41IzWKG8/eDZ6tKfQZZAQj7bGS?=
 =?us-ascii?Q?LnZA3cQ7BqPid8wLOE4GN/NPw9ouf6B5oHgPSyVbp7kM3jP1aWijf7Z1NYtt?=
 =?us-ascii?Q?mbrFNodo4iexmCWyplK4GW/6VGDoFOQJyX9ScRAw2rp2m+qKGbtlwso+vtup?=
 =?us-ascii?Q?MhTKMni03F1q3NKwoeqx8kb+AEqGlaJkc1fSgnDnXxYO87I+rIrbF3mPVesJ?=
 =?us-ascii?Q?0KNfn3y812Tn57dZY5y6yPp9N7GEyY7Ygh6ijH50hsJ2GCdGpIGLslOc3lhv?=
 =?us-ascii?Q?rlI4zSCfRklNGLYW7HPjdUJnuEzgcPVcJG/pyWdkvWKoMhDitcGs4u6apiLw?=
 =?us-ascii?Q?OqqaCTWo0+DJsFLA3wYCUddJAqU1nfEW72UOd39wfxI0tm8KkaZOHX87gyOH?=
 =?us-ascii?Q?gFigksfFnAVtWw3Qa0y/fjuT93ONZXlLLlwpO2xFRlcmT40mZTeuYvNhUFCE?=
 =?us-ascii?Q?TTENltdrcEpOQ/3EJYff9HOJNELJQ8H6pSFFX+nUpu2R6xmB/EWooLDLxsXn?=
 =?us-ascii?Q?Oyz42rNPvZ9PXcNXPLQUQmrN7Dl3sCkHDOPUMjV6BG+uXQ5R23fIN6W1EY5U?=
 =?us-ascii?Q?aoxuZ3iqdyo2sZu0OFNzRPRDBY7o6jvZ4ZdbVD7VLYDuf42lNg+MDeyq35mh?=
 =?us-ascii?Q?52t4Hatp8FNtPq8DdFRPczk2tU2E045y5W1J/HmVzdimz/ntJQa83kUzKHZC?=
 =?us-ascii?Q?zHKiND3IJsViDW6fB8DMtGb8g144n08tkF9xQD5HHi9zYB1FBGuaxsxIUClf?=
 =?us-ascii?Q?m1QWhy4me9Rv5rzEmXpmm/9WvL0bq3dMX92RQEUrmZQ0iApYLmRlADyxWab/?=
 =?us-ascii?Q?Q6eEm8Qg4zyFLSVJDO6ojDRW4HUb5yL1oQPF/TC6o9hRcBO9zwUVxZgblDMC?=
 =?us-ascii?Q?cNpZnlnYNcmjKKCo/6myGKpwujOmC6pRJ+FWKtxQDKF36j7lxBvpj33tkHnY?=
 =?us-ascii?Q?E2xdBWNBymYkZWlH+pTF6f9YcdYzAvirbAHqDx7+wUgtfDX35HdLYG7MjRNR?=
 =?us-ascii?Q?sMe3h0ElorIkwee96k9NNh/E0mE3X79P1q6Y2MBPuxNYTfj1o296AQUGdkYo?=
 =?us-ascii?Q?s03G9boCpoJCTyitINjyxhM9c66IaSBPA5PRm3eV0NXDzNQmxpRBul4Oozzq?=
 =?us-ascii?Q?PwuNZIPb2zxGXxCK18TVLLk8mCiF65wy+KjPYJ1f9GMXx5h4veESpFoJGvp3?=
 =?us-ascii?Q?S/DbHbSYj3e1g/AgJ7sWNn0CIRZiFuXadGjul2VnVGzOjPDgd1kMkFtkMwZk?=
 =?us-ascii?Q?hfO/N+NSgC0H07JFs5DtWfEME7hZ+jnjKyn1dxR+c3AUabTKHLbsDuOQ6+iX?=
 =?us-ascii?Q?F+ZjNAiVQS5C2oBO46/P8AOysFwKx49oedW3VehxI7KzjM/enk/I1WYxOmw6?=
 =?us-ascii?Q?pmE2hewztspJ7rIM7YyA+5cKHtvzRiQv4NaZkQ6aQyHKq7fRAQVJBOdI+AKX?=
 =?us-ascii?Q?JdGPv/FrTIBV21E9v81VtNGL5OhmkjWotCb7Btj4B10UwzwYSd0MsDHVxJoD?=
 =?us-ascii?Q?jVUiXQB4uVgxWVo/z9MyVf2CtoJ6at9iUIkuQaW0drAnPh2Eyfc7pSqbbWY2?=
 =?us-ascii?Q?gjE/CLvo8zit557fz8lSTu9bIY4UjLXt6lBZ5I09URL2181+6rOMg3Z6DMj+?=
 =?us-ascii?Q?x2g94OtKDSk8KpcWDmLTwxNr32sosVg89FrvV+IezxdTAOBT?=
X-Exchange-RoutingPolicyChecked:
	u1qx8LQDqw58yu2AzSmppHe988pPQVzkCm7jvkOn550Rv1fKz4LejUBjpGCTpmNmxuhgpcz1djqnjRVjib5bY49nEIL3thz+ZW6U+ljiAKPHI6X52nEGzaSIZQPmk7rPdXNiSBA8tSi9Z3yp36SKzSkhDkZA7p9F1mhUE1/ULgNqpsliJeCAjLhGw1jXqCbTftim8tDPuLV1OqBV2OMS2sSR+AiIEHjUDSNDN6lud4Kq0TJmWVGepmRqXbTaW2XXOttfIHc4gOO+X6d2jOORlBk4TMQp7/66TvFgHjJAdTGd3NVTWa2XWG10E+wYIkcCd5Mt9xDxlcyyNyqiU9LdpA==
X-OriginatorOrg: wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d1f706-6aec-4324-61e2-08df3ebd96e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB6639.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 00:00:11.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRcreRhF46m0t90xDk0wGMgWePyaWDDd3yAmxjeGt4CrRliL7et+am0+EPnHxxnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS8PR06MB656475
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NSBTYWx0ZWRfX/t0g5S0BQn+l
 ZicYTAZbo4bu7Ozw9Qt53mKQpiznFCww9CmKfNjws50oqcb/XPBSlJK8iuSRAC7d7QQVD4+Xhi5
 B8iZhM2SsbgLt1yHhhNpNHkfcx8ymeg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NSBTYWx0ZWRfX39GPAmfX73bJ
 /lepWbzzjRuZ2E2rtsXOwBTmYk7bUdmkUxjlLMB1jGCT0tkWAFDjdBdfP2quugnTxk/plWVe1Ei
 wZYowwWqxFc3KsNfYIxrW18Z5LGIvZLNZo/XMpIzpIiMLFFAV8Mk2KMPYwVqsOtIs2LWN0W1AEq
 0l6eQfP3ZfPdS+2PgN+/1n8rr+0RS3JZcp0Z0vLswNHAJJEBKB1uTV3lZyCY1o12FcVuw7qdVUt
 E0y5NtyOfwCt4F42ZKOyj57fdUEYsjPBh8mHpb+zuOoxu/7SL82vi0LX6cPtCE1oJUZFfOdt6mm
 wLjI8eHcl6jqyZOtog76S3grFd3uamaWpDCJ0roRfo78USATw/fyGxN46+0hOxT67El4mB+n2Wy
 DqW0FN2EO/YBad89yldoj/NStn5BM0C9kphDPqZuq9vIGyM8s0+wtlBdGpi2CxcaBoJGkSmeV75
 CZNaOyATIGMzrHrdOvQ==
X-Proofpoint-ORIG-GUID: 08yeMdxN---xN5swRpw0l4KXB09rvnxT
X-Authority-Analysis: v=2.4 cv=HtDjiETS c=1 sm=1 tr=0 ts=6af25e8d cx=c_pps
 a=LyZwXkN/zJaPlZXKe3eCLA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=U-hppK1rdbEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ZyELlZqCvD1aXIDzc3I-:22 a=-L2uzytrI8BeDALVFixt:22
 a=zjJ8_30hHowVf6qWvpIA:9
X-Proofpoint-GUID: 08yeMdxN---xN5swRpw0l4KXB09rvnxT
X-Wisc_ValidFrom: true
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090095

vma_has_anon_rmap() calls vma_is_attached() and vma_assert_stabilised()
unconditionally. Without lockdep, vma_assert_stabilised() reads
mm->mmap_lock and then vma_assert_locked() reads vm_refcnt. These reads
stay in CONFIG_DEBUG_VM=n builds: refcount_read() and rwsem_is_locked()
are atomic reads (READ_ONCE()), which the compiler has to keep even
though the VM_WARN_ON_ONCE_VMA() checks consuming them compile away.

__vmf_anon_prepare() calls this on every anonymous fault that allocates
a new page or breaks CoW, so every such fault handled under the per-VMA
lock now loads vm_refcnt twice more, plus the mmap_lock count. When
threads fault on the same VMA,
other CPUs keep writing vm_refcnt in vma_start_read() and vma_end_read(),
so these loads can miss.

The assertion has no effect outside debug builds, so only do it with
CONFIG_DEBUG_VM. The fast path is then a plain vma->anon_vma test again.

On top of the previous patch, same setup as there (AMD EPYC 9634, threads
faulting on one shared anonymous VMA, faults/s, median of 3):

  CPUs                      before    after
  1 CCD,   7 threads        2.369M    2.425M   +2.4%
  7 CCDs,  1 thread each    1.982M    2.215M  +11.7%
  12 CCDs, 1 thread each    2.548M    2.949M  +15.7%

With one VMA per thread, or with processes, the change is +0.3% to
+1.9% (the loads are gone from the local path as well). perf c2c no
longer shows __vmf_anon_prepare() on the vm_refcnt line.

Fixes: 38564710f443 ("mm: implement and use vma_has_anon_rmap(), silence KCSAN")
Signed-off-by: Seunghyun An <san55@wisc.edu>
---
 mm/vma.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/vma.h b/mm/vma.h
index 3fc3b47a95..4562bd4881 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -278,7 +278,13 @@ static inline pgoff_t vmg_end_pgoff(const struct vma_merge_struct *vmg)
  */
 static inline bool vma_has_anon_rmap(const struct vm_area_struct *vma)
 {
-	if (vma_is_attached(vma))
+	/*
+	 * Only check the locking under CONFIG_DEBUG_VM. vma_is_attached() and
+	 * vma_assert_locked() read vm_refcnt, which concurrent faults on the
+	 * same VMA keep writing, and __vmf_anon_prepare() calls this on the
+	 * anonymous page allocation and CoW fault paths.
+	 */
+	if (IS_ENABLED(CONFIG_DEBUG_VM) && vma_is_attached(vma))
 		vma_assert_stabilised(vma);
 	/* KCSAN gets confused about the optimistic check. Silence it. */
 	return data_race(vma->anon_vma);
-- 
2.53.0

