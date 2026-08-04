Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042163F6C39
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827014; cv=fail; b=OrS7DfHk54Mq9zem+UYpwrJ2o+8zvtd9+IzZEbcHUcRk607GhMrbWLZY5JRBji1T8SqJfsnNaKHE4bOIGCf+g+EqQDNKmDd8KcZYwch4KoZsEt11S7AXCAJAFItbu/McVZtpNbWNcy0u0m8fs4ltLXtjeJ08ap1OXxkbPaGZHWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827014; c=relaxed/simple;
	bh=i+mTvP8ey5gHPCjLz4Qq+Jmhz5X6oYUD/f2psQT0450=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=Hz1o+he++kptccKqnG4v3CUVeQ8MmlTB3YyhzHkjP9cb/926w5qYxBbckzroaimwMcYBbWM1t79nKE6ug2diAgA835BLdU1fnX3ysvEXGKykWgJ7G9brdS6XBwxHsn0ZiC+ASDD+P7tSwfwFSmHZQvIvaIqX/JZzi1TEK1e+Mk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DQh/m8qp; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NqoXZmiZ reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DQh/m8qp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NqoXZmiZ"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673Kj0iZ3787209;
	Tue, 4 Aug 2026 07:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QgOQPRaP974h6uX/I6Brp2fH6IZRlFcZDQc7esNw8qk=; b=
	DQh/m8qpJIeqLNXsaXc//jT7ZIGsygYl9PWUCPJY5g5eUWIL22w4uSCq0ocnIZ3a
	GE94ZgFPDw3MIKfrkPW4TGxYYIwdyv4f7Apsn1AFpbbeFXPX/noz2NJ0zGwZ7/6Y
	Q9JY/5SrwQe587FmHKT3SweQzY6CZjpinnl8GRjGaEG5zIquwt6bYTJ6dAygyw0f
	1YMfc4V2cstBgLqBuKnooHA8ygr52XVRZj2A5vLOg/8DxRvZyrmfi17b5vMIglTm
	9HV4T9Oj9pKVZOenylq8OUNrxAFjv6PcAmpplQMp3z9i2rxO5nEpE+ijwxqw/1St
	5Wqarjf+59W20LWBIjCCAg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs8ugd0wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 07:02:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67470clW038039;
	Tue, 4 Aug 2026 07:01:59 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78snp9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 07:01:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cab6SndPamtg2fIoNweM79zmtI3POxxJgx/4gA+KIPuxrzaZC8gmrWeJ61VAm6rcZtMYBlXknfkRRq7+HzX3RXIs/QQl6nHetGcwwvXhgiJb/OXt9fS7BEndyrS8eLetG+BS1Ko2FJEvtBkKTuLg+bFq30LoN562Yvn1YFMWmCL934K397ntLDsEkHSXnojQzDcmN9cef0HZ4n3BJAIpsFgRWY23ugRK0OI7Vr6Ou3DpOoQnY0QVxM3j8XcJ4J2hvXQ2dzvKonegK8r4yAy68WcPO+RNbJ/3KZvtg2PKBQgTsLVZMAhEMwHsoXkxC0XmHququ43kQJNr8H/RnLrDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dli5Txrkqu2e2AP0itJPdzH+ZpXgWNPKK9X59/m8/qw=;
 b=wocp/ev/0KKX8zSJy0bZhDkmauKZcScfY2FtXcJ4yiedO/PZHnxiJsT3oIKav9Kzd91AyeGrA2hXzJCxPpsoSMfOr/ZzNHxR5naS4lUjbnZZyPqYTz06bZSUg+A2aL9AWrEbJ4DSkQhfkRWPHhK2EVP42PaWAIB6I9N3/TZ/FtChvJhVsmGLjvE99SUg0G7geCIgATI50MmRK+oPjOuZ2muLKcEZBQ9kGVB+X77tCGcR34ul2wMKkeljNdEN1YJtD2Bpean2GrL3mQnUjXHbRSfMmnhOSx3D/DhcmnY45uOPOPap3S2aXcjTo4X9PH4Z2GWxSlAn2lBnVr9m2Ckl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dli5Txrkqu2e2AP0itJPdzH+ZpXgWNPKK9X59/m8/qw=;
 b=NqoXZmiZt516Ntoo/NOiR4iso5oRtKk2F+bhmDwpxm2ykbP37tAPtiKJLEAxeCj/h412TUnQOmT2HJyGqiIvNP9vn5JSC+Ks6hX8ROCs7DZxpA6QQmdstwU/4NEjl0eaClshjKzw8ksUhuZOIXgsTw7qHl+dGE+MY4W9ZG8rtiM=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by DM3PPF1652C44C3.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 07:01:56 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 07:01:56 +0000
Message-ID: <3f5b128f-58e1-42d9-8cab-c49cb9e12ce6@oracle.com>
Date: Tue, 4 Aug 2026 00:01:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/15] hugetlb: Set mapping folio order
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jiaqi Yan <jiaqiyan@google.com>, Gregory Price <gourry@gourry.net>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-14-willy@infradead.org>
From: jane.chu@oracle.com
In-Reply-To: <20260731200802.574821-14-willy@infradead.org>
X-ClientProxiedBy: PH8PR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::29) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|DM3PPF1652C44C3:EE_
X-MS-Office365-Filtering-Correlation-Id: e639184b-e051-4681-f772-08def1f6450c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|4143699003|56012099006|4133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jkit1ZolJkoU4rkvT3iGr2BeMHeCg/hyYmbF7Y99T1dhJTDfzp3mkoUG6S4DRhciBv9uGJqgJtl1n/tDOev596hPBsht+MEGyn3dpL5d9krvUMASWVOHpfFYrfpu1BdIRT9dvxf3AOEfXBHoHO7oC9Gr++vBoXxfHSKMZhssZx4cA4E9VdYh/0dKeWkXrGNxHpVEXs8SphAWaRG8kAYHs9pM3TX4M9v4WOpo1qYKfNakuu9DTBMm9NqnyN+nW9K6uGCcX9WhabX+JDKZKr7XfOvzJyysnPnZJEAXXCXNTbAbhGKrLEw/6wvwIyYT6MqAn6fC5mnPleQ8eImiLe+f/7hwTkijmEtSXGPIRKi1C4z4fR3QbejTF8mh00TSMQ+qqTkgIGN+0FdyxpluNs1lfylz5qJAR9p7Mmr399NSFF/5tbUQba7noaSSNxDiFint+EjhKoIjpo+I8sbDUQB+qRApJg/d5BW49pvsn6RZbbd0czldcMfFzbe2pc1UnitRHvKTvYnmcay076smHriAUenI+YF8S8zBSjVnaPt+e1g9NMtIjvRqVyNr2ooIKq0pRBn96WDRQ4J6FyLFDoUOtEC0yGg3A/OfDDR+M/lO2qzLD6bL0VBcqQg3JgEXmo+x9dknmhUB6EeoYTVi2rNV0+aH7/fmqj/82P9awWRbVT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(4133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXpYTE9kWUxPMHZtK3Vnanoxa3JoQzA5eGdaWGlnelluUFJzbUFRdW9Yb2JK?=
 =?utf-8?B?MXlvbHB4UnBGa2lDZ1oxY0lLM3hrNzF1blIyNjhrbHZQODI4YmZXVjFxZEJr?=
 =?utf-8?B?eHh3djAzSWFHRFlTalpYMTBRUlpZTUlBcTk3Qkt5M1dITzJrdHFYREZyQTdW?=
 =?utf-8?B?cDlZaDRrWEV1MlBVbmp1YVBLWkRNNlRPUnpDMlBYSmhWTktvcmNzZlB4bXB0?=
 =?utf-8?B?R1U3aW1Ec2ppMENETFRnTU5oZkJRQzlMMzdyQ0F0STlFWk54elozbUNzUGd5?=
 =?utf-8?B?L2VyY3lpOWF5cWx5NFNYZzZWMG0xbkVXbDVjK1VCOHpKcFVTYzJPVitQeVhE?=
 =?utf-8?B?Qlh5ZDNGMHdXbXlqRVBaL0xvMXZsSlR1aUxvWDhFVFFEUEQzVU0xdnhkV3FF?=
 =?utf-8?B?NjhhVVZ0ZzBVR25xY2s3ZVMzK1ZlcEg1TmF2UEJ5UWk2RUovUkF3TU1ZekQy?=
 =?utf-8?B?dEZGRTVleHlVMG0xbkVpR2dJeUZvSkpBMmZYM0w0aGJFcDZxaUZycnloVCsx?=
 =?utf-8?B?TkVzdUh3Wis4YTdkWUI5UHpqc1lXa3JBanIxTzYyam1qalV3b0Q3M1hkMmVj?=
 =?utf-8?B?aVN1aXRJQW01MytuYVBSVHhFOUlMMFREWE4zdGpYbGJXV3orYUxlbUNqdXAv?=
 =?utf-8?B?dW45b2ZxblByR00wNHVyTG02bHFBcndic3ZYRWY2bThkakdXeTBkbVNnYUFT?=
 =?utf-8?B?ZTlWOXN2bjQ1WWVYSS9YVWI2OWRGWjgxLzdwNm9XU2RnamFOR0lON2VQOEJX?=
 =?utf-8?B?VlhzUmpyTmcwZFVBNGtnQllLRTQrSEN2aTdMYStDdGtrQ2lSa2dZa3llM24z?=
 =?utf-8?B?dFNOd3FoNDdzZjAxV2FIYUI1amZJRzJGa29YUUpYTEtGSnR5anN5ZjNsNFFM?=
 =?utf-8?B?MXlVcW1UbjBVNFdiWU5CT25MdkgvZlAvaU9JRmFlOGlYK0Fjb1BETCtDbWwr?=
 =?utf-8?B?Y0o0dnJvRWJHVFkvSTgvZDV0U2JUZ0dzQW94QjZZc1puMXUvczFVaDQ5VWlw?=
 =?utf-8?B?ajA5ZGNJa3RqNzFkTDVBallIOEE2S3pManM5cjllOHZ4M3U0c3pEcnNkUkpV?=
 =?utf-8?B?b2VXRHJHaTBaSERWUGUwYmdYQXdNWmM2NFRJclpKK2ZYZCt3V2lROENoM05T?=
 =?utf-8?B?NEIxOTNBa3l6VTJjeW80cnJGOXI0Y0dsTUQvcDUySVBuMGJybHZCSWQxL2xV?=
 =?utf-8?B?RFZnMzVEanlKTVZRaVlpcW1mZjFQMlJyVVg0Q3hXRVQrZ0UyRWhSeVZlWkhQ?=
 =?utf-8?B?VVUzT1FJNHZ6WWNLTlprdE9HTWJ5S05aZnNVWEJzc0FaU1FaTVFiUUV2THE0?=
 =?utf-8?B?UkxKVVNKeUhiUThzcldXU2xZZXR4YlV0UDFIb0xQc2tDUGYyNVBCK1hGQjgx?=
 =?utf-8?B?YVlDZ1AxWnhCUHNyYnp3Nk9yUjVaeUg5RCtOVjl6UnljTDVZZERQSWN4OUUy?=
 =?utf-8?B?U3FTZWcvcEx3K3l6NFprTGU0REJJV05BUzJvY0NlRmZxQ2VyUGVyUHNaZDE4?=
 =?utf-8?B?V0txU2d4S1RZdkhpUVUyQXBML1h2NUpRcjNLY0JWdHRiaVJnTU8yWDVMTHZI?=
 =?utf-8?B?Z2RkVnJVcnNmOXVsZHAyQ0xGbGdtbFlaOEIrQ01lcksrcThLRlNLNVVQNW5o?=
 =?utf-8?B?N0xqaDR2RUJvK0N2RmlvQ1d0ejNBUTZJdndpcWlnTE83emkrZFRWUnYwdkxZ?=
 =?utf-8?B?blUxdVZoYzRCMXhlYkdEaHJLN0IxTStMbnVveld0Q09kUnBEWElGNHhwdTRW?=
 =?utf-8?B?cmN4MlBNRG5XcWVCUnZwQi91MWJ1UW41OGlmbnpYcThDdnpnVitsT3RLbEFJ?=
 =?utf-8?B?bHdqV09QYVJhcDdqRmhiMjVWdy9hbWlKaW90YXo1SkhZWjh4QkpHSkhvTWly?=
 =?utf-8?B?ZlBjVFpuSzFsbStWQzJ3ZlMzQXRDeHJxS205a1NER3lnN0ZTOXBNVXZhNEpO?=
 =?utf-8?B?eDltUG1RY1RqbFFKNEhuT1V3Sm5FRjlENytRTGZrM3p2eUI4TW5ic3VxZFg2?=
 =?utf-8?B?WUNueEpGNlBNYldzc1VwUXUwWU5QdURUbjlXWEJLdGloR3dPekN3VlByQmxj?=
 =?utf-8?B?bDl6d0VteEVROFZleG1jVUx4VVFxUFFpYTlWR1RKZ2ZRd1g4bVNYRVNFRENv?=
 =?utf-8?B?WGIrSVR4Tlp2MHlMai94WUNsZlEybFRCWWxibDZYby9YUnovWThGRnRJNXMz?=
 =?utf-8?B?djBaY2lwb2ZmdW9QQXVPS2RmdVhSYlNUT25WRGdrODRYRGJDbFVaWEdvT0wv?=
 =?utf-8?B?anJwK20rdkViODdBTndaY0M0a0d1MjBOVEl2MWlWNUJUMVhic2gxV0JGQ3VV?=
 =?utf-8?B?Q2tjZ2JLd2R5cXFkeFpaWTh3aTA5c1FmY3FQVmtKeTBDeFZaMTgyQT09?=
X-Exchange-RoutingPolicyChecked:
	ddQqxlgKu6blAy3g/TZYBYHBmYXgaD+QsWCBecckt5qq0ar0u7w9a0ewZNsxV3uCUOuBhbt+Gm/zvfg84ieGHhiQ4dL8WILDLKgeRqQHBFdzDaBe7gUT/bwOxX9/mh+LTIQhR1sLfsLbsv6I6Vcuo5WL/oeA9Eqkgsvr44nuzhCIgXYvAlXPRn3Tg1QudkZ/Sz9RqEk0Dq1ofhUQKqBGjP9QUXLPi74gax3U9B9vLt7KOZCFXuy9w1mtXvgb7F7kbNcfm6KPjWpLRQf8M1ITH2aMVLzF+ftOpbUApEFuLQDaQytSXtuB3uBkWmBpCP5mdYSBUIBvqF4Jb1BClz6Ddg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hj+TfhGXokmIDA2foCkPCnVZPSCY1fA66tAPbe7b0TzaiU0AcFl6SdqU1K1CIsNeTztjFFATOJTHAKUSlzixXgzaL12DB0AEpFNIi8LKPYdXtzgpDkhvRCSduLcxGbbDjdkZYACWx4YCqjwTe0FuK8xe3a4decHK9pPvN5rzMScWPfXHbbHTEF3VrUu/pScq9FYgPvU4I+SDmawcgMy3h3gojh0qTFS79mpeRbjC3X+0g6bkZONY/T7vDjeEY7NqwURxBJfmgU8xSmIkSNlUuq+AgjbuWXHjAFE/XT/fBmd4HRX2uyoTdDW+Y+KNdCDPRKNeCd2X5vjPfeMcNgSZ1EGe/goSS6wR7ron1JgKfMxSEfcB5Aohn472cbzQbvV3d5ZD9ERspfFFsQqI4qwu0yXCHJBOH4J3W0qA6UOWJX7BZWrPT7btDAKcDjbIo4rLfFk55BJzfs+qk9z0cPbDICryheYqfaa6Hued8sBx+5LvlO85eR5rkPMzOO6UZYnptcX6r86zN0wlyc+AeiFAvO+ECfrxVrHH5LB7PpalAhNzDUsYhprXjx5vxkjafPppauOZa1uKNiOwjYHM4Qkzl3dWwuKveQ5TBpF2EjxYoEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e639184b-e051-4681-f772-08def1f6450c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 07:01:55.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uWceUVCF0GoHYRk+vv90qqydlebGMwB4ps6pgHgQ2a/CceyuLP6+51r7gMwM7C6a9TU7qSnobypbSUqcBfUeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1652C44C3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608040054
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 3fcttyRwghbDr9BNuz3FNkDhsdDMVF2E
X-Authority-Analysis: v=2.4 cv=XqnK/1F9 c=1 sm=1 tr=0 ts=6a718e68 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=RpNjiQI2AAAA:8
 a=JfrnYn6hAAAA:8 a=tHa68p0SAAAA:8 a=yPCof4ZbAAAA:8 a=ya1zhBcA5Rj874hJU04A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=ufIsyHvWW7FwcMbVRpPq:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13510
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NCBTYWx0ZWRfXx1kLl/rn5nAE
 iAM5CaW8X8OMaofx5so3iNTXBF08EbSild7ED58FJwP0hfUE69DCVZwe3UVehKSmFclzVyWx7hU
 z8Dq1eaSw+3a8UEdZ0NqV2yNQ6/i8G+i4b0SRtBpRfT2mb0GAoA5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NCBTYWx0ZWRfX08KbORAswrFQ
 J4EuLhTwPliJGxn/zZAEUzYhS5wPj4iOIs+hIGct6hF18U02r+ciythPm6pyUefjLFHgSoWUVax
 OiTLEtlnh+xwh/CtVUApSRJjzMylB7MiUxEbp2UvsPqyFyjgdij7BC2LAYKZyYmNWeE+NOkcTcq
 r8CxASW1RE2cGidzixsTxI1IrKO/yi/AX/ISfxNdWtcQ0CB43lDBD3CC8YmbCsXiieHvjW9JZOL
 n0Nj4XPkpumqD+a+PyWsoSZfbkM8GXSPekFpsSx9KgI5RwSBjjON+4y6y0DaHUmlsZFz92566R1
 YQFOyuZKtRv7/LkCHRjN9L37mgnXMJwGrQciETN/YBX3BHVCEOlyBTIcvd/YEyCF4y+oFUu1fVW
 exBT14fc/EsN5WoS4bfmgXSrJoS7i1Z3e7p/gQML0TV2t6s3yoO2Kxzh6hGWbSPOSM6Zgrwjvyk
 K/bZdRK4vebsD/3OyGEecK8zhzy8BEsC94wxOPJI=
X-Proofpoint-GUID: 3fcttyRwghbDr9BNuz3FNkDhsdDMVF2E



On 7/31/2026 1:07 PM, Matthew Wilcox (Oracle) wrote:
> hugetlbfs currently uses an fs-specific way to determine the size of the=
=20
> folios in its page cache. Thanks to the support of block sizes larger=20
> than page sizes, we now support this as part of the page cache. It's=20
> somewhat more efficient as we
>=20
>=20
> hugetlbfs currently uses an fs-specific way to determine the size of
> the folios in its page cache.  Thanks to the support of block sizes
> larger than page sizes, we now support this as part of the page cache.
> It's somewhat more efficient as we have this information directly in the
> mapping rather than going from inode->i_sb->s_fs_info.  We can convert
> the rest of the hugetlb code to use this at our leisure; this is needed
> now so that we can use filemap_get_pages() unmodified.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>   fs/hugetlbfs/inode.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index dbca3f713bbf..8d15413a67ee 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -883,6 +883,16 @@ static struct inode *hugetlbfs_get_root(struct super=
_block *sb,
>   	return inode;
>   }
>  =20
> +static void hugetlbfs_init_regular_inode(struct inode *inode)
> +{
> +	struct hstate *hstate =3D hstate_inode(inode);
> +	unsigned int order =3D huge_page_order(hstate);
> +
> +	inode->i_op =3D &hugetlbfs_inode_operations;
> +	inode->i_fop =3D &hugetlbfs_file_operations;
> +	mapping_set_folio_order_range(inode->i_mapping, order, order);
> +}
> +
>   /*
>    * Hugetlbfs is not reclaimable; therefore its i_mmap_rwsem will never
>    * be taken from reclaim -- unlike regular filesystems. This needs an
> @@ -926,8 +936,7 @@ static struct inode *hugetlbfs_get_inode(struct super=
_block *sb,
>   			init_special_inode(inode, mode, dev);
>   			break;
>   		case S_IFREG:
> -			inode->i_op =3D &hugetlbfs_inode_operations;
> -			inode->i_fop =3D &hugetlbfs_file_operations;
> +			hugetlbfs_init_regular_inode(inode);
>   			break;
>   		case S_IFDIR:
>   			inode->i_op =3D &hugetlbfs_dir_inode_operations;
> --=20
> 2.47.3
>=20

Good idea!

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane
