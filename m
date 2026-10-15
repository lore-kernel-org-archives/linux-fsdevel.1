Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020141.outbound.protection.outlook.com [52.101.69.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8838553F;
	Thu, 15 Oct 2026 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079392; cv=fail; b=ORgn+1mdf0g2C7X66Yp5zk/lvFYQB5gTWECblW/8Wem/KpC1LfOj1gmTZCjecj3vecFcBqEo22EM9jlyzslPfKcfY3VPPQkvjxcI2AkQdAU5Ta7e5kZ477PVKqURJ2rPrktozwcbY/ezqYM0ZtL+FldQ/TyT6OYa4r/OJtR2iP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079392; c=relaxed/simple;
	bh=bb9HX7mHWR3jCQzrRAm3Bq3akNDsE8X1Kuip5r+x9bY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iliw1YeRjRrvc8APtqzRY32lBakPsT41AzpGI0Dfqyq6pUWKMCEk7Ep2qEeos8xWc0VvW1aM/28SYjvSBSXuMGIe3tNdyZ7DqOlz2+a/1YUYbgg1ujitByrqz9w5uPYebDWa1Bxh0C9lOwGn4oi5Orb/tV2ZupG/hfesUoQZsgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=DW50Env9; arc=fail smtp.client-ip=52.101.69.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DW50Env9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/P4LyVqSQUfpWHnq01k1sV5at52SwbUV9/6miVtOUrmPExb2/THSAHfxmyxfnpiGZZMGKpKX+74JJ28u1tX5lxHGqVRq3pTa3m72SYuL5C14kBlb/XcdQ/pbGDKSJmeUK6mLN6+Ioop//8elHL4CMsN0QM5PRZIZAhQ90iMfFg18c+uxm5rhPLWlJ/pjP/XwswZiz7Jgsegs35dfzd5wJNkdyJVfQuSlXbyGwW+KS0z1qbqAL6db4/qh7FeP8NLV1jG9cfZgVOVl0il2Km5iv+AlyKa3X3rPUmwL9VY0puPoawwVmq7oLnJERyZxhbHGXqP4ymMJ9FwZE73MFn4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eb+ioIJ6koMi8PYOYtb5A2A3EDqhMlbHdIz4GNC49jk=;
 b=B9cyNjCth90gtyFrbBzkheZy4oiMIwMInasC9kEKfSx5s4w36sLFutqyOrnunPFmmHcaaLoYrCW4hROw7N26dl+wXyjFQgRdqOGD00f/0jLmulwfQ5E70/A5Gy2KWhzpyOlof2yDTDHqQDiyrI/8plo194ZMNII/pFbuKcz9ibXElvr2UC/amGUcFFTWu2l2TJJV6wICXBPEFvFdhzSyk5N086mGlS1rM5vkZMNSonPGIEPM+1yh87tdkhv/b5Vrz1QwcxK8vDABOwz5PXR+0pdLffATKQIbHDaZW+z9Fuf+zySgZUR1BHGh93ygypi0pLpE382BvRuTWol8B7t0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb+ioIJ6koMi8PYOYtb5A2A3EDqhMlbHdIz4GNC49jk=;
 b=DW50Env9MuO3ncaoYDV7S7vIGxnITJZQSqZjF90YuY3HVW0mRaSl0a1j8sTaj6KXoUpz4t+i+jxyqCmCzA5PXH6XxKQ2bMDQPkduCDjBlVaLIxn/o6zL2/zWuE8eQC0Ez9he+uOlt7xwppli25yh3pMdvWWAMI5GBB/+9ZTgZO0dVcUELORBVqb5sN5g7aKD0aruxhaYD8muyrjJUgTB0M7eI18wDMOIBkDgq0Lm3TTcOpePENEpqX3mBYsIkCQ3qH+xVZBgI9wrg++x9FWGMHQN9quYCI6J7oE9YZlLhM8d/mQXwfRociXP+Ti+BUkyHeX6wbmUbh1tXgioz+VaWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by GVXPR08MB10576.eurprd08.prod.outlook.com
 (2603:10a6:150:14a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Thu, 15 Oct
 2026 15:49:31 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%5]) with mapi id 15.21.0546.006; Thu, 15 Oct 2026
 15:49:31 +0000
Message-ID: <2f6b72c5-9068-446c-a35c-188b603542cf@virtuozzo.com>
Date: Thu, 15 Oct 2026 17:49:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binfmt_elf: return the real error when program headers
 cannot be loaded
To: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Paul Burton <paulburton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20261014-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-v1-1-f39c74d55e42@virtuozzo.com>
 <202610142140.D483AE26DF@keescook>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <202610142140.D483AE26DF@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|GVXPR08MB10576:EE_
X-MS-Office365-Filtering-Correlation-Id: b145de95-90a0-4d9f-beb4-08df2ad3e6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|4143699003|260925022911599003|260925021311599003|260925021911599003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jbMknfOMKVqrm6iQ3qoL41GSeQH923bHCRHuCVmhPV5+29uyXkDADCWQKFZ6pVxWtYyzgIytfUR4Z0RnAKnqqq5Mn7popo0c/+3n+JF/LenLDycOFqmXE6HWH8TrIoz04pN12WOVVKqC3Ho4LL10wVFpy3PX7S0xDaVfRT7p+pPPJgo70B+lrr6vRM02jJcS3OupTVbMEZPnFo2lggQmAMkbxw1lSfVwLftaqau1tajy7e6TErw11q69DiWwd324Vy/LVAGcbOL23CcHM2bIsBle9/nZ5hnghOLEPycaY/jJno0+4tDVPxiFtQRxw/Bv1cJC5YCslFx5tNjFvpYOWBiBIGJ7WbC/q0G03TacG8mirUyb71EVqgNUw6sZ9wWa0KG9nUsrXP6MXAv8vTlKQUEtUiM9OchcLpjyOmr3PTorhED+unzR5uja2m2oSiOBYDHA1LizXpAk4Up+a7AaDOtHyjAZYikqQ8kjPPMS47Z8tQGPga28qJxV4TfI6SHjCOGVuhBjbionMN556owflgmfiJQ2GR6rp2ACMIVYZjLsbHZCajwkuvEUvbSJg+OmwzJBth/pzxWZc1W4IE7Z4hwGtV+F/K+mBK7THKUlYq0hieJUenuWvMSjClqjURrRKJO6eNXaXvkXSFNP79nQs4sqBeUTpqyGMyf3c6L4E6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(260925022911599003)(260925021311599003)(260925021911599003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGZFOVVEdTZyUXpwTVJ3LzVOQkpDQStPMXVNeXZ0b3EycVh1NFJJeW5DWEZJ?=
 =?utf-8?B?VHkrb0VlOUtacGRJMld4V3NoQUhVem91a2tiS01rZCttOUdTU09yb1VhcjI3?=
 =?utf-8?B?dDNyWE5rblJEcDZ5VXlWK1lOQ08rbUdWcWEra3c0SVoxWWJmbjZTV0tCVzFl?=
 =?utf-8?B?T3FjS1VmeVZ5YmZBZU9OdHV1cW1pWUxnR0w3bUVqdDZPUlJaWkUzM2N0emt6?=
 =?utf-8?B?T2RuR0xST0Fmd2Y4L01yUTdhM2t2Mmw4eU1YalBVK2E3VUVtZEpQZTM0MDls?=
 =?utf-8?B?c2xaeWdZeVRuZDlxUlhyUWhoZW9xbUNzeVk5cEdFQnNuMzJRb1VHbmZZWEdi?=
 =?utf-8?B?cnNodlBkWVJmZlZ4RGFhQW95TFdhZDFXN2lxQUFkemxvdENJbDVFbjd2MVJm?=
 =?utf-8?B?Z0xpUExzMS9mL1A5a0RsQzJKeGhBRGZ5cUFUMDY5d20vakREVURrOVFURUdn?=
 =?utf-8?B?Zk1wOFRFcU1hdEtTMlVwMGZIWGNtZk1iMGI2cU9NTVIrR0JBbFV4b2pZalph?=
 =?utf-8?B?Sit4NkF6cUhOYnBVVjNoV29PeTJNRDIvTGYxK2x5NFpCYy9Nd3F2c3Q1bnVC?=
 =?utf-8?B?VlpocCtOZEt1a1VQSThhWHJTQXR5bHlqdytxZVNOL3RWQk5lZ3VBck0rODZk?=
 =?utf-8?B?Y0JBcHptb3c0NkJXRjFnaitNeUZOU2E3NzFiRWF4bXYxVEZHSzdhODFQNGRi?=
 =?utf-8?B?ZStoY2pzVDl0MXhCUHRoZ2JHVGVZVWlYNUxMRWpWcFh6OXVCbnIwdGp6YVBh?=
 =?utf-8?B?Q00yS2FFS0xkR3AySThTaWhDQ2ZIN0xaaEV6a2lOUlhUaUQxMHpBNHJ5MnBG?=
 =?utf-8?B?ZUNMWGc1M2haRW95WlhWbGc3Z0crWGJkYVlmdkNOMFpsejFEcWRPaXFaQ3ZC?=
 =?utf-8?B?VkRDYzdaZXNWWlE2a2NRdzcxTEdFMlRORllodnloVm5DOFJwbHdOcmV4cmJs?=
 =?utf-8?B?ZWJrR2Vnb0lxeWZBZW9qM1ljNTkrRDRwMWhRNVlKdmJnTk5JbEFpRExSTkZn?=
 =?utf-8?B?TTR5czJtYW5GbTNhTW11MlVJMmNvbkNQM0xVT1prdXViWGVaOVR4SnRncGVI?=
 =?utf-8?B?UzRTc20ydUJId2hjc0pTZW95TFZFL3ZSWkpNY2Q4R0FhSUNOalR3WTlCWWF6?=
 =?utf-8?B?UjNuNTJORzdhMnJqSzRrMVdUdUgzbmJZTndWR1Z6bGpBWE1QS203SWcrcHh1?=
 =?utf-8?B?VkREYVFnTjIyalkvazNwMUovNkgzWUhTWDRpUThZWkV4WjRxWmlTV1hZQ2VW?=
 =?utf-8?B?VXZNZklDTTcvQ3dVd2NrcjV3UmtZMmF3WktybWVZQnVMTkdpWldWUGsrYmNh?=
 =?utf-8?B?MXY1TmpaTUNyVUF2T05DYmpjSjNLQjcvcGVYbHRDVHdJaWhXSHBubGNCV2to?=
 =?utf-8?B?eE1FSjhsQXN0SnN3eEhVaUMvbFdKa0pMRmNDMzJGOURyTW5uL1ZIbjMzVGFR?=
 =?utf-8?B?OU9UVGVwUk8vZkVjNC9vRXcyN0xyYlFCdGZycCs5b015ck1TOW9oREptVWJL?=
 =?utf-8?B?dnBtdkNlTiswdjJiVXlEZzNpLzlyZXZZeEFPaDhKMDdSTVF4b2pTZ0djVUZm?=
 =?utf-8?B?UzFQYWVmTW5jTnJtTlBXR2pCRDNlZUtwQXZ4bXpvOWtCYjVHQnl3aktyZXpi?=
 =?utf-8?B?WHVDb2I2UGxMWk5hdG1GVVlZdXR5ZnFBRUYzS3dwK2RzamVLS0tnMmd0K0VT?=
 =?utf-8?B?TmpmRW9tdjhHemtydkJDc2NjTFpYQkQwTFd1WTFQWEtGVG1PSW1uNmovYWRM?=
 =?utf-8?B?VHh3SXhPVld5SHFta2dDOFg4RmM3T0E0K3dOOFlPbTIwRUl4b1VTOEtsTXEr?=
 =?utf-8?B?ek1rbHlpYTV2WkVNemZTYnVtMzlGSThnWXBMaHh0TFlJV3pCWXB6SjJEUnBJ?=
 =?utf-8?B?ZDVxbG1LNlUzUWJPNm1mSXN4YUp3QkpwOUZlTzJhbUdVV0tqMndERCtFMmNN?=
 =?utf-8?B?cUtuOFdHdmd6REMzeXY1MkROUjAxZ3lBTytlQ0tRQWFwVTR2N2RNRlllZHow?=
 =?utf-8?B?bzQ5Nmx3aEh6TDl2SHNoaHJJTTF5aERsVXFZQkNldGdxb2pnbUc3bXRNdjFy?=
 =?utf-8?B?blVOUUsrUWYyaUJ6U3RKaE9leEdlVWFDQ3orcWc3cmhjWjJJMlBvZ3RMVXY0?=
 =?utf-8?B?ckNKMU0yK01kczFLZzROMVhzVHFzWExic1lyMk5wYlR2UW1ITzN5TjJCN2pN?=
 =?utf-8?B?UWRibXJSMmtTZDBRdTMzM2xLak1BMkVZTk9XU1pnL2pqd1M1VnI1Tk40TExK?=
 =?utf-8?B?dGVGVW8zVVZmZXo3QTQ5WnIwRC9xSG8wMGZEM1dKUy9HWmErbnBqMWxBVXQx?=
 =?utf-8?B?Nzd1RjdYenNwQzh5NUU0eUpsV0ZGbXNkWmloSU4xL0NQWHZvYXJtZz09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b145de95-90a0-4d9f-beb4-08df2ad3e6c2
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:49:30.9173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: macqZ6sMWQmyt8dDLSZtMaGEgx+FV1UUCxVSiQ6t7v0Bx3Bi6mBD4TGi+HW3UcLJ+f6slW2lgJhSIJk0Bq3sXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10576

On 10/15/26 06:48, Kees Cook wrote:
> On Wed, Oct 14, 2026 at 02:30:33PM +0200, Konstantin Khorenko wrote:
>> Problem
>> =======
>>
>> load_elf_phdrs() returns NULL on any failure, and load_elf_binary()
>> turns that into a fixed error: -ENOEXEC for the executable, -ELIBBAD
>> for its interpreter. The real cause is lost:
>>
>>   cause                                  really      execve() returns
>>   -------------------------------------  ----------  ----------------
>>   bad e_phentsize, e_phnum 0 or too big  bad file    ENOEXEC (right)
>>   file ends before the header table      bad file    ENOEXEC (right)
>>   kmalloc() of the table fails           ENOMEM      ENOEXEC (wrong)
>>   kernel_read() fails                    EIO/ENOMEM  ENOEXEC (wrong)
>>
>> For the interpreter every row gives ELIBBAD.
>>
>> Consequences
>> ============
>>
>> ENOEXEC says the file is not an executable, which is a property of the
>> file, not a transient failure:
>>
>> - glibc's execvp() and execlp() take ENOEXEC as "not a binary" and run
>>   the ELF file with /bin/sh, which reports a binary it cannot execute
>>   instead of the ENOMEM or EIO.
>> - search_binary_handler() tries the next binary format instead of
>>   returning the error.
> 
> Isn't that what we want? If one handler can't load it, move on to find
> one that does.

For a malformed file, yes, and the patch keeps -ENOEXEC for every
malformed case. For a failed allocation or read it does not help: the
file has already matched the ELF magic, so the other handlers decline
it too, and the loop ends with -ENOEXEC anyway. Moving on only loses
the error.


>> - For the interpreter the caller gets ELIBBAD, "Accessing a corrupted
>>   shared library", about an ld.so that is fine.
>> - A caller that would retry on ENOMEM or report EIO gives up on the
>>   file instead.
>>
>> When it happens
>> ===============
>>
>> - The allocation fails under fault injection. Since commit
>>   8030790477e8 ("binfmt_elf: remove the 4k limitation of program header
>>   size") the table may be up to 64K; above 32K that is an order-4
>>   allocation on 4K-page kernels, which can fail on a fragmented system.
> 
> I would not want to risk changing established userspace error message
> interactions to make fault injection happy.

Fault injection is just how I found it, not why it matters.

The case that matters is execvp().
glibc runs a file with /bin/sh when execve() fails with ENOEXEC.
That exec of the shell succeeds, so the caller's process image is gone,
and the shell then exits with "cannot execute binary file".

For example, QEMU's cpr-exec live update does exactly this:
it re-execs itself with execvp(), and on an error it resumes the VM.
If reading the program headers fails with EIO, or with ENOMEM from
the page cache, the guest is killed by /bin/sh instead of resuming.


>> - The read fails with an I/O error, or with -ENOMEM when the page cache
>>   cannot take the pages.
> 
> This is kind of a bad failure case -- I don't think the "right" error
> code is going to help much there. ;)

It helps execvp() callers: with EIO or ENOMEM they get the error back
and can retry or report it. With ENOEXEC they never get the error,
because the shell has replaced them.

>>
>> Where it came from
>> ==================
>>
>> - Until commit 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header
>>   loading to a function") load_elf_binary() returned -ENOMEM and the
>>   read error. That commit documented an ERR_PTR return but returned
>>   NULL; commit cfc46ca4fdca later fixed the comment, not the code.
>> - Commit a9d9ef133f44 ("binfmt_elf: load interpreter program headers
>>   earlier") gave the interpreter's headers the same NULL check, and with
>>   it -ELIBBAD.
> 
> So it's been like this for 12 years? :)

Yes, since v3.19. :)

It needs an allocation or read failure at exactly this point to show,
which is why it went unnoticed.
So yes, the chances are low, but the price might be a killed VM.

>> [...]
>>   kernel                errors returned by execve()
>>   7.3-rc7               ENOMEM 17, ENOEXEC 1, ELIBBAD 1, E2BIG 2
>>   7.3-rc7 + this patch  ENOMEM 19, E2BIG 2
> 
> ... so there are _fewer_ distinct failure codes with the patch?

Well, this part was not clear enough, sorry for that.

The truth is those runs i did injected only allocation failures, so every
failure is ENOMEM.
The ENOEXEC and ELIBBAD in the first row were allocation failures reported
as a bad file.
(E2BIG comes from copy_strings(); that is a separate issue, left alone.)


On the userspace side: the patch adds no errno that execve() cannot
return today. The same file is read in two other places on the same
exec, and both pass the kernel_read() error through:

- prepare_binprm() reads the first BINPRM_BUF_SIZE bytes of the binary
  and returns the kernel_read() result as it is.
- elf_read() reads the PT_INTERP path and the interpreter's ELF header.
  It returns the kernel_read() error as it is, and -EIO for a short
  read.

load_elf_phdrs() itself reads the table with elf_read() too, then drops
whatever it returned and reports NULL. So a read error on the program
header table is the only read error of an ELF exec that reaches
userspace as ENOEXEC. The patch makes it behave like the reads around
it.

>> +	/*
>> +	 * Read in the program headers. A read that fails part way returns
>> +	 * what it got, so read on to see the error or the end of the file.
>> +	 */
>> +	pos = elf_ex->e_phoff;
>> +	for (done = 0; done < size; done += rv) {
>> +		rv = kernel_read(elf_file, (char *)elf_phdata + done,
>> +				 size - done, &pos);
>> +		if (rv <= 0) {
>> +			kfree(elf_phdata);
>> +			return ERR_PTR(rv ? rv : -ENOEXEC);
>> +		}
>>  	}
> 
> This is a behavioral change mixed into the errno handling change to
> support partial reads??

Yes, I missed this point, thank you for pointing it out!

Yes, previously in case we get a partial read we consider the exec failed
with no other options and now (with the patch), we try to read again and
the new read may succeed or whatever - yes, it's a behavioral change.

My idea was: in case we get a partial read, we still don't know the
reason - the error code (which will be returned only on the next read),
so read once again, get that error code and return IT to the userspace.

But definitely it's a more complex thing here and it should not go along
with this patch. If we decide - I can create another patch for that,
or we can just drop this hunk at all.


> I could be convinced that errnos need to be fixed, but the rationale
> here doesn't really make me think it's worth potential disruption to
> userspace. I'd need a pretty comprehensive survey of what would change
> there and then a clean patch that made zero other behavior changes...

Understood, will try my best.
I can create a v2 which will change only the errno, for two cases:
 - the kmalloc() of the table fails: -ENOMEM instead of -ENOEXEC;
 - kernel_read() returns an error: that error instead of -ENOEXEC.

Short reads case keep -ENOEXEC.

Sounds good?

--
Cheers, Konstantin.
