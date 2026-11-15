Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794787036;
	b=J2rROVqyplbDWjMSkDResTmODgh3Ly/gP/ZiGKWXqlFwK6ydWBTqd2eEgWJhdw2Cij8P
	 fKFh+Kc6rYepxgvYIfUnsWBD4K6dm5L2nTOwswy7dXT1Es2MD10ziIA+NMrZAeVBON9nA
	 3WrTgldxTZJHJMW3RbjW5Ci4DvkaH6zrwEnpkl1J2/V2bAAxkLNf+l15S4BslhWAMoD6/
	 aYxnS/uUc2WyVAzXae0f7DuA636f4lONFhmOTzv5Fg6tz9qhdujDgjkWRjgSdvrsn0ijG
	 5O6LhN8eF9fDLyj4eObP7LsEQhzAb5ixiUJ4pPVA+DSHjQE4X6kOSdPG5gEHQVpthwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787036;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=YDkWQmhvtsTHCe7740Md+HxTNgbsS1JohR6q2CqGb/0=;
	b=Hbg1rlQBjB/lFZc2mlS/VKJmSL8Thvpe+N5j+oX0ChFeYgJpU4B3BsHgUdcE8onKaxHy
	 hWQXE6opSZqAZBcTdqu6HllQHQO8Qhj1VPeyDKLlLtnqDAe2C4gzHXbQ4goOWRVv/1Z+D
	 STuXCCjoOWW9uFwDV88rFbojdz6HTvzNtw0SZ18vqJopZF9M5CTB7lW12O7ukt9fkF65T
	 y45YEdOds/lBJi5UzgN2p5SYAxAx0cQh8c8Q/KmnnGRmUyWKTHkXvxX3TKGB4JZzPaMkJ
	 rBNVcQst43zDmo8y9fd3u+Y7ykL9rl/p6AT4NpzvV6vsHjncpB4h/3xqs83pURDBSfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qG8oUBWL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.51
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E565606A31F;
	Sun, 15 Nov 2026 23:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E565606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qG8oUBWL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkuj2du12SzUQCphHL6hBGS/XlROwx7xeQCFxcAmK9lGymce1W1q0X6Pp0S/wUxTIKUQl22zc/Q3onVAQk1BgDSRVQunYvM/MsCo7ymRoTYkp7UnJ5cYhZc7D1qZLMDiFPwDIuzgvfFvfV8AVOeTK4z4Rl5PFdnAkUm6c/Hwjiudw7C9cKYN9oEMddnGcYKytILc88hu2MuyJUmXejNButJJQVXBMS/kFtHW+0JOQm7cMPldlK5H7VaNcUTfF5eee17fboV6O4QLyROL6vsSR8HAzWonQYD0q01Sa1A3oJr7azjeY7qXj0egAih4ko2m1MeDz+q4DaM1pxl8T6oYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDkWQmhvtsTHCe7740Md+HxTNgbsS1JohR6q2CqGb/0=;
 b=N0Hkc8ySakK4+KuoM4yT0/zSuF10ITvxPrGE8LNAzJRWNAHHQCNNIhvcnGp04L8nU72tuBH7ihMQ13MN8G4f8WGANXjLjr9Bae4fNJk5BCKPKDEUJ8JnJ7YgR6YQS5ZJNQSBgOnaAVf33u0MidqEfYrL20HxVn8qwY2S3EIiMZ5dYYHROjroFGSssTS1VV5AiQVHAeiVYk7hogArHIvKMKK6vNlMQPrxrQcvBOIVILn6+WhecgNGy+l02TrTeaUiolUtDh9zdOpdbjGlsGdB5r3NW6XW4h3dDiq7o42f/S/TRIuCNIZjCZDVbkhTwUUbWb0wwyhPbUFrD3ZtmxzVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDkWQmhvtsTHCe7740Md+HxTNgbsS1JohR6q2CqGb/0=;
 b=qG8oUBWLBsqd4JJMjuiCxpePjBaphJHT09Kj4VbQKqjKNsrq0hPifyfojvM3eZo7F51fJnSZY52cjtl5HTRZlVYysvtmZXyqbq5VKDMghlI3LqMXDf0OpBuw3T75MIqSrFEqo+uyv9xDuLd0QPShf9mXAFoZcl5hEUrZ/3Z3wKIC5iwQ8kgMWa7eueNZcE/nlW4XmaX+gF2qBheawbJRkEqPPRQ+l8/B+CT3cQd4A/U2cOIUYtAb51tNN//bxivcQtQXkCLWwMQcjnBFH0L77baBmE5p2JuIrJoDrdz038dtQPabrqsxzYoEzPajLXabGCd856xLObOsyEzOdCcfbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by BY5PR12MB4148.namprd12.prod.outlook.com
 (2603:10b6:a03:208::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 23:57:12 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0615.013; Sun, 15 Nov 2026
 23:57:12 +0000
Date: Mon, 16 Nov 2026 10:57:06 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Chris Down <chris@chrisdown.name>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/12] mm/migrate: keep the uffd bit when restoring a
 writable migration entry
Message-ID: <avpGkikSWbIKV_Np@nvdebian.thelocal>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-4-00713d368976@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-uffd-state-fixes-v1-4-00713d368976@columbia.edu>
X-ClientProxiedBy: SY8P300CA0023.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:29d::29) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: df6a5ce1-cf1b-4ce2-916b-08df43742a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	l+GX+Dk5z6EhaiODCylwAsZJNeeA+GDzqi2b4Ur60niBrIqJ2vVuDDrgVLgHGqWFesbktBLAxcPov30R/jDLXCRoetPgGjsFvEfoRWjx/y2t1zq7R9ZZX3yDywCm2BIZvpdz8y7Is7VMF+5ntYH5p3JdTXjwCjFy3awfRBB4JiUUopzaFFOMB25lm7ShkksobSnU3szh3NnFgSIo/jLeTzcI9sGomtMUrIsapjo92eg+65+BHMzojJZxvOPxnXPr5KxKK36+1BZNuhT6Sdvvkm0rOWV3HFDjMuegGsXQjMjUXbwSBYDbNaV7fiCkVFz2SEDpkFPf1ZEARwB+HEH+OJtT054VDyGXwl6U4rczy2eiyQILdMn3/UBMZDthNQ2LjQUutF2T7XMpb+HZmGVTKmWjzYL2Znez3vuDAUkZWULLGUAiKtpLnXFRxP4mhAvdwkF7bIEpPHdbf4OV4YN5a99e2HsQV0uypoPUOIOtnAoPrSSE+cQ2oNpmBeg+tth6lxqeq9LWUwlJyCYxzAha4mZb4q2pey1X3MT+DM84i4G9bxu2DgIBf9Ai4sT1yjKC6lJVCgHUEoK28s2vaci0gaK7BAF+uoLgGwutHkAaTGsjrf+3NXRqbAJwOh2dK49Fgl7nXBO/ePtv2oFykF68YbrwVJmjaVLihslMd3ofTjQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB598757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8nM38xqHbDQpAQxpcgdFLOVCmMjr22+quaHkNz/nYWRnRKfCmoj+oqL4sbVy?=
 =?us-ascii?Q?xWzGDrUvBQWB6IMohmRjoIj+H5WPz1rzYDCkReV77yoqqm/yiEdvkDdHbGQo?=
 =?us-ascii?Q?Bb2FB35fGy8oIMeAHaZ6/O2mUCuV61FivlWntjhprkSTS1iyC7sqH1/aDYZ9?=
 =?us-ascii?Q?0ZzfBjpGejgiVPqwUjdmmlkEpbpjif6TUgbgFoBsb+tW5b0soWxC66SE7FcT?=
 =?us-ascii?Q?eAOeXegKaIswnx0eAdIFCcuZl29RqaZC8XAMw3twPbBkefGSDX+sJ7SVXTcQ?=
 =?us-ascii?Q?/1z2iY93gZkFaAe+PewkoAvCZ0PRRdJ0TMToWnY2u2SW4k1Enw55NyMhWLzT?=
 =?us-ascii?Q?Ei0aWs8I3R6eyw5RKYfMQcWNQS6DUzZ3+vB2SF/4W993n4wIQ08Dfm2WQsgh?=
 =?us-ascii?Q?HKLUMapoFVmEOlY/t70Wm+nxoX+VjzWjt94o3jmTRz5mtE19zcofRdMCbbCv?=
 =?us-ascii?Q?XlVreyBaFJustv/z4e/IhFX+ArjtASCcf6lRc3+auBJzCrMKLwaInBfgbahV?=
 =?us-ascii?Q?wOz/Q4vVBYNLJNTIIMolhQNZLkb9A98di4QQIX73EWcLfJWvF3DQ0pv6L89q?=
 =?us-ascii?Q?W8rTTMfJhIjmAL2X0siWJnuPK/zm1rAYgUYKHi+CgN0+k0mJAwbXvkBxP6oR?=
 =?us-ascii?Q?0tWvSsSzo8OWguGXsrcyz97TQltWV5C4oFzu3vgPVQby/0E75dDpbmlXY1TC?=
 =?us-ascii?Q?obBvh0RloVwI+FoCOCXnlDQADHRjuXodPglhsk+MmtiFjPFQFrms3tzTRxZ0?=
 =?us-ascii?Q?ZG6AMvB6XJ2SQU9W2c5yAnxbwqNKGwn/l+9V74XFXioorakWXZKbXJEQ/AGJ?=
 =?us-ascii?Q?XZsjFMMy82OCshv3ZVu8SF64sOvlATRnT/Sz/3WcG+Syw5DgloBQ4Ombkoaw?=
 =?us-ascii?Q?kTMmaZBpOb3cUVu9VtYtxCxPSX04C6x4dkEntuMRH64QDBlvE0E+5xWeZ74/?=
 =?us-ascii?Q?f5PuEuc3DthqmjxcXLRsQV3DjT/ZVt+1kVnJWiE43UNrv78l1ewJxxOwW0G/?=
 =?us-ascii?Q?sYjWib/3E0GHg8JxxCxnqKo1vWpzkkzjJtnt4g4pvKoGQp8wpwQxqBDHwsu0?=
 =?us-ascii?Q?9J70jHBn5hovIA2biqe6Z0cuq8qbsv7roWJqG5s+nfw/RCUTSQCpXGn4WgGc?=
 =?us-ascii?Q?MC14FNxW8WmgekAsT2sUcOVtq/rlYtIvyUbjt0MmMO3Oc+YGf2gdCd/ubKrN?=
 =?us-ascii?Q?XDvcQdqN3FuVq6uweTUMR42s6JFU8MHPcluGG2xhy2vTarMYWeidSwaG2Ywx?=
 =?us-ascii?Q?9Lqs2UtIw7Oa63VP3DXvuCc+YqxZk19hX3i6vUqLhyO7OIY6d3BAYLd7auPB?=
 =?us-ascii?Q?qMWMM7kO/H6vA0w6mUetG2PIa7kYDokN5ghWJ2V5BjJYWQj0ntsZAgp+WWu8?=
 =?us-ascii?Q?sz/eAnIBKqxnlbpe2PFL5Bz3FfcR6neEEqmMvUTIMOkAQiLKeIw2TXKJwgDi?=
 =?us-ascii?Q?QbnBzzOZDrc6afZfradHDFk0ryzyQIuZ6qKFXrJE/MjpoNN0ciT9THoa4KNE?=
 =?us-ascii?Q?9OtOLeqbDgcKIMeEkbZIlG8hUfi0liaAFVZB48ypL1R1B15ByAIkGQhiw3up?=
 =?us-ascii?Q?dYpSSyhDZJVNhNL2HcR0zhLOg5NobHKtM0byHAsle70OGo3mXXnEgWIw+JEX?=
 =?us-ascii?Q?rKnLxUW3IohI6YIJKYf8DcwVZaEB1mFhJuszoDUwIf83hCDO2ZYqbR/ac94C?=
 =?us-ascii?Q?qB0nTuyRQCbJ4JyL3IoNZ2Q4s9OMJIyrOvtysE4P1AR1WYRudyYFFO/U1RXF?=
 =?us-ascii?Q?zblCGYvkLg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6a5ce1-cf1b-4ce2-916b-08df43742a8c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 23:57:12.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6fn71NNVJxdJ5WuTH16makzTpZRMGnAci1OCiYZki2gOTI0dXQl5O9/5HG0P6z6c99skTHfjBiVRXHKzlWwlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

On 2026-11-12 at 04:55 +1100, Tal Zussman <tz2294@columbia.edu> wrote...
> remove_migration_pte() makes the restored PTE writable for a writable
> migration entry, and only looks at the uffd bit of the entry otherwise.
> A writable migration entry that has the uffd bit set is therefore
> restored as a writable PTE without the uffd bit, and the page is no
> longer write-protected.
> 
> An entry with the uffd bit set must be restored write-protected, whether
> the entry is writable or not. remove_migration_pmd() gets this right: it
> makes the PMD writable and sets the uffd bit as two independent steps,
> and pmd_mkuffd() write-protects the result. To fix it, do the same at
> the PTE level, where pte_mkuffd() write-protects the PTE as well.
> 
> The only known path that created such entries is PAGEMAP_SCAN. Now that
> PAGEMAP_SCAN downgrades them like change_protection() does, we should no
> longer see them, so this change alone should not be visible to
> userspace. If another path ever creates a writable migration entry with
> the uffd bit set, the page now stays write-protected instead of losing
> the uffd bit.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

The code change looks correct to me, so assuming you address Lorenzo's feedback
on the commit message:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 28a8d7734735..d200f64b5f98 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -399,7 +399,7 @@ static bool remove_migration_pte(struct folio *folio,
>  
>  		if (softleaf_is_migration_write(entry))
>  			pte = pte_mkwrite(pte, vma);
> -		else if (pte_swp_uffd(old_pte))
> +		if (pte_swp_uffd(old_pte))
>  			pte = pte_mkuffd(pte);
>  
>  		/* See do_swap_page(): restore PAGE_NONE for RWP */
> 
> -- 
> 2.39.5
> 
