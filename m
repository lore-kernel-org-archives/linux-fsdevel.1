Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F33DD508;
	Tue, 24 Mar 2026 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344646; cv=fail; b=jLmiSajO+O8ANnlaSskHssBr3+jvKOFzEJSXgrnB5aSei3qxlk3yq6giXMTo1usVBV9oUEsqEM9eH16JHfj3aWdkYz6UMZvP/v5RY//guEbI+K1WrtTS5yFA2dA20jRC3cXDcEAndzQGOxmpppTm0cYyzFTtq8RVFk+c5IQDEdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344646; c=relaxed/simple;
	bh=t6oD0hbRwMXqY/SVhvwXPUwBQxS7U7Hj4ZLOSAShZP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iHOgxeH5utHm0wZ5VpphtnaYd8SRWoQNEwcRDX6ljt0cNOdC110vfsZyk1QSYk6nAusc+Z9d7cH20oFUH3FC3ot2pAwb3xHP6KQvyQc+JMCRFDDR9MuIM+/O2t2RUtZMQ1SUj00oPjqEBiLspve4oeqd5dTsydHI7+MeCFyQIwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NqS4uQy4; arc=fail smtp.client-ip=52.101.57.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NqS4uQy4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh0xoVzFLHBSlx1P/Xn9KHn8SLAGJHXy5DMcg8VPWNvN4CrtsjfRsgt4CUbxhqxX+DPF2aEFK+0TgGITMZiu0v2SEn7dKU7QT1Yg8APgVhna2GwSjuSV/S9PFWT3syTi/lxVlAXGBmUbK3wqx7sx27C5PJW1Vv1Yhx/DzLIc4IQCk3Sb/+N6rQIxtbo0CSAqTr4qUAaJsKHMFLMRfQmcsz1oeFhvw5MRRqkqokNSoYyJmN49i1iY54dkpkJxEVNUaxI4XN1s6rON9EL6fhHjFrovRnxamo4DIft/kgU38lpMW7PxzPY+5tzHfzDTcHHrMizcKY9EThXhvkqjmepTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zd9ewu7KKDBFLSpypzJjfc4Z4h6U/+oz8Ls6aHbXN8=;
 b=jG00E8kpQE9QttOARGg3DYdOOSEX8pcckTnsHDx01YjpYuzzriSDr4oRBmrjmsXKVlXYukXE0SzFG3sfw/ytHKCTcWRiRBdee9Gyj7xFThv8UsqpsinDWrcZr+7xJ3So+i6GG3x93JIHckRM2p13gneBNrVQinF//gEishuNUav6mk5q2KtNIAn92geVjdhpVIZT3BeEscdbDzoM/MBSlsywF+Lw+0Y8qLMxiyfA7Yr4V0Lcvr0yOxiWCKYhJXjMB5K4ZJI9MAQuWcrtb4XV3stgCVlocEiESsGl9zgUbTGaCALRA5XUSs3qGHQMBnXYSHt9LwzCH9IkZ8OXeNkaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zd9ewu7KKDBFLSpypzJjfc4Z4h6U/+oz8Ls6aHbXN8=;
 b=NqS4uQy4RGKAxoHy+1oe1TxxQgsHgDlzn4hLu7rbFUC7mwYvs3v9J1oUL3r0RRbi9nM9hPC12qF3Mj7HpuDiHsX/Wt1zRrtdiHSOkWo18pRNlvUPvyFaWG4JzQOUjVU7d1ivprQ+rmEu7BKd+KluqE6blQ06c1hCMyGN2bpGo6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 09:30:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 09:30:39 +0000
Message-ID: <b8e8ea43-4c1c-41da-99a8-267010e1b9de@amd.com>
Date: Tue, 24 Mar 2026 10:30:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fdinfo: Option for public fdinfo
To: Christian Brauner <brauner@kernel.org>
Cc: David Francis <David.Francis@amd.com>, linux-kernel@vger.kernel.org,
 Alexander.Deucher@amd.com, linux-fsdevel@vger.kernel.org
References: <20260316183828.3354343-1-David.Francis@amd.com>
 <20260323-neugierig-meerschwein-31b6daaa1db9@brauner>
 <10ac8ef6-56b4-4a0f-b970-18b3ce012ceb@amd.com>
 <20260324-mitmachen-wirst-65daea421642@brauner>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260324-mitmachen-wirst-65daea421642@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 40768696-1ce1-48b4-985c-08de89880324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uaAy+axTAAP2ACO2gvHobBdo9DKfLIpkkHr5NNvL1cZiv6wsopJWLq9apoz2b9ZaEKQXHLWg47DrBI0Qgl7JlYuao49i5KqxKYPRnJ1p/abEUOKYJcgl2lvqJtoiSuF5P/oO+BpQTVDTmkGEm6dfotFSCv6U5R+82m95zTn39aN1fWaUGUl9rwB+VB7MGJmKkE2SRTGPmUhTYioswnHdOjDqykn6XEgUCXVlTL7kEpQOpodv2LDWSv8yEut0w3NdUYyq2UORdNbkXtdtRNcktYkHw0uoh1uAFzBfXf5ipTIt4JImdv61qWVHN/LbIaMckrWxtK68+EpvbqpCaqsIZKPw4cG39hKGBw9yqnjpr9EN66yTqR6aQUvBQryCH8vEuuB0bqrhnLVeLD1B3eDKwPhPgkppDsmiDwNPoQrUsn46akDmCitot9P8n1eLcKrCGJstjsnE2qQxJIKP/3q9VbydTdHrF/X3ksud6x2ixBClIJBLwQa1LjEplyWCsSfZ4ScdhNtrqVjcKCuiuh7tnqRs/3Nxb0eD5NrV47p3LR5ltbmWb1NaMWawY3GaLSwakICJ6rR33ei/g85ioqxrWpScU89zA1FA/jfIVSxTFrKIiqINNqhDfpMDGK/Lg5yGOXlFcYGMnCw/eeT091su/MGyA9Wx71RibFQ0RdoLWRq8dp59ZuBaYO68ncqArBtJlGIL6ddVRy1q7cXMObPrCNNEJS374vjMikas6pbhn58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXZqNnh2b28wZ0pub0UyMFZjOW1GeUFSYklzM1RENVFnOWwzV1BLVWkxL2dq?=
 =?utf-8?B?QXozRlVVbE9TREFla0dwZ0ZIa2RqcS9DRWxtTDlrZHhQMTl6L0VLa0hhREhG?=
 =?utf-8?B?Y29Zck1JcnlvUXlaR2UySGJPVEVDaXVQdTdlbTdVa2RwWjZNZUQrNDB3UHlk?=
 =?utf-8?B?NytiWkxmSWlrNlYvODhPNU9LZDJkS0FDWVF2V1FYNmVaYmtBejcyNXZXeHNw?=
 =?utf-8?B?blhMZGNtNmhpbUZIY0M4cytna09VZXljRXk0eEFod1UvRGRKY2llNG8rUSsx?=
 =?utf-8?B?aE1yMk5Ya3paQ1RhVVNWcWFybXFTMzUyNVA4QWhGa0hBeGwwOXpXa0g0L2VT?=
 =?utf-8?B?TUxoR29RZ3pKMUYwbUxPdnJCa01FYTN2cWc5VkVYb3RWREtEWkdlWlc3Zm5O?=
 =?utf-8?B?RTBrQTVmYUV4dTZ1bVE2aG1KeWVFRjdtYkhpRVp1a25WYVhDTWVZVjJ3VnU2?=
 =?utf-8?B?RVo2Wmd6MkNSMlgvK0VhZGYwYkpwYXByUFF2djJEaGM3dUR4MkY1Sk5MWEVm?=
 =?utf-8?B?Q2VJNDZTTE9JcWJaT2NOb2pDODVJNVB4c25DQnJTd09PRTJpZHl2alN0ZDhN?=
 =?utf-8?B?eHVjRDZWTVBTOGNIOE9qb1pkT0d3TmtPaVVBUkd1a2RxZzRsTzUzaXNNaWR0?=
 =?utf-8?B?K0lzVmtJUTRyVVNvM0RhcDYwLzZHTW9UMlF0a3ExMW1WVG1CUXVqQm9Jem5y?=
 =?utf-8?B?ZDZBZWhKNTM0eUtQNEx5WWVKbWlSUEVmSHNqMEZjek9WNkJFdnBsUW5UUlIw?=
 =?utf-8?B?NEU4WVZGZmtwaFVub3JSNlR5M2EwaFYwL21pbmtleG4zMHVIWk5nbzJKWTE4?=
 =?utf-8?B?YlgvTFY0S09xdUVvUEkxRmhCSFRYMHRZdFU2RWFRbVBxdm1lRGY2bXo2Yld1?=
 =?utf-8?B?eUV5NG1tdDJCYlBHa1VnSWU1aGo0MVpRbi9KYXo5QWdUc1hEL01uYW4xaXM2?=
 =?utf-8?B?R0J2S21KMEhsRmFUUHpTT2V1RmpLNG5laTVrNjU5Sm5wbFlPclpSb2lKdWw0?=
 =?utf-8?B?UmFvU2hzd3dsb2FFcGlSamljclc2d1p1WS9EL3pVR09YZjFpUUw4QXA0dzVX?=
 =?utf-8?B?bVBzYUJzeE5uS3pPdVFUQW1Na0I2aEZoVkJ5dm9iWWVHM2pXSXR4WnN6a2Jy?=
 =?utf-8?B?R3ZDNTFhY0pFYnVFcmlMQmZPcVpQcEkrc016d1pEYmx6K2hQcitWTk1kbVNH?=
 =?utf-8?B?Q3ZUR3BIQUM2dDF0NXp6R0xRbG81dDRScURjTGFaRW1yVDFpTEgyRmdLd2kx?=
 =?utf-8?B?ZDlScEtROWQyMlpQTS83NjBWM3hGd0JSNDU3VXh3N3l1SU1YYUp4cXoycUtM?=
 =?utf-8?B?ODJPR0l5eDJieUtLL2hrcGVsWUNVejFXTUdiYnVNRXg1a29VVlNGYjVtOG1E?=
 =?utf-8?B?UzZmM3ozOTFIK0ltZHBaOURwSVpkVlNJZk5iVWpHdW1oZkNvTWNrK29oWmEr?=
 =?utf-8?B?Mk1DWURhbVl2UjJhZEU1U2VvSnlJeGxkTk5aOU9XNHhqd01Ld09pOS9LWXF3?=
 =?utf-8?B?eUl3UmM3UnpINlFjRmptVTFmS2E5U05sOUx1WnAydExURFNOTXlnSU1kaFB6?=
 =?utf-8?B?d2x0Smx6ZmtidmJ5RldqTDNEY3ZSemVKRGJZZHJ2b3pRRnMrL0R5bTFGYXJL?=
 =?utf-8?B?RlcwQUcwbFN3NTVaYytGajVsNGZGY3lZK1I5aUtNRCtlWXJCS0FSS21oU0lu?=
 =?utf-8?B?eEE4YmtUelkrQ2Q1WUxWbGh6YkM3TTRHMEdyM0d3WGxZYllST252VHg4M1dU?=
 =?utf-8?B?UVU0M0Q0cnBLejlwVFhndnZXUlQ1dVQ1cXJxbUN0eUszZ2NNMmZDYmJBc1My?=
 =?utf-8?B?SGNDODhhTWp1aVBkUXJwRHhCdDhRWGdGdG16eGR6NjA2NzJocngwYkJQcG0z?=
 =?utf-8?B?TWJYS0JVWE1oRG40QjBBdEFpaUNpMjBQQnlhYUNYcTZURGRReXNFa2RIdlZV?=
 =?utf-8?B?WGJRa3ZOU0NNODBONHR0ZW1vUXlxZ3c3LzZ2YTI3L29BdEZCMDRabVFrZm1W?=
 =?utf-8?B?SW9OTWZKb3NRTEx5SUJvYTBmVEU5SzRDMUlQYlZNODAzVUJoOEEzOGZJUHpv?=
 =?utf-8?B?RDRRblpVMm56dEFtRjRMTklSb0dqNUxpYysyOElOVndEQjErM0ZWbVlDaHBD?=
 =?utf-8?B?LzJ5YVlwc0RQSEpndGRDT2dheko5QUQ1Tmc3eDdZU2l0WUs3UmR0V0gvTEVW?=
 =?utf-8?B?OXYvRGtveTZaa1R4Q0RyVkZDY2dYcndxckovczM2dW5vbm1pTlBtdUQ1MEZQ?=
 =?utf-8?B?VmVYcmxqazJrMUJ1aWtLY0VKRlRlM2dJb1owdE9xRXlWZmpST01HeEFTQ3Zx?=
 =?utf-8?Q?2WoLGprbKXXFH8m/bo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40768696-1ce1-48b4-985c-08de89880324
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:30:39.6249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eype2P1U8m9YZPY6GsYTXvh7kBYtmp9XiXtbJzKpvvzoRBBRNnXzX7KVPtmy5bo2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236

On 3/24/26 09:53, Christian Brauner wrote:
> On Mon, Mar 23, 2026 at 02:16:59PM +0100, Christian König wrote:
>> On 3/23/26 13:13, Christian Brauner wrote:
>>> On Mon, Mar 16, 2026 at 02:38:28PM -0400, David Francis wrote:
>>>> We want some GPU information to be publicly available to all
>>>> processes for basic system-wide profiling (think GPU versions
>>>> of top).
>>>>
>>>> This information is available in fdinfo and not easily exposed
>>>> by other interfaces.
>>>>
>>>> Add fd_op flag FOP_PUBLIC_FDINFO, which, if set, makes the fdinfo
>>>> for that file available to read for processes without ptrace
>>>> permissions.
>>>>
>>>> Note that this makes public how many files each process has open,
>>>> and what their fds are.
>>>>
>>>> Signed-off-by: David Francis <David.Francis@amd.com>
>>>> ---
>>>
>>> Eew, please let's not. Add an ioctl if you need to be able to retrieve
>>> that info.
>>
>> Yeah the problem is an IOCTL is even worse from the security pov.
>>
>> This is for an tool which doesn't have access to the file descriptor which provides that information.
>>
>> So using pidfd_getfd() or similar to get the FD and then call an IOCTL on it would be a security violation.
>>
>> The real question is how should we make this information public available in the system?
> 
> Don't you have a way to make this info available in sysfs? Just like
> networking exposes info about network devices in there that may come and
> go?

Yeah that was already tried as well and Greg summarized it as "sometimes you don't know how horrible something is until you tried it".

So the memory accounting parts for DMA-buf files in sysfs were deprecated and removed again just a few weeks ago. And that was basically just a subset of what David tries to do here.

The requirement is that you want to be able to access the stats for accelerators/GPUs drivers similar to how tools like "top" or "htop" work. E.g. everybody can access /proc/*/stat as well, it's just that some security related information are left out.

As far as I can see we have only a couple of different options to fulfill that requirement and lowering the security for fdinfo like David's patch here suggests still looks like the most defensive one to me.

Regards,
Christian.
