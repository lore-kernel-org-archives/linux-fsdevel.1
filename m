Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794787961;
	b=Z6liq5oslX2Decf2KOFPeHOV/gX6WHu7kBgSYQQ2Qcst5Xmrhz4VI5DWQV4WfsBzLNg0
	 LgXdiJuwnZAK0yGvLLOtv+9vn8bw7paNmYQyIk5vBpgMtppkuN9Zd/RE4zy1k49gRLVZj
	 kwN5Wk/rDdYDalqMenxSw7kBJoUkdV62WRzPqKl5CJAR37qcMga9kUBOnOHjSjkxjVY74
	 Q0dR+D+KmV5lZjBBh1SvzFm69xO+IQrya6KTbGRMJLXLc+9EL9kxnltlo/nnMFz0XwatT
	 t4Guw4m5LJ0b3LDpjPC/au5xgjQftuO5qFPadydVelgCRDY9amYzS3bEVATqNChNXXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787961;
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
	bh=dVtGWX4GzNRl2h94XBhwlDXalWar5y3FPOwDgYNDWHk=;
	b=rvFalOCoW/kEkkg7Hk1lTcFWjq1IO/TKYkFQ88bgDULt/UDHPC6z9hwFcBSSjw1xjcKy
	 E+SD9yJSSL7l5JW8HGePMU4TZdYNrSqXU5lrK1KYeQ8XKdOyX/Q/z0obuq3sJYqaWl0AT
	 ksjdLscbRGeArZTITvuP/JyGqyV6s2Ig3EDxy/0bYl6mcRXDCzQeJRmchr7fETZ71AYF3
	 wuefHspzoufCd7yq+6JYP/u1yKZ62gG5Rw6LQf3KAplZ+qq+EPe1OC5+mi+9R+yqoznEm
	 l9wtHhOHNS+3Q/5ibTi7qCD2qUEfdvcbMv3NsRPKFp3PeDhxai7FCd0P+fF4MjMb8wQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YJe6YvLa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.54
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795B606A32C;
	Mon, 16 Nov 2026 00:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8795B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YJe6YvLa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDfpn+1cQ7V3ZpRiDS6dax7hMWkm0Bw42SGd2TB7kmk2IqhvvcZBDKMjq3hfwgwFfkZUUMlc+wc4r92aJFHDafNVi0eelM6/xUkaLhYJkweI5hdV7qDpLcwY2uMFyi0TTHa9uz0qPc+A+HShTNUfu/eqF1syfEzuLdwC7/qpd3xmy7Xj6KTW2M4fupFqYu1bswDJBV2Ur/k++u9nPr9xEGwk5YdeXvtyc2RrvI49ZL8e6A2kYn3M9wTX7KCK6Xr/DELS1Ark78D+ttzwJS92kUn/hLQsnnO1wxlAsv1K6efFSBef3bLH83iVRozOQIWdwz7V3rYAtihYSCCqOxADWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVtGWX4GzNRl2h94XBhwlDXalWar5y3FPOwDgYNDWHk=;
 b=X1z0fYbOWKRrhdEKYW07V4esa6v0joTCbR2PyJ8i3ssIcFeAkSuZHNxkt86/kXx/VOghmncwPFhfW0c4EgHGMPEv78QJgAYgdhOAxA+AFj8ALT90qjRBr1FtgEQGnbJkkGfGs2qGajujvYc9V4PAEJxGlHLBFF006PBWWRxTQ0IwaDUnlLrPQsv8tCwp5uR+dplX5/+Z0ZgJyuX6IZaQy4S1O//OhKHtdW/sIiWULXmlZQ5hFTajI0fM5l6mWARG8ZWgKPtX92wZfecURUuZIdv225DT7ghIrMvg93hpQbXmzOfPIuNNwwvE9DZDmlXsXip3Cy7FR6wkNEV9kZRNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVtGWX4GzNRl2h94XBhwlDXalWar5y3FPOwDgYNDWHk=;
 b=YJe6YvLa0P1zUIj8V2fFPJ8NwlDFpbyZNUz5eU1WU3G6/50kRWzH9zNApmulIixlHdSJ+FWh+qgqXe753dsbyL6C7ctDQtl8HGxONFovnietc+PLx4Z0kTGVr/ZpvYJkt4EK6EgUNt8bSLxi4X3yV9oojPmiawy9RolI0+CuKRp5C+3sLk5tQ5ZDLFc7lXDw5jW9zDhqW2KUm4UiRvnz7h+wz4UPCnPDh0/a06sPVJ8s9f03+ZG8JU3xc6HuH1OI/zc40fEu/JY981v0AE7RjHbwhK/SE1VFoJ5zlj4RQjHFqhKNJHxVR+AqM3bSicsKW/nkHxy/QZCKqJ+QwYaMyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by BL3PR12MB6403.namprd12.prod.outlook.com
 (2603:10b6:208:3b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 00:11:39 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 00:11:39 +0000
Date: Mon, 16 Nov 2026 11:11:33 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/12] mm/migrate_device: do not migrate a uffd-protected
 zero page
Message-ID: <avpHe8sGgnzx6UwG@nvdebian.thelocal>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-8-00713d368976@columbia.edu>
 <179454988585.482102.2051616940227067987.b4-reply@b4>
 <c3a51a9c-083d-4c76-9a62-b7a6fe69a121@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3a51a9c-083d-4c76-9a62-b7a6fe69a121@columbia.edu>
X-ClientProxiedBy: SY5PR01CA0077.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::7) To SA3PR12MB598757.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: dafb7d2e-3ddd-4a76-7781-08df43762f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|261028144727099003|261026140227099003|261026121527099003|261022105027099003|10067099003|261102123227099003|261021121427099003|261022075727099003|11063799006|261009223027099003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	+Qhx0UEhyrXYBdXK8RbNU1LsuknF3gacO/kk5oth1IDyk3a0m2ZpKsRxdHSH0f25csIwI4vwPi9cxP7AoJRX7coLJWhyAp5k14XixgyxrTscjuIeV6mm+XuSZ3kNOLhyH059YJzdIskQWz87IL1r66DjGZqBnXYvLCY5uutaDNTP/cbEEqfxRp6A5Zt+o/3XV4oMdKPu9ZPOLDEmaOdK8Meb+0cD7CuXoeXYqmnXWIr3nNRVFEwG2WM93PvUHX5pwRJLRkiHd6seS56UPwtCRivCDaXAhC41cBWdR4/9YWVKKahJ0DVXt5RM07dUWQav0TRVH3JayTwyyczwb2Z+q7Qcrv0Cf+vR0znUGP+8dJx589u41q2C4TaDzNWhmW8awrOSNoIEg0U6u2vR+WfEZZ7KyzCvO65gAnt+IawfILRj2i5XDjEmmUQynSwXT2oVSmwF4E6U6l2zrWeGzUE07cQvzU6905hOoWG7KgtI5SP0yD+GguqmnA4e/FB0Pzd5Ssq8oOedPOM2UMZPq1BB9zEbn3baz/LXBuXmt+3penPtT76HzylkPCFerBF869VX8Geb1VQOQQDQ7sLrUvqp2q/aOm9b9+2eHgRy+G+IDG9MxxHR2GooeYrHflmjezqS8aobxwoDYy4ivRmG5Kad7lZIFmz7FxpB/nyIzF8XWwQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB598757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(10067099003)(261102123227099003)(261021121427099003)(261022075727099003)(11063799006)(261009223027099003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ODfiAhxQp8bsnRUjvgvQUnaZpqGcODawIo2hISo0nXLlDq6HzcuC0ROnnN2L?=
 =?us-ascii?Q?pFIcZD/pmCKH+LBARLMh9t7E4lyyOZYdO96uv6AJaTlinMIKKBv7fPG4+Dk7?=
 =?us-ascii?Q?FGnKcrHU/hKjSPfrSCqgEADnaxcdiUD0iCyj1DnplGIg+URqJyPhKgon1vpd?=
 =?us-ascii?Q?fh8+aKM21GacuQXmw6dw/YebaNwWNyQWMGBwQZiIXRQqhWoCelFhIrOlpz6A?=
 =?us-ascii?Q?eQzpP+dLYOvChuvlQ0oQy2AP7uQkxbvsf9eCX6tIZhBwOe4U6MWrGXJXF7a+?=
 =?us-ascii?Q?yOh2vh5b1XSO/jPNYBVPXY/uihWs4kXYcFgdh02VSMIfEP2fQ0Mo4QrWv8p2?=
 =?us-ascii?Q?klI1clQu52XygQ4d0hlBwGjXVMrLSMHE+fJwGrfYSnKEyRYmHRr5MyTPbeLg?=
 =?us-ascii?Q?UYxiWnVYT8gvS5GgFpC/JnXH6KzfkyAMJFfZWj9TOLUOGGs1JmbQX1bATENC?=
 =?us-ascii?Q?DlqxGW50PaM7IX7D+jwX9DQzGkeYgug35mGhRVESxTKq2Hrzy4GEM7YCGNZU?=
 =?us-ascii?Q?btdI0vvVAAWpyj033W6AX14VDrI/63paqlJBqfeL45K0Bj/vPyGlY4A/aYhC?=
 =?us-ascii?Q?X8dR50ZVm3CUTrRwBaK9my2fyiO5ZKknQUZVTVAg9aOXzBQ1YZxwrxxXfcU8?=
 =?us-ascii?Q?XAqwis62uKlftrd1HqlUibk9Ep+bid7nhN6Cq4nJ4/Lb7+bbVNR/1NjZDMVv?=
 =?us-ascii?Q?0e8vVJNEgOL6ZogDV8qzmpDnn/cgDpm1qPqZuvuKSq1mhKgSfJQjNYWMhXsS?=
 =?us-ascii?Q?ykA+QRgVBO7wVXiq8gqW+FjOjXA1LaOBlzZIz0aZUORbeAJYcWQWsHlL464P?=
 =?us-ascii?Q?nBYP7Tzl9zvR4WP3bCvRGP2uoeugjV8X+3KbZGgBLah2qJv0tvDILScRTPHZ?=
 =?us-ascii?Q?XyA1DyMluURJESB4IQzHXY5mDJiWlJKX5CsYCW6l0HLphPvTkD78PbyKO2ta?=
 =?us-ascii?Q?ze12i0U88X1OyC1k64de7DGxhRp0DIVZ07DFjhTmAhLMImds7UoR3/dPRFAr?=
 =?us-ascii?Q?A/9kKSupRncfhMamsEDg7MknlkvgCa/BheZmxJ7bnGwDvsQMixnmQA+Bzxty?=
 =?us-ascii?Q?FpcagwaArUjoSC6ag4b7Aa+zMn/KrbWrQbEbdVunttgLNbsvBoHBwR4n9O9k?=
 =?us-ascii?Q?9Qi4NYA8wwymbj/q4V3y7cUFegaxNF7Nx4oeUEdJEtuu5baDk0z3S53OZOfE?=
 =?us-ascii?Q?SJzCffF/T4HeIV4HpDtN3y19R3AxEnRML0lzuCFnWjxhtTPyhzLwWu7aKVe3?=
 =?us-ascii?Q?h2HMbr5bG2BSzoAx55WWmkf9v8iSSCRB3jmXzhZVsRd+yJA8cKmmozfYZxvz?=
 =?us-ascii?Q?i8H5EhZqbp20h/gzbAsxQHROVwuklpXoOb2FtiJy1rZcDsOTFjDac9/Kpvs8?=
 =?us-ascii?Q?6MhxG63gEw0a9mU79V75FLu5Mxia29eaQHXZtA+cSds9KssQPegiv8WZC3fW?=
 =?us-ascii?Q?senDGfW3c9WPxZeleRn7ONOUuU+ZNmRtvGiV9Oj2CuYI2nikMp2/5ZjITBL+?=
 =?us-ascii?Q?eqaVbgA+2S76OmSRSbivW1WXIrum8Dk6/cvwr8xD2Odmh2A+yv2zrh7GG2Vj?=
 =?us-ascii?Q?7RB3oS9KoAcZft/hv3Cy3Cp0Pd/2iHlxAhINPFvBJUXs/mloRwWKHiWPzzkV?=
 =?us-ascii?Q?Phxabc8sBMkAO6vGAs2IDebXd42oE3gt6ogfsXWx+xP9/iqyZaU7LbB9Phjc?=
 =?us-ascii?Q?7lV4I9GaHhZLe2hUC3p/VXkNZFS+q1YJJGZrzVcgt8V7aZxjINj/QXBOIYId?=
 =?us-ascii?Q?m6CJTCavBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafb7d2e-3ddd-4a76-7781-08df43762f9c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 00:11:39.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dglVK4zO5Kj843fOw6vvVWBb73CgtRZ2Dn+fsFfi5bWeLX54EJnDhWwZhdXMePw+fCRgwvA4KN6cGiOesZyicg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403

On 2026-11-14 at 09:26 +1100, Tal Zussman <tz2294@columbia.edu> wrote...
> On 11/13/26 1:04 AM, Gregory Price (Meta) wrote:
> > On 2026-11-11 12:55 -0500, Tal Zussman wrote:
> >> migrate_vma_setup() installs a migration entry for each page it
> >> collects, which carries the uffd bit over to the new PTE. However, a PTE
> >> that maps the zero page is left in place without a migration entry.
> >> migrate_vma_insert_page() later overwrites it with a new PTE that is
> >> built only from the VMA flags, so the uffd-wp bit or the RWP PAGE_NONE
> >> protection of the old PTE is lost. The same applies to the huge zero
> >> PMD.
> >> 
> >> Once a driver has migrated such a zero page, writes and accesses to it
> >> no longer fault into userfaultfd, so the manager misses them. With async
> >> tracking, PAGEMAP_SCAN unconditionally reports the page as written or
> >> accessed.
> >> 
> >> This requires a driver that migrates memory to a device.
> >> 
> >> To fix it, do not mark a zero page for migration if its entry has the
> >> uffd bit set in a VMA registered for WP or RWP. The driver sees an
> >> address that was not migrated, which drivers already have to deal with.
> >> 
> >> The uffd bit can also be set after the zero page was collected, as
> >> write-protecting only takes the mmap lock for read. So check again under
> >> the page table lock in migrate_vma_insert_page() and
> >> migrate_vma_insert_huge_pmd_page().
> >> 
> > 
> > Similar to last patch, this changelog could be improved.  My best
> > attempt at summarizing:
> > 
> > """
> > Device migration replaces a zero-page mapping with a fresh entry,
> > losing its userfaultfd WP or RWP protection.
> > 
> > Don't migrate the uffd-protected zero pages.
> > 
> > Skip protected zero pages during collection. Check again under the
> > page-table lock before insertion, because another thread can apply
> > protection after collection finishes.
> > 
> > The alternative ...
> > """
> > 
> 
> Thanks, I'll trim it along these lines.
> 
> > I have concerns with this:
> > 
> >> The alternative would be to carry the uffd state over in
> >> migrate_vma_insert_page() and migrate_vma_insert_huge_pmd_page(). Not
> >> migrating the zero page is simpler, and a zero page that is protected by
> >> userfaultfd in a range that a driver migrates should be rare.
> > 
> > This basically force-fails a migration of a uffd protected zero page.
> > 
> > Wouldn't we expect this to cause drivers to fail to make progress if
> > they require that page to be resident on the device?  Not sure we want
> > to force drivers to try to handle this special case (if they even can).
> > 
> > We'll need some input from the migrate_device/GPU folks.

Thanks, I was halfway through responding last week but Microslop had other
ideas.

Failing the migration is fine - drivers can never *require* a page to be
resident on the device, as migration can always fail for a host of reasons.
In these cases drivers should fallback to remote mapping pages (eg. using
hmm_range_fault()).

Now if userfaultfd+device memory was a commonly used feature then it would
be worth fixing this as always failing would have a large performance impact.
However I've never tested uffd+device memory and have never been confident the
implementation was correct anyway (both features were merged around the same
time). So I think the simple fix is fine:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Yeah, makes sense. I can implement the alternative approach, but testing
> for this is a little tricky without the right devices... I might drop this
> patch and send it separately with the GPU folks on Cc.

It probably is worth copying other GPU folk as well though in case they have
different use-cases. Matthew Brost (Intel) has done a lot of work in this area
in DRM, but I notice he is already on CC.

 - Alistair

> > -- 
> > ~Gregory
> > 
> 
