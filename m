Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795065695;
	b=bhji2hGhbTS6YvnssOa+QITcC6b183OqtyCN0Ir37gpsMzYeb7Sx6uhBZafRVY+k1TXg
	 PVzwEmCo7dAnaGhXmGO4l/MClhKZjmX6PcjCqAVONx9tUEbyIN7yFILXPuBCtd4EMxqHQ
	 9/oCA1Cpx0t3/uiYtn1G8Ha472BmVbrGKxZ3/eY8+tkDaQch55cezV33c7kyrsJyyh8cI
	 oOpjdDIQoCOuiAOU6JLpNfZ/YIkZrsG5ANQqcbK2AnPkbxR2fqMPAaSOST5MhxMzZXTqL
	 S81YtYE7PQO422rj75ytk+9p9+Fh1pWMJumMprB+nTlCjFEIsW2uKSERY+oHmncB+pQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065695;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zoaYYQCuUVbjGG/R8wodiqPGb7RDM8IVtBVbXDU6WNc=;
	b=tKArBj7XxVg7+byzqwr8rrIhmHK1A8Th3259bNgVWk7m+zLK1R7qoOP14w9vT+yHjY+T
	 RGwCdem1K5/2dW1/mqSoqIVUQB4Q6lcG93kQoX/1IvkCS7+8djlsM3yXmVomOyC0pTY/e
	 Xime4zkNYXTI9LU5zee09tEXLO/F7dolD+1NCM4TpXe2jV84X+ouAqKv7UAUqs/VyCNtw
	 4yd4W4Dh2sI7gL0z0ZWFydjwcPoDDdJFfOU2iWvlYAig0Np+8W34NKVYq4QMPSnMCmWSP
	 ZouyEc8+umt5nl9Mo8xqG0b65yYtI+F+xFZV9GjwiaHuuibUHIIyUMIugWA9JtdwlKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ySPhb3sj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.1
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF4606A320;
	Thu, 19 Nov 2026 05:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00CF4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ySPhb3sj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFV+XQbbNdyOIlxu4tde5ugbaxYVfIApR8d1XsGVKQrBP8LuBpTNLLXVkMfpkbxt3LoQI+WVGI2QW9msA2PuiFg36bShnhQeCg4G9mVZTN8cUeG3Ns+jTYM4tJsaoOPfjrZn0ybJYxC12RHsVsl1oghnwH+T7Bb8I3lVmaIKo2h4/OsOgliKG+eK/fxQvTV5YyfTCPm8kse/o/7RBV2tRWlXyRo/tCg+uP7PXagNTWSAgXLbYqwNAuq+uyrSMY/cuOpJbzocYFIMgCjjXIedWLjVUq2HmSRY4GadBZ/qqBpcFuTg8+HrFzfV9cOoAI3GP76HyVU6ASgzWevYKUk9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoaYYQCuUVbjGG/R8wodiqPGb7RDM8IVtBVbXDU6WNc=;
 b=uTdTTN9Fx3008CTmER5xrkFzb5UTqpoDZRA5rLmPoCnLTFzcIoACK+F7TcU/ov0NJ1RlddEc+2GTr3oiVGhbuPAJl+G9zEYV+99jekgNGH9T8gYtIfneICGABFsznJrq0919WFioiqxk2uPdVam/tjL2v5UVUXU6/ce6dUafaG1ysFQEMdIWfvuUASyAeqC6Muaj6T9sSUSzJRcWZhkoTV6isXOuYhM3rFA5TmUZPc7fgrKK8+HSSZBPrKWwfH/mqGyFH6rtD7Ph91zZ/YRhsqvq55qZ29SEDa6CAu81Xw4AzKmOu5Sp/f586k6ph/W97fcppXL/uSuE9qBoA7gN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoaYYQCuUVbjGG/R8wodiqPGb7RDM8IVtBVbXDU6WNc=;
 b=ySPhb3sjntcRdbdgy26G08qSdZCu9dIxL48LxTN7t/ijtoJUVNf4ERL1TTt8rCxnxBBDWma8pq9yWJl00vI1qActJdDEjEGx4E6twWgZEZsKZ/5qnaPWditcWEpZO4/yM5MtcdDuzdorx68T5IJoC/4+7zpLnsvUw+K3cSaLP7Y=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.16; Thu, 19 Nov 2026 05:21:27 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 05:21:27 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "pfalcato@suse.de" <pfalcato@suse.de>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "chrisl@kernel.org" <chrisl@kernel.org>,
	"shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>, "vbabka@kernel.org"
	<vbabka@kernel.org>, "willy@infradead.org" <willy@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"youngjun.park@lge.com" <youngjun.park@lge.com>, "jack@suse.cz"
	<jack@suse.cz>, "minchan@kernel.org" <minchan@kernel.org>,
	"baohua@kernel.org" <baohua@kernel.org>, "liam@infradead.org"
	<liam@infradead.org>, "kasong@tencent.com" <kasong@tencent.com>,
	"jannh@google.com" <jannh@google.com>, "ljs@kernel.org" <ljs@kernel.org>,
	"baoquan.he@linux.dev" <baoquan.he@linux.dev>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH mm-new v2 1/5] mm: remove unused helpers from pagemap.h
Thread-Topic: [PATCH mm-new v2 1/5] mm: remove unused helpers from pagemap.h
Thread-Index: AQHddmOsPjUCzMWDv0Sv1xS7glE2Ibc03t4A
Date: Thu, 19 Nov 2026 05:21:26 +0000
Message-ID: <2b2042f2f32202fab77e256a2c71fa7963811ad0.camel@amd.com>
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com>
	 <20261117-unused-sym-mm-v2-1-2f845e94dd50@amd.com>
In-Reply-To: <20261117-unused-sym-mm-v2-1-2f845e94dd50@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|DS7PR12MB6168:EE_
x-ms-office365-filtering-correlation-id: 3f67d0f3-4fce-45df-84c4-08df45fcf5e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261028144727099003|261021123027099003|261026140227099003|921020|38070700021|11063799006|4143699003|261022105027099003|56012099006|10067099003|22082099003|18002099003|261009223027099003;
x-microsoft-antispam-message-info:
 1BghEY2JJglgC+lU8FMP7RQQRyDA3fHQr8eWvllz9DKLwkostfgvWyvmAW7fjuYVeSJKOlyJUC0uofI0VUh15FbC2LjqkmxPVkgG+qtDeHbgij2IypmNicdRm7bFwzKA/lxQRoaC70vKqeep2uP7AFLYCPZhuWRop0r8Ck+HnKp9qopfaFi6cwAyfSo+SgLf0WucnqQMlPbfMMnT0M0AXMYqu1QDcsru3qObDn2JY81rX5W+PMROjus+jzNP1tv/Wcqtx9uerD8a4rDoQgQEfYGk3Y8LyRJV/FXo5ohYXp2EKDnLtYWmBj9WaJyyi+Q2DSgoxOUzz9V3Vc9NGvP8hy3XsTHUkWt1QeRsy2eBYXBNi9cw6W1pTF5PzWRFxm2K5LUzpwNXO/6u5rsR96Dg+ZVfS1bO/y+k+lIP9fiQXKCzcPHWlIbDhXka/I3688SA3un0wutUjwXokrPbNJLWapEiXZhk4jhR/dmymvTTD2lLBxs4gT35GgJFzE2PL+7EKuGb5pqFyjP+5K6ddavhhfE31pMZDzgHcze0SJusw/ru7Q1J3Ha1wiOIvO/VGcCl2xV//DsnQeUnUnV+WFdl02rPPB2XzFSw1QsCc7U60IHW4ncrbxjYXeIU5d2Zd6V7BFXn3OZ9jASlbiJevHufCFg7AosydazH91HO0lE3eqkSst2eMDoiNma9XoO9mGam
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261028144727099003)(261021123027099003)(261026140227099003)(921020)(38070700021)(11063799006)(4143699003)(261022105027099003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z240dVRpYk1CcXpRQjlOMTN2ZmpqY0tMbUV3NjhYcnRaMVRSdTYrRGI0c0ox?=
 =?utf-8?B?akZnUDdRT1BwdnhhZVE2U0s3OGEzNWw1Z0ZrL29iZGppOWJpamJsTm1SZ21j?=
 =?utf-8?B?UnhpUk41bEJzQVV1eDBUc0k5TUR0NVlLazVmN1hVUjlpcUthMkFvTEpmUW56?=
 =?utf-8?B?aWorWEpqT3ZvNWdDd2JYaG1JM2U3dXAwOHFYV21Ia1VaNVpWRXp0WG1oN0VB?=
 =?utf-8?B?Ky9UbHdNT3VEM0QzMVNFMlU1VE1ZaCtkYjlsZE8rU3NjaG5hd2ZiclVTL1hR?=
 =?utf-8?B?S2hCL1IzaG5TSnUzVFQ4RTkrNUdYMkhxbStLaEgxaUlIRkcrR2xIbFBhK1VE?=
 =?utf-8?B?MkxzaUxLMEtPRitpeUZkcWdRdzhNVnJ4WDZseWUzMzlwcVVCQ0I1ZnYyMUo1?=
 =?utf-8?B?bmlwTjlvR3c0NzZiZk5rbUdEbzJ5Q0FiTkl1ZERTeC95S3p1WWpBcmQyU090?=
 =?utf-8?B?TzQrQTBlVGFwdTR6ZGplWktwNEsyQ2RaVDhoV00xeXpOQkt1REdUMTFsWkdh?=
 =?utf-8?B?VTJQRzBkOFhOeXJ5TGtPK1ZqUTZLZlpKM3VIdjFSZVNUU25HcWwrTURjOFJB?=
 =?utf-8?B?ZWJCSDRBYkY2QzhqU21wSi9sNXlBTE5OWjBnOG9YMmo5UUcvTmRtaVlFcDRX?=
 =?utf-8?B?STJQYWorL1M5Q1BRcHhsdnNVYkpVMHVYTkFteGtFcVRrSTdjRmFoSEJnR3RJ?=
 =?utf-8?B?b1UwMjJTRm5ScUoyaVVBcFJxL1dYM2F1VWwxS2xXU2dMMlN0L1NjbEd1OVVa?=
 =?utf-8?B?Q05tVjl4RGdqQTBvVjUvOFlxclRTWE9xOGYzQ29ESVNlcThnbWJEcXN3dURx?=
 =?utf-8?B?UWJNL1hsbUxEYTdqeU12ZUs5UHJNSnNnR2IrejBjbS9IQ3ZDaWpxa3FVSFVX?=
 =?utf-8?B?REdYZ05WYzJacWQ4V0swcFNBTkdNOE1Yak1SUjUxNGJRNVR2NS83Y1ZGaVNj?=
 =?utf-8?B?TGJkWkpjRTA2VzhKSFA5TjJsNi82WEdlSFpqMmVVUHVMR2Zlcy9BNk5kNnVW?=
 =?utf-8?B?SVFNMU1TNUIvSkh0Wm1DTlczVmhnU3U3QlhZSk56MmJSWUN3RHB0VjJSdWRa?=
 =?utf-8?B?elFtbmg2R0Rwekt2SWtuVFVrVThUNVluRmIzNTM5a3UrSlJGY2VUdStXZFhY?=
 =?utf-8?B?SnhuVDd5bU1FbzZBeXpSSG82anNXNTYwejl5VXJmSHVwQVFoSmpZdWUxOGcz?=
 =?utf-8?B?QXJSanN6SFNadDVSVFBLRURhLzlkWlA0aXRZeGJ6QmJZM1VCdTRzNmMvNyts?=
 =?utf-8?B?a292NFI4eG1jN0tPN0pyRnRNNHpzM0ZwL2VlVTJMMmlsVjEvbGFUVGsyd0I5?=
 =?utf-8?B?U3hCWWJOeVAxTWpoeEJia2tJd01xQjlvY1dWR05adFo5UUZVWUxYbFlGZ0ly?=
 =?utf-8?B?dHhCaXUySWZobnNZVGdBZHJaWXREUmo5MVNsNUgxOW51RWcrZXM1a2orM2Ra?=
 =?utf-8?B?d1c5MkkzWENVODFjTWRMaElUcjRQR1JBaTdienA4VmFoV21wd29FRDgvTDBE?=
 =?utf-8?B?aFJybXhQZHl1ZmFxSG1oc1ExeGIrc3M2eTB6OU9wSjJRUzhVNGxZdEkxTmxz?=
 =?utf-8?B?QzlTTFF2QjRWNW1kSFBQRzlGd2ROSlRTNWFwY3BHdkJWa05sWWtnS3YxeGgw?=
 =?utf-8?B?LzRBS09XWlRtNHJQQVlNVFU1dlQ3Sk1FVkZROEx0UDh1dnU0WWFjV1NJdFlk?=
 =?utf-8?B?ZG5nT1YwVUwzRWtHRkRrbE9GM3FkY2JxMkVKWlc2SXpkeUVJY0w1ZDNsV3l2?=
 =?utf-8?B?UEVNZ2g4V0xreUhMZHh0K2tGc052QkRQeHZPSXJ2a2NUc1ZWVkVQMGk4THN1?=
 =?utf-8?B?WEM3MGNYSmVSdndnWHpKWXZUZHczdXFlTm02REw3eHUzLzdMRHBybEgrSnRa?=
 =?utf-8?B?N1J6TGt5aGl1WVJObUt4NDFaYVFOUDRkSEhwWmV1ZDg5YktFeXZ2eW5RVnNE?=
 =?utf-8?B?Q3pZZzBnc1RCWFVUbDVmWCtWNjBldUVaQS9udVhTMmlTU0JYV1BHckh3b1B3?=
 =?utf-8?B?N1IwSlBoMmNCK24vZEtZeFp4emFGUjIxakhIbnZ3UGd3YUlnMm05aGw4TnNX?=
 =?utf-8?B?bkFTbkpEM2ozUVV2OXBma2Q3NHVsSVFjKzU5Mkl0V1VNSWx1cXpJS0s5WlVW?=
 =?utf-8?B?a1JHTlVnd0tZS1E3bFpsUUxySlZpV1JXK2lGMGlJT2JrTTljVy9xaUxnYlNY?=
 =?utf-8?B?NFBwMnM0VWIwUXRlZm9hL2ZXK04zSjlGekRpbGZtcjQ4YzN1SWpVNDRyeFBo?=
 =?utf-8?B?RXM5S2RjdHVGOFFuOGhOSFAxa3NKczl2ZTZaV0g4T2orU0JTTkZ0SlV5ZzE0?=
 =?utf-8?B?aHpSeXVEY0NrVDR5WityUit0U0p0Q28xNVFjQ0xMR3BXNlA5aWRnQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <790E148AEB89ED49B1602F3A93D3432B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f67d0f3-4fce-45df-84c4-08df45fcf5e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 05:21:26.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dodi1cmZg4heznUgcZQjRtK85PQfG7E6NRP/5aZ0ha9LcLLY9ZkZblqh0R5BvKi0uC1O4w1hPDHIewlO+4XJ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168

T24gVHVlLCAyMDI2LTExLTE3IGF0IDA3OjE2ICswMDAwLCBTaGl2YW5rIEdhcmcgd3JvdGU6DQo+
IGludmFsaWRhdGVfcmVtb3RlX2lub2RlKCkgbG9zdCBpdHMgbGFzdCB1c2VyIGluIGNvbW1pdCBk
NzMwNjVlNjBkY2MNCj4gKCJhZnM6IFVzZSBhbHRlcm5hdGl2ZSBpbnZhbGlkYXRpb24gdG8gdXNp
bmcgbGF1bmRlcl9mb2xpbyIpLg0KPiBtYXBwaW5nX2NsZWFyX3JlbGVhc2VfYWx3YXlzKCkgaGFz
IG5vIGNhbGxlcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGl2YW5rIEdhcmcgPHNoaXZhbmtn
QGFtZC5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9wYWdlbWFwLmggfCAxMSAtLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvcGFnZW1hcC5oIGIvaW5jbHVkZS9saW51eC9wYWdlbWFwLmgNCj4g
aW5kZXggNzNhZjE4YTM3MzY3Li5lNjgxYTdiYTY2NDIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvcGFnZW1hcC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvcGFnZW1hcC5oDQo+IEBAIC0y
MCwxMiArMjAsNiBAQCBzdHJ1Y3QgZm9saW9fYmF0Y2g7DQo+ICB1bnNpZ25lZCBsb25nIGludmFs
aWRhdGVfbWFwcGluZ19wYWdlcyhzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4gIAkJ
CQkJcGdvZmZfdCBzdGFydCwgcGdvZmZfdCBlbmQpOw0KPiAgDQo+IC1zdGF0aWMgaW5saW5lIHZv
aWQgaW52YWxpZGF0ZV9yZW1vdGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkNCj4gLXsNCj4g
LQlpZiAoU19JU1JFRyhpbm9kZS0+aV9tb2RlKSB8fCBTX0lTRElSKGlub2RlLT5pX21vZGUpIHx8
DQo+IC0JICAgIFNfSVNMTksoaW5vZGUtPmlfbW9kZSkpDQo+IC0JCWludmFsaWRhdGVfbWFwcGlu
Z19wYWdlcyhpbm9kZS0+aV9tYXBwaW5nLCAwLCAtMSk7DQo+IC19DQo+ICBpbnQgaW52YWxpZGF0
ZV9pbm9kZV9wYWdlczIoc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcpOw0KPiAgaW50IGlu
dmFsaWRhdGVfaW5vZGVfcGFnZXMyX3JhbmdlKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5n
LA0KPiAgCQlwZ29mZl90IHN0YXJ0LCBwZ29mZl90IGVuZCk7DQo+IEBAIC0yOTgsMTEgKzI5Miw2
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtYXBwaW5nX3NldF9yZWxlYXNlX2Fsd2F5cyhzdHJ1Y3Qg
YWRkcmVzc19zcGFjZSAqbWFwcGluZykNCj4gIAlzZXRfYml0KEFTX1JFTEVBU0VfQUxXQVlTLCAm
bWFwcGluZy0+ZmxhZ3MpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgbWFwcGlu
Z19jbGVhcl9yZWxlYXNlX2Fsd2F5cyhzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZykNCj4g
LXsNCj4gLQljbGVhcl9iaXQoQVNfUkVMRUFTRV9BTFdBWVMsICZtYXBwaW5nLT5mbGFncyk7DQo+
IC19DQo+IC0NCj4gIHN0YXRpYyBpbmxpbmUgYm9vbCBtYXBwaW5nX3N0YWJsZV93cml0ZXMoY29u
c3Qgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcpDQo+ICB7DQo+ICAJcmV0dXJuIHRlc3Rf
Yml0KEFTX1NUQUJMRV9XUklURVMsICZtYXBwaW5nLT5mbGFncyk7DQoNCg0KSGkgV2lsbHksDQoN
CkkgY2hlY2tlZCBub3cgdGhhdCBNQUlOVEFJTkVSUyBsaXN0cyBmb3IgcGFnZW1hcC5oIHRvIHlv
dXIgdHJlZQ0KDQpnaXQ6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy93aWxseS9wYWdlY2FjaGUu
Z2l0DQoNClJlc3Qgb2YgdGhpcyBzZXJpZXMgZmlsZXMgZ28gdGhyb3VnaCBBbmRyZXcncyB0cmVl
Lg0KV2hhdCB3b3VsZCB5b3UgcHJlZmVyOiBzaG91bGQgSSBzZW5kIHRoaXMgcGF0Y2ggc2VwYXJh
dGVseSwgcmViYXNlZCBvbiB5b3VyDQp0cmVlLCBvciBpcyBpdCBmaW5lIHRvIGtlZXAgaXQgaW4g
dGhpcyBzZXJpZXMgZm9yIEFuZHJldyB0byBwaWNrIHVwPw0KDQoNCkFzIHN1Z2dlc3RlZCBieSBE
ZXYsIGFkZGl0aW9uYWwgaW5mbyB0byBmb2xkIGludG8gY29tbWl0Og0KDQptYXBwaW5nX2NsZWFy
X3JlbGVhc2VfYWx3YXlzKCkgd2FzIGFkZGVkIGluIGI0ZmE5NjZmMDNiNyAoIm1tLCBuZXRmcywN
CmZzY2FjaGU6IHN0b3AgcmVhZCBvcHRpbWlzYXRpb24gd2hlbiBmb2xpbyByZW1vdmVkIGZyb20g
cGFnZWNhY2hlIikgYW5kDQpuZXZlciBoYWQgYSBjYWxsZXIuIEVhcmxpZXIgdmVyc2lvbiBvZiBo
YWQgY2FsbGVkIGl0IGZyb20gLT5ldmljdF9pbm9kZSgpDQpidXQgVjQgZHJvcHBlZCB0aG9zZSBj
YWxscyBhcyB1bm5lY2Vzc2FyeSBbMV0gbGVhdmluZyB0aGUgaGVscGVyLg0KDQpbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzE2NjkyNDM3MDUzOS4xNzcyNzkzLjEzNzMwNjk4MzYwNzcx
ODIxMzE3LnN0Z2l0QHdhcnRob2cucHJvY3lvbi5vcmcudWsNCg0KVGhhbmtzLA0KU2hpdmFuaw0K
