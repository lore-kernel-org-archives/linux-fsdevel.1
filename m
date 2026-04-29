Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE23331209
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478494; cv=fail; b=iryXO4jQ08HhBtLJq4aW7Cxylv3gOY+KfSSjxoMsQVTbABvZUHUjeQikQehLYa38coWW8p4jn29DcRi27fNgge4zDuG7SWJsdN/020PsT41uGlAo8sy0znvK/ull70GH+ZnhN5sHp0djA0RwoSIomrmcRB/Ac0UngpItd2dFDb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478494; c=relaxed/simple;
	bh=CqqpJo6QD3fl9TwiicGRBqsQzFrzbL0hT9fkvZ2u8ZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SY0ELT2rEnVt3XIvNUr6W+B605deFIpriU0FyalZUex+9OVXoMvG7vSCXJP7oaU4TDzE+WAPP+1QeUoo5dJGOIHXSj7UudSxm5XHlT57DW3vDpeVGa6K2Dvx4Gq8QFO3h4bvQYUNQNOJltfEBLpSkfVQpMqYY9xfnBRlFyXeNcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=lz77MJcu; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="lz77MJcu"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021094.outbound.protection.outlook.com [52.101.62.94]) by mx-outbound47-250.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 Apr 2026 16:01:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2LeRXuA5w+Z7iQzxNRujsUZsBcqjiK6gLLSfQxCsYDVP1OL2e36poTNw8OoM9YDoqoKfgHrkr3TFTjOS3XSexuni+ms8nMbLxpvr4n7z43qJ40aTEIZKXQYKh2A16Yn9DjomzwLzTG+gmgng83Zl8CNE+g19af5Hw9NVn9nZzxbust+7p01TJUIPVJsaBpZ88EnsnFp79zGDxHo3tsxxB0IqZazsC67TLRETbIUjNqaucf9OpzY5GBS43MIft5WEPISozBFXR1RZa97Xz1umCxPdyFFT11xfnYM05EluCUBNT1BhX614vaNB3eCaINKUho1YSk83u2PgmqTeHLtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRMDVIaaOASF7TEGpV67VFqPFsIpqCEozIG8fWOESaM=;
 b=L+mCW9IGbGWc2JbQQHB0EnBOVcc/MgRoyzqQcys934l5wfwkmspYgr4UCb8QMo0+ehN6LARHxt+Xw2RtW1bxz5WXsl6PKvkj8B0UBk5GFoK5eiFN/j4SIi5VAuWJB1A4l21ZSiM6JJS2X2IddJvC4do2Bo2YFCkXoK7ApVoaDDa8bZr7iMLV0BAFEYdEgTQgPpGUSGYN2n03Snos97tcaJC7ABS/qq6CFb9OHkURhsPnYQDYwfmz/VHwRM6wW5Q9tylbl2vyJbIT6ahQEyRxgD9G8p8Hk+X7imGVA1TNAaiUXuLkeOwrgjD2zSMGVvTkstnbuYzASNmsH8BdzP+VIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRMDVIaaOASF7TEGpV67VFqPFsIpqCEozIG8fWOESaM=;
 b=lz77MJcuDhXizB8+E4FNZBTug/qHWV4XaFZmBZbwfivO4JSdkgj2m0A9/5+C+T0rub7tOAjF7oCnSa8QC5iDXTKf29W5rM97plDRp+vquTzpqVMArHSsaiuaQyifI+7ZhctUsbmkzUBtUBsY3/56qoRxGCl/R4m1jeJ3+/19Yyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SA1PR19MB8115.namprd19.prod.outlook.com (2603:10b6:806:37c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 16:01:12 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%7]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 16:01:12 +0000
Message-ID: <f3031d36-0f58-432b-8494-7cf6b1762925@ddn.com>
Date: Wed, 29 Apr 2026 18:01:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] fuse: {io-uring} Queue background requests on a
 different core
To: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-6-982b6414b723@bsbernd.com>
 <CAJnrk1ZBFkQSE1XGvM0zuVpiMVpCvh7W8nrbsbFRt2Upt-KAAg@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: fr, en-US
In-Reply-To: <CAJnrk1ZBFkQSE1XGvM0zuVpiMVpCvh7W8nrbsbFRt2Upt-KAAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0133.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::15) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|SA1PR19MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 326a8c0b-10f7-4640-1207-08dea60888ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|10070799003|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ds0NsF7ODmzl2156C0rGcZ3XonvVCYa/IgT+a/2oGSHmtV52SMEUI4btdzaaqRh3rAghdzErwqSjyh578vEZ8k25uBwM/5D4E5QIvpdA9B/1Ec6ESdDBH9hrlK6mFBbgIHMwEyu19G+kN6gA3ipLwpdVvkt8AjHzSOkXAuzUl0x352KkrS28oW/iuIYzObRfHHqk2AIlbqxnG04e6O2VtbCYh3LbcXuOdYN/TiKDTIyiD33HKZVpeX2OznsOmaLkmgfYL0ihS0O4aINknXgMk/5oorVXAwFqKDVrlOnVtSYQvqhMl2bcM3nmUPuoMG2p5rq6e08jR32FvZTzoX8VI9fmDNxoF8gTgjMN8qws4I51cKVnmDKUVlAB/lhbBeLSGFZus7hwMkadbLoWRRfJivvi98sKtmuLWKpsV2tNQQHXVFZ0WhQx9kxpOXLNWTRwyNOSzHaP5qBHKKZyLXYBYcL82Th4A8UPFhoaHN6Vb84kWSEex7S29QS7GKdCiBCHilw9UrwCvYj+PaDPiurLBtMs2eeRsg4XaWkRMt3EFKExExaFFVNLk43/3eehOUAvjGC7q3UL0xMHBkhRuqF8ByAPBtVpvtsCHUKBzD0/E78DA+5HnuaTwR9Yf5oLwQOEVyBqYJRTiCqMcyneNGcXlR6aLbZ076HX231z/e+m0A6RvabuX9QDoVGVXYnMwF1LRUdF8fg5sHODpQN2jDM3FN+N25GH60iism7l04OrNYU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk5mTVFmNSt4dVg1MHRINFZwU1E1ZWNZeWlIRlI4YUEyQmZSMVRQd0dqWm5m?=
 =?utf-8?B?YkV3SERWbnY1dC9GZy8xUlM4QzFYT1JpSFJCTDRiVjRBUE02dVZQYitjdGkw?=
 =?utf-8?B?aklDTGM3MXAwVloxYmZuWkZTQVFGSWFJdk5sWHlDbTY5cGZVU3hhYjFZckdm?=
 =?utf-8?B?ZWFJVWtpVVQxYmpNeWh1ZHo4NTdtMjMxUzhUc3VySEpKQkFOU091T0h3NzZh?=
 =?utf-8?B?WTRiZGRBT0JIOXNsblQ1NjV5V3pCbEhvTWJEdWNTd2I2WWVaYjJzZ3Y1N0cv?=
 =?utf-8?B?TzhPSUJXb3JMY0dvc0dVdVZOeUN0QWRxY0liRy9FQnlhZ2NSb1dzNHRkUlN6?=
 =?utf-8?B?ZUZCK2VacFVoZFdMRXc1cUlTaE5LTTkzNHdKOFMvUTRjbHk3UzJqL2tsaktF?=
 =?utf-8?B?ZVFPcFdIa0tMQjBBcDNKMSt0VGN3ZjB1djBwZzZQajZuOFZvMVNRaCtlbXh0?=
 =?utf-8?B?K0N2cVhrKzFBdThOWkVtQS9CQ3BUL0tIN24ra3VxbEtWQkdpUUtjSyt3MXEx?=
 =?utf-8?B?ajBUUHJvbldFS3pnWXA3eE91Z3dCSnE2eG9CZlhDSm5pSGhnWmNNWVU2NlNP?=
 =?utf-8?B?ZGQyNjRLQlJmcEhSZHI1RnlyaW1LOGVSbHAyY2pUcDNBMkFnNFlhTGIrOGd1?=
 =?utf-8?B?WUxJcmxxNWh4Vld2b2lqQXpPck5adjY3bUc0SXNGVXlWT0R0VWd0TzBSeEE4?=
 =?utf-8?B?ZXhaY2hNRjJENnpIZWRsZHdHUDlGQnIvTXhPRDd1Q2RpMDRwQ1pUVDhjVGxN?=
 =?utf-8?B?amg2aU1ZZHgvVnRubVhIZXhiaHdJdVg2UlE0U1ZTcEFQclM4R3RGNkQ0T2NS?=
 =?utf-8?B?YVpPcFNycGlBdzhGSm93bXliRDJycytvNFNCdmRaVmQ4VC9YL2srWHpHa0dj?=
 =?utf-8?B?VnhsL1NkSWVLd0oxR0lqdVhjdDZDdmhCVWRiVlhrRWlsaFBZRU5keDU3TTFT?=
 =?utf-8?B?a29Sd3hDU0QrVzYxYXVXcVFBbllGZ2l5NVRlYVhYVUNvM1pSQ2wxZW5MMlU4?=
 =?utf-8?B?NC9PY1pGOE1ZYVVFbnppcEJYUjZKTk8vbFZiKzNTSDdlc1Q2V2RVZTNrdHZH?=
 =?utf-8?B?OVhSc2ZUSy9VdEhXY1RWVExVMWJWbGk0Q0xKdXFTSHdFbEVVUkZURG5MMWZv?=
 =?utf-8?B?QUZ1dVFBaGswTTRibWw2bFo1bWVlZjFUbWQxSG55TUdkTlZvSGV1c2RzWmVp?=
 =?utf-8?B?bXZKQk1kRHovd3FJUkEwWnBxck9iSkRsSloxU01Cd3diSWxGSXpHWWM4NmR6?=
 =?utf-8?B?SVBIcG1Zcmh2ZkRWem1YVVBwUjdBVTJLL0xCSmN0Y2E4M3hrSnlhYWZNL0lJ?=
 =?utf-8?B?MWcxWjVUdkF6SWVQUVZMVUhVeFMzSXVKVXFrTmFNWEdNTFU0bU9rMXRoQk5t?=
 =?utf-8?B?aDJ3aXE2bjlrN0lEcE91bzBMdTdPQVExbUN6bEdYTnFnb0djV0JJcWFER2tT?=
 =?utf-8?B?TThLdmNzOHdUK0hFYnJrY2hrWU5haFVVREhvaE4vb0FsRUlHRUQ5bEcraEZJ?=
 =?utf-8?B?cFlQQldUWHJGbWFBb2w5UUp0Z3BzUE55ODdEVmd3dlN1UzZBQnhGcStnU0dB?=
 =?utf-8?B?TTFaWGxiMmVXNXdGbTdaRHhBUzVWcTlON1B3M0RHVVlESW9pQUlFSHVTRHRq?=
 =?utf-8?B?b0JOZjhoTzN2T05tY21lbFBjMWdyeTRhbUVVWkgwS21Pb3dFNkZVRXlhSWx3?=
 =?utf-8?B?S2NVTElGbDBIREgxcXgvaEpUanQ4cnFjSlhxb1YvUGpUQUYwbGFFbjRuM1Ji?=
 =?utf-8?B?NXhVNVVsTCtXOVJUMFRCS2Q1b1p4eDh1Yjd1N0p0dGdrclFmWE1Rck9JMjc4?=
 =?utf-8?B?UHFwclFoOFFObWhJV0Nacy9VNm1iWDg1Y0JSb2hvQlIySS9CWklwSTRNSklJ?=
 =?utf-8?B?MlZoK1J1NzVHQTJ6QTB3R1VoZ3JCSG16ZFBUQ3VqYklIajlhbndWUWxSUUJV?=
 =?utf-8?B?N1pmNlV0RDBlRGFCZGJxODlldnBqVDRyZllYbXZmM0JkK1E0MjVqTVlXMFhK?=
 =?utf-8?B?cVJhaGN3d2pJbTIvUGhGVGUxd0FhYzRZU1dyYjY1U200V2h0Y1h6bUEvTUxC?=
 =?utf-8?B?VUovd29teVVLZjBpTVYvSDNLc0dKR2UyTGJPRVFnNXhlbk5vSjJuUzJWV0hS?=
 =?utf-8?B?QWxxSDVlT25HME96cjFHcFNTNG1RUSs0SFVxcFVzODViQlZlV0FESFdCT05z?=
 =?utf-8?B?anczNThqSjlUVHNkVUhlWTlBUXFSdDlpZVhTNXladnpzYzB1R1cxWS9HNW8y?=
 =?utf-8?B?SVY4WEluMXRaNUpnd3BYczRyU0NRNlNRZUtFVTR1V2dCNk1Kb0VUdXNtajNR?=
 =?utf-8?B?M1FTbWUxd3NrQXIzV0RtNCthSzZzcnlOZ1FsUlhVQyt2aUV6VXlvR0FiUHhB?=
 =?utf-8?Q?QRlOpejSarmNBnTFRUKo5CDoOFizvDVlKnpQWVWSAoWAM?=
X-MS-Exchange-AntiSpam-MessageData-1: 06whTBUIW2R/LA==
X-Exchange-RoutingPolicyChecked:
	dgGL7+/4RiZbB0DIgjZES52i1KX4XFa/9ubboOp72BPNnN4kxn85ETvziEMi4/DQuMvfejMPOOUTQ/gkn123OypQij+yqkAhPh4H3WeIGJGzgO/DvsnxT/4O3wxJWQTlB0NLGlTEZNWZWDdifmSG6gvO5lvcH3NP13HsHrdK5anNUkhYbo5VdIP6jLz0lrRgQJnSYpVvC/904Kfpnp3547aH2qOm5YFs2PUnQ8OLwMgVJ6mFvpoQBSOLtrq3R3C5VlyOelrQSTdzc00UcOEPaELvpliI0u31Zvbw4RI20z3ANy0IGnVGZz2KwIcCe+Dv0NzqP89JlODrXNS/NoKHOg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T28mxl5gaK1jBoLac8rVcI30NEpT6dsUOauFORLNAjNaODWOsoN56Pv0idribGflSFzIJAg9d4FIysFKIcQfDSor8HTS2y802542uleE60r+PEGYWETcDHBgoQ/aed6EQT6n2vpJaEDDix+ntxnPKR/uYCbG4bXqKUyq044UO5Ioaz4mHOoP2nJzTpmX1PwqxI59PtB6N8xRzSy1KS4a9Cd5u/HkCd1UlwVDSa/GRM3Pp34M37yPabYg93lOsK0rT0IqTFwvmfDOl8+gBbe7HyQlsEEAeiw3W2WZmLnGrmbdpLgc1HufyJlW5rZVJe3rFmOuElXBNKsWKjoBP16+oGafatn7JVbjbXVRLfLKqTLr/ltZW6E45vYFcB7CjqCuhdOs4YlAV8cHlYFvx/8dBULVJRNLondcNdq7kXlfjGJO5ZttQCPmi0B7xE5apEt91VxTdtj+kE7OSddtoJzjQAwjuKGLQxymoOrOwdJzF31jNFjZ7Bq3UyVQh/Q/Heu+nM9Unak6eOySKTzQYPeu+BBVP4y5JZ0wuCNMp+gztir6dvUQbHCZKXsaaQlc1fdcH0VPim2q6p3pHAcV3WvxqrSssRSmlN9dxy39rx0ZB9a9AbW/Xev0gEcXwd2N9V9ncU5dBY5HopQSpPaWUI6eJA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326a8c0b-10f7-4640-1207-08dea60888ca
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 16:01:11.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WqmfYCQhRSUIwuUcjpYeWZbB3QBpbQ0YjIsx1lAlCR28DVmSBZ21Q87w5hZOx4kK78HE7BW6O0FymdlU6uYwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8115
X-BESS-ID: 1777478477-112282-9797-12676-1
X-BESS-VER: 2019.1_20260409.1619
X-BESS-Apparent-Source-IP: 52.101.62.94
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmaGRgZAVgZQMNnSONXA0jDJ0s
	ww1cg8ycI0JS3NyCDR2NIozdzSwiRJqTYWAFcMnppBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272903 [from 
	cloudscan9-34.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 4/29/26 16:43, Joanne Koong wrote:
> On Mon, Apr 13, 2026 at 10:41 AM Bernd Schubert via B4 Relay
> <devnull+bernd.bsbernd.com@kernel.org> wrote:
>>
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> Running background IO on a different core makes quite a difference.
>>
>> fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread \
>> --bs=4k --size=1G --numjobs=1 --iodepth=4 --time_based\
>> --runtime=30s --group_reporting --ioengine=io_uring\
>>  --direct=1
>>
>> unpatched
>>    READ: bw=272MiB/s (285MB/s) ...
>> patched
>>    READ: bw=650MiB/s (682MB/s)
>>
>> Reason is easily visible, the fio process is migrating between CPUs
>> when requests are submitted on the queue for the same core.
>>
>> With --iodepth=8
>>
>> unpatched
>>    READ: bw=466MiB/s (489MB/s)
>> patched
>>    READ: bw=641MiB/s (672MB/s)
>>
>> Without io-uring (--iodepth=8)
>>    READ: bw=729MiB/s (764MB/s)
>>
>> Without fuse (--iodepth=8)
>>    READ: bw=2199MiB/s (2306MB/s)
>>
>> (Test were done with
>> <libfuse>/example/passthrough_hp -o allow_other --nopassthrough  \
>> [-o io_uring] /tmp/source /tmp/dest
>> )
>>
>> Additional notes:
>>
>> With FURING_NEXT_QUEUE_RETRIES=0 (--iodepth=8)
>>    READ: bw=903MiB/s (946MB/s)
>>
>> With just a random qid (--iodepth=8)
>>    READ: bw=429MiB/s (450MB/s)
>>
>> With --iodepth=1
>> unpatched
>>    READ: bw=195MiB/s (204MB/s)
>> patched
>>    READ: bw=232MiB/s (243MB/s)
>>
>> With --iodepth=1 --numjobs=2
>> unpatched
>>    READ: bw=366MiB/s (384MB/s)
>> patched
>>    READ: bw=472MiB/s (495MB/s)
>>
>> With --iodepth=1 --numjobs=8
>> unpatched
>>    READ: bw=1437MiB/s (1507MB/s)
>> patched
>>    READ: bw=1529MiB/s (1603MB/s)
>> fuse without io-uring
>>    READ: bw=1314MiB/s (1378MB/s), 1314MiB/s-1314MiB/s ...
>> no-fuse
>>    READ: bw=2566MiB/s (2690MB/s), 2566MiB/s-2566MiB/s ...
>>
>> In summary, for async requests the core doing application IO is busy
>> sending requests and processing IOs should be done on a different core.
>> Spreading the load on random cores is also not desirable, as the core
>> might be frequency scaled down and/or in C1 sleep states. Not shown here,
>> but differnces are much smaller when the system uses performance govenor
>> instead of schedutil (ubuntu default). Obviously at the cost of higher
>> system power consumption for performance govenor - not desirable either.
>>
>> Results without io-uring (which uses fixed libfuse threads per queue)
>> heavily depend on the current number of active threads. Libfuse uses
>> default of max 10 threads, but actual nr max threads is a parameter.
>> Also, no-fuse-io-uring results heavily depend on, if there was already
>> running another workload before, as libfuse starts these threads
>> dynamically - i.e. the more threads are active, the worse the
>> performance.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev_uring.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index e68089babaf89fb81741e4a5e605c6e36a137f9e..ed061e239b8ed70ff36deb51dd6957fe1704ec87 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -1306,13 +1306,21 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
>>         fuse_uring_send(ent, cmd, err, issue_flags);
>>  }
>>
>> -static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring)
>> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
>> +                                                      bool background)
>>  {
>>         unsigned int qid;
>>         int node;
>>         unsigned int nr_queues;
>>         unsigned int cpu = task_cpu(current);
>>
>> +       /*
>> +        *  Background requests result in better performance on a different
>> +        *  CPU, unless CPUs are already busy.
>> +        */
>> +       if (background)
>> +               cpu++;
>> +

Thanks a lot for your reviews!

Ah yes, I think the fix is straight forward, by only getting the 
numa node once on entering the function.

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 44e1b795a636..dbccaa0971c9 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1321,6 +1321,14 @@ static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
        unsigned int cpu = task_cpu(current);
        struct fuse_ring_queue *queue, *primary_queue = NULL;
 
+       /* numa local registered queue bitmap */
+       node = cpu_to_node(cpu);
+       if (WARN_ONCE(node >= ring->nr_numa_nodes,
+                     "Node number (%d) exceeds nr nodes (%d)\n", node,
+                     ring->nr_numa_nodes)) {
+               node = 0;
+       }
+
        /*
         *  Background requests result in better performance on a different
         *  CPU, unless CPUs are already busy.
@@ -1331,14 +1339,6 @@ static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
 retry:
        cpu = cpu % ring->max_nr_queues;
 
-       /* numa local registered queue bitmap */
-       node = cpu_to_node(cpu);
-       if (WARN_ONCE(node >= ring->nr_numa_nodes,
-                     "Node number (%d) exceeds nr nodes (%d)\n",
-                     node, ring->nr_numa_nodes)) {
-               node = 0;
-       }
-
        nr_queues = READ_ONCE(ring->numa_q_map[node].nr_queues);
        if (nr_queues) {
                /* prefer the queue that corresponds to the current cpu */


> 
> I think this may cross numa boundaries in some cases. I think it would
> be relatively straightforward to just route the background request to
> a different queue on the same numa node, using the
> ring->numa_q_map[cpu_to_node(cpu)] bitmap that you have? There's a
> cpumask_next_wrap() helper function that returns back the next bit set
> in the cpumask after a passed-in index.

I think the code already does that, except that it needs the change above.

> 
> If you don't have time to make this change though, i can send a
> follow-up for this.

Friday is a public holiday, I should be able to send an update that day.

Thanks,
Bernd

