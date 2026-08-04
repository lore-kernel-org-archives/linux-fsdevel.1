Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68794341068
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826090; cv=fail; b=NK4ibBJQLjoFm1APG0qZINnKISd0vK4qSkrHeuCfQUNmGsf7oBdGB855ZsfxZ8LPUNFyM2My3zohgLRaQi8iTCiXSkI15xG3h6NcxQjHzNxshs7ok32O2ohQdlQf28JWraSpRRBq/Ng50A2F9CSgViFqcIcg1f3sSmXHfe/BnXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826090; c=relaxed/simple;
	bh=+1YaCSiGs8cQXUS77taDIS7IZFO9RJN08JDvulMyT/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=aiQBsetKun1JFqg+rr8kaOlsd8ksBpX/GQvv7gtPCAKKXpDrraJX98RN0XYBxGbBH3o3tdsAkSTEtvS+rNzAFQ58ACOpS+Cvm/IgyhxJnF5uCnnUeatdbnA3XrxZoC10UVErZ9lsPwzVOOcj0zA04QG5DcXjqN95xd5GrPrm7CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qdmHh9gD; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rqyJHXzc reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qdmHh9gD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rqyJHXzc"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741QoHl4093588;
	Tue, 4 Aug 2026 06:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SCV4+t0RtAISgpF/HYkkbLMwpZZYhNHZKLjMhrpwKlY=; b=
	qdmHh9gD902965zTUQ4u+OCa95TEUreaOrDDTcOcnjppZfOSUge0W5px8X1bQCWl
	vjyU12v/kRLq+vhPJgfmWsjPH8pBu4YXmajCp3DMShRaesuHtWsSFJgTMepLcftc
	IKDbEqNEPZTgthZ6vRSW4Zk/no62tIl0iLp4Ae09kn0blF0HT4xYuBa3H3TqCa/o
	cga9mX1G76GPk5bX5M+66qJPXN3/XsXUuI5uGbbAz0zWid4l3sgq0zzY66MrPaTu
	HXMUm0XRaSUGVQKxd2oxjk6k1c5NPrnA0sN+v+d94/Twn673L3wjlDAKBKZ8rszF
	NF4TH/4VBFhYaQvK5V6NVw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs9bt4yjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 06:47:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6746jD8K033518;
	Tue, 4 Aug 2026 06:47:27 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78bhmux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 06:47:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQUwYK3Nu6nzw9ZHiKAYvVnvg/0K533wk4ONLnBHBVb/0aam2b0NLGJ8sVtXPfqfQ5siyOD9KucTM/RN8debmLd7dmoi8qstyHMEhoq4q8iUbZxENV0oMMtJmOR49PzzE8RdBygyJS9rTvWzx9I+LhVVFwqzV7xEqBxTKrbfmTYiTVnmRtayn1kU91U1/m9mfx7SaFw8yQrLbRyuMhD72d7RyUetBs+0siPQVdfMYYZi2uIAe9N979JPWjAQGDKqjqdCuyievmOy/ZXRWoC1PaAzN98BxqWJ4YD7vTzM2254BknQVzEmNz30sXeZ6qcUhOevG40808K6BwwGEsXe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMKst333ooWqo2g/Xykb8pjAg6rx51M6Lj6qxpw16Y8=;
 b=y4SDmIX9h75GbWRUI7cNXvXQtEeFkXb5bmJsQ1PxnsDUv4KLRpcFpfty7KNFhlj0F9O0ubz5dOuQ6SVXkfdIRbXDJXeeM1Vs1GSMpASOw4giDvZbU7WHz9qY+cHFpzTCBSmhoGYqy4PUs71IXoXiG2i9P7bGRXNkt7cJxQW9nubMXVU3ecHoodi2B1q0T5praokRTF2l+B+2hPM9OlYmgOFWYRfaNX3hhyCHxuihDEuey0ktNzoWMezcSCXZTb7jQD9iP6bUT7WeZ1D00GldVFLxrUjBlgrlnRTsW1/55jx22qnK1iK7552q73JAO/xBoWlzk3Gdae3rie4Mj216mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMKst333ooWqo2g/Xykb8pjAg6rx51M6Lj6qxpw16Y8=;
 b=rqyJHXzcuPKUspkeSljLgNLq9V5HMTYeElG6NoP0ubP87xdQYnq5Rfd0M3mnUYwraII4zuR1d8+9coSBLmyr0K1kT/OrnrGZQoGfsFG7nGmgFBCuEKI8Ev0J9khG5DXOgEbXlHbzYSxnBhVgh3rvXGIZm7EU6/EEhRhgiUkEre4=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by SA1PR10MB5735.namprd10.prod.outlook.com (2603:10b6:806:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 06:47:23 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 06:47:23 +0000
Message-ID: <e7530269-6581-40b5-a0f4-0cdc78d9793a@oracle.com>
Date: Mon, 3 Aug 2026 23:47:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/15] hugetlb: Move poison to pages before clearing
 hugetlb page type
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jiaqi Yan <jiaqiyan@google.com>,
        "Gregory Price (Meta)" <gourry@gourry.net>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-8-willy@infradead.org>
From: jane.chu@oracle.com
In-Reply-To: <20260731200802.574821-8-willy@infradead.org>
X-ClientProxiedBy: CH0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:610:b0::20) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|SA1PR10MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 5976cec2-6ede-4a3b-b2ac-08def1f43d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|4133799003|4143699003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	SjiQrTi1gS8ZYmEpbiOLgmOq9P+1G8yeFweg4B1fLrDHK4y5cobOl35FHlPCAElkro/MAo7mHZglx/uBpJUe7voVhqnLS3dbVyP0U7fnG8rxVFJVzx1Ewb4DXLRmRL9uF6qk9BURjQKm1ZcQgCGMe+48DkGTwNTVDTsohBSQuAb4o3YPYOYtVcVFq26rdI5/u1/XFWD/5FEfgtK8S/FVHZxcKCQ/zkSxlpgWumAcXEhUZI4IP2gteWaifCBzGxU7NakWNIypO9h3M5Ej3Rd5o/1fPK2lHgOeCjn7stxUU1hRduuJogempB4qQlI23wuvqcS0nfpiia8T4zfOjvf8EI6EoPjMpYkE40MvNfma0Zc9b68naUChVi1ZtMH1wiiLxRDf19jaH89rvDKCV8OGQOXHVVcaEg5rJKCk+7kNmvKT1Pjg8CILFZSH7wU+3HMAkjI3Nga6tt2v/9R25kKbAZpPLGGztJWoAO4stJ3sew7iNB8XGCiFtbmLmDSh3a0d72Cj2Xr4LEuRX4v0o2/8L4FCYs2G7B2GpSuU2OOHUVhA6Kq1VLaBbfLNt4pOQZPuNbHqKhQELkzXcI/7C+7eQvZTr4PNIPMLp74gTSFu1MsmVeK6yqSUwFghUXJRTPDjNSmMT2ASct5zeqMq5gTOtCZ5FuwYM0gwftu09Hq6oDs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(4133799003)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3VDZGZrcWN4ZFk0RENyZS9sYWJ5bFc1QnFRVTU0WjBleDRvWlVFRWsxYmxJ?=
 =?utf-8?B?UFRLQ2tkNjFzTXNJWHlCZUFwNmFiTjZKbEhKbE1wTHIrRm0rREJ5M2gwaVU2?=
 =?utf-8?B?LzdjdWJHQ2k2dWVYeHBGRUF2UUNjR0p5UG1GYTZvTmxFaklDaEtZeWpNeEtH?=
 =?utf-8?B?L2lwRENyTnh5QlFDa0VMNnM0eHRQMlhycmVVS0RtNHBneXMrR0V4YXNGVmM3?=
 =?utf-8?B?RzU1WVFLMDhQeHdPRGFLYUZKQSt1YVEwaGdEUkhuekFOUktPM3FHV1ZUNFFy?=
 =?utf-8?B?cTdOTjV2ekdJMXlaeGJGTjhUS1UxUVNkZ3hkd2dMRnEwS2pFRjE2ZG5zRWpo?=
 =?utf-8?B?ZWE3WU45Yk1pVngyRzZvWFp2aFFwV3k2bzBEZ1FlVjN1cU5hbkxFRFdYOFVR?=
 =?utf-8?B?WjRKNitjL2VHVUFtaTF4eXEvNWZKRVVmZU5YYTQreGVzZGpJYW5GdktNMldF?=
 =?utf-8?B?aE1kYkw5allMZWNkVFJMb1BtNlZPbXBFU2hkVWdsVnBlaWxhNzJ1cDQzeHQ2?=
 =?utf-8?B?TmZHMFpPZ3hMYlNFR0pWVDBabW1OMmFLRGh5aDJUWjQvclF6VkhUMnlwdnNY?=
 =?utf-8?B?UW5IT1p2NWpHU09wSlUySmRtOXI4VU1ENkpyL0xtWGVxY2NkOTFEcG0wSEJ2?=
 =?utf-8?B?UDB0VHVCa1hjUUxnM0U0TkxjTCswemFtbStuMkZoZCs1VTFHQ0JPMG9URXpL?=
 =?utf-8?B?dDBkMjJkbURTVHpPNmlpMnlBQ2lWUFhweWpXZnBrWFhpYnJXaVgzQUh1UzNs?=
 =?utf-8?B?eGdTT3BlbVIzYmxlWjJSaHd5NHZYMWpJWkliOGpVakZSZWtQbGNrSmZZY3RC?=
 =?utf-8?B?eVdFUm9ETHg4MjBKU0dueHJUVHc1anNDcFY3bVA2NHVtUWpUZ3M3ZkFDWUVC?=
 =?utf-8?B?QW5UeEpGaDNZTU51VVhYb3hEM2RFVTU5aXNjejRLK1dtaE1xRDRpbzJDMVBy?=
 =?utf-8?B?N3FyWkx5dU9HaTJxeFJ5U25ML1ptY1EzMkw0dkJlb1dJL3gwbmoydW93WUVo?=
 =?utf-8?B?VGkzYS95L1VWOGM5T0hUZ2k5T3p6dEtuLzJOUWNWZ1ZBamxRRTE0Y2MzT2Z4?=
 =?utf-8?B?MFA2NHpPa2FVVWhPaTJMRy9KbCtydnVWWGdJYURGd1Z3UDNIRzdJL3ArRVZk?=
 =?utf-8?B?MUlXY3praVlBNmhqR1crNUpocmhzSGlqakl3clJlMUJnKzJnWEk0Vi9qT3d0?=
 =?utf-8?B?azJlSmVqSStLSEs2dHNuQU5xTXpGRm5Tc1ZyOFhXdi9UcWNwSzRVcGhHd2hl?=
 =?utf-8?B?MTVEaWJmeXYra1hlc3J4RmhTYkpuMllpVEdZekNFaWUrSWYrMDFtTEFJb21Y?=
 =?utf-8?B?cDVVL3Vxai9CblhMVnZJczdnTFl5TmQ3d0JvL2tKV0t5eDhKUHlIb1NBdFZC?=
 =?utf-8?B?aWhXdmYzN01KS1EyOVI0b2hCM1ZTYStJNS91czdSWE5aeWRGa3RTaG0zeUlN?=
 =?utf-8?B?ZnJPT1RiNWdzcVEyYTF6bmtrd0UrZ2l1U3BWditXRi9OQWVBTUF4MVY5ZmVD?=
 =?utf-8?B?VlJvcitQemswM3Vzbm1mdlFEOU05SG5ubnFuakxkM293dFJ6NlZCWUtDbDUz?=
 =?utf-8?B?Z2h0WlhMS2ZSRVZZT09XaUxmak1Bd3NpaTNVUDJGNHY5S09jNU1ldE91eTll?=
 =?utf-8?B?L2VFdStyVkwreHIrWlpNOU1Tajg1NDg4ellSY3RSQXJnK1JkME1jMVlBcDdY?=
 =?utf-8?B?ZDI0S2E2bVdUQTVxZjZpWTVnb3pWOHlwcWRPTzlZSUhRVzJ0b29UODFrWFRX?=
 =?utf-8?B?VEpFdXVWTCtMTDBRS2VlQk5QUFFubDdpRmVNM01PTVpuSEhMVWxVelBrSDRx?=
 =?utf-8?B?aXBBSDd2Ty9TQm03UWtLN2NtdnN2dVRFcGF3bXc2WFRGajVmQ21ZejhqN3ds?=
 =?utf-8?B?YnZOY1JDaDlraWs3SzlHSWxkaEc1WDlpU3VIZm9iRnp1Y3VtMWhKWjY3TWwv?=
 =?utf-8?B?anZXMHdBTFNGZG9IeUd3d3ViM2VjK2h4UzZqZWFXS3VTaU9FZmp5NzNqbTVR?=
 =?utf-8?B?STUxNTJiRVNNcmg2M0pQdmdOVEV4dHRjSVpnd1QvZUVKL0c0ZUhzL0krNGxN?=
 =?utf-8?B?Vm1VbWNRV05PYU84bjJXbHBlcEdBa2dXNE1nWDVocVZNN3NBNVpGVjVwcHBv?=
 =?utf-8?B?S1BuMFN3QWxrTDQrLzNJc0V2b1IydHlVWXhpUExCczlvMm1EMmQxWWtEalpI?=
 =?utf-8?B?QThJSmVkcXoxZTlUakFKY1JObXdabU1XY2c4UC8zTEtxK0F6MTZsaUd5enBB?=
 =?utf-8?B?dTZvK3NiR3g0NXk1NW1FQWlGZENBbTdiNjloQkt3SnBPUDZPOUxVNWRZVk82?=
 =?utf-8?B?dzRCTGdRMTYrRTZZQW5Vd0hNSTd0RmhXMTgyNWxFVDI3blYwelc1QT09?=
X-Exchange-RoutingPolicyChecked:
	ZyvpZibNqWl81e2ccoswjwT5n2Ldul/7amwWg+IyocwawJX/wEaOho3B91oz8FIDHaRZn4L8/3L7zqRGJ0ET98TTZyNLduRLKZ+IWUZjfQ/6o9Db0VUaF2P1btr45D3/+8a8g331RtNJyeWwt6NSkOSI2D6Y0mCKtWMooZxbrIvit9mwzla/3IooH6ZIfYZ+16Ia/tP2XtaZI5jlzZa1YE17MsYkBNUATtiXtW0NjX4NGUtSMhaHNKjILBkYtUUgegeuqBhEjA16Ju25+IsS1qQWIL5fqCA6A0NTFWUB/0cPj/kqv60MMwclve4e+tXyA/T+W9mWIoL3sRpZi1/O3w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LUuT//N2vksu23aGiy23HtRwGlJHkIR1CdMnY1uuABoaBZwxHmnkOMbVan4q23z7+v9mEKiqFuJ6L4ioRVbp8+ES1lw4DtAcK6fiioU2L/nU93gjMNjXZHUOsm3Mvg0wn6uNwc68cHEA56KdO44TIPW7pKyhdig9JQCUEbNC36n2Toxzv/NNMdsMv9AxdBSGJXxqdeEWJCZijgOxIXpRSOOr6CisIYOAU7LtyMlIWtj6oh2E/AAujjrJ//c8HfhWXajQykX+PcL/AFOCCCDc5sY4NElotsiXcAyEDX43RqxFW2WLGxOl/mG9YaRSeu7BXG0higc3T7vtLhuDsVNHVG2RJ3tu/ufwu0qdF9gzUCiRI3ldaVxTwL1JyGofzrNq06NZBFGMHSwDIKMvVywlubVDoCrHbleZWZAecFJoa2aqvXvSAlB0Qti7+yghZQt384n+W5SVM2Yd8EMZ/gaGZfLZGUGmDwjqeaJnaILJJzwBn9KuSFwxC6LMbX8sCNbFPKMSqqhfLApdvX+TAnRwi/UdKJXArGL6waApxgAD7D/75UtBAbzI2vcoYSZx+lt8XbbP/fRo1Ck65B0tqwBsNyXHO36B+HI/hF89/IMndY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5976cec2-6ede-4a3b-b2ac-08def1f43d1f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 06:47:23.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZzPwyhfv62ps5WFfu8dJcWpnv/W1Qbe2sPGv4x/u1kLI3AW/oSC0InmWUpTKoL7qJI1YtDs1dDAvuLQRL55+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608040052
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfXwq+PmILOIc9L
 NifKrs/QBYLx6+ZYFz1WraaOxzTC+dwzDX4yT1RZQHR2Oj8AeNvh/UMxzv6NVrNF8XkWhVswt//
 7k2Nu5q+JPfHHrVZqQchI3MhBIt++UiAgkAQkh3Ixu5sNbjIzUpfmBlhAV5R27wZyTCom+PFdi9
 FfXOxBmu34sJJm7XWDYfoSAwWDCAns8h1RTPt0Uqh+2YrSZoUUPW64SjidVuvmontdUTER9VpCp
 rLi+VeyDvwvR4/+j+OibxFeo7KxiwW3HGonSqj0i3n8kKPsgaUX0xhJ0ijMWtbpE/+UHc62dyMl
 DCDgEBhu4q2SL2p1oeoCTJvThz3x6Q25vMaH/Isf4o9zQdwOv3b4Cgsdy7TlHpO+38mav/kxieB
 Zx0zhTJ0dUazaw+ibnyXVH/+3SXLCBQeB3U3CuavznwufAplE9N499skJuVgEwzEx9PDlu36GHJ
 YrfKMpa6MxcTfK42gHQ==
X-Proofpoint-ORIG-GUID: gur-Yn57ggbQ0b9U6kILrhmwHKu-Pg53
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfX+zqWNmHM1v1z
 py1V1bPVV4N/UXesJvrHeYNa4cSchrz0lrYqsbI6YRew/jtT6Co/CCo1ZERMD3IyO9pf2F2Q6hN
 Q3lYrQ9pzh44h6qG6LxJW5YPxHs2aQteQpbxMaPrmgQDN8rrgqhB
X-Authority-Analysis: v=2.4 cv=ZOTnX37b c=1 sm=1 tr=0 ts=6a718b00 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=RpNjiQI2AAAA:8
 a=JfrnYn6hAAAA:8 a=tHa68p0SAAAA:8 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8
 a=H0AsuSdS_hEipyeM5Z4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22 a=1CNFftbPRP8L7MoqJWF3:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-GUID: gur-Yn57ggbQ0b9U6kILrhmwHKu-Pg53



On 7/31/2026 1:07 PM, Matthew Wilcox (Oracle) wrote:
> For is_page_hwpoison() to be reliable, we need to set the hwpoison flag=20
> on each page before clearing the hugetlb flag. Introduce=20
> folio_clear_hugetlb() to make this easier. This does not by itself make=20
> is_page_hwpoison() reliable; see subsequent
>=20
>=20
> For is_page_hwpoison() to be reliable, we need to set the hwpoison
> flag on each page before clearing the hugetlb flag.  Introduce
> folio_clear_hugetlb() to make this easier.  This does not by
> itself make is_page_hwpoison() reliable; see subsequent patches.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/hugetlb.c | 31 ++++++++++++++++++-------------
>   1 file changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cc8d98399913..47403d02be88 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1381,6 +1381,18 @@ static struct folio *alloc_gigantic_frozen_folio(i=
nt order, gfp_t gfp_mask, int
>   }
>   #endif
>  =20
> +static void folio_clear_hugetlb(struct folio *folio)
> +{
> +	/*
> +	 * Move HWPoison flag to each error page
> +	 * which makes any healthy pages reusable.
> +	 */
> +	if (unlikely(folio_test_hwpoison(folio)))
> +		folio_clear_hugetlb_hwpoison(folio);
> +
> +	__folio_clear_hugetlb(folio);
> +}
> +
>   /*
>    * Remove hugetlb folio from lists.
>    * If vmemmap exists for the folio, clear the hugetlb flag so that the
> @@ -1419,7 +1431,7 @@ void remove_hugetlb_folio(struct hstate *h, struct =
folio *folio,
>   	 * to tail struct pages.
>   	 */
>   	if (!folio_test_hugetlb_vmemmap_optimized(folio))
> -		__folio_clear_hugetlb(folio);
> +		folio_clear_hugetlb(folio);
>  =20
>   	h->nr_huge_pages--;
>   	h->nr_huge_pages_node[nid]--;
> @@ -1493,17 +1505,10 @@ static void __update_and_free_hugetlb_folio(struc=
t hstate *h,
>   	 */
>   	if (folio_test_hugetlb(folio)) {
>   		spin_lock_irq(&hugetlb_lock);
> -		__folio_clear_hugetlb(folio);
> +		folio_clear_hugetlb(folio);
>   		spin_unlock_irq(&hugetlb_lock);
>   	}
>  =20
> -	/*
> -	 * Move PageHWPoison flag from head page to the raw error pages,
> -	 * which makes any healthy subpages reusable.
> -	 */
> -	if (unlikely(folio_test_hwpoison(folio)))
> -		folio_clear_hugetlb_hwpoison(folio);
> -
>   	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
>   	if (folio_test_hugetlb_cma(folio))
>   		hugetlb_cma_free_frozen_folio(folio);
> @@ -1595,7 +1600,7 @@ static void bulk_vmemmap_restore_error(struct hstat=
e *h,
>   		list_for_each_entry_safe(folio, t_folio, non_hvo_folios, lru) {
>   			list_del(&folio->lru);
>   			spin_lock_irq(&hugetlb_lock);
> -			__folio_clear_hugetlb(folio);
> +			folio_clear_hugetlb(folio);
>   			spin_unlock_irq(&hugetlb_lock);
>   			update_and_free_hugetlb_folio(h, folio, false);
>   			cond_resched();
> @@ -1620,7 +1625,7 @@ static void bulk_vmemmap_restore_error(struct hstat=
e *h,
>   			} else {
>   				list_del(&folio->lru);
>   				spin_lock_irq(&hugetlb_lock);
> -				__folio_clear_hugetlb(folio);
> +				folio_clear_hugetlb(folio);
>   				spin_unlock_irq(&hugetlb_lock);
>   				update_and_free_hugetlb_folio(h, folio, false);
>   				cond_resched();
> @@ -1653,14 +1658,14 @@ static void update_and_free_pages_bulk(struct hst=
ate *h,
>   	 * should only be pages on the non_hvo_folios list.
>   	 * Do note that the non_hvo_folios list could be empty.
>   	 * Without HVO enabled, ret will be 0 and there is no need to call
> -	 * __folio_clear_hugetlb as this was done previously.
> +	 * folio_clear_hugetlb as this was done previously.
>   	 */
>   	VM_WARN_ON(!list_empty(folio_list));
>   	VM_WARN_ON(ret < 0);
>   	if (!list_empty(&non_hvo_folios) && ret) {
>   		spin_lock_irq(&hugetlb_lock);
>   		list_for_each_entry(folio, &non_hvo_folios, lru)
> -			__folio_clear_hugetlb(folio);
> +			folio_clear_hugetlb(folio);
>   		spin_unlock_irq(&hugetlb_lock);
>   	}
>  =20
> --=20
> 2.47.3
>=20

With the patch, we're dissolving the raw_hwp_list at the earliest=20
opportunity upon freeing hugetlb, looks fine to me.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane
