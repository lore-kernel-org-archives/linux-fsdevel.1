Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020132.outbound.protection.outlook.com [52.101.195.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DC4ED1AF;
	Tue, 29 Sep 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698070; cv=fail; b=eZh4EExlxkaK0TjxtXkJGT7jOHeYX6D+Flt3IZDgejMnjIiYCYSYlw0WFIhyn5YednQGd+5ZgbZoYhziHHSVsvhNxsyBDICcNN6cBE/MeUTb6lf5skb+7GP/Zw6pdln+QWQJCs7Bhfy/MsdCFMydYRnEg8Qvwp0Vl6V78x/d94k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698070; c=relaxed/simple;
	bh=NNHvMa1Tz2DFZmlNwkpnXggLzcIrlCKY+u8TlM3PfPs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=JVJUKZgo5IMpkhNYoOFNpvAOSWLknNQ/c7JArlu7Rwr0v9LqHQpqkreFixls7kPfzr1wbhg35xHDVwXbEuqvNgCOq6V8npCqQHFkNXTyHoRHXABbFHQ49vpEvgGxHjBmNws3kh34u/tEmGAK4fz7mudAmBq4hRtOWsAxFwA5YXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=I0Bs+KAT; arc=fail smtp.client-ip=52.101.195.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="I0Bs+KAT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHERDb70rVBgnq4fDDYyCxOtxAD265LWPIO4n7ktzVfUg3PEhUOMVO0k18uZeQb9RObuCiFghuEvPpimmSCJ06PKCWULszO8GfbWCox5kdIMnMqCsFXfOrItXFpwtMvJOi+4iRFNqAH5DCNjl9yW0ObJVU6SuxsvJLm+++QO/B3E6CEBJEUh0fqgUqchy3S/LA5Nn1IAzgDGZHmmMsQt94upjWkA6XdK/mJL7msXQn5cEWq1J8mUXjkm92e+lbsjo+bxied5pyamXS2dXVDpgCmwbEE+W23ZsohByhOxLNsnGoC14GWJATbewxMUoPHuh6bdb9tZ/kNiDO3LReS7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQWy8knEoKwak4VX2NrxuTb69omxvj60BURZtq89k5k=;
 b=vD+UyZr3MJoHVGjlNffdiWIPbvdEaWfgfy32TPupPI0AKxV7W+k5CnqoyandRJaqmF66aBOvKblDv8PMgdyLAUGRUmnDrAfo/vSSpD7Pkkm8eNsazS3Tc7a7BQ5w9zNF97niez/ydLQVIihEgOC98nlnGNpUnUHtuo0aApZyRaLhBhVgSDYTCk4DnrU0GTY+zIkhmKKFP+Imb4v0SyJPXjRLQ8oy2Nw/iAE0CLqdvVmBFPxtQSEDVwE+uFcJDc41b9TLah1OwqKa1XcT0XHt6UlAR9oOfd58hRKkwWpHX7Gqij7tFUYWltj4UABK12c2mcka0rkBSdy373G8qT4CYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQWy8knEoKwak4VX2NrxuTb69omxvj60BURZtq89k5k=;
 b=I0Bs+KATZyOuTGxpWnYSbDsiprtSHRMZpC6HB2LfsvVFvYYP2yAApNFhTTQBfV2IwX/FXu9OzftYn1PWpPUmSDam5LzUgPBkNJglkLK2s2Np24ErHKUdGTxt0RKIBDIn4ia5Y8f/AMJR1m1xhGQhwH9mIxJhX9bP3X6TI38asC8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB7557.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 16:07:41 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 16:07:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 17:07:40 +0100
Message-Id: <DLRXHGLDR2QQ.WZVRWGY995BT@garyguo.net>
Cc: "Christian Brauner" <brauner@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Georgios Androutsopoulos"
 <georgeandrout13@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Jan Kara"
 <jack@suse.cz>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-fsdevel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
From: "Gary Guo" <gary@garyguo.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com>
 <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
 <20260929044843.GA3909609@ZenIV> <DLRSQRUVOGT2.10ZY01VEJVHCE@garyguo.net>
 <20260929135154.GB989762@ZenIV>
In-Reply-To: <20260929135154.GB989762@ZenIV>
X-ClientProxiedBy: LO4P265CA0108.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::10) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 914d330b-46c4-4b91-b90e-08df1e43ca56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|23010399003|10067099003|56012099006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AgqVkwB/xkCuf9A7AA8a+p9hkwGbdbdOWD3ZjvFhX2KuqRPhOD5opUuKXkePtk91dRSxTJx/4uD2bSm4xzObPfFcG1QBPMKww+LwI3hoXkupwNIfexyfzzFp2tpy4y0hBmHWjmULHvjV/g6BlIDvjY1tenHGU5KkP8vtFTmcCeoIXg749RzLnwf2bB3RO851nCo++bxc9ZX93H1sjKpcTJ1TsObxVPsg8Vi6TKWQ9IcnwT/lYQ2Lwg1ZWhC2djUs0drv0Sp0oa/kmJT+e4NnLT77IFACsqRglJBGrMNz/xg+bsLWMcsIXfbDilObGcJ0D4lNJTMzSnlFVSnRofxXkhN42kWpdpLE+6woB6IXEUNTX/WCi0BRAHfBkax0C6Sc3m8DiFJ4ozL1NXuq3HQAeeujY64AjSn4poe5cxe1tCs6PFVLJgi1qfJYPUMyESQIMgc6rphMzXgjXh6YHi1rRJ2MUbIttj+XU2Ht9qT8eqIInZVaiYld01mL1TkrJ094zWWfr8SkpsyMV2KXI/8NVEcoOLBL0DHCzb4P5paGEh/no6r8Fg6cOH83BXaxaumE1yy9DO97WQj3c+jV5iGHR8p9pejtYDps9KivADLwr1WdOY3W9C//LNL0Et2nXVZgI4x4dD2HQDmKAftefPJ4mQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0Fwclg5K1ZDUklHRmZOVnVrWlRoZlR2SWZqcGVyalBRbzgzZGtNQTNKeUgy?=
 =?utf-8?B?alhuY0xwRHRFZWpRT2U3VzlDSE5HZmVFNFh1eEhnZUtzMGN2TTZ5eDY4bk5u?=
 =?utf-8?B?eWJBLzFhUnUyRTFuck1qRksvWkRSV2ZrTXZ3WmVPNllzeVBMY3U5c0lsckhF?=
 =?utf-8?B?SEFTUmV3clN3MEZCY1ZTbVZXYXhTc1luS0EvWXlJMFNWU2NsdVNtcEVPeUZS?=
 =?utf-8?B?dlozQXBmUENTVGs2dDN3ZjJ1UHgzaGZvSURUM28xNFd1dXlPUm1yaDY3ZVhB?=
 =?utf-8?B?S2JrMHJ6aW1TYXFVeUsybkZBMUJHdThUZDBDTTZoTDJUUFpTaUsxNFMrUEc2?=
 =?utf-8?B?L3REcTFHR3EvN2xwdDIrWTFoOVppZVhOQVRCaWdyMEFodlNBL1oyVDErVU83?=
 =?utf-8?B?Vm9UNUZEak96c0tNTEtGdnpRYlJ3SkNlNGYyNnNzTUZpWml5c0lJUTFlaXNR?=
 =?utf-8?B?NUZidkNDMEUrTVIrVjQyOGczdjB3OXlxNC95YU52b2tBcTcrRit2azhNbnJv?=
 =?utf-8?B?RGdiQS9qSjErWkk4RlA3aFlIeDVzY2VIc3RMVWpzVWYraTRSRndwOHJmWUpG?=
 =?utf-8?B?ZllEUUpEWDZjaHlYc2N2eHhRTWZwYStqU0RabEI2Uk5yNmdSaHA2Ymd2dVpp?=
 =?utf-8?B?S09GM3NvbGU1WjJZTG0xV3BtYko2eEVtTUhMWUJHYmgrODA2NmVaQUtxNFBC?=
 =?utf-8?B?RmNzOTVMdncra0x1VFc1REQ4dFg4cHh3MVEzYXRRSkZGSTZqQWVnRFlHR3dB?=
 =?utf-8?B?VVpyakU5QVd6a0FTWGlvaGlaN0FRcmkyVXRZWEcweFVVdVMvT3dMeXlVU2Er?=
 =?utf-8?B?dWMyR1V2dEFRL0RzRkRiNzA1dkVCK1JFZjZUZXdBK0dvZFg2eVN2dHp1N2Iw?=
 =?utf-8?B?ZFc2aEJhTklxajhpczNPS2FTZEhwd3Q0dHczbEVUakM4TXdJcGZuUU9UMXdI?=
 =?utf-8?B?Ui9WR1NGS1Q1T2hHdU5Pa3YrQlhXUnVLNkRFNlJBOUMvZDE3bWk0cTdoTUpr?=
 =?utf-8?B?V3RLS1lRWDZwN3EvL0VrQVNaK2ttTVJQVEIzQjNHOVovUjZDVUpOZmtxcEJn?=
 =?utf-8?B?Tk9EdUxWNHpNa2RqNy9wRjJkYmZjcmtBZjlXTUhySUxqZHhCWjdmalJFcFZC?=
 =?utf-8?B?L0NpMUZqK3diRVFjVHd1Vm5md0tVQXRrVUU5YXlXWkZhZDVjZHdubWlIS3N6?=
 =?utf-8?B?ZVpwTjhKdEJ6R0JuZTRvek5ka0xUSHFKdjZDS1R4YzlpWlJwcXpFckJBcjhi?=
 =?utf-8?B?bHhlb3Voa0RVZm1OTHVleUt1cUd2QkRyOUFoMVVPOUZqWVNtZkY1TncvdC9k?=
 =?utf-8?B?ZGlPbGo3WS95bFdiemRBRjNRQjNMYXJxU1pyanhtQTBmQkgwOXMyZmVlMU1l?=
 =?utf-8?B?dEt4b2U1RFhyNGhPTzVPVXg5dnZkTHowUFBqbTJLc0JqUWVYK3FrMGJBRXAr?=
 =?utf-8?B?RzA3djU3czJKLzY3V2ZyVmdINHRWYlZVL0NsMWFndlQ3U2tadWhWQzMwOVZB?=
 =?utf-8?B?RHZQVG44aFg1VGs1NExjTk1aTmRwSnFjYlZicHFUMEVUcWlsT1M1YTFER1E0?=
 =?utf-8?B?M3VrUFR4RnI3NC9HR2dNR3dzK3FDQmNFZyttcDJuYVF4cVBJVEgzVG13VUls?=
 =?utf-8?B?bTVpRWlTTWJBLyt5ZDVhNENRdUs0cUZxd2E3MFgvNjVxQ0FqajA4MWRYK2Zr?=
 =?utf-8?B?T0UvSXpzd2FIT1ZmTkFNbE05N0dWV0ExdnUwNUdvVU92Wm9CT1BKeXNkaUdI?=
 =?utf-8?B?SjlCMEZwcEN5UEQyOFdHVGNvd1VQWlV4ekIwZFM4eXFJUHlYOUtqOERUN0ZX?=
 =?utf-8?B?ciszMngzQ1lSQVJLVXQ3RWtsSU1uM0NkVGVmT1Frb3dKTzZoRXhUK2UxSHhs?=
 =?utf-8?B?b3RuMDQrMXcyY1E5dFV4aTZ6K0pBY3NQejBoZnRIT1dYTzdzZUNQZGhSY09Q?=
 =?utf-8?B?RVFFSVR1Y0UrWkwwUExqS1NZRHNVcHdjOFBiSkcybmZBNzVQVXgvWE4yZSta?=
 =?utf-8?B?L2VkOHAzbmFLcE44TFJkZWxCZ0NmUWlWMFFDQU1oazUzc0w3emJwTytMS2Vk?=
 =?utf-8?B?T3AwemthZGMyVW9VeFl6eXk0U1RRTDBUQmtNSWoxQmtLcUFSQmVqQnRWZUgr?=
 =?utf-8?B?VFdkZTkyMEVUYVJ2VEZHUjN6dU1sYVJIQUsxUlkxTFVBbWhRbnRVbjJPMGsx?=
 =?utf-8?B?d2V1YW5ydEloL2FqT0ZuaW5xcU54N2NnWWdFWE94czhsYkJyUkoyQmZtRzI4?=
 =?utf-8?B?cXdyMHZlb3dmSlV2WUR2dDFEMHlOS20rdnRyMnlVVEh0SU9Sb1FvK203bGlm?=
 =?utf-8?B?d2lzT285WHR1cGpvLzBwUmRQOWV6NXNraVVYR2xKN3NXNHFzS2lOQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 914d330b-46c4-4b91-b90e-08df1e43ca56
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:07:41.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8Z9FgZkutqPFZSPemAo9PEiTmHoVcHDzsqFZC/ctkdFcMFn5BJOwPfnJNSelKJb1FKxNaCb/S5KZaLUn5K7jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7557

On Tue Sep 29, 2026 at 2:51 PM BST, Al Viro wrote:
> On Tue, Sep 29, 2026 at 01:24:45PM +0100, Gary Guo wrote:
>
>> > 	In particular, ->release() mentioned upthread should not be allowed
>> > to access _anything_ hanging off current, not just descriptor table.  =
Note
>> > that the last reference to an opened file might be sitting in an SCM_R=
IGHTS
>> > datagram pruned by AF_UNIX garbage collector; as far as the method is =
concerned,
>> > it might be called from random thread.
>>=20
>> This part is protected -- we mark FileDescriptionReservation as `!Send` =
which
>> prevents it being moved to another task. We also take care to make sure =
that
>> the task returned `current!()` is not allowed to be used outside the cur=
rent
>> task.
>
> Not the point - ->release() can't make any assumptions regarding which th=
read
> it will be run in.  current won't change under it, but there's nothing
> useful you could want with it.  If it has non-NULL ->files (or ->mm, or..=
.),
> that reference will also remain stable, but any attempt to do anything wi=
th
> it would be a bug.

What I am saying is that due to FileDescriptorReservation being `!Send`, it
cannot make its way to ->release() from another thread. So
FileDescriptorReservation::drop will guarantee that it is on the same task =
that
created it.

The reproducer that Georgios posted on GitHub is some cleanup job being add=
ed to
task_work, which drops FileDescriptorReservation. And since exit_task_work(=
)
happens after exit_files(), put_unused_fd in that cleanup observe that
current->files is NULL.

So it's not from random thread, it's from the current task. And I find that
particular case of doing per-task cleanup not unrealistic.

For fget/get_unused_fd_flags I already mentioned that I agree it's a bug, b=
ut
checking that statically would require codify the concept of syscall contex=
t in
a static analysis.

Best,
Gary
