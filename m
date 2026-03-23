Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE118FC80;
	Mon, 23 Mar 2026 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271828; cv=fail; b=DBQKnL2MRkCii4ssrrOYFfBKinaXAc3D4b+SfcfX2TSX67GWJYwmbAs/n29//zMejpUfK1C37qdDlcwbqaHQ2SiUYF4eIDGpOfBY1wVEy48D4Cb6c3B+CPSxuCB7gKf6qndz2p+w/DTMT4O0wJx6W7Md9/KM/gCAF9uiJ5CyuiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271828; c=relaxed/simple;
	bh=T8aA2pEMb624XnIKN8v3I2PhXn9TNiIdR7MtjsN7NvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SG75g/VE9Rwvh+Yv70WPd2HSA5zO/ANPJZ2xzp/ekJjBxZjovUgB82cGLwIqCbxF1eNNYin79cdx3trU7/de+IVy8CT3FVQyXDA5eUpqhg+8y3J/+XRnTfZu7pHz3p95d8LIDO9e5ICgNs79sCFiTno66ykP5E4uyqrRE0XSDIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j44moXqL; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j44moXqL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEvuWqoLkwvywn101AE3KoXSqi2OsZvwQ0E2PGskZZUQRh1HjH8ABLutC7FkDvdP5Tne0kCUWn+bcKA/vraZH8BjqHZiX93uY4N48wRB7WY/BvzYWH4C0eY3LRVq/wf7no2ocdaZmhEA8QbM3y8lTZ94SNIpajvnFCJqPQJ+TxvJiWt82aRhGIlMlXN3kbQ+0AoFmUmfmzNjLfIcy1IKQIlccHLiz41CiWUAwvHvcy6h4+poFIK6zZNNEGe2Bf5xviYM+SBevfpbd6FZchoeFm7zOM+d3duOdFdqtrVkCqGndQt0HAezMwJGKLLDdixIYegTNxXnDiJnLwGfp/5j8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buQG+9JckZz2ra/cje+0o+AmaNTqXXe3lJIVKZflpVM=;
 b=S97Ub3P6vv+fx19aRnQgrW2Z3CLImzqiDt17TcTtu1vmOaW82+swgl3//UxTbFVnmJSh/rO4uCgQou5fvXWodkGYj365SGpFhvV3BkozJlnQOrvK5fRM8eJLUR52n8jezai7K5Lrtf5UcFmmh+o/qBm+blnfUlvWp4rSTeCpGk0aQazTbAjb6b2mMxYFd9jfO4P3DxJXvo8gY7j8jWtSELkFQ9MfwCUikV1Ja3qi+xf1wntJ3TY4C+CtbeWu7TGzZvc+xrJVaBone9iBwyRbdsrLB+87n2/gcf/Iy1FceE2Awvfx+w09Dh/+8t+c1hB5kzeQfz11gN32S2Wh11iV3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buQG+9JckZz2ra/cje+0o+AmaNTqXXe3lJIVKZflpVM=;
 b=j44moXqLhAM0kxr3oblMG7+W1s9OHCqBhqfIYP8jeoZruRBBPgNhjW0NY4yf2F5IdmXt79i8p8YxHCwqjmMSp1COnHT5bzWxJbQBIEAZemboqzCArDHiCm/kPYN/2tHUy19wr7FCOYMnP+UoujgOpNyeSKqcWA0D4q8NjF2rZ4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:17:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:17:04 +0000
Message-ID: <10ac8ef6-56b4-4a0f-b970-18b3ce012ceb@amd.com>
Date: Mon, 23 Mar 2026 14:16:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fdinfo: Option for public fdinfo
To: Christian Brauner <brauner@kernel.org>,
 David Francis <David.Francis@amd.com>
Cc: linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com,
 linux-fsdevel@vger.kernel.org
References: <20260316183828.3354343-1-David.Francis@amd.com>
 <20260323-neugierig-meerschwein-31b6daaa1db9@brauner>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260323-neugierig-meerschwein-31b6daaa1db9@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:208:160::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f7d8da-8a0b-41db-7f07-08de88de79d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZJidiyI4HEoUYnWHXIkJdlOX9zuRBbl2eYsjThR26I6od0UY7pdAYfveq1Aw4hwxNqR4d1q8I2bvC0R42VYbtmiIUqJ79xgdEKA42B7cr+mIuYcHCzaabkhW0vz3nYxdOCBr47ZYuVxRCzx09XShf66p4DV/LlGCdun81Ktn7E6z4XPgwr0poVMLkA8vSV9pZKA4Wc0nnLQzppyMQYJbGrdgi0BfI6d7lVehABhmFXNZe6qt8w4GZaENl0Fa9JoptbOXH65++2Ey10jhz8Pnl4EFvrjfTBv2ym1jtmzmZ9WoFq5CPl2s/301R91l6cw8FgXRhqdA9fZU7TkLW1qn+BeFj9c/rhkeTShOL1stvTlBio4S/nhhRItVRvwRRXKsxDF+LdgYkvyYZb3y+Yen2zE6270LXdT6eHbEQxbyyn8eQKHxlaAQDmg+21lVcIf5hZ+8skizquyQEumrDvZfmBNirBiEsYZSKRmNEHuMSexKqbpHAYzT+LORrSBnoOG1tD+wE427ZKfNghANM4Zcqwpm44W2OctQd10SWj7HTppT+rU7x/QHNDXcNhIzOIXUnmI+81zv0TkQ7pc217vfcHvtwENsZ2yN8VJmfvJeOwqqW3kMnakL03LgqUbYqJsZeNDpNsY4k8V52VT146Xnr4NkKRJK06I9C3LLH8p1z8Aj7Hm882aQ0jlMTwrRLKqq4yyqp4hqCfyyNKs1QB4DR7h8NsjSJnIGNsrV1D1hFrE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1Y3S29Kd3ZOYTBuZjdHOVJqK2NvN0JzN0R5eXU5ZWR1Q2xDUW1hUnZIN2tM?=
 =?utf-8?B?WmRxeGZFSHM3a0c4bWFMZlh2QmhLaFRIOERqVjZVdUsvMGxxUFBKNVBsK0tX?=
 =?utf-8?B?ZDJ6UXRVNlpVUll5VElaTGRKeG51SnludFJBVFRnVUZIY3lJYk4wWExUZWt5?=
 =?utf-8?B?NE9lMUV6eUFoYkt0emNvS2dPRDNQWlczRk8yYkpZWmluVnFDQk5PSVJhU25v?=
 =?utf-8?B?bGNRYmNFNFludVhTTWFjWWR5SS9jOTRFbitJeUtFYllNZythUDJlWDAzWDN5?=
 =?utf-8?B?d3UxbGlpZ1ZKa3c5ZjJOVjdYY3hHeTZPYXZ6WEUwVkxTeHN0bGszcmRtcWhM?=
 =?utf-8?B?d2ZCTWxhNnJnTU9HdE1TSGV5ZUo5bVcyaEZwbTVKV0VEaURkb05vOU1ITk1a?=
 =?utf-8?B?WFRyTitYYjAxcCtrbkhvVlRSSzZ6cWNWRTBpb2I1RFVTVnJzOWU4M05FdHVM?=
 =?utf-8?B?cklXS0hJTCtSVFFxMEVJbEJScXJGSTBoNis2WWJSZlpQd1EvekUxZTl6Vy9v?=
 =?utf-8?B?VU9BeGs2ME5uakFFSndmRDFKeE9RaUFFTkp4cmJUL1h0VFFaOXR1Tkx1MlVi?=
 =?utf-8?B?M1lkKzZWSGpGQk5vaXFBYTY4RFZzYTB5YU1CY2x5bzA2ZVRVK1poc2FpYVlQ?=
 =?utf-8?B?MXNaWnZ4NUlSVENzQ2VSSzRzYSswckZqdFFtcHYrMGpLYndQVVJoWWc3WGR2?=
 =?utf-8?B?aVpPTS9kd1dCNmhlYlNXWit2YlhZbGswWE5LQjJMdmFiU0hWZGNLd1BMbHZY?=
 =?utf-8?B?SkRkZkl6NkxHWUY4MnhGbG9tQjRvaUhGV3pkaUl2SjhYWXZYNGZBUk1ySjJP?=
 =?utf-8?B?NVpuTXhMTUh3dXJac1plM1JyVkhyZE9ocTVkWXVhM1dTUEc1UUFFNU9uZFQ5?=
 =?utf-8?B?ZGM5TWpmYjV6L2YydWFLMWZ6R0J1ZjI5UEM0SnRSNVJNZzBESmQ3NGdFT2NB?=
 =?utf-8?B?SDVvLzhQS2VUYkpoR1A0RUtxN0dia3UzRlRXYnZHandNcjZVbU93U3NlR2gv?=
 =?utf-8?B?bU5CRE9hZjlxVDdzTDZkenFvN0c0TWErTVNBSVo4cVZqUk8zdVRzTWp3TzBW?=
 =?utf-8?B?c1JjTzFiMVByMGk3UVp6U1RDY1lkaWZkYnNLTkxMUStwMm5uMWlpTWdIWHBp?=
 =?utf-8?B?VHkveStiOVBrdW01ZlFwSkdzSUszUWxPOG5jRDJLVlg4THQxa3o0MFJJN1c0?=
 =?utf-8?B?RXVDUWtXTEdLYTdvTitVdVoxMndRUFJpZkxVTGV4YmpuZ2NBbEFqOVBzNkpm?=
 =?utf-8?B?QkJaTU9DMjZvU0dNYVd6ZEc2ZGhFdkRVSnBCT3hYVzY5aUFxMzZLOGZVUkxn?=
 =?utf-8?B?Z1hkSFhvK0lNOGx1dUpwSmpFN0tBY3JtcDBEYnk0VnB5ZGxOcmRsdUt2UFY1?=
 =?utf-8?B?bC9mVzQ2VUMyeUFGcjZGTy85Y1pQdERwNFFOeTlOYURod2pPOENvK1NQRmIx?=
 =?utf-8?B?UjZVUFQxS3kxVGNlREtrK2NsWHpNYjZ2NkNxRVZvQmhqc1RCeHBxVzFocys4?=
 =?utf-8?B?NW44ZnJhc2M4a0JQbmYzK0szYVNkSk14VUg3VkxuS3ZUdFpRc0lKWUttKzQr?=
 =?utf-8?B?ZnZNbFZvRjdIQW5HMHZiZmtiRGN2cGdYdSt1MmZIV0ZTNUtNZ2tOVFdKSitl?=
 =?utf-8?B?STQ5L0gyZjFVV1dpdlUyTzNNc1VNYWw0YzhGc3RkOUtYTmsvaW5NYnBLSjZS?=
 =?utf-8?B?MzJVVm9NMnlJV2ZYYnlqZGdzb3pyZkoxZHJsV1JEeVY1VXAzZ1lUQllidERI?=
 =?utf-8?B?UkhwMlozdmYxNmNqSHd2dmdkdE92cXdVRjh0K2o1RW82YTJZSW1JZUpwbGRo?=
 =?utf-8?B?Z3J2MWkyY1E4S3M4aitOMFJVQkFNeGJxRUxuRjBadWtoSFlvWnpVelg0dnQw?=
 =?utf-8?B?cmFSQXZXTHdIelF2UGZaK3ZPckg3MEZGQStsRHB0S3NvYTFkNUl2ZjIxenhw?=
 =?utf-8?B?cWFsOWc2MC83V01EUWxYbmFFMFR2WXhDdHh2SHcxQ0pib3hnZFhUaW1GK0Mv?=
 =?utf-8?B?SUNLbm1ZRmpubEZkd0UvQkIvT0tQNlMrZ0JxUk5pajRCc1hhcWRjQTdGTmdK?=
 =?utf-8?B?eDdrUEhCeTg3UmVsQTg2d3luUGtyQ2RvaFFoRWFHYkYyZU1RMm9tb0QyTnNs?=
 =?utf-8?B?SzVieGtzOGxXM1Fqa1RFQ3BWN3FUUkUxLysvMU0xdG5jaUJVVk9iQ0VCdlhi?=
 =?utf-8?B?dlZZbzBVMCtqanpEVVhqeXRVZW1hbExZVkF0azZ4WWpqUFYvV0ZVQkJQdW9G?=
 =?utf-8?B?VUNab2RQc2JFczFyZVJJdkJQcDFoUXEwSkFoOUhBRlFSMjdPMlhoQlExUFZV?=
 =?utf-8?Q?f5/AqYfu64WHmd4dSv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f7d8da-8a0b-41db-7f07-08de88de79d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:17:04.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8+8UqQd8paMCE/kBDvvDOZ8NZLRPIx38aqVQ5FPFPmHceXKU8oUQ8RAK9TPzj7Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

On 3/23/26 13:13, Christian Brauner wrote:
> On Mon, Mar 16, 2026 at 02:38:28PM -0400, David Francis wrote:
>> We want some GPU information to be publicly available to all
>> processes for basic system-wide profiling (think GPU versions
>> of top).
>>
>> This information is available in fdinfo and not easily exposed
>> by other interfaces.
>>
>> Add fd_op flag FOP_PUBLIC_FDINFO, which, if set, makes the fdinfo
>> for that file available to read for processes without ptrace
>> permissions.
>>
>> Note that this makes public how many files each process has open,
>> and what their fds are.
>>
>> Signed-off-by: David Francis <David.Francis@amd.com>
>> ---
> 
> Eew, please let's not. Add an ioctl if you need to be able to retrieve
> that info.

Yeah the problem is an IOCTL is even worse from the security pov.

This is for an tool which doesn't have access to the file descriptor which provides that information.

So using pidfd_getfd() or similar to get the FD and then call an IOCTL on it would be a security violation.

The real question is how should we make this information public available in the system?

Regards,
Christian.
