Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E7941E6A7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827031; cv=fail; b=ucUlFjtN1wBtH5EtsJPltpFGjCVYz3KplkInYV/TWNxoMilRHQjchxwwFU8s1EH/P7nM26qDMBZMMQpm8vPeNCAudb2/vfWrgstdJGCkPXpf47fzJnd31kTrW0ECCLc5jndOT+hqktFEuo83/CCGF4gr6OAzS6X95yAE3W4yDGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827031; c=relaxed/simple;
	bh=nA7wmx0qgQ4Psc3gtSCwVfrEGPGqQ395gb+yGmtlk1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=Y+evZeDP/z8Oya7J0gZ9nTiMm4d9xf9FKIv+7VtSFJmdt+EyNM/1DdyYBuXENqLImEX7nieNkv0W4d9wCs++yze74LIQLGLjIOLRsMZO9zdlR5r9LYTichovBOw557ZLCtL1oGvbfzr3rM3tXeDIj6XM+QB8lWTweq3Qhqp6vgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=la2Ni4Az; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hh8BvkKL reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="la2Ni4Az";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hh8BvkKL"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673LCZ9G3099052;
	Tue, 4 Aug 2026 07:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=t0oDuLhu64BuYUOkxcNBO2hi2u6IzmqTXXMZ9RzvXQM=; b=
	la2Ni4AzYRYXmrRuWgeqth/BGrENvqqMEt+Q2VOH7S7p+oldxLPGIz3WBuNteMO3
	3aJrHGOUIyAWYTnKUMSpfiNekHAnq594foknWM7ovqd6QRI1gdki3nONMfVLleN8
	LposBcfD9spxsLryAGnWvFuiamSwYYnZ998XpbkBnItOQQCZaOy/cBLZpVakjf/z
	/tBUx92YDx7cXNbkjKvVlt+dJjnnKe/06nRYaViEQjocOnTdYktg9wnwzwrdIVNQ
	PAG+77InYtkey9qVXiTjYRWfqxGcugsv3xBIEM8T1SR7OTDWqJZOWS4RrjRG84NL
	Rap61eeqxwhcX7EYNW2M2w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7qa5d14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 07:03:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67470eLi021213;
	Tue, 4 Aug 2026 07:03:06 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78srs8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 07:03:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvdVaeT5lg+loKc5Lm0xpy6PzEUicrYHicZy1dspbr9glLV39ZUaivBG++wWSX0segk3i8Dj8QLpuqYWEXSM2CJ8i+G6j1Emz2gLH9sEwWFtFrYJrPf94AG9bY/C9IiNltpSRHXhakBq2rmULPStuZKN7y+2zeHE9IzYDUc9larTu+BlfHhjYe6fFBEBlKWv+L95A7H/IoWQqimxOVZGWCSWBHc3eleU0llXDOBf1J5DQsoJNrb7sqUdC5kicUiPRx36oLuV/5FCQhbhjn7yA+zxPDRHHzezo6cH26I0CwA5eTZ/7osGT5qwVROS8Rird56Fq1iqzDu3FPzbVV8UiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCIVMVBGOFoOlSGnIHBKkMOdDXixXzGhKO/G37Qe9uw=;
 b=Odcbh8HLDxeCZV+opAGEOl1fO+VsTchXmxocSt165SgYmPvjaIpj6aN/62o3YfUYK649DFVon+RxT+x8cw0H2v+ZRCpRWeF6t5uWnABMF4xPFAVVHAQMRKq2jVoAzRAgeauxFHD18XX5kejEzeyYDD+6B/MTI7CWZmbeZX4DaamSMs6aAOZWMorHtYsMA0uISfnrZ5E36z0xIk8zaUZK9b+rBmjGnfifZ8ccqOvhCHiwRAOlS/DT2tq5MOrbSNjoKT6+H0xiE0KH8aY0fCXWfH9ResxoSL8wmWD91W8NZ+YI/vwS58cU9j71KY2jCrI97Zm33doXBjCezmqKv/Qwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCIVMVBGOFoOlSGnIHBKkMOdDXixXzGhKO/G37Qe9uw=;
 b=hh8BvkKLAD0R+xsQH4Zfs/ia6tXlAvQreCvgwPk6JuOYytqTFemcBxZ63GTUSx5gKMi++Jvem7IVybccpjNkb0mKGjgQgoK5gZXF+RD/7rBcEfgDeep7pRhxSLkJRKutnwx+FXTu4IgjH1FDn78J8isbX33sS4wr1sAOMHIZpqI=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by DM3PPF1652C44C3.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 07:02:59 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 07:02:59 +0000
Message-ID: <5776d0b2-3bfe-49ac-b771-8021aaba409e@oracle.com>
Date: Tue, 4 Aug 2026 00:02:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/15] filemap: Add support for authoritative mappings
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jiaqi Yan <jiaqiyan@google.com>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-15-willy@infradead.org>
From: jane.chu@oracle.com
In-Reply-To: <20260731200802.574821-15-willy@infradead.org>
X-ClientProxiedBy: PH7PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:510:23d::16) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|DM3PPF1652C44C3:EE_
X-MS-Office365-Filtering-Correlation-Id: b78b5baf-81df-46f1-49a5-08def1f66b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|4143699003|56012099006|4133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	IfPQhn47rBC9VNSXWy/nduYxkf0I3lNMRpsXy/0YmwPn2EV3lUoGe1uIBftIOB+IXR9uos+JctS4btK7M5KwDx5svC1dgyETdXCLLkjizsf+LuP/KDx1XaDmOVzDPbQn0z4TAkf6iIWtmxn9zFMrTC6oDZpAUYjB121pFrJ4/YkNDAlVstBWiNLod96kVIw1nY3rb0WhgxKdhwfur5wu2Jc0cuFRlLFIdX1a72iWFXmteHHqqbL/f/fMNrum0S45JR9ZDr6LhC52cOgKpGdbkc/J9xCb1wMLJLD1RZXhZGHBkAUzZm20Z/mqJI+3tXCOhJgxt77C8hHNObQXm5iAOmbDt2Hf6mxa9VB2l2LBooM1rIHzecrjzA+hC2seYw1372JBm4tXjB2TZmUlI0NXOv4TlUVKfoFtddoJMyjgYPvppAddkwf/W3jOpFG9CftLYeGEu6ZHmI4xrRqXNst/FGdvkcjPeDKo7pKQodiE0YUfC6V866K0RPXhUT+09PdJp3INVUESsxBeOFPz1TjlJfC8vHm4bxfXZ+x0RjLiSy+wNjUxXU2hv5Cqs53k5YtDNjAAmYfKXsIDq1T1yNO1OrOHyWLCkRtwNLdPuvm/tDiV+mPdhJsCbi0LdvB3uqqYb1hDu7qRio7cOIrwTZ25PPXHuCxvgKX1tMSIKwWY7bo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(4133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2JMTzFjMTRoeFpyWUl4cDFyZEVTR3RpU3VNaVpKeStRUzhua1pHRHNodG9t?=
 =?utf-8?B?VE9GcE1OU0tqUGJlZkRXbGE3UkJNUEtZQUgxTklyMFUzcnlwYy9aNEZLOUlI?=
 =?utf-8?B?V0VLMElBeEl1L3FzTHErUmFZS0xmdDVCaWk4bDBSbXJzTTd1b0tzTUovTGdx?=
 =?utf-8?B?b3d2Nkh2dG13Wlk4eWVkNjQzUGV1MmpxcGZRazcvRzFuOERFQlJXMGwxa0sw?=
 =?utf-8?B?YXUySGxTVjBSeFBTc1BuSXdVZUhJdEpkR2dmbi9QWm5Ra3BRdFRHaWJDZUh0?=
 =?utf-8?B?N3ZLVXQ4UEFETzVIODZ5ODdka1BsYjdVZG9tZTZ4Q0FSaENWMVJJdkNoTWZk?=
 =?utf-8?B?bGV4ejgzL1VybDYrdGVGamVqNGJKdXFSSDBmeFpKeXpjZUZScUVyRkJEOGxM?=
 =?utf-8?B?RkxaRUtOMThYYUZTN3UycFhTSEZlWm1kYUxGYXcxZTh3eU8yWGZmL3djRFlR?=
 =?utf-8?B?MkxzYWJvTFZ4Z2lNTFFXNDFneFF5NHN5Z1J1ZUhzSnRoZmtVb3RjNGJKallG?=
 =?utf-8?B?czh0RGhxQXlUS1RiT2dnVkt0Vmt4SktIbW1GSEo2bnVmYUhpeUsySTFPVTN2?=
 =?utf-8?B?UFEwZHdqZXNXRlNSMXRMTVI0c1ZCS0tFd1MwTG9ET3dwTTJBeWFWQTBzdXJm?=
 =?utf-8?B?Y0F2MC91alZEZWtURmw2ekUvMUdHUlcyMmQ4TW14cUp6MTZWZ2RVY2t1eW1z?=
 =?utf-8?B?UU95RCtBSXFQaG96NjNDUjdWclBGL3cyTzdNaXRqTDF2M1dLcDdRdmJieUxX?=
 =?utf-8?B?d0c4QUxqWWhjUEVwRE53UFN2ektnWEM1SXBZS2Z5amNCSE9nMDNTVWZGMUpS?=
 =?utf-8?B?RTFpNFhTNTBReFo4MndGVzhiRW5Rd0M0eGhDbjJGWnpiWWRJMEFKL1pWQ2tm?=
 =?utf-8?B?TzU3MkxWMnFublhkYXBUMmQyQTFJRjZhTEZrYWNXL0tiMURBU0FYOFVPL2dZ?=
 =?utf-8?B?SEhRdFFGcUdOclRFenY2NkZZbm9oSGJkS08vN2FoT05CNDI1R2RRT29hb3Fi?=
 =?utf-8?B?bFErbDdZb0x1amkzVFVwQmFIZmpIcFJYbzhTeWIxRGZacEtIMFFaQUZHNFZy?=
 =?utf-8?B?YmgzMk1BWEpPeW9ER2QyYjllVDVWRHQrOU0zaUxPV1VPc3J0anlyYnlqSDZP?=
 =?utf-8?B?cDBaaElWMjJWWVZQSGZEZFR2d0s0OHRYQTFwcnJZd0lVUlFFbzZEM1VnUTVs?=
 =?utf-8?B?UGFrS2JiN3F4VjR1NUZCakFVeGQwL3BZUUY1UTY3NjZPYnFuaGdCcWZoUkwy?=
 =?utf-8?B?dGJqZjdlZ2x4VWhNRXpxWnljdlVFRTJoSHluRXAxbmJyR3NjTU9iZDFjb2g5?=
 =?utf-8?B?RGxVRVkzN0xGTVJWNnFNQnQvUGJMVTBwZ016ZWZ3Ni9idkZHV2ZINEJGeEpu?=
 =?utf-8?B?elovR1c1Wk83MkgwQTZjWlBvUVQ1SHh1SEtrWkp3Uzgxb0FqOUVwS3FKTWNw?=
 =?utf-8?B?NGkwcjlDMU16K2JLYzhPMmpsRHRiMlkvNGFzbzlpOEVPMlduN01sRUVkWWVP?=
 =?utf-8?B?UGtsS2NNMEFpS1laV01FQVcxandSZml5b0NuUENCVi84N1pMdGVteFQzaG8r?=
 =?utf-8?B?SlZJMExST3IzVjZuaVlBSWQ0RmlWQUdBRE1ZRS85T21NYzdENVN1QzR1VTVR?=
 =?utf-8?B?ZWVZbEt4MzVLcHNLVXVWOFJ3b3loMkIrS1lEeHNZYStoVkJzcW1saGRSQTZi?=
 =?utf-8?B?aHJNcjBlQ2lUZWtwckhGRWdZa1RoTjVLMURCOGdOV1ZQSVJYQ0Z3V0ZLRHBD?=
 =?utf-8?B?S2YwZG9TMWIxU3JINEQ1UlUzTk0wZmRkRElha3YySkl1YWdBdi82d2JXT2xa?=
 =?utf-8?B?WTF2amN2dFJVb0hLKzY2MXFCeUxJejJXY3ZCVzhxZW9rMk5SVmtlY04rVmJk?=
 =?utf-8?B?Q0MzN2UxNm1YYzFWY2c1aTRZNThNZ084SFhQbEkveDdqdDlKdnhrUElaUzB3?=
 =?utf-8?B?Z05TVmhXeHl0eWlWSWllNEVCS3hVcG9iVUQ0c3R3YlVpanRsRDV2eGVhcVJr?=
 =?utf-8?B?NEM1bUZlampqdmN2QXFJWXVnOW9jMjdTeWhwczU0enFRbTVlTjRrbjVLbnU0?=
 =?utf-8?B?UHp3Q05Md01wOVVybUh1M3hocCtaTGRoSkR1TkNLRmNYZCtUVFBhTzlMams1?=
 =?utf-8?B?VTh1MENtaUlFcStYYzZOWC9qYXV3SmZNY2JFSjRiK21EeHVBNHhrYWF1UCtH?=
 =?utf-8?B?K3p6ZU5uc29XWUZkNmI2Ry9IdVRhditJSnJWZVc2YzVUbXY4OUJjMU5RbHZm?=
 =?utf-8?B?WUx1YWU0K0JiTFY3V0tXb0pWWFpMZE5SS01Yd1dOK0x5Q2pSelZpcGRmNXBJ?=
 =?utf-8?B?dWZra2dqR0dNWTRDTnNxNHZuTTc2OWJPZ25KZ09FOEtQQ0tTblhudz09?=
X-Exchange-RoutingPolicyChecked:
	SDlVC6xTLoJej2yZ3DSfdU/n5gplJYXQaB4fVxUqLYSLfhQEr8dRNzTklcSKJ1D8tLW2oYDvx20gVJAShCZJNPXNVya0hoPTfPWMHOEHjXr0RJkq95bd1XOGGkMFtgFcjryYlktOOx8ERgRrhlxilPUZ27pYdBrhJUGvRYNOyrHFafIDxDh9hAx28T4EaOO8Lo4ADf638ORyKm2gQ0MEtD0QvSVIEOWCLCurTRlD2Xaa1gGFitaQ+7suaVzPxIFU4TrqlarMMoH5HNkL3qLve4vbZ2QGKWPAXPsmQyiT9bvLubU5jnHT/6HHPp8CvCZj9COwJ+5qHBhbx9AHL+Tg2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oG6iuxbq3T0yJIq8ocKO9FFzyqy3VfYstqcjb/MOScP5Jios6N2M/Do85nRom3AOmFOP50MZP/SEcLoANmNHHA0a9k6dkDex8ExmzW1ctxLMv+N8uitj0E5coRDxllThS0Ep15yIwcLr9IBE2kCR+nT6tuZW2qAmOiain/nf6aRwmpGvVERlG19jMSPQolzRfLyuLxsvQJJyZ6TMQUQ0uxXV1b4tI/Zecx8YRCc2sQoATN5Y+OjTGy3pBAX8IDyk7R63j0z6EiWu/Gsa1ujvzW6o+FnJLgAyMPvp0i9s2FkgHXu7t6vJXSIemyP3Ry32EKqv+/gX+IDIfOsy9O/dtzxFOkcALqK8AhPvNgbR2D21KsOYkWYNmYx9WQfVgWSWpIaHT9GaT88CEDZu51ZDLHYUfdOb8TodgZ96FNfR22RN/HL8f91CfvqTQcAgXmpcPLufg1LcZ9mFzQfJYd6y5zPeGlXhDJnE2MdpXeHsnvCUqUbxBqpCrklncrap3Oem9uFhxjm14SX7nxGNiMF84AgnoVKUEmY8TrxlR7Hq02QZkPVAlWIDyoxlO9aLH+Ve5aQe3vOzGuypgS6qV/1w1EfRxx8dz4sLxv7zS3WHly4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78b5baf-81df-46f1-49a5-08def1f66b22
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 07:02:59.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0HReatbH54Kw+H/CK1/4bVk//tTPKsx06gZ8ZafAyUKh6GXIF57jejXHNIw9lB9Xoy9k/7+7gUQrRjp2jbpgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1652C44C3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608040054
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NCBTYWx0ZWRfX9n+Qkiv+gW5X
 VaZIke7FTYc5Han/IBfuhQMFi9isku+aMqMq9xda4h4vk7pxVg6tlHDxCsXZdgGrGYxmGzmcmJu
 c5YRBJlNM9VrYjDqTlYBemLz3/eix9+dayh6BE+nmoKbFvoM/avWz8L9h/vzmxUTAk7EBl7YbxD
 yf/++j6s5aDwWMJBAI76iNN3CPSCgLQE+PZCE/WjKfK3dspHuol0MT8Wv2ap3bH6801nhfKVd0l
 f3T74cZfXMkx1XzKBrgp/UYO+IyiQPCLGZuGoVNwgY1BfKa4oKT3lyhgfi99YxBisuol/VJLOTL
 +U6g9H88T6rTwvXXaqgBcJ9c6Jbp7GTTdwAQcJgKfdm8kNwlLcAhEaS6IL+NKVCMU4hzGcNbrIl
 2UH7f8mld3Z3GPSe9ofbAUc06YgtRwh3b7ara9kqmNnF2TVb8qOxrhUGy0GlXPEK5FTQuzeVJR/
 jO/rQw6M6fsg+ZaCGjIqt52MM2cw/FzI7Y4/dXt4=
X-Proofpoint-GUID: OCtxD5pU1JBtgzw_5alHLiJwx6uUuCxN
X-Authority-Analysis: v=2.4 cv=frDsol4f c=1 sm=1 tr=0 ts=6a718eab b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=RpNjiQI2AAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=8dRQpW5Z0ZQAO81WL6sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-ORIG-GUID: OCtxD5pU1JBtgzw_5alHLiJwx6uUuCxN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NCBTYWx0ZWRfX2IRP8LAvZjJT
 LLpleJivvIS6kPlXy3pykv2WRY7o7B2FRUsAz/DzyAQcPYb7Uv034zszgk5rgmeWWiDahU/5Ise
 JhMxonK9GAs4v8hhndm54RZEEDf5CCBP4jjTAEbWAwZzHAWzkitd



On 7/31/2026 1:07 PM, Matthew Wilcox (Oracle) wrote:
> An authoritative mapping knows about all the folios in the mapping. If=20
> read() finds a missing folio, there's no reason to allocate one and try=20
> to read it because we know it's a zero region of the file. We can just=20
> call iov_iter_zero() instead.=E2=80=8A
>=20
>=20
> An authoritative mapping knows about all the folios in the mapping.
> If read() finds a missing folio, there's no reason to allocate one and
> try to read it because we know it's a zero region of the file.  We can
> just call iov_iter_zero() instead.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/pagemap.h | 11 +++++++++++
>   mm/filemap.c            | 18 ++++++++++++++++++
>   2 files changed, 29 insertions(+)
>=20
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 968b791cfd14..22d48935ffda 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,6 +210,7 @@ enum mapping_flags {
>   	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM =3D 9,
>   	AS_KERNEL_FILE =3D 10,	/* mapping for a fake kernel file that shouldn't
>   				   account usage to user cgroups */
> +	AS_AUTHORITATIVE =3D 11,	/* If we miss in the page cache, it's a hole */
>   	/* Bits 16-25 are used for FOLIO_ORDER */
>   	AS_FOLIO_ORDER_BITS =3D 5,
>   	AS_FOLIO_ORDER_MIN =3D 16,
> @@ -345,6 +346,16 @@ static inline bool mapping_writeback_may_deadlock_on=
_reclaim(const struct addres
>   	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>   }
>  =20
> +static inline void mapping_set_authoritative(struct address_space *mappi=
ng)
> +{
> +	set_bit(AS_AUTHORITATIVE, &mapping->flags);
> +}
> +
> +static inline bool mapping_is_authoritative(const struct address_space *=
mapping)
> +{
> +	return test_bit(AS_AUTHORITATIVE, &mapping->flags);
> +}
> +
>   static inline gfp_t mapping_gfp_mask(const struct address_space *mappin=
g)
>   {
>   	return mapping->gfp_mask;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 26a5f18121f9..5a8cc20e624e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2697,6 +2697,8 @@ static int filemap_get_pages(struct kiocb *iocb, si=
ze_t count,
>   	if (!folio_batch_count(fbatch)) {
>   		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
>  =20
> +		if (mapping_is_authoritative(mapping))
> +			return 0;
>   		if (iocb->ki_flags & IOCB_NOIO)
>   			return -EAGAIN;
>   		if (iocb->ki_flags & IOCB_NOWAIT)
> @@ -2853,6 +2855,22 @@ ssize_t filemap_read(struct kiocb *iocb, struct io=
v_iter *iter,
>   			goto put_folios;
>   		end_offset =3D min_t(loff_t, isize, iocb->ki_pos + iter->count);
>  =20
> +		if (!folio_batch_count(&fbatch)) {
> +			size_t fsize =3D mapping_min_folio_nrbytes(mapping);
> +			size_t offset =3D iocb->ki_pos & (fsize - 1);
> +			size_t bytes =3D min_t(loff_t, end_offset - iocb->ki_pos,
> +					     fsize - offset);
> +			size_t copied =3D iov_iter_zero(bytes, iter);
> +
> +			already_read +=3D copied;
> +			iocb->ki_pos +=3D copied;
> +			last_pos =3D iocb->ki_pos;
> +
> +			if (copied < bytes)
> +				error =3D -EFAULT;
> +			continue;
> +		}
> +
>   		/*
>   		 * Once we start copying data, we don't want to be touching any
>   		 * cachelines that might be contended:
> --=20
> 2.47.3
>=20

Very nice change.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane
