Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677597;
	b=igmRZZ2JvgSPtM/3tqZe5YPm5lEwsSPbxPPUE23M116HuWGUiCsNAIBE8ZNj3kS8QYXu
	 w+dOdCRvRKDeTuFvnd/pqOEY2OLZfv6iE91ycpgKTR/fP+qtHFUZ4aBUEeumpshKnThVg
	 FJSUMpziveVc3n1wWb7MTIlxfxEAMLNZElSi/IuMJtG8/Vs0LIUeXLGOiUjIt2h1ro5dr
	 XsY4zdSwjqhno9NWdHjLhKYNHHkWbYyw5526AMUDJKeSB9sPTVmkkMP+MB6r5xkJE2MTu
	 3FjZphkD6olHPgSr+unBDaoKwZ4zGVdGsvU+aeQWJfznyYMbCVFFKFG/1TzQ/hQ31zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677597;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:To:From:
	 Subject:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Pyxe9BJ4trPYIv57AxgZqUysPagmUKFnFPYKXnN+IKI=;
	b=SgfHSfrhGmwHkUPLgVQtR8LJpEFIvfIKndGj0WmynLxCdJxKx0y8vPVK+F/DyLWc1exw
	 18FmICL7+944W78UhxmqrgumO1fLc6C00X+zfQGj9Sn90GmDGmJQypBM5aO7+qBZQrVcO
	 xVSR/O3Xm6oIC9QM/AmjJ9GX02fnN3tu8+fthMcT0m2r5WuIkb4blBn1G3yxlB/cx8tZF
	 exfAX7lUKX7jqYyJ0WAQqq1Kpubilh60+jt6pS8lnD3+lVctDYSZ7fUQJn/RDnVyEJVxm
	 4PENpmadzKpBbftctzYvnhQNJGFOhBzdDGjPTdcPLbPZvx+WvgE3o2YqAhD/Z+djUfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IJ2eXeYY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.9
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE60C606A329;
	Tue,  3 Nov 2026 03:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE60C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IJ2eXeYY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYkRkuH6U6yB6e2FFfx8BDCErhmWn3S/HwbFDP/oAkWt2itlCGlZo5PVRsy2jDibodC3pmgd0vkJLWtFQzSO8XNGc34kdJ+RFU/8dEDqju3Wm5LiLS0kt3HHl0oe1KPWwniuIgXjzuYkpJAIEm7qnSCR4Y8HmOAUD3RnMJOxFXhznvVkZWsAEwQa9scWRt4S87jYxcPZYqhTrVPyhje0aGkc4Kc1LoVQYYD8UIGCKWzJ9k9IbO3xEMPDTeN2fFdcqlNI/yY4DEdG2M3IJv3QkjjWOtGmkuWrOWXF+whDN4phY0VcsxJc03z2X+423evwbSzDSUrK6+lXCoGz0g6c2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pyxe9BJ4trPYIv57AxgZqUysPagmUKFnFPYKXnN+IKI=;
 b=fIfZllZZRBmt4HHJ6pgD3Fs3joiAg0il5RAAMesjjSFbopWanxSSE+UcfPrs7bN9m3kNT9/hZ7IhkxIg5nZJUfD62HK25OyhSosJicrRJ8jN901+yJQDHXQrZrK79sXNBGcM4z5Al7wULGaXfNkdHKiYWh/QcljMsSaN2PGScwn+wgL26SSTEl4UD0FsFo8BI/0KuPnSAFmlRsygzy0SwV3kD8mCUnM9hHls5xWR/P5FCVxRn3sX6CAc0yXk/L3j5jr19HjLzP0O2afN2MkVMhiDPEbm9fVHh7g5g4b4+hg2Dt8aSQBAPno5Z1YY+H7ROIj/QZkKD4cR6k5+iG/0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pyxe9BJ4trPYIv57AxgZqUysPagmUKFnFPYKXnN+IKI=;
 b=IJ2eXeYYQTBeMRF9KmfPS7uadxDFyH2BDQUx1RwZdZ3AEYe0PzkOU726FvI8juIWKwMuIoORVYyD0YfStFZ2V+JJBVA3GIsRiGBk/u6kXFSAYPxqOX7AyvW5TvN70WS2I/CVG5QeCVd1BLwx+yCUSvFXEeVQFxIWKfYIx4qv8c8OQ+CG4aT1jyr0hTFAmPRGb+sNY+nHaORV5hdVMK/Eh/C3eNXTXyikCNFS0QYZPjQbuicbiS+KS7PaWjxCV8Sez3zONeLoJNQvU+u/9cA63GGcstCi7j44mwfH3PsVFXL7EQbQ/In3oTb9FKIdKWzjvFW2R/lxj2kSah5qcp4SOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Tue, 3 Nov
 2026 03:46:31 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 03:46:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:46:29 -0500
Message-Id: <DML9N19HM19L.1PDQBUPSX3RQT@nvidia.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
To: "Tal Zussman" <tz2294@columbia.edu>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "Jan Kara" <jack@suse.cz>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Byungchul Park" <byungchul@sk.com>, "Gregory
 Price" <gourry@gourry.net>, "Ying Huang" <ying.huang@linux.alibaba.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "John Hubbard" <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>, "Hugh
 Dickins" <hughd@google.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 7/8] mm: remove read_cache_page_gfp()
X-Mailer: aerc 0.22.0
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102-page-wrappers-v1-7-e7280bdb31f6@columbia.edu>
In-Reply-To: <20261102-page-wrappers-v1-7-e7280bdb31f6@columbia.edu>
X-ClientProxiedBy: BN0PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:408:143::28) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 028be32c-986d-4f9b-26fa-08df395d0c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|261102123227099003|22082099003|921020|10067099003|4143699003|11063799006|261021121427099003|261021123027099003|261022075727099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	AORhaMLXjpWKlYEmd0U+iVMOqNuQsH2jZEuvzFIOiogiYQpmmdMXfyC61+1DBX4a0ookr85iEvUQNo6M8JrzJ89wUfHm8PkURwTuVc12K682aVgnQF2koiKbepIi8DBU04IE80jM+IvxHytT7xspUTd2fQbjXjvNMfA/DiEO5vEp1OdTPST8HwdRpSh91xbw4jA8X0vs1CWpT3xdXvCg5kIkIOIVoT5sGZY6QPP6ifnDG+iyOGtWR9O6/F/My5f5Rm/jeDnzooVdxt0LWFHvmWTxurDaSsUuO286HyeM8hSFMCb40MWe7bnh3MV1G4ksgojZ0UtxQN+wHRzKpJ/6Oq5MSGEgLiw+aishfyTw7bzdgyCAL4l/bZUncY69LeDMALezTgq2+X0C4SR8quVZ/f9zMg1xv+wGB6T1205qp2IoxHh+pi1Q1KlpjnEiWTcQn797N8n+HPCAsZhRhEsCyfy47Xr6ZNS5yduHKb8U2+2qUAhBfbu87YjgloiDsB87KnjiB0o5SjVmXYHQTQ1EoG5en00Ie+YvAi9c2BjctgSN0r/ZtAC4Hn/Syt+U0Oa8EmvaBZCE0D2o5ZL50+TNQwxL2oclEocYZtKE7/+Tb5B/MD2YaiuFu3uLYwj7CdjVmrXrH9LD5Kr58W7ptjLrqx8RV8GSXgjaLYZg7zLMP99coksTfPWZcBR4Tijle7VK/G3i/bBKI7b3FrKHpko04g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(261102123227099003)(22082099003)(921020)(10067099003)(4143699003)(11063799006)(261021121427099003)(261021123027099003)(261022075727099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm0zRVFwMDFZVDBZSDZER0M1STBRNE1BQXNnQkRrcmdSVUVMQjJmYkZrd0FP?=
 =?utf-8?B?d1o5QUFPUWo3VjBkMnI3d0l2SXRVem1LWGNZWHJUQkdNN2MxaEQ2MzQvQ3Fs?=
 =?utf-8?B?RVRvNlJYMHFHU0pFWnJna1U1Q3RVVk4wbmc1WjNmMFN6QVpTUE5vaXFNSW9n?=
 =?utf-8?B?d3AzdXV3cDUwSUZQVVU5Sk13SFFHZWxVMGV2eWkrMitUVzd5NmJVeUtIc2xL?=
 =?utf-8?B?WEFuVFNtWmFkS1VEYS82alByZWNhMElUVjFLMkRVdFYyN3p3aU1KQldvcEts?=
 =?utf-8?B?VHZyeTRGS2tZcUE3cmNxT2RmSlQrNHdFSWRzcGFpdkwxbWlGSGh0bXhtR2d1?=
 =?utf-8?B?S2Z4SVp0dzd6VjF1RFlha3psTXR3eVI4RThjSmZxZ2JmZmZ0czFvb2t4U0tO?=
 =?utf-8?B?K2ROQkNxc0lJYkxHK0VEOFFvV0NvYkZ6SUV3WVl3N2laYnNYV3pDQnI0UWJ0?=
 =?utf-8?B?Qi9LTEtsSFd2czVocnBPYzdsQWFQa1NuR2xpMDlpZ3ZLQ0ZXTGR3cDNwaW5J?=
 =?utf-8?B?WXhSKzY0b21WaTdyWC9STGxVWm9SbW03V2VXQ2N5TmdJcXp0RndxaE9MLzBH?=
 =?utf-8?B?YzVmd01JMHFJRHgrTEhka3FUWHlIZkJmZWpxN2w3M0ZUSCtmckMzK0Rra1Q3?=
 =?utf-8?B?WFowcWdNUllONFRhaEhYSTN2YkYraEVCb21CMnJnOUxDL2p6YlhJNzJXQ25F?=
 =?utf-8?B?enorSWxvb2tvaG8zaGdSWUVVWnBNVjUzWll1SUdQK1BpVGlMUU83SFNaZE1i?=
 =?utf-8?B?bE02TUFnT2dSeGd2YUxpdEtsei9aZ21RWlJPSGdHQVdXanpOdkt6VnlTUjBj?=
 =?utf-8?B?OFR3QmE2Sm9mSk9iTGRzVzF2YTNUTnArV0lIbXdFQkprbnJpVG94K3BPaHcr?=
 =?utf-8?B?VzlGaHdKTG5JZ3Z6MnNBYzM3cU5ZaFZLdzdnSTJveWFNM1hTSHJPeTk5Sml5?=
 =?utf-8?B?aFN5YXpSenR5ZzlZZlZzbmxNR3ZJSGk4YXIxbTBtRDBiWWVJQmJ6K0dnNndJ?=
 =?utf-8?B?OUZBdlZhUGlzVUVQdXNwRUQxUzBvazJYTHBsOHl2RHY1dW02ZTJ4dHQrdzAy?=
 =?utf-8?B?MTQ2d0FMMFBqc2luUkxyaGdIOFVwMEJlbzlWQmJaTVo3elE4ZW4wVXdHTTZ4?=
 =?utf-8?B?NUE0ampUUEwvVFliS041SWZKenQ3NGxwK0tEbnI2VXFTUTJDU05Ga0w3ckdO?=
 =?utf-8?B?UXYyQlJxTEdlMWlNaFNoUHlKZ2Q4MTE2VGh1NUNzRzgzVW1jcDltUXgybHB6?=
 =?utf-8?B?UjJ6UUFiQ2NFOGVLNXcrbkRrWW5zV1pZM2NwWDJZdWl5eTRzU0NMNHJmR2Zv?=
 =?utf-8?B?aWxQaXR4VGlYNHhXS0JrM3F1ZW9PWHBWaTFUd0tDQm5tT0gzT3pyQy8yZGh4?=
 =?utf-8?B?cWRsdkdML210KzVCeUV4SzBNdUtGK1Z0MGNKTFVOQWtWNC96N1MrVXJ3REsx?=
 =?utf-8?B?NXJ6V0pkc0d2a3VpQWZLeFd2QU1oekZMN2NONFZsM0FpL0REZHY0RUF6d0xZ?=
 =?utf-8?B?czlEMjlzMnJRRFNaL0I1R1dGcXpOQ3FZUnFFQVlMSC96ZWtnblBWRU96aHRw?=
 =?utf-8?B?VGFnN3NRK09EWU1GQndOU1E0Q1hWZHp1R2U5MGhrVnJDb0xlRHZ6aXVxc3Vi?=
 =?utf-8?B?dnlCSFhXZ0p6VGlqcDJGYktrZXh3MkpNbFI2VXJ5N24yZjVjblNVL096Wmty?=
 =?utf-8?B?emxNSlczTzVJTXQwYTNmRjBqZDZhTENCc2NMZERBSW1pdzI1WTdiakNVNHBO?=
 =?utf-8?B?RThFenNOdHV3MHVtcUd2VzRSd2hKeVJGZ2RaaXFJS1BZaEdnTnhuQmZyVVBT?=
 =?utf-8?B?QlRmWFBCV1RjMVkvZGxhZVoxSStOMnRaaTVzaVNtNk9KMVkrcVIyTi9wSDZq?=
 =?utf-8?B?bjBDYWU0Z3VlQS95QWpaeWlmUzViMitXSFhJaEp3YUNyaUVvd2YxMnFCQWY1?=
 =?utf-8?B?SUE2YmZ1czc1WTFDZE1WaSsxQTdvM1R1b0kxL28wclFMQ0VJbXNNNmp6eThM?=
 =?utf-8?B?Q2N3ZDhndVRJZkNrOENnNTZkUUtiU3lHaEFBTktCZ0xUM1Y3UkRIbWhSQVli?=
 =?utf-8?B?STBuYVFJbzhPV3JiaC9rd0thcHJuSVlscGNPdkdkV011WXRJRWpsSFlrbGQ3?=
 =?utf-8?B?WVhacjYyK05seXVkdVBlV1JrYm9zTGhGYzlTMkZXRTd5ZWRhTDFJSVFVbnhD?=
 =?utf-8?B?cnRLRkMwMmFONXBiT0FObW5hYWhCYVZqWU1xVjVlZW51bTdELzdYMGhEL1R2?=
 =?utf-8?B?NTZsazIzSFUvaEdXeEpkb1ZadXFVcm15NFNKS3ozQktaS2NqcUNwaHVhOFhG?=
 =?utf-8?Q?89HJsqyS+s2dVuHcCt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028be32c-986d-4f9b-26fa-08df395d0c66
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:46:31.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYMWpGRI+Q0gr8kfZ5SFVJ7OEU2tZCK4iDXcqe7C6ylp+X4ToGobAOxkp9D9qe+b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

On Mon Nov 2, 2026 at 5:54 PM EST, Tal Zussman wrote:
> There are no callers left. Point the comment on shmem_read_folio_gfp()
> at mapping_read_folio_gfp() instead.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  include/linux/pagemap.h |  2 --
>  mm/filemap.c            | 23 -----------------------
>  mm/shmem.c              |  4 ++--
>  3 files changed, 2 insertions(+), 27 deletions(-)
>
Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

