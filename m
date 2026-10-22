Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792655239;
	b=5HKwh6tNrCqpBSEfDKoujsQdT09aAllwZxCynO94GKBEFmc7rpdFR5S5c2fFK9oEBHeo
	 meRaQWB0KKGJobVgMGc/lSKqchYE5tZjL/k/A8tPDB1wg2UogQ8tY/h9g7dkCCmfPwDjP
	 c7qnzu/vs3O7345xCuTe3wyt5FMWutb1ua2BTmyGp1NtEzLWCWRHSVw3TP+0WoV15f1nn
	 uQHPBGv6thzc/T8GzuMTyX4dokWCqboCV5a+8hwi+IS/zm0YVc3BwO8s/hkyeRy7T8kdq
	 JRkVYaIzt0GxoTfe7kki20mtMDA+MAUou6ADiHeZ2+xO3xPh5Zayz4/lufKQzppVVvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655239;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis;
	bh=1/GEYB+rwBRfA3rRM/uIi7ecrjkJmWpPV8KVqbz4G10=;
	b=zWT4p7vz1gMwdduVcx56sBtk/OvlbHN4rUFhzWhOIo594U6QvoW1dG//sT25ESjnrwbW
	 1U7gfHueC4aZb0U934B7Qd9MBZvWV2MgfiOtKrfyM9xoZMoq6O4JLnJHdc/2BW9ejB7gT
	 lIjb1A91KyP3VoFz+ol6OLqj/9qwyDvRmQrNXT0wNduxs7eERUagUdUt30g/U5fvu+m6D
	 lIM+LKIymgNgEefukoai9iMNvG6WN+OQ3DYteocdoE439iIhZJR6u3FrjBrtIVd972C41
	 +7U0VhUktr/XY5+tIbeW/yvPdrK9gD+GouVCnDFuRAUszWPOIJVQZl0yID5u3WCAJfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=XMMnBhZm;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=E1tIBIRp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F137B606A339;
	Thu, 22 Oct 2026 07:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F137B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=XMMnBhZm;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=E1tIBIRp
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LLD4ek3178567;
	Thu, 22 Oct 2026 07:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1/GEYB+rwBRfA3rRM/uIi7ecrjkJmWpPV8KVqbz4G10=; b=
	XMMnBhZmCKmgR09zvSGylAefK5LHg3YEmS5PC/nRu+1A7p42sgyrMaSqLX7qTMjr
	elsxpcZGYQyB0TxG2NnXLyU+wjD6gnDdNhdKoHngXXM5nVxrjvQCgZn+ABm/p/NQ
	NKQfDcR8p+9Hhb5cxb9uEDdR0tkpUmoCWqud4nCkIlq7Fuay7CPUXGH4nqF+E87A
	5f4AHTwgBga9Y3vgbjwhJJkjTrAY46mMCAwrjIoBpTNQ099bGNPE/XKiRc+rxHkk
	ah2qejq7Mx0aLNj1LK3kY0rWMhE9a6uejafjesis9FwSklkpfE53HUwjLUr9/8S/
	1FaZnjG04BAvj0mXvRssAg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hdw4hbusw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 07:47:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69M6wFfm1637108;
	Thu, 22 Oct 2026 07:47:12 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hfagdxqp1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 22 Oct 2026 07:47:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHic+mQcsfJF0hs0ParKlVYRjpq6vb1yAB85LYqgz/AoMx3cmt2NcYus58UUWghWBEmG5Fjf9iCPpFtrgXrK6OX0enauOHnd81oiprdwcdLWkNWsnwPHvvHKCHQyzFPILLjGsPFPxeSzJmx6NSaKzOCI8YcEKATFllIlvngXmoUyjMc4SLRigT872W2XhYDuMNwKW9nBDUwndQK5T6a459+0naISKfy4iowsj9aOnIjmb1RVGk1zENrQRFPA3Gha3CDjQUgA5bXyPfn7+QcmJ0aBwe7jTL89oo+aSxwCOIhkUDQ5Sqj2btu+g+mU9rcrtjWV4lyl9uyHFHwALh2M7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/GEYB+rwBRfA3rRM/uIi7ecrjkJmWpPV8KVqbz4G10=;
 b=H8tSoJlC1NGCDEK87iNQ86qu427X+A7cNJ0ki+TDaKIDOcyFzwp8QIVGhyj57AbsHD4T3P2nSif5mjviYeqmWTAEbqk53iHdpDYXNBvom5PavU1DIN+xgRHwjnRX+P5VlMS2TMFaj2kUnTvMEca6AG/ey9W+obUrtddWuBbe2BUveq1NemHlZcUy2Knf6kVNratS7ygj95We5mx6boxwVtgvaoi0p0B3gwaGDB3GJdrjN0gHDfl4R97glgQO3uSEDjxuw7kN6RQO99AxCWKeCPqUtT+hWzmUcBS4U36UOpcPRZY6hOJW15HqYY/Kk4h/HfopDRw1fzKqMpGXzN/QXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/GEYB+rwBRfA3rRM/uIi7ecrjkJmWpPV8KVqbz4G10=;
 b=E1tIBIRpiSISYsezrrZm6jRLIsVTblLW9TcMyexhFl+CrHy8cYxvjJl7Hb3NIQSgCorQI9DRFVWXEmTkBzfVtpolg+IHsu7xm0O9W2goL0PqERpOnZyinoj2+E+xkEBllSlHwViLLF0AHly0sH5wdPL7/PgdEN4q2DJ02utEmP8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DS7PR10MB4990.namprd10.prod.outlook.com (2603:10b6:5:3a5::8) by
 DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14; Thu, 22 Oct 2026 07:47:07 +0000
Received: from DS7PR10MB4990.namprd10.prod.outlook.com
 ([fe80::48cd:32fd:985e:239e]) by DS7PR10MB4990.namprd10.prod.outlook.com
 ([fe80::48cd:32fd:985e:239e%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 07:47:07 +0000
Message-ID: <f9164f65-1a99-425d-b216-326de0eaee69@oracle.com>
Date: Thu, 22 Oct 2026 13:17:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 0/1] fsnotify: Check parent watches
 without child dentry flags
From: Partha Satapathy <partha.satapathy@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: amir73il@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1791373689.git.partha.satapathy@oracle.com>
 <qlw6x3hyky5yoievlkd6ylz3ov432hdjlzkcyboswqktnk43il@fvccpqnil5sp>
 <9499fb1a-85f2-41da-88b7-5e7de6fdff0a@oracle.com>
 <gnntcprg4f7ag7ictugnfza24nwfdmyubkuqac7plxbwtedfrz@xgxyvks3h2uv>
 <2528e790-8913-45dc-a8d5-cc22908a441e@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <2528e790-8913-45dc-a8d5-cc22908a441e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DO0P289CA0009.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:20::17) To DS7PR10MB4990.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::8)
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
X-MS-TrafficTypeDiagnostic: DS7PR10MB4990:EE_|DS0PR10MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: f3cc11f2-7f50-419b-6fba-08df3010ab8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|260925021911599003|260925022911599003|260925021311599003|261021123027099003|261009223027099003|10067099003|261021121427099003|261021135927099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w1MhiWs6RWa53/sJKznxyCuXmda0VNXA8LZyp9zPLXL6yQWYaAA76AEVSg+7FweRmBlsrYRhg7LSrUzZcQ7AnWKD65N/vokkY5fXiaqKZHjLxG6b6YAcWCJya6wFKaw8fCszaN0nhkWKSorazMbJubs5j63XuB/NSzATJZCNqA9IRrueChH7RiLJGTjDSFHxTzUyShLPJW/+7ZBwOcakfMtyMkuivO3jgDOfKpvKt7n+lUGUlvYD7mJC/KkaIu0KlS+03jOP+NanLmvOQAn5EA6WzcIE5o8mOUwl4uyoBO6zxEV/877fdpjlDb71T2vAYSO1hYTw9ruGED0KXHjsBzBuTZhlRczcWb5NXL5FgUMpmcJ8+EpUk43xKbTPMP+P8peXD71DnIJ2kpMS9fIXEE2haM5F3p69irTjBFd4GgjPl+7qbtKvujArSk86eibTF5eC6rryAeHJdYRNBaPwnH5QGnJkNrpkg0pO74VJqnJqn5u2IW/YBYqkQxCliC9w7D44bJuN6ROxUPLbUaAwT+RY6nJRX5ktaZGalejdAWv81cCXmdQ6VaMh3mTQmDy/Vhn+FpFp5ERWTDKKm3gnyyKpI9akg134GBQFY8CUr6LMZlZbzlPgheIGE/gxuOPk97xdIRUjHpStmwAlOOXnHauUFZLRlym2lBLm2DLzHW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4990.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(260925021911599003)(260925022911599003)(260925021311599003)(261021123027099003)(261009223027099003)(10067099003)(261021121427099003)(261021135927099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHVPQ1BRRmVMUFIyNWdROHFYcWwyWk8wR2kwZU4wVUtCRFBzZDZMTnRHMGlp?=
 =?utf-8?B?ZFJ4cmdmKy9IN1FjVHBGSlhIQVFDQ1ZJWGowWXNVQ3pSWTR2OGtVUGlHdlNH?=
 =?utf-8?B?dFdjRVF1OE14SHdyVFE3WDQ1L3NvU3FjdkJrMkJ5Um54Y2p6Y0NzNlk2eXl6?=
 =?utf-8?B?V1R3blRGd0h4QkJzNGhrK1p3VG5HNGszNjhPcGptUUdnN1NONXpwZnEyTmto?=
 =?utf-8?B?ZGVPVmVpRm9EeFJudmRiM0RvMjF3K1pFNXo3SHBQTGFSRTgzWEhRVFZyZ1Z2?=
 =?utf-8?B?M3EzSnAwWkV3bXEzSkRBRGdhTkVBbnVqeDhnajhwcVlJS3lOc2NzN2FENGR0?=
 =?utf-8?B?K0NDeDJMa015R0V3S2ltaWNOUHd0eThKYkNjS29aanAyVzN3bndXZER0cnkz?=
 =?utf-8?B?MjZQRzBRa0F3YjRVYUJ5QnFmWDYyQU90czBJS3NlMFhncFgwYUJZalQ1ZUpY?=
 =?utf-8?B?TGFxU2I1V1c0Q010amRqRk9aVE5PNGtGNTR2alhZT3lCTDQyRXZXdkg3NUVV?=
 =?utf-8?B?MDloQTFCd2V6ZVp2RjllcEVTRHk4TTQzUkFoSWdBeWZwemR4ZHNXTXlBa1lh?=
 =?utf-8?B?M3E2cUdsbmpRRmRZcWpIUHM1YmJyMExua1VNcUcrUDY2cGhHbmhUS1RXdEJm?=
 =?utf-8?B?dCtzMlR2Y2toRlVUa3RaMXBvcjFBMXMxeXhCNDBWYjI1dnpIVytSVGJJbXNR?=
 =?utf-8?B?d1B4SmY1NlBuU1pkYTdwOUZZZlNNcjZtd3hNUTVyRjFWQkowZTl5WHdiZDQ3?=
 =?utf-8?B?R3JMODNFdVo3V20xSjJMcmM2SmQ0VU12ZGYremtZTVJmR3Q0Ym5aMUsyMXhi?=
 =?utf-8?B?L1ZreTY5ejByL1c4SU4xSmNHWVc4VjhRSm5GSE1Tbm9tY0oycWprZXY1S3Js?=
 =?utf-8?B?OGJ6VmpDa0J3YnUyTVJnZ2t2WGM1ek5qUjY0a3dtN1luUzVkK09IRWFxNWFF?=
 =?utf-8?B?NkRpR2g3SzY2VnFDZGJwSFRPMVc5QnZ4ZHBjYUNWNW5ZTS83MWYrMlYwZThk?=
 =?utf-8?B?b1diRjBHdEJGdkhRL0JNUWt1Ty8vMy9QMkdIM0gxdGp0emhDYndVM2w3TmJ4?=
 =?utf-8?B?aXpMVU9YY1ZQVzVKb0lCbUR6VkROUzVqOTV4RWZSSHVtLzBIbU1OWU81dGxm?=
 =?utf-8?B?Zjl0eHlmYVRXSHVzSGJwRmZaczRzdzN4K3Y2RWVaWVUyY255Y3o2d1g0VnFs?=
 =?utf-8?B?blRWVWt5OGRRT201TkFMVkRic3hjY0o0Y1VheGZodEZVY2xOMkNWemtXbWM2?=
 =?utf-8?B?bzZTMEE4OXhNR0dJMStML0NubHQrRHc5ckRrRFUzbkswc3oxcjBhaFkzZkRs?=
 =?utf-8?B?VlcreUNrbVR6SktUNHY4WHBIMU5uZDlTNkNTUHhxZDlKbXJHd0FwL2tIZ21S?=
 =?utf-8?B?MEg5anlMdjZFNERrakt0amdGN1F2RXIwNFlKRm93UWljTmErNVlwdmJMcU40?=
 =?utf-8?B?dEg0MjJMb0FpaCtheUI4M2hEZFplOHlkYWFwYnkvTkxmaDJjMXJEeENoMmZN?=
 =?utf-8?B?TWwyYlc0OWkzVzZWYUZOSTNkRCs4b3FWZVB3dXUxR0hRUW9vdzJmQW8yUUtn?=
 =?utf-8?B?L0ZuR0dzUmdKSzNSQTdXVGtNQUVGQzNtWDByVjFjN3pBRERvcDRUVDgxWlhB?=
 =?utf-8?B?dnBIL24yUzdLS0tkSldnc0g5UGhJZTZYS1ZiWG02RGJoRXJVNHZMbW0xSkxi?=
 =?utf-8?B?RXI2OFQ1clJCeHdhbTJTM2tRQk5iRlRaaks3RG5yOG44cyttK1dZSzJjdW5o?=
 =?utf-8?B?eHk1Q043b2RDR3dyQklpQ25JRHFDbThpRVR2b3BHSit6bUM2bExuVE1CQ3pl?=
 =?utf-8?B?dE9KZWVQUlAxbVJva1EwMk9ZeVlNNWFtZjljNDJUdnFZWnRuYVhlb3Ftanpj?=
 =?utf-8?B?c0cyZ0RHem9RNlF3Qmc2emQ3aWo1cTJNKzN2SUt3TG9aSVRzOVlEVGFmeXpS?=
 =?utf-8?B?bTRWeFJWZWFKZ1h1T2RkNGdua3YyVVVYWEJLSUVrNVNrK2Q2NVJPNy9MMEdn?=
 =?utf-8?B?dFZBcSsvZDBQb29Lbk91UkVpa1hTQmV3b2JlbVNoQUVxNitMWkdwR2VtdUVJ?=
 =?utf-8?B?ZDhvYVBnVDJzZDg3QTBXNjYrdmRDSmtMeEgrM3crL1NwQjdUWGFCY1VuUUFx?=
 =?utf-8?B?MkRQNnBXMUlrdmMzdDAzRlVaN3ptSnlzeUY4MXNpQU1iY2VpTGIrL2U2R1I4?=
 =?utf-8?B?VkZsSEl6aEIxb2xuSThSbS9naVJtMDFMeEltQW5LbUNmZ2JCWTI5cjBGcHhp?=
 =?utf-8?B?MmhONU1ZZ0I2bGhIN0dlc2ZicmtQU3Jpa1VSMnBhUFp0NVlwbisxRzVNcmFW?=
 =?utf-8?B?cWl3bElINkZFWlVBenJDWmdpbXU5SklEWlpWaEJaUnk3UUJJemRRNTM4bmoz?=
 =?utf-8?Q?DkN04ECVfHAuk5kY=3D?=
X-Exchange-RoutingPolicyChecked:
	tyuXfdFAmR6AFHz1XgkEe/FAV8iMMmQ6i5vYCOZOlZovAd8Iosf82eXbTVPd86gmAOZyBSAT6C+RRHDsmjBuPWIo0Hy58ouWdHtHUzD570wOhwKWmn3IpEHGYfEAZB+6DAF4CzX6RUgBFYyB87wexxj0+9s0Kq3f4ryXVTwOa2i5jepKJxtEEeY+tk56QG0sZ7oeQ5LcUvlOsdHhjyUMxrMsaDzCt1wMbqqHNw0aqIGSC6KslSP/kcQdvcOjECubzxw9f6VcqNhAAl/xXfyeHHwAwy8XcpvyXhkpW1KwWOLW8i5y1hreKEppe19Z1n3eRD4XFJO9zOHZXyMrgibMjA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yRv4BubAyyeE5RhzOAvjphAvsPqnp4YtsEZr7DQ3oayJ+kR8Tj6WPTRkMnH0xTvq815FtvR/q0TSfFz93xvIiriMygslokZqlkr2aCUsIz2fsWaykAkqDvk7dMUNepP4OXBn9RFeo7iDdBg2MsxB+PSLNrC3Eqz5e0FdGBsVF7ZYkaI5YmCCBh8inZY+zOGbAIDvIaYHlzG5ZR1RaE09BZzLKXMLG7OaUhX+62MK/5tRcemaZEGia2h5YDb3jz8secFIsySlbecWk7xZ2boUQb3GosYAzoU1wleBN2zgDd45Q364twLO1bJQu0qV9KYNLrI9lkZTP8/ELaw4tWht0yNQYGtWyPmbqJsIAw1GR3BWU5NSdyXduYEohlHVuVcRFzepftslMckrMM6MnmyW4GKs/Kfq6Pua6VXJyl7F65wUz7UkM47nl/RYaul3oK9lYK2gs8ziZSP+6ELeH2vlQ/D7knNgza2W6RvN0QZuGSBri/8ragugX56j4cBjmTT2dHg39YVe6+UbQFC8/U4oackQsY9kNqxZWodHrHXZle1S3NrH87TFpJQUoBr17JrQGGgsVuwuMMA29NjsQaRl86hmRu8QRCQV/r99CBD5S1k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cc11f2-7f50-419b-6fba-08df3010ab8f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4990.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 07:47:06.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atlufubmajrtGEK3RD9MZ8NyrOLmLvc9U8q7yG0OKkGy2WJDPqcSUX3DZK3UhR5VY2q3Co4NgkFYKITbkxQDSZ9tX5BOL4Y8u0za2UPYxYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610190000 definitions=main-2610220030
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzMCBTYWx0ZWRfX2NRrtce47FDL
 FlRGk3aXV8YmxrnQyGiSdoDXLdmphQ2fNR8WS20eoYZLRBEyJHG34RYte6342R04ZxiEojY3hg+
 K3H0OkEKl1rlllXWH37qGb80xgA4bZeMYGtM/JgKZUhfXbevat0r
X-Proofpoint-GUID: 3H6895yYWRnqwN06Xs2WzILRBlajUAXT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzMCBTYWx0ZWRfXwk9QK9G5f+jc
 tnkTmez9eru/D6Cw+aKV9UF6alsDq4VaHWI75Y7xTcvOZ4I6MjdTayYp5h+dcKbRLLJ+JBcDF1N
 ZDR2IhUpn34HOwhp7Z/Nuw4Nflaa/kDqg7rnJTHxNVKwK0i6VfYUc+GZDwcs57HIG8nQpZdIX6d
 sZ2ueq6Zp6z5Mkg4E3bRWZaTCtbRNQkj3fXD2nC2OinVQcs9NhnSTXdA8RBftOQ78WuFjITHzLo
 PDNAuMmHk+ojzojlzlbsUnbRCIjQ4gn97jzQ3zou8iQ83iE7shw7D7UbUxcoSIll+dPln0DeS++
 UQ78Ajc+NeT83dlUY48ucBfurPUdwdztt9e8xPBMvoJjHwsSVDJBvBOrgh9BGcMXRzlhO9KrBfC
 bzBlEMy8F9j1xM6+DN4ChREIbY5I51pX+kvB93Nu8QYY2z2D8UzcYoutsEISDLmBPRZW5I3/1q8
 SGLCPKK3wlkq326+Pmw==
X-Proofpoint-ORIG-GUID: 3H6895yYWRnqwN06Xs2WzILRBlajUAXT
X-Authority-Analysis: v=2.4 cv=OICyTiaB c=1 sm=1 tr=0 ts=6ad9bf80 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=iox4zFpeAAAA:8
 a=22NncBEOZyUZaAbhUBUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=br55WurUj89AL1qEz8Q6:22

On 13-10-2026 12:08, Partha Satapathy wrote:
> On 12-10-2026 14:10, Jan Kara wrote:
>> On Fri 09-10-26 17:18:17, Partha Satapathy wrote:
>>> Hi Honza,
>>>
>>> Thanks for suggesting this workload.
>>> The setup and before/after timing comparisons are below.
>>>
>>> Architecture:                x86_64
>>> CPU(s):                      512
>>>   On-line CPU(s) list:       0-511
>>>
>>> NUMA:
>>>   NUMA node(s):              2
>>>   NUMA node0 CPU(s):         0-127,256-383
>>>   NUMA node1 CPU(s):         128-255,384-511
>>>
>>> Testcase :
>>> Using /dev/shm  tmpfs to create  private test directory.
>>> Create 1,024 files each fully populated with 4kb.
>>> Add IN_MODIFY inotify watch to the directory.
>>> Start a listener thread to read notifications and count queue overflows.
>>> Start X(1,2,4..1024) client threads; each opens a different file once.
>>> Wait until every client is ready, then release them together.
>>> Each client starts its timer and performs 1000000
>>> one-byte pwrite() at offset0 on its own file.
>>> Each client stops its timer and closes its file.
>>> Wait for all clients to finish, drain remaining notifications,
>>> and stop the listener.
>>> Print write times, throughput, notification count, and queue-overflow count.
>>> Close inotify and delete the test files and directory.
>>>
>>> Note : File creation, open, close, and cleanup are outside the timed
>>> write loops.
>>>
>>> Run 1:
>>> -------
>>>
>>> | Clients | Before average time | After average time | Time change |
>>> |---:|---:|---:|---:|
>>> | 1 | 1.392 s | 1.484 s | +6.6% |
>>> | 2 | 2.205 s | 2.402 s | +8.9% |
>>> | 4 | 3.969 s | 3.644 s | −8.2% |
>>> | 8 | 5.851 s | 5.804 s | −0.8% |
>>> | 16 | 10.607 s | 11.538 s | +8.8% |
>>> | 32 | 21.093 s | 22.492 s | +6.6% |
>>> | 64 | 48.698 s | 49.576 s | +1.8% |
>>> | 128 | 100.208 s | 100.467 s | +0.3% |
>>> | 256 | 198.773 s | 197.669 s | −0.6% |
>>> | 512 | 400.056 s | 399.550 s | −0.1% |
>>>
>>>
>>> Run2 :
>>> --------
>>>
>>> | Clients | Before average time | After average time | Time change |
>>> |---:|---:|---:|---:|
>>> | 1 | 1.491 s | 1.484 s | −0.4% |
>>> | 2 | 2.391 s | 2.402 s | +0.5% |
>>> | 4 | 4.050 s | 3.644 s | −10.0% |
>>> | 8 | 6.630 s | 5.804 s | −12.5% |
>>> | 16 | 11.931 s | 11.538 s | −3.3% |
>>> | 32 | 22.513 s | 22.492 s | −0.1% |
>>> | 64 | 50.231 s | 49.576 s | −1.3% |
>>> | 128 | 100.699 s | 100.467 s | −0.2% |
>>> | 256 | 198.771 s | 197.669 s | −0.6% |
>>> | 512 | 401.860 s | 399.550 s | −0.6% |
>>> | 1,024 | 803.812 s | 806.593 s | +0.3% |
>>>
>>>
>>> Positive means After Fix took longer; negative means faster.
>>>
>>>
>>> The measured write performance is broadly comparable before and after
>>> the fix, with no consistent substantial regression or progressively
>>> worsening slowdown as concurrency increases.
>>>
>>> The differences vary between baseline batches: the increases at 16
>>> and 32 clients in the first comparison disappear or reverse in the
>>> second. At 128–1024 clients, average write times differ by approximately
>>> 0.6% or less. These shifts are consistent with run-to-run variation;
>>> the results do not show a persistent substantial slowdown from the fix.
>>
>> Thanks for running these tests. Results are very interesting. Can you
>> please share your benchmarking program with me?  I'll check it and try to
>> play with it on my end. Thanks!
>>
>> 								Honza
>> -- 
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
>>
> 
> $ cat run_parent_ref_scale.sh
> #!/usr/bin/env bash
> set -u -o pipefail
> 
> bench=./fsnotify_parent_ref_bench
> if [[ ! -x "$bench" ]]; then
>         printf 'Build %s in the current directory first.\n' "$bench" >&2
>         exit 1
> fi
> 
> results_dir=$(mktemp -d ./parent-ref-results-XXXXXXXX) || exit 1
> printf
> 'kernel=%s\nbenchmark=%s\ntmpfs=/dev/shm\nwrites_per_client=1000000\nmode=watch\n'
> \
>         "$(uname -r)" "$bench" > "$results_dir/run-info.txt"
> printf 'Results: %s\n' "$results_dir"
> 
> for i in 1 2 3 4 5; do
> for clients in 1 2 4 8 16 32 64 128 256 512 1024; do
>         log="$results_dir/clients-${clients}.log"
>         printf '\n=== clients=%d ===\n' "$clients"
>         "$bench" /dev/shm "$clients" 1000000 watch 2>&1 | tee "$log"
>         status=${PIPESTATUS[0]}
>         printf 'exit_status=%d\n' "$status" | tee -a "$log"
> done
> done
> 
> printf '\nAll results saved in %s\n' "$results_dir"
> 
> 
> 
> $ cat fsnotify_parent_ref_bench.c
> #define _GNU_SOURCE
> #include <errno.h>
> #include <fcntl.h>
> #include <inttypes.h>
> #include <limits.h>
> #include <poll.h>
> #include <pthread.h>
> #include <stdatomic.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/inotify.h>
> #include <sys/stat.h>
> #include <sys/statfs.h>
> #include <time.h>
> #include <unistd.h>
> #include <linux/magic.h>
> 
> #define FILES 1024
> #define FILE_SIZE 4096
> #define DEFAULT_WRITES 1000000UL
> 
> struct gate {
>         pthread_mutex_t mutex;
>         pthread_cond_t cond;
>         unsigned int ready;
>         bool start;
>         bool abort;
> };
> 
> struct worker {
>         char path[PATH_MAX];
>         unsigned long writes;
>         unsigned int id;
>         struct gate *gate;
>         uint64_t begin_ns;
>         uint64_t end_ns;
>         int error;
> };
> 
> struct listener {
>         int fd;
>         atomic_bool stop;
>         uint64_t events;
>         uint64_t overflows;
>         int error;
> };
> 
> static uint64_t now_ns(void)
> {
>         struct timespec ts;
> 
>         if (clock_gettime(CLOCK_MONOTONIC_RAW, &ts)) {
>                 perror("clock_gettime");
>                 exit(EXIT_FAILURE);
>         }
>         return (uint64_t)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
> }
> 
> static unsigned long parse_count(const char *s, const char *name)
> {
>         char *end;
>         unsigned long value;
> 
>         errno = 0;
>         value = strtoul(s, &end, 10);
>         if (errno || !*s || *end || !value) {
>                 fprintf(stderr, "Invalid %s: %s\n", name, s);
>                 exit(EXIT_FAILURE);
>         }
>         return value;
> }
> 
> static void file_path(char *out, size_t size, const char *dir, unsigned
> int i)
> {
>         int n = snprintf(out, size, "%s/file-%04u", dir, i);
> 
>         if (n < 0 || (size_t)n >= size) {
>                 fputs("File path is too long\n", stderr);
>                 exit(EXIT_FAILURE);
>         }
> }
> 
> static void *run_worker(void *arg)
> {
>         struct worker *w = arg;
>         int fd;
>         char byte = (char)w->id;
>         unsigned long i;
>         bool abort;
> 
>         fd = open(w->path, O_WRONLY | O_CLOEXEC);
>         if (fd < 0)
>                 w->error = errno;
>         pthread_mutex_lock(&w->gate->mutex);
>         w->gate->ready++;
>         pthread_cond_broadcast(&w->gate->cond);
>         while (!w->gate->start)
>                 pthread_cond_wait(&w->gate->cond, &w->gate->mutex);
>         abort = w->gate->abort;
>         pthread_mutex_unlock(&w->gate->mutex);
>         if (abort || w->error)
>                 goto out;
> 
>         w->begin_ns = now_ns();
>         for (i = 0; i < w->writes; i++) {
>                 if (pwrite(fd, &byte, 1, 0) != 1) {
>                         w->error = errno ? errno : EIO;
>                         break;
>                 }
>         }
>         w->end_ns = now_ns();
> out:
>         if (fd >= 0 && close(fd) && !w->error)
>                 w->error = errno;
>         return NULL;
> }
> 
> static void *drain_events(void *arg)
> {
>         struct listener *l = arg;
>         char buf[65536] __attribute__((aligned(8)));
>         struct pollfd pfd = { .fd = l->fd, .events = POLLIN };
> 
>         for (;;) {
>                 int ready = poll(&pfd, 1, atomic_load(&l->stop) ? 0 : 50);
> 
>                 if (ready < 0) {
>                         if (errno == EINTR)
>                                 continue;
>                         l->error = errno;
>                         break;
>                 }
>                 if (!ready) {
>                         if (atomic_load(&l->stop))
>                                 break;
>                         continue;
>                 }
>                 for (;;) {
>                         ssize_t len = read(l->fd, buf, sizeof(buf));
>                         size_t pos = 0;
> 
>                         if (len < 0) {
>                                 if (errno == EINTR)
>                                         continue;
>                                 if (errno == EAGAIN)
>                                         break;
>                                 l->error = errno;
>                                 return NULL;
>                         }
>                         while (pos + sizeof(struct inotify_event) <=
> (size_t)len) {
>                                 struct inotify_event *ev =
>                                         (struct inotify_event *)(buf + pos);
>                                 size_t step = sizeof(*ev) + ev->len;
> 
>                                 if (step > (size_t)len - pos) {
>                                         l->error = EPROTO;
>                                         return NULL;
>                                 }
>                                 l->events++;
>                                 if (ev->mask & IN_Q_OVERFLOW)
>                                         l->overflows++;
>                                 pos += step;
>                         }
>                         if (pos != (size_t)len) {
>                                 l->error = EPROTO;
>                                 return NULL;
>                         }
>                 }
>         }
>         return NULL;
> }
> 
> static void cleanup(const char *dir)
> {
>         char path[PATH_MAX];
>         unsigned int i;
> 
>         for (i = 0; i < FILES; i++) {
>                 file_path(path, sizeof(path), dir, i);
>                 if (unlink(path) && errno != ENOENT)
>                         perror(path);
>         }
>         if (rmdir(dir))
>                 perror(dir);
> }
> 
> int main(int argc, char **argv)
> {
>         char dir[PATH_MAX], path[PATH_MAX];
>         unsigned long writes = DEFAULT_WRITES;
>         unsigned long count;
>         unsigned int clients, i, created = 0;
>         struct statfs fs;
>         struct gate gate = {
>                 .mutex = PTHREAD_MUTEX_INITIALIZER,
>                 .cond = PTHREAD_COND_INITIALIZER,
>         };
>         struct listener listener = { .fd = -1 };
>         struct worker *workers;
>         pthread_t *threads, listener_thread;
>         bool watched = true, listener_started = false;
>         uint64_t first = UINT64_MAX, last = 0, sum = 0;
>         uint64_t shortest = UINT64_MAX, longest = 0;
>         char zeroes[FILE_SIZE] = { 0 };
>         int rc = EXIT_FAILURE, err;
> 
>         if (argc < 3 || argc > 5) {
>                 fprintf(stderr, "Usage: %s TMPFS_ROOT CLIENTS
> [WRITES_PER_CLIENT] [watch|none]\n", argv[0]);
>                 return rc;
>         }
>         clients = parse_count(argv[2], "clients");
>         if (clients > FILES) {
>                 fprintf(stderr, "Clients must be at most %d\n", FILES);
>                 return rc;
>         }
>         if (argc > 3)
>                 writes = parse_count(argv[3], "writes per client");
>         if (writes > ULONG_MAX / clients) {
>                 fputs("Total write count is too large\n", stderr);
>                 return rc;
>         }
>         if (argc > 4) {
>                 if (!strcmp(argv[4], "none"))
>                         watched = false;
>                 else if (strcmp(argv[4], "watch")) {
>                         fputs("Mode must be watch or none\n", stderr);
>                         return rc;
>                 }
>         }
>         if (statfs(argv[1], &fs)) {
>                 perror(argv[1]);
>                 return rc;
>         }
>         if (fs.f_type != TMPFS_MAGIC) {
>                 fprintf(stderr, "%s must be a tmpfs directory\n", argv[1]);
>                 return rc;
>         }
>         if (snprintf(dir, sizeof(dir), "%s/fsnotify-parent-ref-XXXXXX",
> argv[1]) >=
>             (int)sizeof(dir) || !mkdtemp(dir)) {
>                 perror("mkdtemp");
>                 return rc;
>         }
>         workers = calloc(clients, sizeof(*workers));
>         threads = calloc(clients, sizeof(*threads));
>         if (!workers || !threads) {
>                 fputs("Cannot allocate worker state\n", stderr);
>                 goto out;
>         }
>         for (i = 0; i < FILES; i++) {
>                 int fd;
> 
>                 file_path(path, sizeof(path), dir, i);
>                 fd = open(path, O_CREAT | O_EXCL | O_WRONLY | O_CLOEXEC,
> 0600);
>                 if (fd < 0) {
>                         perror(path);
>                         goto out;
>                 }
>                 /* Allocate the tmpfs page before the measured write
> loop. */
>                 if (write(fd, zeroes, sizeof(zeroes)) != sizeof(zeroes)) {
>                         perror(path);
>                         close(fd);
>                         goto out;
>                 }
>                 if (close(fd)) {
>                         perror(path);
>                         goto out;
>                 }
>         }
>         if (watched) {
>                 listener.fd = inotify_init1(IN_NONBLOCK | IN_CLOEXEC);
>                 if (listener.fd < 0 ||
>                     inotify_add_watch(listener.fd, dir, IN_MODIFY) < 0) {
>                         perror("inotify watch");
>                         goto out;
>                 }
>                 err = pthread_create(&listener_thread, NULL,
> drain_events, &listener);
>                 if (err) {
>                         errno = err;
>                         perror("listener thread");
>                         goto out;
>                 }
>                 listener_started = true;
>         }
>         for (i = 0; i < clients; i++) {
>                 workers[i].id = i;
>                 workers[i].writes = writes;
>                 workers[i].gate = &gate;
>                 file_path(workers[i].path, sizeof(workers[i].path), dir, i);
>                 err = pthread_create(&threads[i], NULL, run_worker,
> &workers[i]);
>                 if (err) {
>                         errno = err;
>                         perror("worker thread");
>                         gate.abort = true;
>                         goto release;
>                 }
>                 created++;
>         }
>         pthread_mutex_lock(&gate.mutex);
>         while (gate.ready < clients)
>                 pthread_cond_wait(&gate.cond, &gate.mutex);
>         pthread_mutex_unlock(&gate.mutex);
>         for (i = 0; i < clients; i++) {
>                 if (workers[i].error) {
>                         fprintf(stderr, "Worker %u open: %s\n", i,
>                                 strerror(workers[i].error));
>                         gate.abort = true;
>                         break;
>                 }
>         }
>         printf("test_dir=%s files=%d file_size=%d clients=%u
> writes_per_client=%lu mode=%s\n",
>                dir, FILES, FILE_SIZE, clients, writes,
>                watched ? "watch" : "none");
>         fflush(stdout);
> release:
>         pthread_mutex_lock(&gate.mutex);
>         gate.start = true;
>         pthread_cond_broadcast(&gate.cond);
>         pthread_mutex_unlock(&gate.mutex);
>         for (i = 0; i < created; i++)
>                 pthread_join(threads[i], NULL);
>         if (listener_started) {
>                 atomic_store(&listener.stop, true);
>                 pthread_join(listener_thread, NULL);
>                 printf("inotify_events=%" PRIu64 " queue_overflows=%"
> PRIu64 "\n",
>                        listener.events, listener.overflows);
>                 if (listener.error)
>                         fprintf(stderr, "Inotify listener: %s\n",
> strerror(listener.error));
>                 if (listener.overflows)
>                         fputs("Inotify queue overflowed; event delivery
> load changed during the run\n", stderr);
>         }
>         if (gate.abort || listener.error)
>                 goto out;
>         for (i = 0; i < clients; i++) {
>                 uint64_t duration;
> 
>                 if (workers[i].error) {
>                         fprintf(stderr, "Worker %u write: %s\n", i,
>                                 strerror(workers[i].error));
>                         goto out;
>                 }
>                 duration = workers[i].end_ns - workers[i].begin_ns;
>                 if (workers[i].begin_ns < first)
>                         first = workers[i].begin_ns;
>                 if (workers[i].end_ns > last)
>                         last = workers[i].end_ns;
>                 if (duration < shortest)
>                         shortest = duration;
>                 if (duration > longest)
>                         longest = duration;
>                 sum += duration;
>         }
>         count = (unsigned long)clients * writes;
>         printf("total_writes=%lu wall_seconds=%.6f
> throughput_writes_per_sec=%.0f mean_worker_ns_per_write=%.1f
> shortest_worker_seconds=%.6f longest_worker_seconds=%.6f\n",
>                count, (last - first) / 1e9, count * 1e9 / (last - first),
>                (double)sum / count, shortest / 1e9, longest / 1e9);
>         printf("result=%s\n", listener.overflows ? "QUEUE_OVERFLOW" :
> "PASS");
>         rc = listener.overflows ? EXIT_FAILURE : EXIT_SUCCESS;
> out:
>         if (listener.fd >= 0)
>                 close(listener.fd);
>         cleanup(dir);
>         free(workers);
>         free(threads);
>         return rc;
> }
> 
> 
> Please compile : fsnotify_parent_ref_bench.c -o
> fsnotify_parent_ref_bench. After that
> run the script ./run_parent_ref_scale.sh
> 
> Thanks
> Partha

Hi Honza,

A gentle ping on the benchmark program, Have you had a chance to try it
on your setup? Please let me know if any further tests or information
would be helpful.

Thanks,
Partha
