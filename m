Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA53CEB8C;
	Fri, 13 Mar 2026 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427260; cv=fail; b=XoATk0a86DwZFANDmHOxZU+1cCM8z+cRSYmtROtVyN6+kF68pf6HRWiCRlAhttF+FGbhJOSN+ZmtQzIwjGYyor3PYX4oHcCAVBpjeOIkKcyI3luqAtvblodMDR+L75UB1k3Ndxg6ZYgj+aNRnruOTyO0/qR+x3BuwsaBCwqKg0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427260; c=relaxed/simple;
	bh=1a2pUKPw7E2DZH8nrl8eqZWU+wzOX2tozitE0Dxh5kM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=aHJQ5t1Je4y+7NZYYG6uOcMti5gYRl+srIiNGE7Bt26/YazL5vnMXBYF2PeFspTJqepC0JMoKAgU4yoqtFnFMn+0YLWSoo3Rwbo48zqQ+T1xLl7Q7aFlu1XLIT1xQOlznmJwSGAFt7fWgPnQKqlZDb250q/ZzkNhatKAfci2HSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eUlQRANg; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eUlQRANg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6YNVO2206547;
	Fri, 13 Mar 2026 18:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=1a2pUKPw7E2DZH8nrl8eqZWU+wzOX2tozitE0Dxh5kM=; b=eUlQRANg
	p/iCEMnfHsVYllHhpoX8ILHMeexDv3R0fHWXGKRPABAEucCeEvomaACnqgmHKB51
	fKFPUxfYAfAtj3C0qesNzsGpKcRYWt6jBiqRyHnulhEUi1vgo0MfN4jIhdJDZN20
	LMUcj9WQ1lESIGfx9NmEoWlpMNYpR5pWXcrUdGPkDJS+U8u7ogGXJQ9OUIdLLYHy
	m2qbxBMpmnB7bio7XK/AoyAXvezxextBuSAzUmlLOON1rXrybfSHf1Nc+P26mcAp
	+NIIKP2Lk0cfXuk6cIba2bp/ACguazhgDVtfEiB+HHFcDHBjp48oIVbjSTGD3Vec
	tELkri8md5oQKw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98gxy4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 18:40:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7Q69Qqrqv+hqRL0/73hBlhXFWv91ji9cwZZEXujFaoLLYmZm0522KKHUHLLFYca4d9Bxck0qpfLE62YfnhDgwScGSyzi12noDcgkaoNeAr8QfQv73PvKLhAcR5MqhhDWXL0fBBMNv6lXzHBhhej9Fb/iuDoeFbY1OltkJPAMbPQ+lE7XAjJ3zqtG/+E2CiYE2aCZmLEB91MHo+kIWXKN/Ne8GIy9/fLeDBX+oJH7GDxAhDoJzNmNwc0FPPWP/fgDLXJRI/PgTgezM+3/Du1mK4d/LB47pyDvfspwUeRc/R5LnB4da/VHnazxsIOFFjY71eWNN+sa5dIl/XygN6Qnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1a2pUKPw7E2DZH8nrl8eqZWU+wzOX2tozitE0Dxh5kM=;
 b=lfP2H/xrSchkk3HWUOIqedr1I7q/o1HozGAPxar/MNRkoZX7AZwF7F6pPUiEQFJsHbBpVedkxrj00AI+2uHC9vgVwzBHToqSaDW0o9zXlu9DLeGII/SZbQrm929fwVCzPJ3HykL/6SLt0w6/NzWBmYroILkPZeO534LVOQnVf3XkMfB2WlSqreHk9cM7G+90FOGu0o2vwnjTKWt/EPMg4tb3BVxzcYGzoTDayneqjeEGzr/wofyu2XTlOGSvfjlIFSbVgyT1GqhLkrcuGvq6zYpPdYI3dlEymOKdxrG1GGamzaL3eKRzUzklqT0qiV39PeJeyYKGnDWte1KFby7UmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4213.namprd15.prod.outlook.com (2603:10b6:510:29::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 18:40:43 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Fri, 13 Mar 2026
 18:40:43 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "contact@gvernon.com" <contact@gvernon.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
Thread-Index: AQHcsg/APN5tsWR8/06I9Ew1VYcR+rWrh4IAgADGZ4CAAH/BAA==
Date: Fri, 13 Mar 2026 18:40:43 +0000
Message-ID: <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
References: <20260311211309.27856-1-contact@gvernon.com>
	 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
	 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
	 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
In-Reply-To: <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4213:EE_
x-ms-office365-filtering-correlation-id: e1851a00-12be-435f-6346-08de81300886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 1Ox5wniw7GyulgT0c3ITUGQUllyyZlv3r3F3io6Wy2rzbUW5vS9u7g3xu0neKeQNqb2tOnw2LbfWN+APgD2AAnxyWJKy/4tAUJy48PZitKBrrScaGFecOf1t1eoMg6thI6qgqgrz5irNDsk6c9Yz8pLNd8aLg8Gh6C8pUw/x0Tv1HQB7FQDzYjZQAjTzxCmftyoYLlTbsoFrQgRjUJBjxZYX1UeryLIsopF/dEwwQdcYN2MDXNVpDe8NH4KFME54KkQBA7vW+Zps/c7ee0y2NXGhOqpo9FQP1f//62NvQ594geIZwfsfXTuDY6qMZkCoi2MVTr9A9N01jKnGIw95t286/EyAP27t7MU9PEQFKFHFfVutAxocByr8E/r1QJOeoodxCYPtqH2Ax1I9b+vn85w6OfdlYgz9gGDx95+2FSKQkwPVISBRvXqonHrTPNHc5+bTXiiJUppRcZWejs47Cm2lIMOWTGqZyU2L6ykWeeRkxYdTS1ESa4ctR2a1Thiu5Q8b58P17wrcdJHxTO6tCN9SYBYKcZ5Nh2SNwsjAxgnwf2/2kfqrRuv+UJulmEQSJlFsOY8GUuNeQlzZUFPjJlrsEtrNLe25XoCmNcuUyolFgrAd26EiYCVpYw/mjiItxSvWkT8LaKVmjm6i5yo2sAYBLG3rp6WGFH6vqhhTjAfw64IKSz7iGalgeoK8bf9Sk8ycGoJdshFaMj6DLSBxfs5xWZ2AwDEvuVD+yQ8ZDHGmq51GmrRXa5Ek1cqMmg8mADrfyAFaiDo3HScC3TWfVajfFRr93PFL3dBjZOcF7ig=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnFmQW44TmE5QW1ZVmZvMk1hK1NDZzFSczYxRENkekk4ZGsxNnhNS1lnQlFD?=
 =?utf-8?B?R0FITkU1MDJYVSs4U1l3ampLamZIRnhYNjViRitzL2F3NVptSmdIMFI2aFJy?=
 =?utf-8?B?SDJpcEtHN2orcVc4TUdmWnoxNlY1YzJJaXdWaXBGalBzd2lhWmRFMlo1TjNH?=
 =?utf-8?B?RVFhTXp3dXFqYnJrTjlaTkFBUVJUUXFnaUgrcXZsZkVnVzA4UEtpdnREdlow?=
 =?utf-8?B?eVdZZ0lvN09Ja3pNMjlwRnRBeXNWWHhYeTNLaXN3a2lQTWt0eHNPR1dqQ1Jv?=
 =?utf-8?B?VUR2b3JUN3UzeWpzZUpyY3V0b0dWdU9ua3VHY0JMSklTWTRBS3htTWEvb1lP?=
 =?utf-8?B?UGVrTXJpd1hjcUxUTk9lVFVNa09aZkFuSWcveFRZc3E4U3RZQXBpRElkMEg5?=
 =?utf-8?B?R0ZVOTl3VEU5R0huU1ArRHgwWWdkTGdaNUZjSVVxZklqV3JudlN2OC9vc2x0?=
 =?utf-8?B?SW9VMTg3dGwxRGhoZEF3OVI4RklUYWZWc0E3Y1J5a0RUbDZzOCtQZ1hLYVZJ?=
 =?utf-8?B?dUdoOUEzc3dZZlBGbFBXTDB6Y25pVXprano3QTEybDMvbXQ3L3ozRnhKSDJC?=
 =?utf-8?B?ckxieXp1YUsycGFVT1BjL3ZxNmlLek85QVI0cThISHlSYTh6eWxKaHdicXMw?=
 =?utf-8?B?VFk0K2NZdkw5T09aUlJoMGx5dkxBeXl3WC9oZEVZM0ZvVXIxdURocnI4Qkpm?=
 =?utf-8?B?R0I3UkM0TUI3WlVjQWtlcFd2VEp4eTNVYVVQYzB4VUd6OE9manFsQ0VJV3pu?=
 =?utf-8?B?TmlMaGJtQThZK3hBVys0eW4rcEZ0c20ySmNPRDZlbnpnNm5oSGlHWFBOckZQ?=
 =?utf-8?B?eHI3eDVORmZSZUdCS1dHaHVUY1hUaXA5ZjI1Syt0c0w5M0NxaWFwVmkvdHJy?=
 =?utf-8?B?a1cvN0E1MGhnWDV3cWZ0d0lBeHhHZ25GbHlhcVM2RWl6b1ZPWEtTUTRiYm5P?=
 =?utf-8?B?NFpaYmZVbHF2WWFnV09jMzZyUHpiK3NQeEFZbWpaeTR4UmRZWk5RYTVlOU8w?=
 =?utf-8?B?ME5jVlVCeXBtLzJxaWVpY3JlcmNRZ25sNTJ5ekFOdWxQVzhVbWV2bzZteWJN?=
 =?utf-8?B?WjR3V3hoc1pLSnh5eXBiNG9EWTE4WUZnRWVMZEhCQmJwM2dWRCswTWZpWnRW?=
 =?utf-8?B?aE1LcWE1c1V3RWhKT1JpckxUanBNK2x6WHkyWHMxS082NEIvZWo5Z0FjWUlY?=
 =?utf-8?B?cWNDYlhIbFUycmxUcXF2RkVlRUFVY1Y5dHBIM21RN0RZUGptZkQ3WHN3eUc4?=
 =?utf-8?B?bkp6UW9weG5jY2hNWUNBSTA3Z1drZTY4RjJGVUNocExodll4WlV2ZGU2OWo4?=
 =?utf-8?B?bGRSc2NVZDBKQTZFc2hvSHY3SEF6bjJUck1qdEJDN0JBZkpCdXdXemhQZmVz?=
 =?utf-8?B?MU5Bb3g3Q0dRUTk4UFBNUGNoUFBUeXJKZ1JHa0s2WVlZUTFYWXErTnh5QTRN?=
 =?utf-8?B?cVJaSmladlFDaXpIQUptdXh3QmMzVkxITkRCUW9yTjEyN25jbHcra2ExdDc0?=
 =?utf-8?B?ZjA3akpreStyWEN5TjRvdm5zL1VKZXdHRjllS2FMZDRRZ3hicWtoRzlnc1lj?=
 =?utf-8?B?WGQxdHRucS8rNVI1blc2SWZmWEcxMDh0R1hmYktvOXBkbXJMaXRzMXEwMDR5?=
 =?utf-8?B?OGg2VUxzdTZCaFZIeUJOSEF0cUV6QitzRmNQUkpnaUNJQ0Fublp4ZDdrSDIx?=
 =?utf-8?B?N0dvTkNnWHNQWXZEM2pjb2x1T1RyY2JQZDRGeDlpZ2pQVGRLaURDejU1Q0NW?=
 =?utf-8?B?Mll5QTcrcStJR3dZc3lBUm5HcXVGc0V0Q2RRcGtaU2djaEcxeklVSTlSd21D?=
 =?utf-8?B?LzdRQ2o0d3Bna0xjRWlxTGl4RVVVWjQzRFdyd05LTE56RWI3RmVGaUxtZ0RM?=
 =?utf-8?B?ZFhUNGZvajl1WnMxeGRkUkp2bGdCNllaNVFMUTRTWHI3SnZoMCtnSXM5dWdD?=
 =?utf-8?B?NG8rRGFSc2NtZk1ETnlxTmxSRVFwcGNkS2RmZTF4TGtCMUZIMDY4ZmxSTk04?=
 =?utf-8?B?SkIvalpQQ0VOWlQzek5pcUFmZWNob29KbHZEazRUV1lIbmhDd3B3VEd6czVz?=
 =?utf-8?B?TUxFRFVrc1Bac0RHTWt0bGNjL0NicFVOSVdWTm5taENBQkVnQkNvaTBWbVA4?=
 =?utf-8?B?VWFDL0EvT2tuV1IrVnoweFBiQTZ5NnNCN0ZWSnpUMXNlVDNpS3ErazhvNGlV?=
 =?utf-8?B?Uk8zQTE1VVdIYzFpUTFPUUZPeVZEeEJ5OXN0THFtVWkrUnNCdzdmdHBqTW9N?=
 =?utf-8?B?a0Nlc3BsQ3Z2YlpiS2NNeHo4L3l4Q00wYXVCMCtPNFc4KzZwd280VGJibHBw?=
 =?utf-8?B?WmhKQ2lUWHdhSmsyNHNFZzk1dUtXazl6cGR3SHJtRFoyNDFyb0JBVXBtOFBY?=
 =?utf-8?Q?XngeUEUjm6QgRetJI6yG+wsBNrWNlrJFXSQSt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4F3DC9F94581242BA9D6592E2FE7FC2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	PtT/g2P9owfstrhrg/u/j8Sle3lAs4d6OOzun1xlQEUecxjvStNke9ms4Cwt9QDkamx52VfRu3wt6TtntXYX9g+onbQzHAokJCccMA+0ipPkcWt95dIHAJZGEESKbRW5aT0HcL/FCnLM/vlvI65OisC2DMn1aW3Bi3nIe/KF60bdLJ6iXkMLywRaUDUoZujqzbpAmkcvSd5tCZLwnX/pWjFptFnf0E0nTL+LAKsRO7X7B/9hVo2yqSBLhG1G8vuDvxqprEL9n4fWbq+N/BLWw+BGvcT9zsqA3+mVhC1K4USu/kb/i5uYa1xjlK0PKXtASZDDcJX7zrt1SuqQNyO5UQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1851a00-12be-435f-6346-08de81300886
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 18:40:43.4316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ey0xepWsW0a9ME7kDWfJD5eU0C2FZOMWL1v/n7kMyAMHGDtqMCtHcJb3SeZ8cOuD9C9I0FoioACUOmQGT6ejqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4213
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b45a2f cx=c_pps
 a=XNfUKZRMy1FbR/3CVfPpdw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=jdtEs2fCU3bYLw86070A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XVCm-jNRWlKrHzYe9F2Vhl7T7eA0LNz3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE0NyBTYWx0ZWRfX/wZNrF9dmfkL
 U/HhU1gDyF6MUI4qWewCCF12+DzGjn5d07b5tcDYDe+UAcGSwYVwZkLE+wAVvxt7hweYF53+u2R
 OZFGsU2UT3mPoHWD9v7UDS26GzkHVYAmxPoFyYrzOqpZckS/Y0bvscEqjvP9ic4rkRnloUIMac3
 CTDIeI+Dt3MMpt9v1CDU0ft5xKvZkQ5hP7qK4loWPqeS6pWjp9nuWA8jdnsJffzCzEJ82DJgnuh
 z1t6E6hQdFHCEnvET9X3oKLHtnFOnA9WQ2z4HLdSuIH4FsCctBuHqHpVh/dj3xFBR4K82okV/8m
 2tlLfl0IF+7KkWEdCELLSeLomcWXiPAV5GLd/bWLNo3X8UXXuf+rkxGDhqzg2IRUceSV8ULIQTb
 cIefMPVG0TdaxLZEHkRX//ncw5JabXslaqK2uccCOYDL/FHESsmv7bICYT48FNLA1NBK7QVMkUm
 GSq8XBF9ZHs3FFFnMgw==
X-Proofpoint-ORIG-GUID: XVCm-jNRWlKrHzYe9F2Vhl7T7eA0LNz3
Subject: RE: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130147

T24gRnJpLCAyMDI2LTAzLTEzIGF0IDIwOjAzICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjYvMDMvMTMgODoxMywgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gQW5k
IGV2ZW4gYWZ0ZXIgYm90aCBjaGFuZ2VzIGFyZSBhcHBsaWVkLCBteSBwYXRjaCBzdGlsbCBtYWtl
cyBzZW5zZQ0KPiA+ID4gYmVjYXVzZSBtb3VudCgpIG9wZXJhdGlvbiBzdGlsbCBzdWNjZWVkcyBm
b3IgY25pZCA+PSAxNi4gOi0pDQo+ID4gDQo+ID4gSSBkb24ndCBmb2xsb3cgaG93IGl0IGNvdWxk
IGhhcHBlbi4gUGxlYXNlLCB0YWtlIGEgbG9vayBoZXJlIFsxXToNCj4gDQo+IERvIHlvdSByZW1l
bWJlciB0aGF0IHlvdSBzYWlkDQo+IA0KPiAgICJXaHkgZG8gbm90IGxvY2FsaXplIHRoZSBhbGwg
Y2hlY2tzIGluIGhmc19yZWFkX2lub2RlKCk/Ig0KPiANCg0KSWYgd2Ugc3RpbGwgaGF2ZSBub3Qg
Y29ycmVjdCBpbXBsZW1lbnRhdGlvbiBvZiBoZnNfcmVhZF9pbm9kZSgpIGZsb3csIHRoZW4gd2UN
CmNhbiBtYWtlIGl0IHJpZ2h0LiBUaGUgcGF0Y2ggaXMgdW5kZXIgcmV2aWV3IHlldCBhbmQgaXQg
Y2FuIGJlIGNoYW5nZWQuDQoNClRoYW5rcywNClNsYXZhLg0K
