Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794998989;
	b=R8HVlg1iIk080CGoYb1xjFqo2LPTpFnKYEPrL6xyOKRF7r4o8Og7b/jNEvq8YC843hl8
	 tTTBpi9UBZMWeQr3rNR1eZp6mcV6J5IpMRfmOjxMs9Zwapa1Y81qzvYXoJS1xrv/NuWR4
	 Kbys/nACKokYCkbsZcupxjP0puO6GyFcIt7aJ4ZPQ7Kku8C2IxP+25vPy/pScGOD1TqNl
	 W9piKELUJgiBnjVQKFcfoVMMi54vt02K5NaT2/aXSYLfvX+UEVZl8J5fOg+rxdpScnwJP
	 FuNxspKRAdTiR4oRsnxXwsnoKaeC+gn34c6p1J/QDR8qtvTngBkNYmG3P1lcx/08Dpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998989;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=jJP4jzx1CoEXKP/A8XquhLGSt+0LVhvgdlLco1Ws30c=;
	b=Se3hfTXgYOs75JUeHfrL1lknE6YX1Yh3dCEUvDQ5yqeyMKYniX2ONhUo1tup4EsZ1d4l
	 K89u4awvM7Wg7WHxKTYuvQAicK3ifBbzdpOJAi+udtOTmPLNtq6726gtj8Q2wUXTJbaro
	 bfo2qBGbwmqajkaRzlFEZU8P2ryFMGqvuXKkcCWDXHlhkF5OowzcosRubLzoF4IySB1p9
	 cYfG/3B6OYuc2VWCFf4a0Jr5wAiuwJkS1XMLAoZMhc9HwbVU1loKgCxcVztF4LRWEzq2R
	 XwmeQwCRJ0yvlcN2maVYUxg7DUg3jnhg056wo71vwGCASOjA1vU/Q+UovIFSjblF6KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=GAddrNYX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.98
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020098.outbound.protection.outlook.com [52.101.195.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CFA606A333;
	Wed, 18 Nov 2026 10:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67CFA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=GAddrNYX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZLcL9kqjxJtRfRqI7o1QH1b2ZVwoDCerlI/CYnUmoL9QQOFEjQtgfETm4pNKLQqPkZ972AHddW7J6F6JtDFPdrdsiTRs7MIbgfnHAiA+d6jvwiUsv8ptzZH3rhN4yFNxREXNPKfZKYpFrYF37FzZto/KBxNdSA4O+FHJ6enfTgLnQhhfmW5UJasQseMhMiHVXvVDQNZXWLGPGYGk//xf2Mn+IZaXXr+Ne8bCL79OKNbWJYLbHKBA7/13LyMeqPC8FY+fM3egdMQmawhJk3SuUV3Xv057dbNzKeDF57vpY5q8IRHqXrzzFdgTfqpFq+rpXouGqBuEFIzcvRXblDsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJP4jzx1CoEXKP/A8XquhLGSt+0LVhvgdlLco1Ws30c=;
 b=Slx5KnHeryzsoCc3b9SuWLdowfxX0cV2/TOHzW/8iv183kWRU2B+PDI04ls483+LkJbJQ0fzKdruiOteNvLaBe60JZiHttR0xyV+CJA3tN2gUka8kdORe0Je5ra3lcQEzIylpKxdGCe9UNP2ULVZmOM7D9hRM/ihOz6YDOrQP7XKQXis0suPgu0PHizKjvFE+hlCfWrd9e7hpbuM2bpd9MezGzjOoF6UFfs6+Fx/RqZsJz7LbMzP/Kc9DB1nhwzk9RRIZmSKqtXThKJtKhAghoPszP9KQx7lv5nB0otnz5YrVD0gMeJ+C57BmL1k4jh8Fj6gQGhe4h9SQ2qpWT1pVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJP4jzx1CoEXKP/A8XquhLGSt+0LVhvgdlLco1Ws30c=;
 b=GAddrNYXKFcp2vE+MwlS+Sjl+5bgE4mc4IjVpsAaTF2e2R9j210mH3HmccWKosqQXkznUG03bqn5qhIi7GGAxL3JU0Zvc2MxYCYwhicvyKSDgOco7mgOx2MItgWfLF7/LPWG3kPhCUtftOfocmte4ZS78vOa6gmhTgoRWRnZFAo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO0P265MB5653.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 10:49:46 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 10:49:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 10:49:45 +0000
Message-Id: <DMYA19YYRRJO.2KQF9PAODA2DS@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <aliceryhl@google.com>, <lyude@redhat.com>,
 <daniel.almeida@collabora.com>, <work@onurozkan.dev>, <ojeda@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] rust: sync: convert CondVar and PollCondVar to
 use WaitQueue
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261117001507.1611984-1-dakr@kernel.org>
 <20261117001507.1611984-4-dakr@kernel.org>
In-Reply-To: <20261117001507.1611984-4-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0463.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::18) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO0P265MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8823e3-93b8-4b2a-d574-08df4561a8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|7416014|376014|18002099003|22082099003|261009223027099003|921020|4143699003|56012099006|261026140227099003|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261022075727099003|261021123027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	/eosXtlvjTwiEv02eHFuGyAXPmap1BeCD0PIkM/hQETWEekHqqaYPqxTRRPc3+bFw0GWF5koW1q48ZZIleES5IOmk0VpAftKJqzcma32sSbhnc+VaFZx8j7/nf/qOS3vKoPFpNxA7wdusOu765dbA8y0w/+XuUBB9XospLqdZnjIYGGlQXq7NH+ja9v2lUhKrRqrM5hB3b72AyTDvjr6tgknmYXchr8ygRMeTtV5L3d/VueukhvSlxZ91S7WxsGK2ITnOnyQwV+/0CB2zO1M4pIvJN/DSvuqMYlWFJt/p3z4y9BOlI98SAuqxJmxLfmkOP/lraE34Cb1etuNljm2/F5XCOMDSejrk5g+VKhvsDTGyNfuPDLUckMN9CQ90jwj2gk+Awisusxp4yINJQ2Ck1+dbvuvlM24mQsZDogTuE523uehw5q2l+JyYClEeGqHJMKOIuam2bCY/7Wjyrzm+KNc0owfSn0tx3fJfO+kl/iatyItnmOGMCpJwSH6tWvVnvLQDXmmycR8YCAA1fsO4PFu2C6R600506KsnuxTuOiPzlErf3SFSdVv971/YDjWzb0sc/nQFGk0H63MARuHXnkvf2WtyIGgmtqQermBKxT/Zt9wrboIlxlLl8MAxdX2fVqUjEo0QTiT2B1QpfpkY0+3mpkWgu/aaDH/GqEpkEhpm4zpKYGZODvzx/6mwUr8dGYmyTxy4/F779HOE7BFCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(261009223027099003)(921020)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261022075727099003)(261021123027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0N0ZUd6MGFRQ24veGJBSXZ4bkdSRmRmK2lZSXhsMm80c2Q2OExmVUVqR1Vx?=
 =?utf-8?B?U0xFTU1uSnF0VG56ajZmeFJmZkFpVFVQNS9wWDhmRzhKWi9XdUhaUjhWUERB?=
 =?utf-8?B?TFdKRU04UWhuTG0xMnpxdThLd3VFOXU4RHB4eGJyVG9VeEJwRWd0UlBNYkIz?=
 =?utf-8?B?ZjVvc0Z3MmJlWUVlOHZITURGWVFrNDdMVExWWWdIbDFYL0dSYk5mYXNKTlBK?=
 =?utf-8?B?L0krSEVoLzRXMUZsS3g1RTN4ZHVSaEdUS2NxNjhvYUc3Umpzc2sxeHJ0RkVr?=
 =?utf-8?B?dUdLMlcwTnN4T29UTDRaSHBlUnhEUFJZaUd4eXFrMEFlRDFYQWM0L3VrQ2Jp?=
 =?utf-8?B?Z043WkQrK3AvMUVHajZZdUV1RUpxRVVKRUN0bTdKaGdUZEcrWkhHVmF6aEZj?=
 =?utf-8?B?emNyNVdTNWtQYlhHUjhEV0lMMkVLam0rTjlUWEVKUG9iMGZDZXprbkkvaVdM?=
 =?utf-8?B?NGM1YlRaYmkyNzFQVXpHbXJKZmRicU56clBneHVIY3g5cnpEbjA1QlpWNjB6?=
 =?utf-8?B?S0ZJcWY5d1piMFF4aHovYWxXUTJtTDJMMjNQWFgxbEFzaUtQTmNJaWViTmFY?=
 =?utf-8?B?ZXR3VTBYYUVSZUxBZjIrcDFkWCtkY3grekhDSnNuTXoya1lJSE03RjFOeTJ1?=
 =?utf-8?B?TytaNE9SZGF4UmpoTXRVaHpaL2c3RkxDdEVuZUhPOFhXS3htc3dTd1ZLTjAv?=
 =?utf-8?B?aG9JSjkwb29zVFJHS0p6aDc3cTBNRDJXN0xib0EyVFpKM3gyNlJwZ3JPZmZR?=
 =?utf-8?B?dWtpc1pJU01kQmNZY3BvQk5BYjR4aHAxTWM2cWw0WHBNVnVZRzR3aEk1ZWZq?=
 =?utf-8?B?MWJoY2Q3ZjE1aVdaWVFRU0M2UkkxVlJlbFZCUjhEMDNLNnpWR3l3TTFlMFBV?=
 =?utf-8?B?VUFjR1J3cUJhNXFJVlBvL1BiMmx6aWJxZ0NOaUNrVU80dU5VVGdBUXlLaGor?=
 =?utf-8?B?TXhURk5pd2xIMlJBUStDSWpTL1VGOEovczRrY1VvZ0trTjI2UjYvcDlkdWVN?=
 =?utf-8?B?SmZJN0c0QU9hYU5KRjlvcUxDT2I2OFNrM0Z5eExCb2s3ZUszWkVSUndWdEF1?=
 =?utf-8?B?bzcrQ21KNlJIMVI1WkxKSGo4a2RYTWJaa1V0RmZKSFFWUzZSdGFYU0U5dlRC?=
 =?utf-8?B?SEEvVTFzZGl2MTFOSUI5UVdMVm5lZWRHZ3R2WHcwYTZnN0RtQlRMaXBIcG9n?=
 =?utf-8?B?R3E0Q3V4UDRPMHZ5cG84K0JKQU5aT1doalFMTldpK1NUTEo5ckk1UjBRQ3I0?=
 =?utf-8?B?d3E0ZHE3WC93U3ZrTDVwa1g4T2F2c21IcE81bmhKK2N3eW1pUzJCSXB6dnA4?=
 =?utf-8?B?MGhPclRka1g4RWlHb1ludW1IcE1OekJPdDcvTk1XUXdUcUpHdjFDbmpiNFlC?=
 =?utf-8?B?ZWI1QU1mdWNXS1dlQ21HVWZSNGRqUFpPV0FaeGJRZWF4UXNGc0tBTXNCVkEx?=
 =?utf-8?B?WXB6UGlTOUd5K2t6RFJvUnVxcDZKemxheXhoVWQ2M1pMRVgyb1hWUDduTjlJ?=
 =?utf-8?B?MDNCNzNEaGVrNURtTjR6WHN5VWllK0NLN21wclM5MFl1dGoycUhxUTdyMm9M?=
 =?utf-8?B?clhFUVE5U0RNTWVYRXVlS2xnVUpYNFFIOEpPRDBZd1dYVjdPdk8ycStmZ2xK?=
 =?utf-8?B?RnB2VFZaa0xaVWNuWXdzYXpHbU14ckxFYXF5TTJ3SVlXT0gxaUI0K3VENEJO?=
 =?utf-8?B?ZkZUZ211TE1Qa0JEbmhOYUl5d2E4eDV5Rmpjd2V4bWpwUGlDOU9SSzRXL0VR?=
 =?utf-8?B?RDhUNlRUQm9KUTJ1L3ZjcU53MzE3eUllTlRHNFYrekZCNG1JanVwNGpjZVBZ?=
 =?utf-8?B?eXZYSENLZGxLdkNSUFp6cWpnTkljbFJ5Q3pRckV5NVJOQ2hzZk1ZcGd3V01X?=
 =?utf-8?B?blFTNmQzSXVPQWt4d281UTdzbnF2QWIvVERZdDNRSVp0UlNMQjZZU1E3bm16?=
 =?utf-8?B?aXFkOXpuRC9PYjVUb1R6WmRmU3IvUGZOTWZoNG1VdmxHMWt5OFpRcjdMZ2VB?=
 =?utf-8?B?TlUxSDZhVnRsaUxuUE5xU3RJYkdEUWxFK1pseUFhNlVLb0Uvd29ycWdUaHMw?=
 =?utf-8?B?Z1Fsczc5NGV6Q0cvOU4xSzZTSnAzbis3Vm9LTmJtTVV1eG1tYUNHbXdaaFh5?=
 =?utf-8?B?eGY3QlVuelZJelNMMFBvM2JHZVZNYjZKSDhqd0FQeTNxazBhMmE5bzE5OWZu?=
 =?utf-8?B?RkZtUEhoWWg1RHhHa1IyblFqZnJjMy8zb0JsVnYwL0ZBMjUweFc5TVVVTjdD?=
 =?utf-8?B?UGFFMlVDeng2K01nMEpja21HTGt0YVByVHlJTThxdFdmNDYrQ3pjamUxYXUy?=
 =?utf-8?B?UEJYKzdVQVBKa2IvQ1pzVDdvdE1NMlZJdUhRemxUTnlobnZxQW5rZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8823e3-93b8-4b2a-d574-08df4561a8fc
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 10:49:46.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7C1/ZdvidYk9wV/NnfyGsMajNNfX3sNGj4ZPvdlkpD/GxZKL4o3ERFss26dyJtfhLQZgtQsDn2wjveLfa2estg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5653

On Tue Nov 17, 2026 at 12:14 AM GMT, Danilo Krummrich wrote:
> CondVar currently wraps a raw wait_queue_head directly. Now that
> WaitQueue provides the same primitive, convert CondVar to use it
> instead. This removes duplicate init, pinning, Send/Sync, and wake-up
> code from CondVar.
>=20
> Keep the wait logic in CondVar since it needs to release and reacquire a
> lock guard around the sleep, which WaitQueue's condition-based
> wait_event() methods do not handle. Use wait_once_exclusive() to perform
> a single prepare_to_wait_exclusive / finish_wait cycle with a
> caller-provided schedule function to implement the lock-aware sleep.
>=20
> Adapt PollCondVar accordingly.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/condvar.rs | 89 +++++++++++--------------------------
>  rust/kernel/sync/poll.rs    | 19 ++++----
>  rust/kernel/sync/wait.rs    |  2 -
>  3 files changed, 33 insertions(+), 77 deletions(-)

