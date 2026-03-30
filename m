Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788A3DF01A;
	Mon, 30 Mar 2026 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896559; cv=fail; b=ZuSla3Egb8NYGX8QjdviMlpsE6vByGVcx3T/KeAafPnZ2Sz8RLA3T01yBjVzzfGQpQUYiN6yzPnmlIA5NCK+zQwwbrbKL3y8Y1wVjf7WY06SmWAvkpvxjGdebnFAkDY9vjG9zRdEtpD6lx6dwWwZHXGtLmlLLLQHXSLVwazpsy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896559; c=relaxed/simple;
	bh=CyRVQib6iVJr6l2tOB9xtkZU4jgU5H/JfWbpQ4n+E8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HITcLRFClP435NAH1Uw9GAyH44mE1mITf6cXHzGxNAhxJafidfDxtczLZVkF7CBjCHZwVYKciF3SZVf58FcR4G1jRbuzmN04ZM9/ck/D0CW9X1lImipnAiGObMrc64PwltbQZvZbMPJgZo4nvbwGPfAeHIPC06N8xDbQfMi4LTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=15jBjLqh; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="15jBjLqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbd7S+MsHwwOgPbaZrCQcOsTHHFtFbsjINIaNQta2GJeGfa3mYa+3EX/Q7WgSyHplTUgiSPTGRD710VlwQjIrYN44rKCYI7ae0hE/olKlyBCmiECnBWSenhrEtzP7gRq05NhiM0GKPwn8VRT2Db0Nxz1dA8LRXTzV+VW3pqoJuoo3mb4jL81YJuvid0LedaxKOjXmsJ4Ul8g8j09s9uIjKvLetn3ErxFouBUPbv5mVs3bnymk3gAdKaBAARBJwnJ/3qSUgBbRG0EYnAWO54uZZGJVTuICOuxxN37i+oiEoMSzgGCk13kTMrpmJEhAoyo63XaVVq8Ylghd8CwUi3Rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr8iUdGDSOoDT+6epoSEm4TL8kfRlrCjVhBjF4pcMOM=;
 b=kD8LKWKc4DN8RBJub1qVulWGJJlDqmmGe93+frPHvzo66tQt6m4MGJ+nfVfXoWEAm6NzF47f7OYY37tSjPSb6HoGtd7IUGoI+reRts6pOUJxY6CgVMyocTYIvL9nY4mOSUNzGAogazMISvRAn1YBP1BS1IvdNW+dwD1e8ykCGOR26rLuJ6IzZidEoLu0uTON1XnsThtPQZIG9Dhu/hEw98V0QBPlmhjV9R+32TMM00QA/p0kC3cu//BMHqZvO86aL+MjgMl7kYefIilotFzYESTuz8jw9CF3VJujWttasPj/87IcFYCJ1gxuba9fCL2DqQlqFwB/5bokBN4x6kKg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr8iUdGDSOoDT+6epoSEm4TL8kfRlrCjVhBjF4pcMOM=;
 b=15jBjLqhlSGnmanWd6rhZp0pGf8F0559KuosE0TKiL9HhYy18yYJruBSmnn+uTUmHFkMMpcFcyRhjsQ5gbP1t928Wby5SQhR9ua/LEH95oOqNlEw2agrOXp9OOZLgl7R8nfoELx6fAmNC2BFKKHUetUCbm4XlFzt4EHXrWvGSI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 18:49:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 18:49:11 +0000
Message-ID: <94d15393-687d-44a5-94c0-0f6248e58bc8@amd.com>
Date: Mon, 30 Mar 2026 20:49:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fdinfo: Option for public fdinfo
To: Christian Brauner <brauner@kernel.org>
Cc: David Francis <David.Francis@amd.com>, linux-kernel@vger.kernel.org,
 Alexander.Deucher@amd.com, linux-fsdevel@vger.kernel.org
References: <20260316183828.3354343-1-David.Francis@amd.com>
 <20260323-neugierig-meerschwein-31b6daaa1db9@brauner>
 <10ac8ef6-56b4-4a0f-b970-18b3ce012ceb@amd.com>
 <20260324-mitmachen-wirst-65daea421642@brauner>
 <b8e8ea43-4c1c-41da-99a8-267010e1b9de@amd.com>
 <20260326-enten-hauen-36402c54073b@brauner>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260326-enten-hauen-36402c54073b@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:208:52d::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6316bdf8-103e-4166-4cdf-08de8e8d07f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EDtKn12hBqI0GsLBvjL3dl0QHNF3wV3FkGISFCvuCTL54qtwO3oneHUYFR7O/7J5JRloooD4rntF5bl6oZdK/8y50c4zmBbpXutKAUwB4TnrnG2zZ4fnW4FL4zGcvraTKPSIZnxe0VdN40EbUbA3/1gjwE1hKr1CGOWgLniYqDpEjSFDaTWCUNLXjlGXWB2YucxCH0ZyiGbNXlKxW7/TSJ61l2ggjphWJt6KjYNAJSx9sFptCeDsItoc85r/Ks20NdITL1g3QFzpeAQ5r8Cev7VnJ9dxZBVfzTbPFZ9R4SdN4zMfvRkIWDn+gJKdcqZTkzlVgRqVoya4TJMLr+vxFy+Lsvvo8I7G9/X4rxIRmEqBcCKMjlc8tqubh1AYFuxW8ulm9SxO0tkz7tq2pWnYJ2boGkt38BnhazfIsD+QqVg/YSipDF4RiSq4JSVBI2pa9ljSdmyoDd4ovVnSs+Yqxv1RkPrr3F312j7bPUPClxT8QgFE2Hl8g/AzHzZXMOJncM2q+beEgC7qUpbEiLVjkujKzRtpNvn/v9sBWpzarGu24qIqIvM6JrjZ9fI5+N3paQtMpXKnRkF+YREgyz9C5FeRw6CsihBT8+2aORH9xkxB0EWUIO6qlodZBl9CwDi3WS/JR/8GmzOY7DwFnE/qD2BswNfZRLARqSIPCCkYor7nbXOmASjeF5HSG93Ya58syKEfcTQ6DbobUo0+hCRDMPs5EGepxcKv7nI224UvNOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTBLcm9YMExLUUNsNUxxQlpMaDFqQjdDbmkrUVo4bWh4UUhqckZlemlCS0x2?=
 =?utf-8?B?bEtCR2hYcUlVN0tzNWcyQ202dCthbWI1ME9pWC91Yy9tbHdvSUNWWVRHTzlN?=
 =?utf-8?B?YlVuVWxoVFdXZ3ZGZ3NUSFhCWjNZRVJvWmFtQUh0SC9zQ2NuUnY2TkVKc2xZ?=
 =?utf-8?B?ajJmR0QzbU5kWk1HVkFmNVVhVi9LSS83ZzdyYXpaQXI2Y0dKRWRYNFppNG4y?=
 =?utf-8?B?bkppd1YvZ3BFMy8vRmdlN3MxdTAweFl6MmwrL2Y0N1FpK3crcnJXaXFGeUFm?=
 =?utf-8?B?NDVCaC9wUXJCUDg2UTAvM3ZESnRwc2Y5ME9EV1BWM2JRczg4dDlrRUM1c2FE?=
 =?utf-8?B?QmFhYkxzZGptVk0yZGV1bzBvbWZzYlgyY2xuT09iYnRtaUhYRExQWll3OXRM?=
 =?utf-8?B?bUo4MnpGbWxIaU84czB2NGRMQXdTK2hJK3h1VGZPWmMxRXF4QUxYeUswTUlt?=
 =?utf-8?B?RzhNNThFMHJWRzRQb1Bzamhvcm5PcmJVMWVOd3MvVlR3ODlKSmc0WVVoTjg5?=
 =?utf-8?B?LzFLdS9ramNiSE5xelgrYzU5czh5UDVoU09lVnp5ZC9CTkNtME1Bd0hEYXR6?=
 =?utf-8?B?a05VUGtieThaYkVEdTNtak5LVmNjSUlYa1k4QkVjTXVKU3dzMWs0RzJkUmFj?=
 =?utf-8?B?dnYzbnVRN1UvNGo4aDRwSGVTM2NLRnZKMkt4aGZ2YjJuY1p3cURTbVRYc2JL?=
 =?utf-8?B?TmZsZGIwZTEzV1JZZG9uMkpBR1lGYTFNQWk2YnB6SmY3SEUwWXBGVlJlYnVZ?=
 =?utf-8?B?dTJXNjd4cG1kMTR2Tnp2TG5vOXhnMmF0M0xtMWlYRXV2NGd2U0k3KzFQUzlJ?=
 =?utf-8?B?d2VFd2R5aUpsSkpBVW1pK0dPMDN6N3lYZTA2dlQ2MnRjR3FZWndHYk5GWTVJ?=
 =?utf-8?B?OE83R2RGN3pFS3psYW1yZWlHU201L05SVHpSTEtEc0hIQW5JNFRmQ2xQUXp3?=
 =?utf-8?B?TzlXb0ZwNkwrUUhkK21IQkRFRlZudVFnYXlTVEI2alZKMFlURE5zUG1RRjkr?=
 =?utf-8?B?aStQdzdXc1JQVERWZFJlZVVKc2Z1OGgwSWpTU0hWbTdwNDV6WmdjUWRKZVFV?=
 =?utf-8?B?Q3A4blN5OXlPbzhNOWI0cGVnZXp5M1lMeHpBcElQK0RvSkR4K0hvYmVldVVR?=
 =?utf-8?B?Vno0MHZTSzArR2xUTjhZcCtZaFQrditIZ0lJVFF0WXZTeGQ1M01yM1g0NGE0?=
 =?utf-8?B?R2VFeGdhQkpiQ1AvYnJmL25PMXB3UFF6emdBeXhjNkZTckI4RURVQTl1ZUx0?=
 =?utf-8?B?NkZSSDRRRkl0UHJqNXRTNGpkREJlUm1IUXAxT2FNeElRdi9KVFdKY1RXWGgv?=
 =?utf-8?B?NmRkZ2VwRHE4YzAyVENYbmFtRngzQ0w5UUE1dER4MDNCOS9XZGtONjRKT3du?=
 =?utf-8?B?VnlGcU5KWFptY1FPMWVZbExMQk5UdXhVQzRFejIvek9uclNnakllbGozQ1Bn?=
 =?utf-8?B?bm5qRzRYVktsNVR6MExTMkZ2UUNZWm4xcUxTUFNNRUpIRHI5TWZ1eWdrbVVI?=
 =?utf-8?B?Y0NZYzdYSTBUQS9CdHoyS1d3V0tTejNiajRnWE1USWE1RFNEWTA2b09FVGlq?=
 =?utf-8?B?cFhZT2pKZlhiMHVWakR1VXljakpibWdQdGIxbEpGS3ZKRDRyQ1FSU2tRVjNJ?=
 =?utf-8?B?Mzd6bU8wMW1xNnowUkw4eW1QNm52bUI4OXRobC9YN1dYN3huT3p1RzNObElC?=
 =?utf-8?B?dzVQeDFsVlRuTTRheTEvNjVLanN0V0FEQzlrbmllelk5VzJnQ1lqclBEUkVs?=
 =?utf-8?B?K29nK1pic2M5a0ppb1hORERheFZCR1djMjczRDVteVRYVmZrV3k0KzlKR3lL?=
 =?utf-8?B?T0NSdVR6RjN2SjhMb3A5YjNRbWVLTis5S0dEWktVOVJqN08rVmI3MTFLUlI2?=
 =?utf-8?B?RlkyLzJNa05BditDcXp0RnNTUks0SVBnRVd3Q0pLcXAzSmRZNnd3UDRUbTVr?=
 =?utf-8?B?MEVkY0NiRzYrU3dXOUxMSExtUmVzcGdPUk5wM2VzWTYyK2txUGZJcjN5TU9T?=
 =?utf-8?B?c29zeXUzNnFFY3VXQ0twUWdWL0x6MGdEU0hSR2tsWFJEaEJFKzdyZnpKTXl3?=
 =?utf-8?B?VzNlR3E0NDRrRFgzVzVlZDFyQ1h4THFpTVJiZHROZXlPOTMzbkpKU1hHaElX?=
 =?utf-8?B?UTVMbFNleGJLamJsMWNoN1djVEQ4ZVZrait3YlNHWXo4NUhOWDUzN2xRQ0Rp?=
 =?utf-8?B?SEkzV2M5eU9ZdVVxQk9TWFJPUktEUU56RmhEaThDMmN4dXhTZm1ESnk2Vm9k?=
 =?utf-8?B?NzVITytEL2djcFEvZ2o5WStWd3JDVkFvZTBYL05lSGU5Yk15bjZoa2oyeHFk?=
 =?utf-8?Q?vFV7TolVhV2cf5WTO0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6316bdf8-103e-4166-4cdf-08de8e8d07f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 18:49:11.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AH87HY/Jff3Q281lyrZKSdDdVas8KHMDteh7rd7Vr7dWFOyDyHT9etv6K6A7rf/C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046

On 3/26/26 15:42, Christian Brauner wrote:
> On Tue, Mar 24, 2026 at 10:30:26AM +0100, Christian König wrote:
>> On 3/24/26 09:53, Christian Brauner wrote:
>>> On Mon, Mar 23, 2026 at 02:16:59PM +0100, Christian König wrote:
>>>> On 3/23/26 13:13, Christian Brauner wrote:
>>>>> On Mon, Mar 16, 2026 at 02:38:28PM -0400, David Francis wrote:
>>>>>> We want some GPU information to be publicly available to all
>>>>>> processes for basic system-wide profiling (think GPU versions
>>>>>> of top).
>>>>>>
>>>>>> This information is available in fdinfo and not easily exposed
>>>>>> by other interfaces.
>>>>>>
>>>>>> Add fd_op flag FOP_PUBLIC_FDINFO, which, if set, makes the fdinfo
>>>>>> for that file available to read for processes without ptrace
>>>>>> permissions.
>>>>>>
>>>>>> Note that this makes public how many files each process has open,
>>>>>> and what their fds are.
>>>>>>
>>>>>> Signed-off-by: David Francis <David.Francis@amd.com>
>>>>>> ---
>>>>>
>>>>> Eew, please let's not. Add an ioctl if you need to be able to retrieve
>>>>> that info.
>>>>
>>>> Yeah the problem is an IOCTL is even worse from the security pov.
>>>>
>>>> This is for an tool which doesn't have access to the file descriptor which provides that information.
>>>>
>>>> So using pidfd_getfd() or similar to get the FD and then call an IOCTL on it would be a security violation.
>>>>
>>>> The real question is how should we make this information public available in the system?
>>>
>>> Don't you have a way to make this info available in sysfs? Just like
>>> networking exposes info about network devices in there that may come and
>>> go?
>>
>> Yeah that was already tried as well and Greg summarized it as "sometimes you don't know how horrible something is until you tried it".
>>
>> So the memory accounting parts for DMA-buf files in sysfs were deprecated and removed again just a few weeks ago. And that was basically just a subset of what David tries to do here.
>>
>> The requirement is that you want to be able to access the stats for accelerators/GPUs drivers similar to how tools like "top" or "htop" work. E.g. everybody can access /proc/*/stat as well, it's just that some security related information are left out.
>>
>> As far as I can see we have only a couple of different options to fulfill that requirement and lowering the security for fdinfo like David's patch here suggests still looks like the most defensive one to me.
> 
> It's not acceptable to make /proc/<pid>/fdinfo accessible just to carve
> out an exception for you. You can look at implementing something like
> taskstats based on netlink transpart if you want to.

What exactly do you mean with that? As far as I can see we can't expose per file descriptor information through netlink.

What's actually the problem exposing things through fdinfo? As far as I can see it shouldn't be much of a problem exposing the directory for everybody and letting each file decide what the security checks should be.

Regards,
Christian.
