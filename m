Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ADB35949
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010296; cv=fail; b=ZugFzvjbsTM2P4uczIl59OP8pDhU6FMFp1b32HcQ9I/n+LnYUIURL7KeZScJ1fHU71fMJ0oSZnWub5yIiygq8oWAlxFyfOwujG009PsOCts1hJ/AzRXOP9M+YTvjP4PxUf81FvVRyYpygrQrzoJirGG9yE9abDlpicVknA+b07Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010296; c=relaxed/simple;
	bh=BlwQ8Ahgfh0i9EtiQl7m8daQ3ditaB3p9czAi9LknqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sqvTGS0hNdjlazpYEZOj87fHP6ZvxNE+oSIaQ5IVwT0fMvgUrTIQICJ+kwdk6ISxNIDTerkHpPQUg3Jo/f0Fjr8piwWyL2WCO2+3m0RwXmn2AHpJLPe7pvZ/dfDJBeoDactdrrDqz/iZpPsL9EMokpE6Ki3240zzVgjMPGOacr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Y+brAL1M; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Y+brAL1M"
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6311eupg3065930;
	Wed, 1 Apr 2026 02:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=aVZxepi
	n6fTmrqHl6+67owwXHp+De4wafVE3kiHAeys=; b=Y+brAL1MBguqrZe7E1jjQC/
	6w9YIGm3xiNvzFKVXz11UDXLYnGtk7IxuswnSfNtwOTvp8tEugvXrSavSVWrKpVP
	uwuxaO+s0AelpA0/qdWPhCbyIdXBgDXIyWaAtmuhvxFcZhdxKPzQTM9afXz+sVM7
	XYyg4mRznqygzD9TIb67iJ+/OyP4DpPGZm/fUS6ntRuCNoaQPy2WMDtQSMH1hZWn
	VbYM7UoOsiixZMrIQcItMTVhzffB2KnTfob1RdYHnpKPaxackjboD6sTMsSf24gv
	sl0Q8Acac2j+0Au8PBQkCYLJuxMKHSqyCtRvQLRwbxht8Ju7rPPpc7vfrLtDVIw=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012031.outbound.protection.outlook.com [52.101.126.31])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4d65s0vbuh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 02:24:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTJOrWSoqvbv82lO8GDd9btTiu5Zp8TxEN7sIkfS9c7k574fgoSHOckFzniCVlIPt+NYcA/1/SgLRfVNqoC8c3Op8Xnt2XwVqasOnJeMylYcbJcQwPi2KOlRb2Ldburj0Pt7Upjo8zcoyrRP+qblazOZtvUwwvcHDlsdA6VyjUFmur++FbcokhooTD2uFeg/v/WoJcJOr0fydiI0m6A6T2/IxpSWODqCU6k+3n6V5z9p5p7zb3upO0U8lRYrCgaI+eWiVDw1jO3garRruIQ7fWldvkRVkpwnWpHnnRTxceYFE2bRecBBvw4WKM2ljR9ScO5Tv5hWhA5LwpgFwStQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVZxepin6fTmrqHl6+67owwXHp+De4wafVE3kiHAeys=;
 b=aRMTeJHV6myw3n9dM3LP9WjJ12hnHtrE/m1Gx9VHJtJRtHEALtypSg57/xnOAsC/s/HVSF6mWtl1MlJl4Ihy1HisIJpf3dua5lrbssKDyNYwha77h6YSR0sF+aA4mNA4skEt/qeFI3s9OKRyBPOP2qLwJu3QHP214ufcWZ65v8zNzWpRh+5JZzvzPFplur13yG/m4lljSK+UXFxJVIjmr+RhE/VGh0ouqDMeEXjbP8+y3+Pr9lvo4ypopD8eU1RscvaNjumiIfCrenC904evogeDrDs+xNbrX3SQFTLffwvpdqJk9/KuNTyCx14ohue0j8iaFh730CG3SNLQ5+Dpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYQPR04MB8996.apcprd04.prod.outlook.com (2603:1096:405:2fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 02:24:11 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 02:24:11 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "anmuxixixi@gmail.com" <anmuxixixi@gmail.com>,
        "dxdt@dev.snart.me"
	<dxdt@dev.snart.me>,
        "chizhiling@kylinos.cn" <chizhiling@kylinos.cn>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/5] exfat: add iomap support
Thread-Topic: [PATCH 1/5] exfat: add iomap support
Thread-Index: AQHcvRbfxLOqOW72bkCmVZkkvpi4prXJeTA/
Date: Wed, 1 Apr 2026 02:24:11 +0000
Message-ID:
 <PUZPR04MB6316DABA9CEE62B3873600598150A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260326115045.9525-1-linkinjeon@kernel.org>
 <20260326115045.9525-2-linkinjeon@kernel.org>
In-Reply-To: <20260326115045.9525-2-linkinjeon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYQPR04MB8996:EE_
x-ms-office365-filtering-correlation-id: 613f619c-ec30-418c-32fb-08de8f95c2a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 9PCQh5/2+EEwy20Go+7JBRgpmnapwxFmiuJtUBqhLwjhdMUZr9gq5vcoeCCYFKuovsk2rJarNpYjK0vZXLL48+DGyE0Msoeu0OFfYxyfX87shamSJEOnAzpQl4DVCY6hFcr1K2ITm7/WqJjFB8dwHIDgDMk5Z1sb6lEg2wrnlZ8GZzHt6QCpdFDIDvPx98bVN83N8jCs+YvpI3wXoXO0sX11+jPNYcZ6L8bn2piniikvq0TACu4wPi3v/MemRelmiN7NRw2QRchbHhKP9yrWk8kMGWwrI7YMQzVSg3V4/hRAeeC2Wjka8WfkVVnpglWLXzRHQ5pmpAOqzznvj7lLOfieemt3GuNGwOF3FVUV7QR5zSAiYr2q6vvKXwqdw+567oZBPdnoOyiQA9qrGBme1tQKL5Qpv3nZ802z5avmTAyRi8zFSL2DrMg9f54KWiCLMMy6M7yf5rsJefPGBmaCs2JZ00LRbBC/QePl4YVizObYKgfywbQHjk2QfeVpyhqBoZKi0GXfLDvijQhZ2bgcTD3Jx0LYTYVW9jDrBJfojN6iJJ7OnjaVhzIal7LKvj09QaK3VOmbb7IW0sJRKE7zotqRqEpn0DIzgXLr6pMe9+Dj9KOm3Kd3WcPN4qIJbC7fec1V0T+4ouexNM6nNnCrx9JV4giciaGlgWe7nM0EFJNTEyPf+S6m3iwhQC2PB5LEmJ8fLBnRkYwxbokfrpomCvns2exkuZ9g3mivTNB8wo+dxLwc+yKD+cnanSLTe8ykEXt3gOW5sURzaxNqT7uzIMKgzndOw3VkIBPKQMtdW9g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gSnFmxjYiy6x/dj1/Y/LJSGGUQM7k35JRnXCF8e09etcnplHA4Sok+DPA1?=
 =?iso-8859-1?Q?oe/xEsBqUFS35cFt5MJlFMWwwtoYDCl/Q7uEhPW78AaWU1SyOITyAHtrUM?=
 =?iso-8859-1?Q?wrtJXxnx/tLSnyTvYJzURvxRFs369FYC8VLdS7xFCf/C+QEsw92XF8B/qK?=
 =?iso-8859-1?Q?hJP6Bv2eXUymH0zgIwoc+FIbKjV0UXzoyUS2Nkh5DeCCZOpbYfCHiSboyB?=
 =?iso-8859-1?Q?nJ+Uz+QOru+J2WQPNt037y0tEFNYbdnpZVmRSmi5vGe+nvhlsE0BE5Z0R3?=
 =?iso-8859-1?Q?EblAtBijIR4OxNRHQHD5qrXgUm8uKVED/cmVWluKtTr2Poo+MCA2gWQZP+?=
 =?iso-8859-1?Q?6iKsx4wQxGOvc0eN/xM6qZ73ZRLSMBxwsoK52+6+N77KgzY4Xm4juRIhij?=
 =?iso-8859-1?Q?EF27jFL3RndoVs9x9Fg3ZFAFqM67+ZdjiQLNb7gnUdIUDDdkkM4mW+8mId?=
 =?iso-8859-1?Q?8LfYCWglueouRYyH3OeslTzjttxW5RxSB7Qdxpz8eQxV7nA9UrLy3jZxya?=
 =?iso-8859-1?Q?oXvnQGvTz8mzT2YI2u3ZNJN976QdXHHc/1XTObvxmbLH1mca8xoDDrynYe?=
 =?iso-8859-1?Q?18utg9CgiqTDxm7Fwmd0DnWkl8zMLcOClX8qFoBcM1i6w+6Hy2hj+vXhbk?=
 =?iso-8859-1?Q?syv2LWFqjrStS4CDhy4lImAbGCqneyeBYKh4hzMRJmXhacfW/qYMYB6iDT?=
 =?iso-8859-1?Q?RF/fFfEiCj/9Ud1BEvfZZPvjJ9uBoJ7IiTYUGw4Knc2Hx3odWo93jbTVQs?=
 =?iso-8859-1?Q?NXTVFdx3rp8UsiFiZQJdTALduNLMCT1cUWquqSIOxSH+lfFXrnIiqYOonI?=
 =?iso-8859-1?Q?nhfWnALMRZzQLxgdRwrXGeuziuTkNMO8brg2+7mI8j1Jm0kh1uMla0F7/N?=
 =?iso-8859-1?Q?EjH8KA5f9hgksaXfgELff1abWC9rQ7RPAD+Gd/cdl5qYGL3/UmxAmesgVe?=
 =?iso-8859-1?Q?FdsHTalyWINCvi0wKFIBxavGDer/nj1Zf/gZTl0XIdgU+oKOptNkja3GJ2?=
 =?iso-8859-1?Q?t/V0vyeBcceJpdn5+mRpe81owsuca6dwTghC52e9bjLHJqEsm3wQ+SyiUq?=
 =?iso-8859-1?Q?LFJfv72Q9WaeSeaNFoMp0RtLuPpzTiqcEFh6xVaqJ0Lck2wpHyOXcKpAQ2?=
 =?iso-8859-1?Q?UJJ6AFZONgzU9y/cVdUvnLXuHveyG4BA9kAJzMo83sncwuLMHBPrnlm/zA?=
 =?iso-8859-1?Q?IrO8W0Tz8A258zbcb9cOn5VxTvyQSfbxlc7Jp9+QXj3IcYMNJUWRnIMZSB?=
 =?iso-8859-1?Q?uH/iDhyt1SPPam9aDlX7F52BetEZHEGC2iBNSN1u/vGzw1FV8huJdx9Ma+?=
 =?iso-8859-1?Q?ylfsUkevVQWKKWcLacjpPq6j3MeIxoIWD0yEKWlCLDcu17Coi82j+Bd/ZQ?=
 =?iso-8859-1?Q?V2+s/521wSUrpgkQ4osP0qA1feA9Q2K54Y9HmWybwXn1w6mHqbVjhrCCzG?=
 =?iso-8859-1?Q?JjwFnKia4xFZaugPKM7e4jSSSAX+clKJu8iUHlViXxaojS2Um7K41UpAEf?=
 =?iso-8859-1?Q?2oXLRi/rz2PWhgMcX0tsRpCnXgPNEvMiwGdFyJ0ocVThCNknBfq9LOnege?=
 =?iso-8859-1?Q?9MX3wLPZq07jCJyZomZUwNFyn7YTJHVQhqeVseVNUoB0192FEYCZfdYXfR?=
 =?iso-8859-1?Q?DAVEbOjxDyiFhG5R4EpbBA2b9yqzWiMrzF3hHvse+Wc82w/9qhppnT8Mmf?=
 =?iso-8859-1?Q?nEQB72mQO3UB94PxVynNJHNDNB8tbOrqBnPykbGPH1bEBYg3HZeoTOQWdV?=
 =?iso-8859-1?Q?C3wwrpLvynHGGnOmTtF/SqhKCUV+/J9FFbX36ofa1NxVTfctl1jrNNiOBV?=
 =?iso-8859-1?Q?8sDGLKyJVYLbXKAX0AMAffP0jIetMJw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LHKHeKnyaPulH57A5sOmO4HxGiX54bpBVxUVo8alw9RPtiHaueLncj7TyYKhwTEyzPW8ye0OZLs9plceevXRzix3gqzQGhTT9j7eYHtu0d2L5UzHnbREfPJmAmZs0xsT86EIE3VHmjjRHWgqrTTVo5q/l5TuWmxWXnpHDEhSmvMyTOLGpRN4hjCn93imUcZV1WxrKBuwC8GIvSwBlEMPBVDKqbGpR40jWWTF0pFkDxxA+Cy+30JKO8F66quGJEFWKLY5/x+z3ufjKr/xXvzJQ6l6UgsiT4NSlmS2Tnecw07WGU8bpIPiUuwbnNDWVuv4DLjv/ZoHyKDyPZikAV+26w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MlkV2rgG7mH2dihYNzi/lsF2Ve1X9Y018XqRat7y92jIYFdzRerM4n/C/bW7+KNqgKudKB6h/Z28igvkKuKm1vTrYMSRoo2oB5sj/W86208f+dWncwLKuJA6lu6XbXMLkC1B9ZQicmM+XoV9T3OFL7xAXHcuQBfNLFKFQLg6xv7nPUBce+0ro2MhavLwD6kY7GDQgSwePARdhFOxbJjgnpucem6ZoV0TqYFCv2/mbwfZ+DWRFL3biRCfFEDXcasT+/Iv2Pf4Jhxt+oScRA8L5jRSafTwL1YgHfMCBMAVkh0x4ms3quHhYJkdRXzgpQ3PFGVEBDyE3EjdsrquWDSHW3f0lfTLYMK2kcnqcf56P7G3jDaJLMM6+0hQrJWFaNoSV+b8Y36EvJ6/LJ6sf5EuGEvq6FCejcTi0RWlIv+D3aJEFffEKQaw2fm3MIQI6pDq9fRL7gczM8YFVJYgkutdzDTBu3Kcbj/zOv8Qm88xaRp5N1Tg7rnlf8w+yH01RjeygmjuaS5vfJ9vYUwpHDZnDlYjXuvnLgvkNXX5veq8aUsRSZiPWZ/p5IdZ1Et3kP4LVdsz8MGTW3FFGM7htqL+kFB5t8rFF5qw8zjesCAtymKymKTRLlRc2ECGHYnr7yi5
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613f619c-ec30-418c-32fb-08de8f95c2a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 02:24:11.1361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9CNCxi7XlLaNRpOzoIIo3F82zSX8Yfp+2xEr4eYucQ3Ty9roSqNEi5h8dfnsosZVMfJDP6rOUHe8ZxwTfFB5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR04MB8996
X-Authority-Analysis: v=2.4 cv=NvPcssdJ c=1 sm=1 tr=0 ts=69cc81d0 cx=c_pps
 a=9dR2u/dkgXXn0o5Tv4UyaQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=cIyGuqrkuvkXWOl_fzuj:22
 a=WUb3HDuSkCPymwPuW8oA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAxNiBTYWx0ZWRfX1VXi9K9OuYVN
 3x5tUzIScQZJ4ekMyKWelqipuCsYjN6G+lj21T4XbKoZEdOOkU1r4lltOhrzxHfa53+VrfG2hvv
 pEZBKfWuwdKc/HnTnc9amL2QStXTAgQfK0EfI9JtA30jajEHHdW5Ned7KU5yJGVX3xPIY0MRN3E
 7gzlbRr93tSPJ5s0VBrKvKRS2tsaVcI1tdEuSulq7zr9M4RgX1hFxM5Kc0I1SJD12UHq737MAAP
 +eLH7jnhhIv4RJzH0rNtywXxC5m0QmM4+HG7/TH3AOLCyW7PwWZ68gaYY7gpIHZofiloUydMnz5
 AtGkBuV+tiPjQmMZki0ouVnbCNTFO+gMnFfC5oQu97+TZKcAx5ocvBx4Bkdw0vFrSKAt34znKmI
 JjVImPNoQ0du45J9lsEJ1rDHxyiAu846M2VHmc6eABtrpXjFO599RIQIL0P0N3PzspcN3SjVrxW
 Xeefaj1CidH2JfhJP5g==
X-Proofpoint-ORIG-GUID: wUsXpXcghXXlPFXiTjsZnLBWADwujS10
X-Proofpoint-GUID: wUsXpXcghXXlPFXiTjsZnLBWADwujS10
X-Sony-Outbound-GUID: wUsXpXcghXXlPFXiTjsZnLBWADwujS10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01

> +static int __exfat_write_iomap_begin(struct inode *inode, loff_t offset,=
=0A=
> +               loff_t length, struct iomap *iomap)=0A=
> +{=0A=
> +       struct super_block *sb =3D inode->i_sb;=0A=
> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +       unsigned int cluster, num_clusters;=0A=
> +       loff_t cluster_offset, cluster_length;=0A=
> +       int err;=0A=
> +       bool balloc =3D false;=0A=
> +=0A=
> +       num_clusters =3D max(EXFAT_B_TO_CLU_ROUND_UP(offset + length, sbi=
) -=0A=
> +               EXFAT_B_TO_CLU_ROUND_UP(offset, sbi), 1);=0A=
> +       mutex_lock(&sbi->s_lock);=0A=
> +       err =3D exfat_map_cluster(inode, EXFAT_B_TO_CLU(offset, sbi),=0A=
> +                       &cluster, &num_clusters, true, &balloc);=0A=
=0A=
num_clusters is the number of clusters which the region [offset, offset+len=
gth] is=0A=
distributed.=0A=
=0A=
num_clusters should be set as follows in both __exfat_write_iomap_begin and=
=0A=
exfat_read_iomap_begin.=0A=
=0A=
  num_clusters =3D EXFAT_B_TO_CLU_ROUND_UP(offset + length, sbi) - EXFAT_B_=
TO_CLU(offset, sbi);=0A=
=0A=
And num_to_be_allocated in exfat_map_cluster() should be set as follows.=0A=
=0A=
     num_to_be_allocated =3D 0;=0A=
     if (clu_offset + *count > num_clusters)=0A=
             num_to_be_allocated =3D clu_offset + *count - num_clusters;=0A=
